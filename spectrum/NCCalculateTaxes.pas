procedure NCCalculateTaxes(proj, taxTypeID : byte;var taxes : NC_TTaxes);
var
  t    : byte;
  tax  : ^NC_TTax;
  base : double;
begin
  base := 0;
  for t := GetNCBaseYrIndex(proj) to GetNCFinalYrIndex(proj)  do
  begin
    tax := @taxes[t];

    tax.populationEffect := 100*tax.Excise/100
                          * tax.Distribution/100
                          * (tax.DemandElas[NC_AllAges])
                          * (1-tax.Unrecorded[NC_AllAges]/100)
                          * (tax.OtherFactors[NC_AllAges]/100);

    if (GetNCBaseYrIndex(proj)  = t) then
    begin
      base := tax.populationEffect;
      tax.RelativeImpact :=  0;
    end
    else
      tax.RelativeImpact := (tax.PopulationEffect-base);
  end;
end;
