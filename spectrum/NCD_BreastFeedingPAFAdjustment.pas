procedure NCD_BreastFeedingPAFAdjustment(p:byte; t, s, a:byte;  var prev : NC_RFPrevalence; var RR :NC_RFRR; var PAF : NC_RFPAF;  var coverages : NC_RFCoverage);
var
base_t:byte;
CS:TCSData;
BF_t0,BF_t:double;
dBF:double;
BF_protect: array[NC_Age0_4..NC_Age80_100] of double;
age, age_ub:byte;
prop_age_ub:double;
RR_IHD,RR_Stroke:double;
meanSBP,dSBP:double;
impact_IHD,impact_Stroke,impact_Diabetes,impact_Breastcancer,impact_Obesity:double;
meanBMI,sdBMI,dBMI,pOverweight:double;
ObeseBMIVal:double;
begin

    ObeseBMIVal:=30;//BMI

    base_t:=GetNCBaseYear(p)-GetGBFirstYear(p)+1;
    dBF:=0;


    CS:=GetCSData(p);
    if assigned(CS) then
    begin

      //CS.GetCoverage(CS_IV_EarlyInitBF, CS_0t1months, Get_CovBYIndex);
      //CS.GetCoverage(CS_IV_EarlyInitBF, CS_0t1months, t);

      //all BF types
      BF_t0:= ((1/6)*CS.GetBFPrevalenceResult(CS_bAuto, CS_ExclusiveBF,    CS_0t1months, CS.Get_CovBYIndex)+
               (5/6)*CS.GetBFPrevalenceResult(CS_bAuto, CS_ExclusiveBF,    CS_1t6months, CS.Get_CovBYIndex))/100;

      BF_t := ((1/6)*CS.GetBFPrevalenceResult(CS_bAuto, CS_ExclusiveBF,    CS_0t1months, t)+
               (5/6)*CS.GetBFPrevalenceResult(CS_bAuto, CS_ExclusiveBF,    CS_1t6months, t))/100;

      dBF:=BF_t-BF_t0;
    end
    else
    begin

      BF_t0:=coverages[NC_RFBreastFeedingCS, 1, GB_Male, base_t]/100;
      if(t>base_t) then
      begin
          BF_t:=coverages[NC_RFBreastFeedingCS, 1, GB_Male, t]/100;
          dBF:=BF_t-BF_t0;
      end;

    end;

    //value is read from default data for A3 analysis
    //if(t>base_t) then
    //      dBF:=coverages[NC_RFBreastFeedingCS, 1, GB_Male, t]/100;

    if (dBF>0) and (dBF<1) then
    begin

      for age := NC_Age0_4 to NC_Age80_100 do
      begin
        BF_protect[age]:=0;
      end;


      //First Cohort to benefit from BF promotion at base year, 20 years old at base year + 20
      prop_age_ub:=1;
      age_ub:=NC_Age0_4;
        if(t>CS.Get_CovBYIndex+20) then
        begin

         age:=t-CS.Get_CovBYIndex;

         if( (age>20) and (age<=24) )  then age_ub:=NC_Age20_24;
         if( (age>25) and (age<=29) )  then age_ub:=NC_Age25_29;
         if( (age>30) and (age<=39) )  then age_ub:=NC_Age30_39;
         if( (age>40) and (age<=49) )  then age_ub:=NC_Age40_49;
         if( (age>50) and (age<=59) )  then age_ub:=NC_Age50_59;
         if( (age>60) and (age<=69) )  then age_ub:=NC_Age60_69;
         if( (age>70) and (age<=79) )  then age_ub:=NC_Age70_79;
         if( (age>80) and (age<=100) ) then age_ub:=NC_Age80_100;

         if(age<29)                  then prop_age_ub:=1/5*(age mod 5);
         if((age>=30) and (age<79))  then prop_age_ub:=1/10*(age mod 10);
         if(age>=80)                 then prop_age_ub:=1;
        end;

      if( (age_ub>=NC_Age20_24) and (dBF>0)) then
      for age := NC_Age20_24 to age_ub do
      begin
        BF_protect[age]:=dBF;
        if(age=age_ub) then
          BF_protect[age]:=dBF*prop_age_ub;//adjust for partial last age category
      end;

      //Impact on SBP
      //Apply Odds ratio
      meanSBP:=Prev[NC_RFMeanBP, s, a, base_t];
      dSBP:=RR[NC_RFBreastFeeding, s, a, NC_RFBloodPressure];
      RR_IHD:=RR[NC_RFMeanBP, s, a, NC_RFIschemicHeart];
      RR_Stroke:=RR[NC_RFMeanBP, s, a, NC_RFStroke];

      if((RR_IHD>0) and (dSBP<>0) and (BF_protect[a]>0)) then
      begin
        if(power(RR_IHD, meanSBP)>0) then
          impact_IHD:= (power(RR_IHD,meanSBP)-power(RR_IHD, (meanSBP-dSBP)))/power(RR_IHD, meanSBP);

        impact_IHD:= impact_IHD*BF_protect[a];
        if((impact_IHD>0) and (impact_IHD<1)) then
        begin
          PAF[NC_RFBreastFeeding, s, a, NC_RFIschemicHeart, t]:= (1-impact_IHD)*PAF[NC_RFBreastFeeding, s, a, NC_RFIschemicHeart, t];
          PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t]:=(1-impact_IHD)*PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t];
        end;
      end;

      if((RR_Stroke>0) and (dSBP<>0) and (BF_protect[a]>0)) then
      begin
        if(power(RR_Stroke, meanSBP)>0) then
          impact_Stroke:= (power(RR_Stroke,meanSBP)-power(RR_Stroke, (meanSBP-dSBP)))/power(RR_Stroke, meanSBP);

        impact_Stroke:= impact_Stroke*BF_protect[a];
        if((impact_Stroke>0) and (impact_Stroke<1)) then
        begin
          PAF[NC_RFBreastFeeding, s, a, NC_RFStroke, t]:= (1-impact_Stroke)*PAF[NC_RFBreastFeeding, s, a, NC_RFStroke, t];
          PAF[NC_RFAll, s, a, NC_RFStroke, t]:=(1-impact_Stroke)*PAF[NC_RFAll, s, a, NC_RFStroke, t];
        end;
      end;


      //Impact on Diabetes
      //Apply Odds ratio
      impact_Diabetes:=1-RR[NC_RFBreastFeeding, s, a, NC_RFDiabetes];
      impact_Diabetes:= impact_Diabetes*BF_protect[a];
      if((impact_Diabetes>0) and (impact_Diabetes<1)) then
      begin
        PAF[NC_RFBreastFeeding, s, a, NC_RFDiabetes, t]:= (1-impact_Diabetes)*PAF[NC_RFBreastFeeding, s, a, NC_RFDiabetes, t];
        PAF[NC_RFAll, s, a, NC_RFDiabetes, t]:=(1-impact_Diabetes)*PAF[NC_RFAll, s, a, NC_RFDiabetes, t];
      end;

      //Impact on BreastCancer
      //Apply Odds ratio
      impact_BreastCancer:=1-RR[NC_RFBreastFeeding, s, a, NC_RFBreastCncr];
      impact_BreastCancer:= impact_BreastCancer*BF_protect[a];
      if((impact_BreastCancer>0) and (impact_BreastCancer<1)) then
      begin
        PAF[NC_RFBreastFeeding, s, a, NC_RFBreastCncr, t]:= (1-impact_BreastCancer)*PAF[NC_RFBreastFeeding, s, a, NC_RFBreastCncr, t];
        PAF[NC_RFAll, s, a, NC_RFBreastCncr, t]:=(1-impact_BreastCancer)*PAF[NC_RFAll, s, a, NC_RFBreastCncr, t];
      end;

      //Impact on Obesity
      if(a>NC_Age15_19) then
      begin

        //impact on BMI
        impact_Obesity:=RR[NC_RFBreastFeeding, s, a, NC_RFBodyMassIndex];
        meanBMI:= Prev[NC_RFBMI, s, a, base_t];
        pOverweight:=Prev[NC_RFOverweight, s, a, base_t]/100;
        sdBMI:=NCD_STDOfNormalFromCDF(meanBMI, NC_BMI_Max_SD, ObeseBMIVal, pOverweight);
        //cdf_e:=1-NormalCDF(25, meanBMI, sdBMI);
        dBMI:=NCD_MeanOfNormalFromReduc(meanBMI, sdBMI, 0.75*meanBMI, ObeseBMIVal, impact_Obesity);
        dBMI:=min(dBMI,10);

        RR_IHD:=RR[NC_RFBMI, s, a, NC_RFIschemicHeart];
        RR_Stroke:=RR[NC_RFBMI, s, a, NC_RFStroke];

        if(RR_IHD>0) then
        begin
          if(power(RR_IHD, meanBMI)>0) then
            impact_IHD:= (power(RR_IHD,meanBMI)-power(RR_IHD, (meanBMI-dBMI)))/power(RR_IHD, meanBMI);

          impact_IHD:= impact_IHD*BF_protect[a];
          if((impact_IHD>0) and (impact_IHD<1)) then
          begin
            PAF[NC_RFBreastFeeding, s, a, NC_RFIschemicHeart, t]:= (1-impact_IHD)*PAF[NC_RFBreastFeeding, s, a, NC_RFIschemicHeart, t];
            PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t]:=(1-impact_IHD)*PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t];
          end

        end;

        if(RR_Stroke>0) then
        begin
          if(power(RR_Stroke, meanBMI)>0) then
            impact_Stroke:= (power(RR_Stroke,meanBMI)-power(RR_Stroke, (meanBMI-dBMI)))/power(RR_Stroke, meanBMI);

          impact_Stroke:= impact_Stroke*BF_protect[a];
          if((impact_Stroke>0) and (impact_Stroke<1)) then
          begin
            PAF[NC_RFBreastFeeding, s, a, NC_RFStroke, t]:= (1-impact_Stroke)*PAF[NC_RFBreastFeeding, s, a, NC_RFStroke, t];
            PAF[NC_RFAll, s, a, NC_RFStroke, t]:=(1-impact_Stroke)*PAF[NC_RFAll, s, a, NC_RFStroke, t];
          end;
        end;

      end;
    end;


end;{NCD_BreastFeedingAdjustment}


function NCD_RiskAgeToStataAge(age : byte):byte;
begin
  result := 0;
  case age of
    NC_Age0_4    : result := NC_Risk00_30;
    NC_Age5_9    : result := NC_Risk00_30;
    NC_Age10_14  : result := NC_Risk00_30;
    NC_Age15_19  : result := NC_Risk00_30;
    NC_Age20_24  : result := NC_Risk00_30;
    NC_Age25_29  : result := NC_Risk30_44;
    NC_Age30_39  : result := NC_Risk30_44;
    NC_Age40_49  : result := NC_Risk45_59;
    NC_Age50_59  : result := NC_Risk45_59;
    NC_Age60_69  : result := NC_Risk60_69;
    NC_Age70_79  : result := NC_Risk70_79;
    NC_Age80_100 : result := NC_Risk80_99;
  end;
end;


function NCD_StataToRiskAge(age:byte):GB_TByteSet;
begin
  result := [];
  case age of
    NC_Risk00_30: result := [NC_Age0_4..NC_Age20_24];
    NC_Risk30_44: result := [NC_Age0_4..NC_Age20_24,NC_Age25_29..NC_Age30_39];
    NC_Risk45_59: result := [NC_Age40_49, NC_Age50_59];
    NC_Risk60_69: result := [NC_Age60_69];
    NC_Risk70_79: result := [NC_Age70_79];
    NC_Risk80_99: result := [NC_Age80_100];
  end;
end;
