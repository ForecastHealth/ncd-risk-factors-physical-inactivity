procedure NCD_FruitsOrLegumesPAFAdjustment(p:byte; t, s, a:byte;  var prev : NC_RFPrevalence; var RR :NC_RFRR; var impacts : NC_RFImpact;
  var coverages : NC_RFCoverage; var PAF : NC_RFPAF; RFFruitOrLegume:byte);
var
  cov0,cov,dcov,
  dFruit,
  Fruit0,
  Fruit,
  impact,
  impact_IHD,
  impact_Stroke,
  impact_Cancer,
  RR_IHD,
  RR_Stroke,
  RR_Cancer:double;
  I,lvl:byte;
  base_t:integer;
  intvn_list:GB_TbyteSet;
  age_list:GB_TbyteSet;
  age_lim:boolean;
begin

  base_t:=GetNCBaseYear(p)-GetGBFirstYear(p)+1;

  Fruit0:=prev[RFFruitOrLegume, s, a, base_t];
  Fruit:=Fruit0;

  if(RFFruitOrLegume=NC_RFFruitIntake) then
    intvn_list:=[NC_RFFruitPublicProcurement,NC_RFFruitMassMedia]
  else
    intvn_list:=[NC_RFLegumePublicProcurement,NC_RFLegumeMassMedia];

   age_list:=[NC_Age15_19..NC_Age80_100];

  if(I=NC_RFFruitPublicProcurement) then
    age_list:=[NC_Age15_19..NC_Age20_24];

  if(I=NC_RFLegumePublicProcurement) then
    age_list:=[NC_Age15_19..NC_Age20_24];

  for I in intvn_list  do
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
        impact:=impact + 80*impacts[I, s, a, RFFruitOrLegume, lvl,  NC_RiskBurden]/100*
                         dcov; //impact as % of 80g portion
      end;

       Fruit:=Fruit+impact;

    end;

  end;

  //if fruit intake was updated
  if( (Fruit<>Fruit0) and (Fruit>0)) then
  begin

    dFruit:=(Fruit-Fruit0);

    RR_IHD:=RR[RFFruitOrLegume, s, a, NC_RFIschemicHeart];
    RR_Stroke:=RR[RFFruitOrLegume, s, a, NC_RFStroke];
    RR_Cancer:=RR[RFFruitOrLegume, s, a, NC_RFColorectalCncr];

    impact_IHD:=1-power(RR_IHD,dFruit/200);//per 200g change
    impact_Stroke:=1-power(RR_Stroke,dFruit/200);//per 200g change
    impact_Cancer:=1-power(RR_Cancer,dFruit/200);//per 200g change

    if((impact_IHD>0) and (impact_IHD<1)) then
    begin
      PAF[RFFruitOrLegume, s, a, NC_RFIschemicHeart, t]:= (1-impact_IHD)*PAF[RFFruitOrLegume, s, a, NC_RFIschemicHeart, t];
      PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t]:=(1-impact_IHD)*PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t];
    end;

    if((impact_Stroke>0) and (impact_Stroke<1)) then
    begin
      PAF[RFFruitOrLegume, s, a, NC_RFStroke, t]:= (1-impact_Stroke)*PAF[RFFruitOrLegume, s, a, NC_RFStroke, t];
      PAF[NC_RFAll, s, a, NC_RFStroke, t]:=(1-impact_Stroke)*PAF[NC_RFAll, s, a, NC_RFStroke, t];
    end;

   if((impact_Cancer>0) and (impact_Cancer<1)) then
    begin
      PAF[RFFruitOrLegume, s, a, NC_RFColorectalCncr, t]:= (1-impact_Cancer)*PAF[RFFruitOrLegume, s, a, NC_RFColorectalCncr, t];
      PAF[NC_RFAll, s, a, NC_RFColorectalCncr, t]:=(1-impact_Cancer)*PAF[NC_RFAll, s, a, NC_RFColorectalCncr, t];
    end;



  end;

end;{NCD_FruitsOrLegumesPAFAdjustment}
