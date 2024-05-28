Procedure NCD_CalculateRFImpact (proj : byte; sex, lvl,  t : byte;
   var prev : NC_RFPrevalence;  var RR :NC_RFRR; var impacts : NC_RFImpact;
   var coverages : NC_RFCoverage; var hap_usage : NC_HAP_Cov; var PAF : NC_RFPAF); overload;
var
  rf, a, base_t,  i, d, alc, m : byte;
  impact,
  prev_rr,exp_adj,
  prev_update,
  PAF_Denom : double;
  applyInterv : boolean;

  PublicProcurementList:GB_TByteSet;
begin

  PublicProcurementList:=[NC_RFSodiumEnvSaltReduct,
                      NC_RFTransFatPublicProcurement,
                      NC_RFSSBPublicProcurement,
                      NC_RFFiberPublicProcurement,
                      NC_RFFruitPublicProcurement,
                      NC_RFLegumePublicProcurement];

  base_t := GetNCBaseYrIndex(proj);
  for a := 1 to NC_MaxAgeGrp do
    for d := NC_RFIschemicHeart to NC_RFMaxDisease do
    begin

      PAF_Denom := 1;

      //regular RFs, sodium impact not via PAFs
      for rf in NF_RFWithPrevs do
      begin
        prev_rr :=  (prev[rf, sex, a, base_t]/100)*(RR[rf, sex, a, d]-1);
        PAF_Denom := PAF_Denom + prev_rr;
      end;

      //HAP
      if d in [NC_RFIschemicHeart,NC_RFStroke,NC_RFCOPD] then
      for rf := NC_RF_HAP_Biomass to NC_RF_HAP_Electric do
      begin
        m:=rf-NC_RF_HAP_Biomass+1;//note offset on rf
        exp_adj:=GetNCHAPInputs(proj, NC_HAP_ExpAdjust, m)/100;
        prev_rr :=  (exp_adj*hap_usage[m, base_t]/100)*(RR[rf, sex, a, d]-1);
        PAF_Denom := PAF_Denom + prev_rr;
      end;

     //regular RFs
      for rf in NF_RFWithPrevs do
      begin
        prev_rr :=  (prev[rf, sex, a, base_t]/100)*(RR[rf, sex, a, d]-1);
        PAF[rf, sex, a, d, base_t] := 100*prev_rr/PAF_Denom;
      end;

      //HAP
      if d in [NC_RFIschemicHeart,NC_RFStroke,NC_RFCOPD] then
      for rf := NC_RF_HAP_Biomass to NC_RF_HAP_Electric do
      begin
        m:=rf-NC_RF_HAP_Biomass+1;//note offset on rf
        exp_adj:=GetNCHAPInputs(proj, NC_HAP_ExpAdjust, m)/100;
        prev_rr :=  (exp_adj*hap_usage[m, base_t]/100)*(RR[rf, sex, a, d]-1);
        PAF[rf, sex, a, d, base_t] := 100*prev_rr/PAF_Denom;
        //if (t=45) and (sex=1) and (a=3) and (rf=11) and (d=1) then
        //  t :=  t;
      end;

      for rf in [NC_RFAlcohol..NC_RFInactivity, NC_RF_HAP_Biomass..NC_RF_HAP_Electric ]  do
        PAF[rf, sex, a, d, t] := 0;

      for rf in [NC_RFSodiumIntake..NC_RFBreastFeeding]  do
        PAF[rf, sex, a, d, t] := 1;


      PAF[NC_RFAll, sex, a, d, t] := 1;
    end;


  //set all prevalence values to base prevalence, sodium prev update included
  for rf in [NC_RFAlcohol .. NC_RegRFMax] do
    for a := NC_Age0_4 to NC_MaxAgeGrp do
      prev[rf, sex, a, t] := prev[rf, sex, a, base_t];

  //impact of interventions applicable to RFs with Interventions
  for I := NC_RFTobaccoPolicy to NC_RFPhysicalActivityAdvice do
    if i <> NC_RFAlcoholDriveLaws then
    begin

      //change in coverage relative to base year
      impact:=0;
      for a := NC_Age0_4 to NC_MaxAgeGrp do
      for rf in NF_RFWithPrevs do // CDP check range
      begin

        //note interventions with one level of impact is not processes over all
        //four levels
        if not (I in NC_RFFourLevelInterv)  then
        begin
          for lvl in [GetNCRF_TargCovLvl(proj)] do//interventions with one level of impact handled differently
          begin
            impact:=impact+(impacts[I, sex, a, rf, lvl,  NC_RiskBurden]/100*
                            (coverages[I, lvl, sex , t]-coverages[I, lvl, sex , base_t])/100);
          end;{lvl}
        end
        else
        begin
          //note interventions with more than one level of impact is processes over all
          //four levels
          for lvl := NC_Level1 to NC_Level4 do
          begin
            impact:=impact+(impacts[I, sex, a, rf, lvl,  NC_RiskBurden]/100*
                            (coverages[I, lvl, sex , t]-coverages[I, lvl, sex , base_t])/100);
          end;{lvl}
        end;{if I}

      end;{for a,rf}

      rf := NC_GetRiskFactorForInterv(i);
      applyInterv := ((impact<>0) and (rf>0));

      if ((i=NC_RFTobaccoTax) and (rf=NC_RFSmoke)) then
      begin
        impact := GetNCRF_Taxes(proj, NC_TaxTobacco, t).PopulationEffect/100
                 -GetNCRF_Taxes(proj, NC_TaxTobacco, base_t).PopulationEffect/100;

        applyInterv := impact<>0;
      end;

      if ((i=NC_RFAlcoholBanTax) and (rf=NC_RFAlcohol)) then
      begin
        impact := 0;
        for alc in NC_Liquors do
        begin
          impact := impact + (GetNCRF_Taxes(proj, alc, t).PopulationEffect/100
                             -GetNCRF_Taxes(proj, alc, base_t).PopulationEffect/100);

        end;
        applyInterv := impact<>0;
      end;


      if  applyInterv then
        for rf in NF_RFWithPrevs do
        begin

          //impact of intervention on risk factor prevalence: reduction in prevalence
          //get diffrence in population level impact relative to baseline
          for a := NC_Age0_4 to NC_MaxAgeGrp do
          begin
            if ((I = NC_RFTobaccoTax) and (rf=NC_RFSmoke)) then
            begin
              impact := GetNCRF_Taxes(proj, NC_TaxTobacco, t).PopulationEffect/100-
                        GetNCRF_Taxes(proj, NC_TaxTobacco, base_t).PopulationEffect/100;
            end
            else if ((I =NC_RFAlcoholBanTax) and (rf=NC_RFAlcohol)) then
            begin
              impact := GetNCRF_Taxes(proj, NC_TaxAlcBeer, t).PopulationEffect/100-
                        GetNCRF_Taxes(proj, NC_TaxAlcBeer, base_t).PopulationEffect/100;
              impact := impact +
                        GetNCRF_Taxes(proj, NC_TaxAlcWine   , t).PopulationEffect/100-
                        GetNCRF_Taxes(proj, NC_TaxAlcWine   , base_t).PopulationEffect/100;
              impact := impact +
                        GetNCRF_Taxes(proj, NC_TaxAlcSpirits, t).PopulationEffect/100-
                        GetNCRF_Taxes(proj, NC_TaxAlcSpirits, base_t).PopulationEffect/100;
            end
            else
            begin

              impact:=0;
              //note interventions with one level of impact is not processes over all
              //four levels
              if not (I in NC_RFFourLevelInterv) then
              begin
                for lvl in [GetNCRF_TargCovLvl(proj)] do
                begin
                  impact:=impact+impacts[I, sex, a, rf, lvl, NC_RiskBurden]/100*
                                 (coverages[I, lvl, sex , t]-coverages[I, lvl, sex , base_t])/100;
                end;{lvl}
              end
              else
              begin
                //note interventions with more than one level of impact is processes over all
                //four levels
                for lvl := NC_Level1 to NC_Level4 do
                begin
                  impact:=impact+ impacts[I, sex, a, rf, lvl, NC_RiskBurden]/100*
                                 (coverages[I, lvl, sex , t]-coverages[I, lvl, sex , base_t])/100;
                end;{lvl}

              end;{if I}


            end;

            //get rid of small impacts due to editor rounding issues
            if (CompareValue(impact,0,0.00001)=0) then
              impact:=0;

            prev_update := prev[rf, sex, a, t]/100;
            if(I in [NC_RFTobaccoTax,NC_RFAlcoholBanTax]) then
              prev_update := prev_update*(1+impact)//note sign for tax interventions. impact already negative
            else
              prev_update := prev_update*(1-impact);//note sign

            prev_update := GBmax([prev_update, 0]);
            prev_update := GBmin([prev_update, 1]);

            if(rf in [NC_RFAlcohol,NC_RFInactivity,NC_RFSmoke]) then
              prev_update := GBmin([prev_update, 1]);

            prev[rf, sex, a, t] := prev_update*100;


          end;{a loop}
        end;{r loop}
    end;{i loop}


  for a := 1 to NC_MaxAgeGrp do
    for d := NC_RFIschemicHeart to NC_RFMaxDisease do
    begin
      PAF_Denom := 1;
      //regular RFs, sodium impact not via PAFs
      for rf in NF_RFWithPrevs do
      begin
        prev_rr :=  (prev[rf, sex, a, t]/100)*(RR[rf, sex, a, d]-1);
        PAF_Denom := PAF_Denom + prev_rr;
      end;

      //HAP
      if d in [NC_RFIschemicHeart,NC_RFStroke,NC_RFCOPD] then
      for rf := NC_RF_HAP_Biomass to NC_RF_HAP_Electric do
      begin
        m:=rf-NC_RF_HAP_Biomass+1;//note offset on rf
        exp_adj:=GetNCHAPInputs(proj, NC_HAP_ExpAdjust, m)/100;
        prev_rr :=  (exp_adj*hap_usage[m, t]/100)*(RR[rf, sex, a, d]-1);
        PAF_Denom := PAF_Denom + prev_rr;
      end;

     //regular RFs
     for rf in NF_RFWithPrevs do
      begin
        prev_rr :=  (prev[rf, sex, a, t]/100)*(RR[rf, sex, a, d]-1);
        PAF[rf, sex, a, d, t] := 100*prev_rr/PAF_Denom;
      end;

      //HAP
      if d in [NC_RFIschemicHeart,NC_RFStroke,NC_RFCOPD] then
      for rf := NC_RF_HAP_Biomass to NC_RF_HAP_Electric do
      begin
        m:=rf-NC_RF_HAP_Biomass+1;//note offset on r
        exp_adj:=GetNCHAPInputs(proj, NC_HAP_ExpAdjust, m)/100;
        prev_rr :=  (exp_adj*hap_usage[m, t]/100)*(RR[rf, sex, a, d]-1);
        PAF[rf, sex, a, d, t] := 100*prev_rr/PAF_Denom;
      end;

    end;

  //calculate the impact on disease incidence of all risk factors
  for a := NC_Age0_4 to NC_MaxAgeGrp do
  begin

    if(a>=NC_Age15_19) then
    begin
      //NC_RFSodiumIntake
      NCD_SodiumSBPAdjustment(proj, t, sex, a, prev, RR , impacts, coverages, PAF);

      //NC_RFTransFatIntake
      NCD_TransFatCholAdjustment(proj, t, sex, a, prev, RR , impacts, coverages, PAF);

      //NC_RFSSBIntake
      NCD_SSBPAFAdjustment(proj, t, sex, a, prev, RR , impacts, coverages, PAF);

      //NC_FruitIntake and NC_LegumeIntake
      NCD_FiberPAFAdjustment(proj, t, sex, a, prev, RR , impacts, coverages, PAF);
      NCD_FruitsOrLegumesPAFAdjustment(proj, t, sex, a, prev, RR , impacts, coverages, PAF, NC_RFFruitIntake);
      NCD_FruitsOrLegumesPAFAdjustment(proj, t, sex, a, prev, RR , impacts, coverages, PAF, NC_RFLegumeIntake);

      //Impact of marketing on weight and BMI
      if(a=NC_Age15_19) then
          NCD_BMIPAFAdjustment(proj, t, sex, a, prev, RR , impacts, coverages, PAF);

      //BreastFeeding impacts
      NCD_BreastFeedingPAFAdjustment(proj, t, sex, a, prev, RR, PAF, coverages);

    end;

    for rf in NF_RFWithPrevs  do
    begin

      //change in prevalence of risk factor relative to base year

      //prev_rr := GBmax([prev[rf, sex, a, base_t] - prev[rf, sex, a, t], 0 ])/100;
      //prev_rr := ( prev[rf, sex, a, base_t] - prev[rf, sex, a, t])/100;

      //relative change in base_t, allow negative impacts
      //if (prev[rf, sex, a, base_t]>0) and (prev_rr<>0) then
      //begin

        //prev_rr := prev_rr/(prev[rf, sex, a, base_t] /100);
        for d := NC_RFIschemicHeart to NC_RFMaxDisease do
        begin

          //PAFVal := PAF[rf, sex, a, d, base_t]/100;
          //impact := prev_rr*PAFVal;

            impact := (PAF[rf, sex, a, d, base_t] - PAF[rf, sex, a, d, t])/100;

            //checks: suspended for now
            //impact := GBmin([impact, 1]);

            //if(rf<>NC_RFAlcohol) then
            //   impact := GBmax([impact, 0]);

            if( (impact>0) and (impact<1) ) then
            begin
              //reduction in incidence
              PAF[rf, sex, a, d, t] :=  impact*100;

              //keep track of reduction in disease incidence due to all interventions and risk factors
              PAF[NC_RFAll, sex, a, d, t] :=  (1-impact)*PAF[NC_RFAll, sex, a, d, t];
            end;

        end;{d}

    end;{rf loop}


    for rf in [NC_RF_HAP_Biomass..NC_RF_HAP_Electric]  do
    begin

     for d in [NC_RFIschemicHeart,NC_RFStroke,NC_RFCOPD] do
     begin

          impact := (PAF[rf, sex, a, d, base_t] - PAF[rf, sex, a, d, t])/100;

          //reduction in incidence
          PAF[rf, sex, a, d, t] :=  impact*100;

          //keep track of reduction in disease incidence due to all interventions and risk factors
          PAF[NC_RFAll, sex, a, d, t] :=  (1-impact)*PAF[NC_RFAll, sex, a, d, t];

     end;

    end;

//    for rf in [NC_RF_HAP_Biomass..NC_RF_HAP_Electric]  do
//    begin
//
//      //change in prevalence of risk factor relative to base year
//
//      m:=rf-7; //note offset of rf
//      hap_usage_rr := (hap_usage[m, base_t] - hap_usage[m, t])/100;
//
//      //relative change in base_t, allow negative impacts
//      if (hap_usage[m, base_t]>0) and (hap_usage_rr<>0) then
//      begin
//
//        hap_usage_rr := hap_usage_rr/(hap_usage[m, base_t]/100);
//        for d in [NC_RFIschemicHeart,NC_RFStroke,NC_RFCOPD] do
//        begin
//          PAFVal := PAF[rf, sex, a, d, base_t]/100;
//          impact := hap_usage_rr*PAFVal;
//
//          //reduction in incidence
//          PAF[rf, sex, a, d, t] :=  impact*100;
//
//          //if (t=45) and (sex=1) and (a=3) and (rf=11) and (d=1) then
//          //  PAF[rf, sex, a, d, t] :=  impact*100;
//
//          //keep track of reduction in disease incidence due to all interventions and risk factors
//          PAF[NC_RFAll, sex, a, d, t] :=  (1-impact)*PAF[NC_RFAll, sex, a, d, t];
//        end;{d}
//      end;
//    end;{r loop}



  end;

end;
