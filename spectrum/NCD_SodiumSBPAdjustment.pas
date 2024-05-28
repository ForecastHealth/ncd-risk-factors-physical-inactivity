procedure NCD_SodiumSBPAdjustment(p:byte; t, s, a:byte;  var prev : NC_RFPrevalence; var RR :NC_RFRR; var impacts : NC_RFImpact;
  var coverages : NC_RFCoverage; var PAF : NC_RFPAF);
var
  cov0,cov,
  dSBP,
  sodium0,
  sodium,
  impact,
  impact_IHD,
  impact_Stroke,
  RR_IHD,
  RR_Stroke,
  meanSBP       : double;
  I,lvl:byte;
  base_t:integer;
  dcov:double;
  z:double;
begin


  base_t:=GetNCBaseYear(p)-GetGBFirstYear(p)+1;
  sodium0:=prev[NC_RFSodiumIntake, s, a, base_t];
  sodium:=sodium0;


  for I in [NC_RFSodiumReformulation,NC_RFSodiumKnowledge,NC_RFSodiumEnvSaltReduct] do
  begin

    if ( not((I in [NC_RFSodiumEnvSaltReduct]) and (a>NC_Age20_24)) ) then
    begin

    impact:=0;
    //for lvl := NC_Level1 to NC_Level4 do
    for lvl in [GetNCRF_TargCovLvl(p)] do
    begin
      cov0:=coverages[I, lvl, s, base_t]/100;
      cov:=coverages[I, lvl, s, t]/100;
      dcov:=cov-cov0;
      impact:=impact + impacts[I, s, a, NC_RFSodiumIntake, lvl,  NC_RiskBurden]/100*
                       dcov
    end;
     sodium:=sodium-impact;//through abs impact

    end;
     //cov0:=Coverages[I, NC_Level1, s, base_t]/100;
     //cov:=Coverages[I, NC_Level1, s, t]/100;
     //impact:=impacts[I, s, a, NC_RFSodiumIntake, lvl, NC_RiskBurden]/100;
     //sodium:=sodium-impact*(cov-cov0);//direct reduction
  end;


  for I in [NC_RFSodiumPackLabelling] do
  begin

   impact:=0;
   //for lvl := NC_Level1 to NC_Level4 do
   for lvl in [GetNCRF_TargCovLvl(p)] do
   begin
     cov0:=coverages[I, lvl, s, base_t]/100;
     cov:=coverages[I, lvl, s, t]/100;
     dcov:=max(cov-cov0,0);
     impact:=impact + impacts[I, s, a, NC_RFSodiumIntake, lvl,  NC_RiskBurden]/100*
                      dcov;

   end;
   sodium:=sodium*(1-impact);//through relative impact

  //cov0:=Coverages[I, NC_Level1, s, base_t]/100;
  //cov:=Coverages[I, NC_Level1, s, t]/100;
  //impact:=impacts[I, s, a, NC_RFSodiumIntake, lvl, NC_RiskBurden]/100;
  //sodium:=sodium*(1-impact*(cov-cov0));//through relative impact
  end;

//  1 mmol sodium / 17 = 1 gram salt
//
//  1 mEq sodium / 17 = 1 gram salt
//
//  1 gram sodium * 2.542 = 1 gram salt

  //if sodium intake was updated
  if( (sodium<>sodium0) and (sodium0>0)) then
  begin
    impact_IHD:=0;
    impact_Stroke:=0;

    impact:=RR[NC_RFSodiumIntake, s, a, NC_RFIschemicHeart];
    if(I in [NC_RFSodiumReformulation,NC_RFSodiumPackLabelling,NC_RFSodiumKnowledge,NC_RFSodiumEnvSaltReduct]) then
        dSBP:=( (sodium-sodium0)*17/100 )*impact //reduction in gram of salt, convert to mmol sodium
      else
        dSBP:=( (sodium-sodium0)*23/100 )*impact; //reduction per 100 mmol change (23 mmol in 1 gram)

    meanSBP:=Prev[NC_RFMeanBP, s, a, base_t];
    RR_IHD:=RR[NC_RFMeanBP, s, a, NC_RFIschemicHeart];
    RR_Stroke:=RR[NC_RFMeanBP, s, a, NC_RFStroke];

    if(RR_IHD>0) then
    begin
      if(power(RR_IHD, meanSBP)>0) then
        impact_IHD:= (power(RR_IHD,meanSBP)-power(RR_IHD, (meanSBP+dSBP)))/power(RR_IHD, meanSBP);

      if( (impact_IHD>0) and (impact_IHD<1)) then
      begin
        PAF[NC_RFSodiumIntake, s, a, NC_RFIschemicHeart, t]:= (1-impact_IHD)*PAF[NC_RFSodiumIntake, s, a, NC_RFStroke, t];
        PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t]:=(1-impact_IHD)*PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t];
      end;

    end;

    if(RR_Stroke>0) then
    begin
      if(power(RR_Stroke, meanSBP)>0) then
        impact_Stroke:= (power(RR_Stroke,meanSBP)-power(RR_Stroke, (meanSBP+dSBP)))/power(RR_Stroke, meanSBP);

       if( (impact_Stroke>0) and (impact_Stroke<1)) then
        begin
          PAF[NC_RFSodiumIntake, s, a, NC_RFStroke, t]:= (1-impact_Stroke)*PAF[NC_RFSodiumIntake, s, a, NC_RFStroke, t];
          PAF[NC_RFAll, s, a, NC_RFStroke, t]:=(1-impact_Stroke)*PAF[NC_RFAll, s, a, NC_RFStroke, t];
       end;

  end;

  end;

end;{NCD_SodiumSBPAdjustment}
