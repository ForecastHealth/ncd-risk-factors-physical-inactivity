procedure NCD_BMIPAFAdjustment(p:byte; t, s, a:byte;  var prev : NC_RFPrevalence; var RR :NC_RFRR; var impacts : NC_RFImpact;
  var coverages : NC_RFCoverage; var PAF : NC_RFPAF);
var
  cov0,cov,dcov,
  dBMI,
  BMI0,
  Weight0,
  Weight,
  dWeight,
  impact,
  impact_IHD,
  impact_Stroke,
  RR_IHD,
  RR_Stroke:double;
  I,lvl:byte;
  base_t:integer;
  dKCal,dKCal_Denom:double;
begin

  base_t:=GetNCBaseYear(p)-GetGBFirstYear(p)+1;

  Weight0:=prev[NC_RFBodyWeight, s, a, base_t];
  Weight:=Weight0;
  dWeight:=0;

  BMI0:=prev[NC_RFBMI, s, a, base_t];

//  Policies to protect children from advergames -> Energy intake
//  -60 kcal/day
//
//  Energy intake -> body weight
//  -1kg in body weight for each
//  -(68  2.5*age) kcal/day in energy intake (boys aged 5-18 years)
//  -(62  2.2*age) kcal/day in energy intake (girls aged 5-18 years)

  if(a=NC_Age15_19) then
  for I in [NC_RFSodiumMisleadingMarket]  do
  begin

    lvl := GetNCRF_TargCovLvl(p);
    cov0:=coverages[I, lvl, s, base_t]/100;
    cov:=coverages[I, lvl, s, t]/100;
    dcov:=cov-cov0;

    dKCal:=60*dcov;

    if(dKCal>0) then
    if(s=NC_DP_Male) then
    begin
        dKCal_Denom:=(68-2.5*17);//using age 17
        dWeight:=dKCal/dKCal_Denom;
    end
    else
    begin
       dKCal_Denom:=(62-2.2*17);//using age 17
       dWeight:=dKCal/dKCal_Denom;
    end
  end;

  //if weight and BMI was updated
  if((a=NC_Age15_19) and (dWeight>0)) then
  begin

      dBMI:=BMI0*dWeight/Weight0;
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
          PAF[NC_RFBodyWeight, s, a, NC_RFIschemicHeart, t]:= (1-impact_IHD)*PAF[NC_RFBodyWeight, s, a, NC_RFIschemicHeart, t];
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
          PAF[NC_RFBodyWeight, s, a, NC_RFStroke, t]:= (1-impact_Stroke)*PAF[NC_RFBodyWeight, s, a, NC_RFStroke, t];
          PAF[NC_RFAll, s, a, NC_RFStroke, t]:=(1-impact_Stroke)*PAF[NC_RFAll, s, a, NC_RFStroke, t];
        end;

      end;


  end;

end;{NCD_BMIPAFAdjustment}
