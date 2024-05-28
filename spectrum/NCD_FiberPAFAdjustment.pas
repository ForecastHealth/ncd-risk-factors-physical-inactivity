procedure NCD_FiberPAFAdjustment(p:byte; t, s, a:byte;  var prev : NC_RFPrevalence; var RR :NC_RFRR; var impacts : NC_RFImpact;
  var coverages : NC_RFCoverage; var PAF : NC_RFPAF);
var
  cov0,cov,dcov,
  dFiber,
  Fiber0,
  Fiber,
  impact,
  impact_IHD,
  impact_Stroke,
  impact_Cancer,
  impact_Diabetes,
  RR_IHD,
  RR_Stroke,
  RR_Cancer,
  RR_Diabetes:double;
  I,lvl:byte;
  base_t:integer;
begin

  base_t:=GetNCBaseYear(p)-GetGBFirstYear(p)+1;

  Fiber0:=prev[NC_RFFiberIntake, s, a, base_t];
  Fiber:=Fiber0;

  for I in [NC_RFFiberFrontPackLabelling]  do
  begin
    impact:=0;
    //for lvl := NC_Level1 to NC_Level4 do
    for lvl in [GetNCRF_TargCovLvl(p)] do
    begin
      cov0:=coverages[I, lvl, s, base_t]/100;
      cov:=coverages[I, lvl, s, t]/100;
      dcov:=cov-cov0;
      impact:=impact +  impacts[I, s, a, NC_RFFiberIntake, lvl,  NC_RiskBurden]/100*
                        dcov //impact given as g increase
    end;

     Fiber:=Fiber+impact;
  end;

  //if fruit intake was updated
  if( (Fiber<>Fiber0) and (Fiber>0)) then
  begin

    dFiber:=(Fiber-Fiber0);

    RR_IHD:=RR[NC_RFFiberIntake, s, a, NC_RFIschemicHeart];
    RR_Stroke:=RR[NC_RFFiberIntake, s, a, NC_RFStroke];
    RR_Cancer:=RR[NC_RFFiberIntake, s, a, NC_RFColorectalCncr];
    RR_Diabetes:=RR[NC_RFFiberIntake, s, a, NC_RFDiabetes];


    impact_IHD:=1-power(RR_IHD,dFiber/8);//impact per 8g change
    impact_Stroke:=1-power(RR_Stroke,dFiber/8);//impact per 8g change
    impact_Cancer:=1-power(RR_Cancer,dFiber/8);//impact per 8g change
    impact_Diabetes:=1-power(RR_Diabetes,dFiber/8);//impact per 8g change

    if((impact_IHD>0) and (impact_IHD<1)) then
    begin
      PAF[NC_RFFiberIntake, s, a, NC_RFIschemicHeart, t]:= (1-impact_IHD)*PAF[NC_RFFiberIntake, s, a, NC_RFIschemicHeart, t];
      PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t]:=(1-impact_IHD)*PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t];
    end;

    if((impact_Stroke>0) and (impact_Stroke<1)) then
    begin
      PAF[NC_RFFiberIntake, s, a, NC_RFStroke, t]:= (1-impact_Stroke)*PAF[NC_RFFiberIntake, s, a, NC_RFStroke, t];
      PAF[NC_RFAll, s, a, NC_RFStroke, t]:=(1-impact_Stroke)*PAF[NC_RFAll, s, a, NC_RFStroke, t];
    end;

    if((impact_Cancer>0) and (impact_Cancer<1)) then
    begin
      PAF[NC_RFFiberIntake, s, a, NC_RFColorectalCncr, t]:= (1-impact_Cancer)*PAF[NC_RFFiberIntake, s, a, NC_RFColorectalCncr, t];
      PAF[NC_RFAll, s, a, NC_RFColorectalCncr, t]:=(1-impact_Cancer)*PAF[NC_RFAll, s, a, NC_RFColorectalCncr, t];
    end;

    if((impact_Diabetes>0) and (impact_Diabetes<1)) then
    begin
      PAF[NC_RFFiberIntake, s, a, NC_RFDiabetes, t]:= (1-impact_Diabetes)*PAF[NC_RFFiberIntake, s, a, NC_RFDiabetes, t];
      PAF[NC_RFAll, s, a, NC_RFDiabetes, t]:=(1-impact_Diabetes)*PAF[NC_RFAll, s, a, NC_RFDiabetes, t];
    end;


  end;

end;{NCD_FiberPAFAdjustment}
