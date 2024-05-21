// Constant is NC_RFInactivity
// Is in: NF_RFWithPrevs
// Interventions are: NC_RFPhysicalActivityAwreness, NC_RFPhysicalActivityAdvice
// Collection is: NC_RFPhysicalInterv

procedure NCD_CalculateRFImpact(
  proj: byte;
  sex, lvl, t: byte;
  var prev: NC_RFPrevalence;
  var RR: NC_RFRR;
  var impacts: NC_RFImpact;
  var coverages: NC_RFCoverage;
  var hap_usage: NC_HAP_Cov;
  var PAF: NC_RFPAF
); overload;
var
  rf, a, base_t, i, d, alc, m: byte;
  impact, prev_rr, exp_adj, prev_update, PAF_Denom: double;
  applyInterv: boolean;
  PublicProcurementList: GB_TByteSet;
begin

  base_t := GetNCBaseYrIndex(proj);
  
  for a := 1 to NC_MaxAgeGrp do
    for d := NC_RFIschemicHeart to NC_RFMaxDisease do
    begin
      PAF_Denom := 1;
      for rf in NF_RFWithPrevs do
      begin
        prev_rr := (prev[rf, sex, a, base_t] / 100) * (RR[rf, sex, a, d] - 1);
        PAF_Denom := PAF_Denom + prev_rr;
      end;
      for rf in NF_RFWithPrevs do
      begin
        prev_rr := (prev[rf, sex, a, base_t] / 100) * (RR[rf, sex, a, d] - 1);
        PAF[rf, sex, a, d, base_t] := 100 * prev_rr / PAF_Denom;
      end;
      for rf in [NC_RFAlcohol..NC_RFInactivity, NC_RF_HAP_Biomass..NC_RF_HAP_Electric] do
        PAF[rf, sex, a, d, t] := 0;
    end;

  for rf in [NC_RFAlcohol .. NC_RegRFMax] do
    for a := NC_Age0_4 to NC_MaxAgeGrp do
      prev[rf, sex, a, t] := prev[rf, sex, a, base_t];

  for i := NC_RFTobaccoPolicy to NC_RFPhysicalActivityAdvice do
    if i <> NC_RFAlcoholDriveLaws then
    begin
      impact := 0;
      for a := NC_Age0_4 to NC_MaxAgeGrp do
        for rf in NF_RFWithPrevs do
        begin
          if not (i in NC_RFFourLevelInterv) then
            for lvl in [GetNCRF_TargCovLvl(proj)] do
              impact := impact + (impacts[i, sex, a, rf, lvl, NC_RiskBurden] / 100 * 
                                  (coverages[i, lvl, sex, t] - coverages[i, lvl, sex, base_t]) / 100)
          else
            for lvl := NC_Level1 to NC_Level4 do
              impact := impact + (impacts[i, sex, a, rf, lvl, NC_RiskBurden] / 100 * 
                                  (coverages[i, lvl, sex, t] - coverages[i, lvl, sex, base_t]) / 100);
        end;

      rf := NC_GetRiskFactorForInterv(i);
      applyInterv := ((impact <> 0) and (rf > 0));

      if applyInterv then
        for rf in NF_RFWithPrevs do
          for a := NC_Age0_4 to NC_MaxAgeGrp do
          begin
            begin
              impact := 0;
              if not (i in NC_RFFourLevelInterv) then
                for lvl in [GetNCRF_TargCovLvl(proj)] do
                  impact := impact + impacts[i, sex, a, rf, lvl, NC_RiskBurden] / 100 * 
                            (coverages[i, lvl, sex, t] - coverages[i, lvl, sex, base_t]) / 100
              else
                for lvl := NC_Level1 to NC_Level4 do
                  impact := impact + impacts[i, sex, a, rf, lvl, NC_RiskBurden] / 100 * 
                            (coverages[i, lvl, sex, t] - coverages[i, lvl, sex, base_t]) / 100;
            end;

            if (CompareValue(impact, 0, 0.00001) = 0) then
              impact := 0;

            prev_update := prev[rf, sex, a, t] / 100;
            prev_update := prev_update * (1 - impact);

            prev_update := GBmax([prev_update, 0]);
            prev_update := GBmin([prev_update, 1]);

            if (rf in [NC_RFAlcohol, NC_RFInactivity, NC_RFSmoke]) then
              prev_update := GBmin([prev_update, 1]);

            prev[rf, sex, a, t] := prev_update * 100;
          end;
    end;

  for a := 1 to NC_MaxAgeGrp do
    for d := NC_RFIschemicHeart to NC_RFMaxDisease do
    begin
      PAF_Denom := 1;
      for rf in NF_RFWithPrevs do
      begin
        prev_rr := (prev[rf, sex, a, t] / 100) * (RR[rf, sex, a, d] - 1);
        PAF_Denom := PAF_Denom + prev_rr;
      end;
      for rf in NF_RFWithPrevs do
      begin
        prev_rr := (prev[rf, sex, a, t] / 100) * (RR[rf, sex, a, d] - 1);
        PAF[rf, sex, a, d, t] := 100 * prev_rr / PAF_Denom;
      end;
    end;

  for a := NC_Age0_4 to NC_MaxAgeGrp do
  begin
    for rf in NF_RFWithPrevs do
      for d := NC_RFIschemicHeart to NC_RFMaxDisease do
      begin
        impact := (PAF[rf, sex, a, d, base_t] - PAF[rf, sex, a, d, t]) / 100;
        if ((impact > 0) and (impact < 1)) then
        begin
          PAF[rf, sex, a, d, t] := impact * 100;
        end;
      end;
  end;
end;
