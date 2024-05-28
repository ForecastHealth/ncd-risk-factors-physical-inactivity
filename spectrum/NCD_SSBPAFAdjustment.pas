procedure NCD_SSBPAFAdjustment(p:byte; t, s, a:byte;  var prev : NC_RFPrevalence; var RR :NC_RFRR; var impacts : NC_RFImpact;
  var coverages : NC_RFCoverage; var PAF : NC_RFPAF);
var
  cov0,cov,dcov,
  dBMI,
  SSB0,
  SSB,
  dSSB,
  impact,
  impact_IHD,
  impact_Stroke,
  impact_Obesity,
  impact_diabetes,
  RR_IHD,
  RR_Stroke,
  RR_Diabetes,
  RR_Obesity,
  meanBMI       : double;
  I,lvl:byte;
  base_t:integer;
  pOverweight,sdBMI,cdf_e:double;

  meanSBP,RR_SBP,impact_SBP,pHighSBP,sdSBP,dSBP:double;
  ObeseBMIVal:double;
  SBP_Impact_Unit:double;
  age_list:GB_TbyteSet;
  val:double;
begin

  SBP_Impact_Unit:=20;//RR is per 20 mmHg change

  ObeseBMIVal:=30;//BMI
  base_t:=GetNCBaseYear(p)-GetGBFirstYear(p)+1;
  SSB0:=prev[NC_RFSSBIntake, s, a, base_t];
  SSB:=SSB0;

  meanBMI:=Prev[NC_RFBMI, s, a, base_t];

  age_list:=[NC_Age15_19..NC_Age80_100];

  if(I=NC_RFSSBPublicProcurement) then
    age_list:=[NC_Age15_19..NC_Age20_24];

  //if(FALSE) then
  for I in [NC_RFSSBPublicProcurement]  do
  begin
    impact:=0;

      if (a in age_list) then
      begin

      //for lvl := NC_Level1 to NC_Level4 do
      for lvl in [GetNCRF_TargCovLvl(p)] do
      begin
        cov0:=coverages[I, lvl, s, base_t]/100;
        cov:=coverages[I, lvl, s, t]/100;
        dcov:=(cov-cov0);
        impact:=impact + 355*impacts[I, s, a, NC_RFSSBIntake, lvl,  NC_RiskBurden]/100*
                         dcov; //355 ml in one serving
      end;
       SSB:=max(SSB-impact,0.01); //abs impact

    end;
  end;

  //if(TRUE) then //impacts for Tax
  for I in [NC_RFSSBTax]  do
  begin

   impact:=0;
   //for lvl := NC_Level1 to NC_Level4 do
   for lvl in [GetNCRF_TargCovLvl(p)] do
   begin
     cov0:=coverages[I, lvl, s, base_t]/100;
     cov:=coverages[I, lvl, s, t]/100;
     dcov:=(cov-cov0);
     val:=impacts[I, s, a, NC_RFSSBIntake, lvl,  NC_RiskBurden];
     impact:=impact + SSB0*impacts[I, s, a, NC_RFSSBIntake, lvl,  NC_RiskBurden]/100*
                         dcov; //355 ml in one serving

     //impact:=impact + impacts[I, s, a, NC_RFSSBIntake, lvl,  NC_RiskBurden]/100*
     //                 dcov;

   end;

   SSB:=max(SSB-impact,0.01);  //abs impact
   //SSB:=SSB*(1-impact);//through relative impact

  end;


  //if transfat intake was updated
  if( (SSB<>SSB0) and (SSB>0)) then
  begin

    impact_IHD:=0;
    impact_Stroke:=0;
    dBMI:=0;
    dSSB:=max(SSB0-SSB,0);

    //reduction in BMI
    //if(a<=NC_Age15_19) then
    //begin
    //  impact:=RR[NC_RFSSBIntake, s, a, NC_RFBodyMassIndex];
    //  dBMI:=(SSB-SSB0)/355*impact; //-0.06 BMI units per year per serving SSB/day in children, serving =250 ml=g
    //end;

    if(a in age_list) then
    begin

      //reduction in BMI
      meanBMI:=Prev[NC_RFBMI, s, a, base_t];
      RR_Obesity:=RR[NC_RFSSBIntake, s, a, NC_RFBodyMassIndex];//12% reduction in obesity per 250ml SSB/day in adults
      impact_Obesity:=(1-power(RR_Obesity,dSSB/250));//per 250ml change
      pOverweight:=Prev[NC_RFOverweight, s, a, base_t]/100;
      sdBMI:=NCD_STDOfNormalFromCDF(meanBMI, NC_BMI_Max_SD, ObeseBMIVal, pOverweight);

      //cdf_e:=1-NormalCDF(25, meanBMI, sdBMI);
      dBMI:=NCD_MeanOfNormalFromReduc(meanBMI, sdBMI, 0.75*meanBMI, ObeseBMIVal, impact_Obesity);
      dBMI:=min(dBMI,10);

      RR_IHD:=RR[NC_RFBMI, s, a, NC_RFIschemicHeart];
      RR_Stroke:=RR[NC_RFBMI, s, a, NC_RFStroke];

      if(RR_IHD>0) then
      begin
        if(dBMI>0) then
           impact_IHD:=(power(RR_IHD,dBMI)-1)/power(RR_IHD,dBMI);//IHD impact, (RR-1)/RR
           //impact_IHD:= 0*(power(RR_IHD,meanBMI)-power(RR_IHD, (meanBMI-dBMI)))/power(RR_IHD, meanBMI);

        if( (impact_IHD>0) and (impact_IHD<1)) then
        begin
          PAF[NC_RFSSBIntake, s, a, NC_RFIschemicHeart, t]:= (1-impact_IHD)*PAF[NC_RFSSBIntake, s, a, NC_RFIschemicHeart, t];
          PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t]:=(1-impact_IHD)*PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t];
        end;

      end;

      if(RR_Stroke>0) then
      begin
        if(dBMI>0) then
             impact_Stroke:=(power(RR_Stroke,dBMI)-1)/power(RR_Stroke,dBMI);//Stroke impact, (RR-1)/RR
             //impact_Stroke:= 0*(power(RR_Stroke,meanBMI)-power(RR_Stroke, (meanBMI-dBMI)))/power(RR_Stroke, meanBMI);

        if( (impact_Stroke>0) and (impact_Stroke<1)) then
        begin
          PAF[NC_RFSSBIntake, s, a, NC_RFStroke, t]:= (1-impact_Stroke)*PAF[NC_RFSSBIntake, s, a, NC_RFStroke, t];
          PAF[NC_RFAll, s, a, NC_RFStroke, t]:=(1-impact_Stroke)*PAF[NC_RFAll, s, a, NC_RFStroke, t];
        end;

      end;


        //Impact on diabetes
        RR_Diabetes:=RR[NC_RFSSBIntake, s, a, NC_RFDiabetes];
        impact_diabetes:=(1-power(RR_Diabetes,dSSB/250));//per 250ml change
        if( (impact_diabetes>0) and (impact_diabetes<1)) then
        begin
          PAF[NC_RFSSBIntake, s, a, NC_RFDiabetes, t]:= (1-impact_diabetes)*PAF[NC_RFSSBIntake, s, a, NC_RFDiabetes, t];
          PAF[NC_RFAll, s, a, NC_RFDiabetes, t]:=(1-impact_diabetes)*PAF[NC_RFAll, s, a, NC_RFDiabetes, t];
        end;

        //Impact on SBP
        meanSBP:=Prev[NC_RFMeanBP, s, a, base_t];
        RR_SBP:=RR[NC_RFSSBIntake, s, a, NC_RFBloodPressure];//12% reduction in obesity per 250ml SSB/day in adults
        impact_SBP:=(1-power(RR_SBP,dSSB/250));//per 250ml change
        pHighSBP:=Prev[NC_RFHighSBP, s, a, base_t]/100;
        sdSBP:=NCD_STDOfNormalFromCDF(meanSBP, NC_SBP_Max_SD, 140, pHighSBP);
        cdf_e:=1-NormalCDF(140, meanSBP, sdSBP);
        dSBP:=NCD_MeanOfNormalFromReduc(meanSBP, sdSBP, 0.75*meanSBP, 140, impact_SBP);
        dSBP:=min(dSBP,10);

        RR_IHD:=RR[NC_RFMeanBP, s, a, NC_RFIschemicHeart];
        RR_Stroke:=RR[NC_RFMeanBP, s, a, NC_RFStroke];

        if(RR_IHD>0) then
        begin

          if(dSBP>0) then
             impact_IHD:=  (power(RR_IHD,dSBP/SBP_Impact_Unit)-1)/power(RR_IHD,dSBP/SBP_Impact_Unit);//IHD impact, (RR-1)/RR
             //impact_IHD:= (power(RR_IHD, meanSBP)-power(RR_IHD,(meanSBP-dSBP)))/power(RR_IHD, meanSBP);


           if( (impact_IHD>0) and (impact_IHD<1)) then
           begin
            PAF[NC_RFSSBIntake, s, a, NC_RFIschemicHeart, t]:= (1-impact_IHD)*PAF[NC_RFSSBIntake, s, a, NC_RFIschemicHeart, t];
            PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t]:=(1-impact_IHD)*PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t];
           end;

        end;

        if(RR_Stroke>0) then
        begin
          if(dSBP>0) then
            impact_Stroke:=  (power(RR_Stroke,dSBP/SBP_Impact_Unit)-1)/power(RR_Stroke,dSBP/SBP_Impact_Unit);//Stroke impact, (RR-1)/RR
            //impact_Stroke:= (power(RR_Stroke,meanSBP)-power(RR_Stroke, (meanSBP-dSBP)))/power(RR_Stroke, meanSBP);

          if( (impact_Stroke>0) and (impact_Stroke<1)) then
          begin
              PAF[NC_RFSSBIntake, s, a, NC_RFStroke, t]:= (1-impact_Stroke)*PAF[NC_RFSSBIntake, s, a, NC_RFStroke, t];
              PAF[NC_RFAll, s, a, NC_RFStroke, t]:=(1-impact_Stroke)*PAF[NC_RFAll, s, a, NC_RFStroke, t];
          end;

        end;



    end;


    end;

end;{NCD_SSBPAFAdjustment}
