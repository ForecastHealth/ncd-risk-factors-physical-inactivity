procedure NCD_TransFatCholAdjustment(p:byte; t, s, a:byte;  var prev : NC_RFPrevalence; var RR :NC_RFRR; var impacts : NC_RFImpact;
  var coverages : NC_RFCoverage; var PAF : NC_RFPAF);
var
  cov0,cov,dcov,
  dChol,
  transfat0,
  transfat,
  dtransfat,
  impact,
  impact_IHD,
  impact_Stroke,
  RR_IHD,
  RR_Stroke,
  meanChol       : double;
  I,lvl:byte;
  base_t:integer;
begin

  base_t:=GetNCBaseYear(p)-GetGBFirstYear(p)+1;
  transfat0:=prev[NC_RFSaturatedFatIntake, s, a, base_t];
  transfat:=transfat0;

  for I in [NC_RFTransFatPublicProcurement,NC_RFTransFatFrontPackLabelling] do
  begin

      impact:=0;
      if ( not( (I in [NC_RFTransFatPublicProcurement]) and (a>NC_Age20_24)) ) then
      begin

        //for lvl := NC_Level1 to NC_Level4 do
        for lvl in [GetNCRF_TargCovLvl(p)] do
        begin
          cov0:=coverages[I, lvl, s, base_t]/100;
          cov:=coverages[I, lvl, s, t]/100;
          dcov:=(cov-cov0);
          impact:=impact + impacts[I, s, a, NC_RFSaturatedFatIntake, lvl,  NC_RiskBurden]/100*
                           dcov
        end;
         transfat:=max(transfat-impact,0);

    end;

  end;

  if(FALSE) then //no relative impacts
  for I in [NC_RFTransFatFrontPackLabelling] do
  begin

   impact:=0;
   //for lvl := NC_Level1 to NC_Level4 do
   for lvl in [GetNCRF_TargCovLvl(p)] do
   begin
     cov0:=coverages[I, lvl, s, base_t]/100;
     cov:=coverages[I, lvl, s, t]/100;
     dcov:=(cov-cov0);
     impact:=impact + impacts[I, s, a, NC_RFSaturatedFatIntake, lvl,  NC_RiskBurden]/100*
                      dcov;

   end;
   transfat:=transfat*(1-impact);//through relative impact

  end;

  //if transfat intake was updated
  if( (transfat<>transfat0) and (transfat0>0)) then
  begin

    dtransfat:=(transfat0-transfat);

    impact_IHD:=0;
    impact_Stroke:=0;

    impact:=RR[NC_RFSaturatedFatIntake, s, a, NC_RFCholesterol];
    dChol:=(dtransfat)*impact; //reduction of 0.064  mmol/L per 1% of energy from SFA replaced by cis-PUFA

    meanChol:=Prev[NC_RFMeanChol, s, a, base_t];
    RR_IHD:=RR[NC_RFMeanChol, s, a, NC_RFIschemicHeart];
    RR_Stroke:=RR[NC_RFMeanChol, s, a, NC_RFStroke];

    if(RR_IHD>0) then
    begin
      if(power(RR_IHD, meanChol)>0) then
        impact_IHD:= (power(RR_IHD,meanChol)-power(RR_IHD, (meanChol-dChol)))/power(RR_IHD, meanChol);

       if( (impact_IHD>0) and (impact_IHD<1)) then
       begin
          PAF[NC_RFSaturatedFatIntake, s, a, NC_RFIschemicHeart, t]:= (1-impact_IHD)*PAF[NC_RFSaturatedFatIntake, s, a, NC_RFIschemicHeart, t];
          PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t]:=(1-impact_IHD)*PAF[NC_RFAll, s, a, NC_RFIschemicHeart, t];
       end

    end;

    if(RR_Stroke>0) then
    begin
      if(power(RR_Stroke, meanChol)>0) then
        impact_Stroke:= (power(RR_Stroke,meanChol)-power(RR_Stroke, (meanChol-dChol)))/power(RR_Stroke, meanChol);

        if( (impact_Stroke>0) and (impact_Stroke<1)) then
        begin
          PAF[NC_RFSaturatedFatIntake, s, a, NC_RFStroke, t]:= (1-impact_Stroke)*PAF[NC_RFSaturatedFatIntake, s, a, NC_RFStroke, t];
          PAF[NC_RFAll, s, a, NC_RFStroke, t]:=(1-impact_Stroke)*PAF[NC_RFAll, s, a, NC_RFStroke, t];
        end;
    end;

  end;

end;{NCD_TransFatCholAdjustment}
