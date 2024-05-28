unit NCConst;

(* This unit declares constants used throughout the module. Try to use
   as many standard global constants from GB as possible (ex: GB_NOERROR,
   GB_MAX_PROJ). *)

interface

const
  {$I NCTagsRW.INC}

  (* Constants for writing to file *)
  NC_Version       = 1.1;
  NC_DataFileTitle = 'NC Data File';

  NC_DefaultBaseYear = 2019;
  NC_DefaultTargYear = 2025;

  (*Sections*)
  NC_EpiSec     = 1;
  NC_DiagSec    = 2;
  NC_HlthImpSec = 3;
  NC_Demography = 4;
  NC_SummarySec = 5;
  NC_PyramidSex = 6;
  NC_ValidatSec = 7;
  NC_NUM_Sect   = 7;

  (*Display indicators*)
  NC_IncInd          = 1;
  NC_PrevInd         = 2;
  NC_MortInd         = 3;
  NC_PopulInd        = 4;
  NC_DPMortInd       = 5;
  NC_PopAgeInd       = 6;
  NC_HYL             = 7; (*Healthy Years Lived, Live long and prosper 2-27-15*)
  NC_DWInd           = 8; //Disability weight
  NC_MortImpInd      = 9; //mortality impact
  NC_MortTotalInd    = 10;//total mortality
  NC_EpiSummaryInd   = 11;//Epidemiology Summary
  NC_HlthSummaryInd  = 12;
  NC_pplReachedInd   = 13;//number of people reached
  NC_targPopSumInd   = 14;//number of people reached
  NC_SummaryInd      = 15;
  NC_BirthsInd       = 16;
  NC_DiagstackBarInd = 17;
  NC_HealthImpIncInd = 18;
  NC_DiagCasesInd    = 19;
  NC_RemInd          = 20;
  NC_RemDWInd        = 21;
  NC_PrevImpInd      = 22;
  NC_PyrIncInd       = 23;
  NC_PyrRemInd       = 24;
  NC_PyrPrevInd      = 25;
  NC_PyrMortInd      = 26;
  NC_PyrPopInd       = 27;
  NC_SumPopAgeInd    = 28;
  NC_SumRiskHYLInd   = 29;
  NC_SumRiskMortInd  = 30;
//  NC_DALYInd         = 31;
  NC_YLDInd          = 31;
  NC_AFInd           = 32;
  NC_ProbDyingInd    = 33;
  NC_TargetPopInd    = 34;   //onehealth
  NV_ValidIncInd     = 35;
  NV_ValidCFRInd     = 36;
  NV_ValidStageDInd  = 37;
  NV_ValidHPVPrevInd = 38;
  NV_ValidHPVDInd    = 39;
  NC_DiagBYStage     = 40;
  NC_RecurrenceInd   = 41;
  NC_HAPHYLInd       = 42;
  NC_HAPYLDInd       = 43;
  NC_HAPMorbidityInd = 44;
  NC_HAPMortalityInd = 45;
  NC_YLLInd          = 46;
  NC_DALYInd         = 47;
  NC_NUM_IND         = 45;

  NC_NoScaleUp       = 0;
  NC_DoScaleUp       = 1;
  NC_Impact          = 2;
  NC_MaxImpactTypes  = 2;


  NC_PopIndicators = [NC_PopulInd, NC_DPMortInd,NC_PopAgeInd, NC_SumPopAgeInd];

  NC_HlthImpInd =
    [NC_HYL,      NC_DWInd,      NC_MortImpInd,      NC_DALYInd,
     NC_RemDWInd, NC_PrevImpInd, NC_HealthImpIncInd, NC_YLDInd,  NC_YLLInd];

  NC_PyramidSet =
    [NC_PyrIncInd,  NC_PyrRemInd, NC_PyrMortInd,
     NC_PyrPrevInd, NC_PyrPopInd];

  NC_AllDiseaseResultInd =
    [NC_SumRiskHYLInd, NC_SumRiskMortInd, NC_AFInd, NC_ProbDyingInd];

  NC_ByDiseaseResultInd = [1..NC_NUM_IND]-NC_AllDiseaseResultInd;

  NC_ValidationInd = [NV_ValidIncInd..NV_ValidHPVDInd];

  NC_HAPIndSet = [NC_HAPHYLInd, NC_HAPYLDInd, NC_HAPMorbidityInd, NC_HAPMortalityInd];

  NC_Per100k  = 1;
  NC_Per1k    = 2;
  NC_NumCases = 3;

  NC_prevPerPerson = 1;
  NC_prevPer1k     = 2;
  NC_pervPer100k   = 3;

  NC_SolidDot = 3;

  (*population indicator*)
  NC_FromDP = 1;
  NC_FromNC = 2;

  NC_TargetPop  =1;
  NC_PopReached =2;

  (*Aggregate ages or display total*)
  NC_DisAggrAges   = 1;
  NC_TotalAgesSum  = 2;

  NC_SummaryTables = [NC_PopAgeInd,       NC_EpiSummaryInd, NC_SumPopAgeInd,
                      NC_HlthSummaryInd,  NC_pplReachedInd, NC_SummaryInd,
                      NC_DiagstackBarInd, NC_targPopSumInd, NC_SumRiskHYLInd,
                      NC_SumRiskMortInd,  NC_AFInd,         NC_TargetPopInd,
                      NC_DiagBYStage];


  NC_NUM_EDITORS = 1;

  NC_MAXChart = 1;

  NC_MaxNumLines = 72;

  (*Diseases*)
  NC_NoDisease    = -1;
  NC_AllDiseases  = 0;
  NC_ARF_RHD      = 1;      // Acute rheumatic fever and rheumatic heart disease
  NC_CVD          = 2;  //cardio vascular disease
  NC_Diabetes     = 3;
  NC_BrstCncr     = 4;   //breast cancer
  NC_CervicCncr   = 5;   //cervical cancer
  NC_ColonCncr    = 6;  //colon cancer
  NC_Depression   = 7;
  NC_Postnatal    = 8;  //post natal depression
  NC_Anxiety      = 9;
  NC_Psychosis    = 10;
  NC_Bipolar      = 11;
  NC_Epilepsy     = 12;
  NC_Alcoholism   = 13;
  NC_Conduct      = 14;  //conduct disorder (ie disruptive children)
  NC_Attention    = 15;  //Attention deficit hyperactivity disorder (ADHD);
  NC_COPD         = 16;  //Chronic Obstructive Pulmonary Disease
  NC_Asthma       = 17;
  NC_LungCncr     = 18;
  NC_ALRI         = 19;
  NC_maxDiseases  = 19;


  NC_CancerIDs = [NC_BrstCncr,NC_CervicCncr,NC_ColonCncr,NC_LungCncr];
  NC_MaleOnlyDiseases = [];
  NC_FemaleOnlyDiseases = [NC_BrstCncr,NC_CervicCncr, NC_Postnatal];  //, NC_CervicCncr
  NC_SingleGenderDiseases = NC_MaleOnlyDiseases+NC_FemaleOnlyDiseases;

  NC_DeveloperDisease = [NC_ARF_RHD];
  NC_DisabledDiseases = [];

  NC_RiskDiseaseSet =
    [NC_CVD,        NC_Diabetes,  NC_Depression,
     NC_Postnatal,  NC_Epilepsy,  NC_COPD,
     NC_Asthma,     NC_ARF_RHD];

  NC_AllowZeroStartCov =  [NC_BrstCncr,NC_CervicCncr,NC_ColonCncr];

  NC_MNSDiseases = [NC_Depression..NC_Attention];
  (*health states*)
  NC_AllStates            = 0;
  NC_None                 = 1;

  NC_DsFreeSus            = 2;

  //CVD
  NC_StrokeAcute          = 3; //A cute Stroke <3
  NC_IHDAcute             = 4; //Acute Ischemic Heart Disease
  NC_StrokeIHDAcute       = 5;
  NC_StrokePostAcute      = 6;
  NC_IHDPostAcute         = 7;
  NC_StrokeIHDPostAcute   = 8;

  //MNS
  NC_PsychosisEpsd        = 9;
  NC_DepressionEpsd       = 10;
  NC_EpilepsyEpsd         = 11;
  NC_AlcoholismEpsd       = 12;
  NC_DepressAlcEpsd       = 13;
  NC_PsychoticEpsd        = 14;
  NC_BipolarEpsd          = 15;
  NC_ConductEpsd          = 16;
  NC_AttentionEpsd        = 17;
  NC_PostnatalEpsd        = 18;
  NC_AnxietyEpsd          = 19;

  //Lung
  NC_COPDEpsd             = 20;
  NC_AsthmaEpsd           = 21;

  //Diabetes
  NC_DiabetesEpsd         = 22;
  NC_DiabeticRetpathy     = 23;
  NC_LowerExtrmAmpt       = 24;
  NC_DiabeticNephropathy  = 25;


  //Cancers
  NC_DsFreeSusScr         = 26;
  NC_NonCancerous1        = 27;
  NC_NonCancerous2        = 28;
  NC_NonCancerous3        = 29;

  //Colorectal
  NC_PolypLT5mm           = 30;
  NC_Polyp6to10mm         = 31;
  NC_PolypGT10mm          = 32;
  NC_PolypLT5mmClinical   = 33;
  NC_Polyp6to10mmClinical = 34;
  NC_PolypGT10mmClinical  = 35;

  NC_PreCancerous1        = 36;
  NC_PreCancerous2        = 37;
  NC_PreCancerous3        = 38;

  NC_PreClinical0         = 39;
  NC_PreClinical1         = 40;
  NC_PreClinical2         = 41;
  NC_PreClinical3         = 42;
  NC_PreClinical4         = 43;

  NC_Clinical0            = 44;
  NC_Clinical1            = 45;
  NC_Clinical2            = 46;
  NC_Clinical3            = 47;
  NC_Clinical4            = 48;
  //Cervical
  NC_HPV16_18             = 49;
  NC_CIN1_16_18           = 50;
  NC_CIN2_16_18           = 51;
  NC_HPVLowRisk           = 52;
  NC_CIN1LowRisk          = 53;
  NC_CIN2LowRisk          = 54;
  NC_HPVHighRisk          = 55;
  NC_CIN1HighRisk         = 56;
  NC_CIN2_3_High_Risk     = 57;
  NC_HPV_16_18_regr       = 58;
  NC_HPV_High_Risk_regr   = 59;
  NC_HPV_Low_Risk_regr    = 60;
  NC_Immunity             = 61;
  NC_Vaccinated           = 62;

  // health states for Acute rheumatic fever and rhematic heart disease
//  NC_ARF0                 = 62;  // acute RF , 1st episode
//  NC_REM                  = 63;  // remission
//  NC_ARF1                 = 64;  // recurrence ARF
//  NC_RHD0                 = 65;  // rheumatic heart disease (mild)
//  NC_STK                  = 66;  // stroke
//  NC_RHD1                 = 67;  // rheumatic heart disease (severe)
//  NC_RHD1m                = 68;  // rheumatic heart disease (mild), med management not surgery

  NC_ARF0                 = 63;  //acute RF , 1st episode
  NC_REM                  = 64;  //remission
  NC_ARF1                 = 65;  //recurrence ARF1
  NC_RHD0                 = 66;  //rheumatic heart disease (mild)
  NC_ARF2                 = 67;  //recurrence ARF2
  NC_RHD1                 = 68;  //rheumatic heart disease (severe)
  NC_RHDOp                = 69;  //Post operative RHD
  NC_STK                  = 70; //Stroke
  NC_LungCncrEpsd         = 71;
  NC_ALRIEpsd             = 72;
  NC_RHD1m                = 73;  //rheumatic heart disease (severe)
                              //<--Add health states here, before disability!
  NC_Disability          = 74;
  NC_Deceased            = 75;
  NC_maxHlthState        = 75;


  NC_NonZeroRateStates = [];//[NC_NonCancerous1, NC_NonCancerous2, NC_NonCancerous3,
                          //NC_PreCancerous1, NC_PreCancerous2, NC_PreCancerous3];

  NC_CVDStates = [NC_StrokeAcute,     NC_IHDAcute,     NC_StrokeIHDAcute,
                  NC_StrokePostAcute, NC_IHDPostAcute, NC_StrokeIHDPostAcute];



  NC_BreastStates =
    [NC_PreClinical0, NC_PreClinical1, NC_PreClinical2,
     NC_PreClinical3, NC_Clinical0,    NC_Clinical1,
     NC_Clinical2,    NC_Clinical3];

  NC_CervicalStates =
    [NC_PreClinical0, NC_PreClinical1, NC_PreClinical2,   NC_PreClinical3,
     NC_PreClinical4, NC_Clinical0,    NC_Clinical1,      NC_Clinical2,
     NC_Clinical3,    NC_Clinical4];


  NC_ColonStates =
    [NC_PreClinical0, NC_PreClinical1, NC_PreClinical2,
     NC_PreClinical3, NC_Clinical0,    NC_Clinical1,
     NC_Clinical2,    NC_Clinical3];

  NC_CINSet = [NC_CIN1LowRisk, NC_CIN1HighRisk,     NC_CIN1_16_18,
               NC_CIN2LowRisk, NC_CIN2_3_High_Risk, NC_CIN2_16_18];

   NC_CervicalPrevalenceStates =
    [NC_HPV16_18,   NC_CIN1_16_18,  NC_CIN2_16_18,   NC_HPVLowRisk,
     NC_CIN1LowRisk,  NC_CIN2LowRisk,  NC_HPVHighRisk,  NC_CIN1HighRisk,
     NC_CIN2_3_High_Risk,  NC_HPV_16_18_regr,  NC_HPV_High_Risk_regr,
     NC_HPV_Low_Risk_regr,  NC_Immunity,   NC_Vaccinated];


   NC_HPVStates =
    [NC_HPV16_18,   NC_CIN1_16_18,  NC_CIN2_16_18,   NC_HPVLowRisk,
     NC_CIN1LowRisk,  NC_CIN2LowRisk,  NC_HPVHighRisk,  NC_CIN1HighRisk,
     NC_CIN2_3_High_Risk,  NC_HPV_16_18_regr,  NC_HPV_High_Risk_regr,
     NC_HPV_Low_Risk_regr];

   NC_ARF_RHDStates =
    [NC_ARF0, NC_REM, NC_ARF1, NC_RHD0, NC_STK, NC_RHD1];

   NC_DiabetesStates =
     [NC_DiabetesEpsd,NC_DiabeticRetpathy,NC_LowerExtrmAmpt,NC_DiabeticNephropathy];

   NC_AsthmaStates = [NC_AsthmaEpsd];
   NC_COPDStates   = [NC_COPDEpsd];
   NC_RHDStates   = [NC_ARF0 .. NC_RHDOp ];

  (*health state transitions*)
  NC_AllTransitions = 0;
  NC_NoTrasition    = 1;
  NC_Incidence      = 2;
  NC_Progression    = 3;
  NC_Recovery       = 4;
  NC_CFR            = 5;
  NC_Screened       = 6;
  NC_Function       = 7;
  NC_Remission      = 8;
  NC_Onset          = 9;
  NC_Recurrence     = 10;
  NC_maxTransitions = 10;

  (*risk factors*)
  NC_AllRisks         = 0;
  NC_NoRisk           = 1;

  //CVD
  NC_BldPrsr160TRlt20 = 2; //systolic blood pressure 160; risk less than 20%
  NC_BldPrsr140TRlt20 = 3; //systolic blood pressure 140; risk less than 20%

  NC_Cholest8TRlt20   = 4; //Cholesterol 8; risk less than 20%
  NC_Cholest6TRlt20   = 5; //Cholesterol 6; risk less than 20%

  NC_BldPrsr160TRlt30 = 6; //systolic blood pressure 160; risk less than 30%
  NC_BldPrsr140TRlt30 = 7; //systolic blood pressure 140; risk less than 30%

  NC_Cholest8TRlt30   = 8; //Cholesterol 8; risk less than 30%
  NC_Cholest6TRlt30   = 9; //Cholesterol 6; risk less than 30%

  NC_TotalCVDRiskgt20 = 10; //Combo CVD; risk greater than 20%
  NC_TotalCVDRiskgt30 = 11; //Combo CVD; risk greater than 30%

  NC_NonDiabTotalCVDRisklt10           = 12; //Total risk for CVD less than 10
  NC_NonDiabTotalCVDRisk10to20SBPgt140 = 13; //TR 10% to 20%, SBP gt 140
  NC_NonDiabTotalCVDRisk10to20SBPlt140 = 14; //TR 10% to 20%, SBP lt 130

  NC_NonDiabTotalCVDRiskgt20SBPgt130   = 15; //TR >20%, SBP gt 130
  NC_NonDiabTotalCVDRiskgt20SBPlt130   = 16; //TR >20%, SBP lt 130

  NC_NonDiabSBPgt130=17;
  NC_NonDiabSBPgt140=18;

  NC_DiabSBPgt130=19;
  NC_DiabSBPgt140=20;
  NC_DiabStatinsAgegt40=21;

  NC_CVDRFmax=21;

  //general
  NC_Smoke            = 22;
  NC_Inactivity       = 23;

  // indoor/household air pollution
  NC_Household_AP     = 24;

  NC_maxRisks         = 24;

  (*age categories *)
  NC_AllAges   = 0;
  NC_Age0_4    = 1;
  NC_Age5_9    = 2;
  NC_Age10_14  = 3;
  NC_Age15_19  = 4;
  NC_Age20_24  = 5;
  NC_Age25_29  = 6;
  NC_Age30_39  = 7;
  NC_Age40_49  = 8;
  NC_Age50_59  = 9;
  NC_Age60_69  = 10;
  NC_Age70_79  = 11;
  NC_Age80_100 = 12;
  NC_MaxAgeGrp = 12;




  (*Intervention constants*)
  //CVD
  NC_PreventTRgt30              = 1; //Total Risk greater than 30% (CVD)
  NC_PreventBldPrsr160lt30      = 2; //Blood Pressure 160 risk less than 30%
  NC_PreventBldPrsr140lt30      = 3; //Blood Pressure 140 risk less than 30%
  NC_PreventCholest8lt30        = 4; //Cholesterol 8 risk less than 30%
  NC_PreventCholest6lt30        = 5; //Cholesterol 6 risk less than 30%
  NC_PreventTRgt20              = 6; //Total Risk greater than 20% (CVD)
  NC_PreventBldPrsr160lt20      = 7; //Blood Pressure 160 risk less than 20%
  NC_PreventBldPrsr140lt20      = 8; //Blood Pressure 140 risk less than 20%
  NC_PreventCholest8lt20        = 9; //Cholesterol 8 risk less than 20%
  NC_PreventCholest6lt20        = 10;//Cholesterol 6 risk less than 20%

  NC_PreventNonDiabTRlt10           = 11;//No Diabetes, TR < 10%
  NC_PreventNonDiabTR10to20SBPgt140 = 12;//No Diabetes, TR 10% to 20%, SBP gt 140
  NC_PreventNonDiabTR10to20SBPlt140 = 13;//No Diabetes, TR 10% to 20%, SBP lt 130
  NC_PreventNonDiabTRgt20SBPgt130   = 14;//No Diabetes, TR >20%, SBP gt 130
  NC_PreventNonDiabTRgt20SBPlt130   = 15;//No Diabetes, TR >20%, SBP lt 130
  NC_PreventNonDiabSBPgt130         = 16;//No Diabetes, SBP > 130
  NC_PreventNonDiabSBPgt140         = 17;//No Diabetes, SBP > 140

  NC_PreventDiabSBPgt130            = 18;//Diabetes, SBP > 130
  NC_PreventDiabSBPgt140            = 19;//Diabetes, SBP > 140
  NC_PreventDiabStatinsAgegt40      = 20;//Diabetes, age > 40

  NC_TreatAMIAcuteAspirin                           = 21;//Treatment of new cases of acute myocardial infarction (AMI) with aspirin
  NC_TreatAMIAcuteAspirinAndTrombolysis             = 22;
  NC_TreatAMIAcuteAspirinAndClopidro                = 23;
  NC_TreatAMIAcutePCIAndAspirinAndClopidro          = 24;

  NC_TreatMechanicalTrombStroke                     = 25;
  NC_TreatIntravTrombStroke                         = 26;

  NC_TreatPostAcuteIHDComb                          = 27;
  NC_TreatPostAcuteStrokeComb                       = 28;

  NC_TreatStrokeAcuteAspirin                        = 29;
  NC_TreatStrokeCare                                = 30;

  NC_EliminateTransFats         = 31;

  NC_Tobacco                    = 32;
  NC_Exercise                   = 33;

  //MNS
  NC_AntiEpiBasic               = 34;
  NC_AntiPsychBasic             = 35;
  NC_AntiPsychInten             = 36;
  NC_AntiDepBasic               = 37;
  NC_PsychSocialInten           = 38;
  NC_PerinatalPsySoc            = 39;
  NC_AlcAssess                  = 40;
  NC_AlcBrief                   = 41;
  NC_AlcWithdrawl               = 42;
  NC_AlcRelapsePrevnt           = 43;
  NC_BiPolarStableBase          = 44;
  NC_BiPolarStableInten         = 45;
  NC_PrvntDepression            = 46;
  NC_PrvntAlcohol               = 47;
  NC_PrvntAnxiety               = 48;
  NC_AntiDeprIntensPsychNEW     = 49;
  NC_AntiDeprIntensPsychREC     = 50;

  //COPD
  NC_SmokingCessation           = 51;
  NC_InhaledSalbutamol          = 52;
  NC_LowDoseOralTheophylline    = 53;
  NC_IpratropiumInhaler         = 54;
  NC_Antibiotics                = 55;
  NC_OralPrednisolone           = 56;
  NC_OxygenConcentration24to28  = 57;

  //Asthma
  NC_InhaleShortactingBeta      = 58;
  NC_LowDoseBeclom              = 59;
  NC_HighDoseBeclom             = 60;
  NC_TheopPlusBeclom            = 61;
  NC_OralPrednisTheopPlusBeclom = 62;
  NC_AsthmaOralPrednisolone     = 63;

  //Diabetes
  NC_StdGlycControl             = 64;
  NC_IntsvGlycControl           = 65;
  NC_RetinopathyScrn            = 66;
  NC_NeuropathyScr              = 67;
  NC_NephropathyScr             = 68;

  //Cancers
  NC_TreatmentStage0            = 69;
  NC_TreatmentStage1            = 70;
  NC_TreatmentStage2            = 71;
  NC_TreatmentStage3            = 72;
  NC_TreatmentStage4            = 73;
  NC_TrastuzamabStage0          = 74;
  NC_TrastuzamabStage1          = 75;
  NC_TrastuzamabStage2          = 76;
  NC_TrastuzamabStage3          = 77;
  NC_PalliativeCareBasic        = 78;
  NC_PalliativeCareExtensive    = 79;
  NC_TreatPalBasic              = 80;
  NC_TreatPalExtensive          = 81;
  NC_ScreenMammogr1             = 82;
  NC_ScreenMammogr2             = 83;
  NC_ScreeningClinclExam        = 84;
  NC_MoodStableBasicPsych       = 85;
  NC_MoodStableIntensivePsych   = 86;
  NC_FamPsychoEdu               = 87;
  NC_MethylphenidateMed         = 88;
  NC_AntiDepBasicPsychMild      = 89;
  NC_AntiDepBasicPsychModerate  = 90;
  NC_AntiDepBasicPsychSevere    = 91;
  NC_AntiDepInten               = 92;  //Anti Depression Intensive treatment
  NC_PAPSmear                   = 93;  //Papanicolaou Smear Positive
  NC_HPV_DNA                    = 94;  //Human papilloma virus  Deoxyribonucleic acid
  NC_VIA                        = 95;  //Visual Inspection with Acetic Acid
  NC_PAPSmearP_HPV              = 96;  //Papanicolaou Smear Positive _ Human papilloma virus
  NC_HPV_VIA                    = 97;
  NC_Vaccination                = 98;
  NC_AwarenessBasic             = 99;
  NC_AwarenessExtended          = 100;
  NC_FOBT                       = 101;
  NC_Sigmoidoscopy              = 102;
  NC_Colonoscopy                = 103;
  NC_AnnFOBTSig                 = 104; //annual FOBT with Sigmoidoscopy

  // interventions for ARF_RHD
  NC_ARF_PrimaryPrevention      = 105;
  NC_ARF_SecondaryPrevention    = 106;
  NC_Mild_RHD_Supervision       = 107;
  NC_RHD_ValveSurgery           = 108;
  NC_Severe_RHD_Supervision     = 109;
  NC_VMMC                       = 110;

  NC_MaxInterv                  = 110;

  NC_RecordBaseline    = 0;
  NC_CalcImpact        = 1;

  NC_ActiveIntervDef =
    [//Physical conditions
     //NC_PreventTRgt30,   NC_PreventCholest8lt30,   NC_PreventBldPrsr160lt30, 'old' preventions

      //NC_PreventNonDiabTRlt10,
      //NC_PreventNonDiabTR10to20SBPgt140,
      //NC_PreventNonDiabTRgt20SBPgt130,
      NC_PreventNonDiabSBPgt140,
      //NC_PreventDiabSBPgt140,
      //NC_PreventDiabStatinsAgegt40,

      NC_PreventDiabSBPgt130,
      NC_PreventDiabStatinsAgegt40,

      NC_TreatAMIAcuteAspirin,
      NC_TreatAMIAcuteAspirinAndTrombolysis,
      NC_TreatAMIAcuteAspirinAndClopidro,
      NC_TreatAMIAcutePCIAndAspirinAndClopidro,

      NC_TreatMechanicalTrombStroke,
      NC_TreatIntravTrombStroke,

      NC_TreatStrokeAcuteAspirin,
      NC_TreatStrokeCare,

     NC_Tobacco,
     NC_Exercise,        NC_ScreenMammogr1,
     NC_TreatmentStage0, NC_TreatmentStage1,       NC_TreatmentStage2,
     NC_TreatmentStage3, NC_AwarenessBasic,        NC_TreatmentStage4,
     NC_TreatPalBasic,   NC_ScreeningClinclExam,   NC_PalliativeCareBasic,
     NC_PAPSmear,        NC_HPV_DNA,               NC_PAPSmearP_HPV,
     NC_VIA,             NC_Vaccination,           NC_Sigmoidoscopy,
     NC_FOBT,            NC_Colonoscopy,           NC_TrastuzamabStage0,
     NC_HPV_VIA,         NC_TrastuzamabStage1,
     NC_AnnFOBTSig,      NC_TrastuzamabStage2,     NC_TrastuzamabStage3,

     //MNS
     NC_AntiEpiBasic,    NC_AntiPsychBasic,        NC_AntiPsychInten,
     NC_AntiDepBasic,    NC_PsychSocialInten,      NC_AntiDepInten,
     NC_PerinatalPsySoc, NC_AlcAssess,             NC_AlcBrief,
     NC_AlcWithdrawl,    NC_AlcRelapsePrevnt,      NC_BiPolarStableBase,
     NC_FamPsychoEdu,    NC_BiPolarStableInten,    NC_MoodStableBasicPsych,
     NC_PrvntAlcohol,    NC_MethylphenidateMed,    NC_MoodStableIntensivePsych,
     NC_PrvntDepression, NC_AntiDepBasicPsychMild, NC_AntiDepBasicPsychSevere,
     NC_StdGlycControl,  NC_PrvntAnxiety,          NC_AntiDepBasicPsychModerate,
     NC_NeuropathyScr,   NC_IntsvGlycControl,      NC_AntiDeprIntensPsychREC,
     NC_NephropathyScr,
     NC_RetinopathyScrn,    NC_SmokingCessation,      NC_AntiDeprIntensPsychNEW,
     //COPD
     NC_InhaledSalbutamol,NC_Antibiotics,NC_OralPrednisolone,NC_OxygenConcentration24to28,
     //NC_Antibiotics,        NC_InhaledSalbutamol,     NC_LowDoseOralTheophylline,
     //NC_IpratropiumInhaler, NC_OralPrednisolone,      NC_OxygenConcentration24to28,
     // ASHMA
     NC_InhaleShortactingBeta,NC_LowDoseBeclom,NC_HighDoseBeclom,NC_AsthmaOralPrednisolone,

     // ARF_RHD
     NC_ARF_PrimaryPrevention,  NC_ARF_SecondaryPrevention, NC_Mild_RHD_Supervision, NC_RHD_ValveSurgery];

  NC_InActiveIntervDef = [1..NC_MaxInterv] -NC_ActiveIntervDef;

  NC_TreatBreastSet =
    [NC_TreatmentStage0,      NC_TreatmentStage1,         NC_TreatmentStage2,   NC_TreatmentStage3,
     NC_TrastuzamabStage0,    NC_TrastuzamabStage1,       NC_TrastuzamabStage2, NC_TrastuzamabStage3,
     NC_PalliativeCareBasic,  NC_PalliativeCareExtensive, NC_TreatPalBasic,     NC_TreatPalExtensive,
     NC_ScreenMammogr1,       NC_ScreenMammogr2,          NC_ScreeningClinclExam];

  NC_TreatCervicalSet =
    [NC_TreatmentStage0, NC_TreatmentStage1, NC_TreatmentStage2,
     NC_TreatmentStage3, NC_TreatmentStage4,
     NC_PalliativeCareBasic, NC_PalliativeCareExtensive, NC_TreatPalBasic, NC_TreatPalExtensive,
     NC_PAPSmear, NC_HPV_DNA, NC_VIA, NC_PAPSmearP_HPV, NC_Vaccination, NC_HPV_VIA];

  NC_TreatColonSet =
    [NC_TreatmentStage0,      NC_TreatmentStage1,         NC_TreatmentStage2, NC_TreatmentStage3,
     NC_FOBT,                 NC_Sigmoidoscopy,           NC_Colonoscopy,     //NC_AnnFOBTSig
     NC_PalliativeCareBasic,  NC_PalliativeCareExtensive, NC_TreatPalBasic,   NC_TreatPalExtensive];

  NC_TreatCancerSet = NC_TreatCervicalSet+ NC_TreatBreastSet+NC_TreatColonSet;


  NC_TreatMapToUH =
    [NC_StdGlycControl,     NC_IntsvGlycControl,  NC_RetinopathyScrn,
     NC_SmokingCessation,   NC_InhaledSalbutamol, NC_LowDoseOralTheophylline,
     NC_IpratropiumInhaler, NC_NeuropathyScr,     NC_Antibiotics,
     NC_OralPrednisolone,   NC_LowDoseBeclom,     NC_OxygenConcentration24to28,
     NC_HighDoseBeclom,     NC_TheopPlusBeclom,   NC_InhaleShortactingBeta,
     NC_AntiPsychBasic,     NC_AntiPsychInten,    NC_OralPrednisTheopPlusBeclom,
     NC_AntiEpiBasic,       NC_PrvntAnxiety,      NC_PerinatalPsySoc,
     NC_AlcAssess,          NC_AlcWithdrawl,      NC_MoodStableBasicPsych,
     NC_AlcRelapsePrevnt,   NC_PrvntAlcohol,      NC_MoodStableIntensivePsych,
     NC_MethylphenidateMed, NC_FamPsychoEdu,      NC_AntiDepBasicPsychModerate,
     NC_EliminateTransFats, NC_AntiDepInten,      NC_AntiDepBasicPsychMild];

  NC_TreatARF_RHDSet =
    [NC_ARF_PrimaryPrevention, NC_ARF_SecondaryPrevention, NC_Mild_RHD_Supervision, NC_RHD_ValveSurgery];

  (*RiskFactors*)
  NC_All_Risk           = 0;
  NC_SBP_Risk           = 1; //Systolic blood pressure
  NC_Chol_Risk          = 2; //Cholestoral
  NC_BMI_Risk           = 3; //Body Mass Index
  NC_Tobacco_Risk       = 4; //Tobacco
  NC_Household_AP_Risk  = 5; //Household air pollution
  NC_MaxRiskFactors     = 4;



  (*Risk Ages*)
  NC_Risk00_30    = 0;//currently not used in the default data, could be changed
  NC_Risk30_44    = 1;
  NC_Risk45_59    = 2;
  NC_Risk60_69    = 3;
  NC_Risk70_79    = 4;
  NC_Risk80_99    = 5;
  NC_MaxRiskAges  = 5;

  (*SBP*)
  NC_SBP_180plus=1;
  NC_SBP_160_179=2;
  NC_SBP_140_159=3;
  NC_SBP_120_139=4;
  NC_SBP_lt120=5;


  (*CHOL*)
  NC_CHOL_lt4=1;
  NC_CHOL_4_49=2;
  NC_CHOL_5_59=3;
  NC_CHOL_6_69=4;
  NC_CHOL_gt7=5;

  NC_RF_NoSmoking=0;
  NC_RF_Smoking=1;

  NC_RF_NoDiabetes=0;
  NC_RF_Diabetes=1;


  (*P OR N (Percent or Number constants*)
  NC_Number  = 0;
  NC_Percent = 1;

  (*association file and tags*)
  //NC_AssociationFileName = 'Associations.csv';
  //NC_CervicalCancerFFile = 'CervicalCancer\CervicalCancer_F.csv';
  //NC_CervicalCancerMFile = 'CervicalCancer\CervicalCancer_M.csv';

  NC_Transmission    = 'Transmission';

  NC_StateAssocTag   = '<State Association>';
  NC_RiskAssocTag    = '<Risk Association>';
  NC_TreatAssocTag   = '<Treatment Association>';
  NC_PreventAssocTag = '<Prevention Association>';

  NC_StartTag        = '<Start>';
  NC_EndTag          = '<End>';

  NC_DWTag           = '<DW>';

  (*configuration constants*)
  NC_relHlthStateID = 1;
  NC_cfgTotalPopID  = 2;

  NC_per1E5ID   = 1;
  NC_per1000ID  = 2;
  NC_NumCasesID = 3;

  NC_AlcoholFile    = 'Diseases\AlcoholDependency.xlsx';
  NC_AnxietyFile    = 'Diseases\Anxiety.xlsx';
  NC_AsthmaFile     = 'Diseases\Asthma.xlsx';
  NC_AttentionFile  = 'Diseases\AttentionDisorder.xlsx';
  NC_BipolarFile    = 'Diseases\BipolarDisorder.xlsx';
  NC_BreastCncrFile = 'Diseases\BreastCancer.xlsx';
  NC_CervicalFile   = 'Diseases\CervicalCancer.xlsx';
  NC_ColorectalFile = 'Diseases\ColorectalCancer.xlsx';
  NC_ConductFile    = 'Diseases\ConductDisorder.xlsx';
  NC_COPDFile       = 'Diseases\COPD.xlsx';
  NC_CVDFile        = 'Diseases\CVD.xlsx';
  NC_DepressionFile = 'Diseases\Depression.xlsx';
  NC_DiabetesFile   = 'Diseases\Diabetes.xlsx';
  NC_EpilepsyFile   = 'Diseases\Epilepsy.xlsx';
  NC_PostNatalFile  = 'Diseases\Postnatal.xlsx';
  NC_PsychFile      = 'Diseases\Psychosis.xlsx';
  NC_StataFile      = 'Diseases\Stata.xlsx';
  NC_ARF_RHDFile    = 'Diseases\ARF_RHD.xlsx';
  NC_LungCncrFile   = 'Diseases\LungCancer.xlsx';
  NC_ALRIFile       = 'Diseases\ALRI.xlsx';

  NC_BreastCncrAfricaFile    = 'BreastCncr-EasternSSAfrica';
  NC_BreastCncrAsiaFile      = 'BreastCncr-SEAsia';
  NC_BreastCncrAndeanLatinAmericaFile = 'BreastCncr-AndeanLatinAmerica';

  NC_EasternSubSaharanAfrica = 'Eastern sub-Saharan Africa';
  NC_SouthEastAsia           = 'Southeast Asia';
  NC_AndeanLatinAmerica      = 'Andean Latin America';
  NC_Peru                    = 'Peru';
  NC_Caribbean               = 'Caribbean';

  NC_NoBreastCncr     = 0;
  NC_BreastCncrAfrica = 1;
  NC_BreastCncrAsia   = 2;
  NC_BreastCncrAndeanLatinAmrica   = 3;
  NC_BreastCaribbean   = 4;

  NC_CancerHigh =   4;
  NC_CancerMiddel = 5;
  NC_CancerLow =    6;


  (*Real Risk Factors*)
  NC_RFAll                            = 0;
  NC_RFMeanBP                         = 1;
  NC_RFMeanChol                       = 2;
  NC_RFBMI                            = 3;
  NC_RFSmoke                          = 4;
  NC_RFAlcohol                        = 5;
  NC_RFInactivity                     = 6;
  NC_RFSodiumIntake                   = 7;
  NC_RFSaturatedFatIntake             = 8;
  NC_RFSSBIntake                      = 9;
  NC_RFFiberIntake                    = 10;
  NC_RFFruitIntake                    = 11;
  NC_RFLegumeIntake                   = 12;
  NC_RFBreastFeeding                  = 13;
  NC_RFHighSBP                        = 14;
  NC_RFOverweight                     = 15;
  NC_RFBodyWeight                     = 16;
  NC_RF_HAP_Biomass                   = 17;
  NC_RF_HAP_Charcoal                  = 18;
  NC_RF_HAP_ICS_Charcoal              = 19;
  NC_RF_HAP_ICS_chimney               = 20;
  NC_RF_HAP_ICS_biomass_natural_draft = 21;
  NC_RF_HAP_ICS_biomass_forced_draft  = 22;
  NC_RF_HAP_ICS_pellet                = 23;
  NC_RF_HAP_Kerosene                  = 24;
  NC_RF_HAP_LPG                       = 25;
  NC_RF_HAP_Biogas                    = 26;
  NC_RF_HAP_Ethanol                   = 27;
  NC_RF_HAP_Electric                  = 28;
  NC_RFHousehold_AP  = 29;       //?
  NC_RFMax           = 29;
  NC_RegRFMax        = 16;

  NF_RFWithPrevs =[NC_RFSmoke,NC_RFAlcohol,NC_RFInactivity];

//  NC_RFLiverCncr           = 8;  //Liver Cancer
//  NC_RFOralCncr            = 9;  //Oral Cancer
//  NC_RFOesophagealCncr     = 10; //Oesophageal Cancer
//  NC_RFPancreaticCncr      = 11; //Pancreatic Cancer
//  NC_RFLarynxCncr          = 12; //Larynx Cancer
//  NC_RFLowerRespInf        = 13; //Lower Respiratory Infections
//  NC_RFHemorrhagicStroke   = 14; //Hemorrhagic Stroke
//  NC_RFTuberculosis        = 15; //Tuberculosis
//  NC_RFHypertension        = 16; //Hypertension
//  NC_RFLiverCirrhosis      = 17; //Liver Cirrhosis
//  NC_RFConductionDisorders = 18; //Conduction Disorders
//  NC_RFPancreatitis        = 19; //Pancreatitis
//  NC_RFInjuryViolence      = 20; //Injuries and Violence
//  NC_RFExtendedMax         = 20;


  NC_RFIntervImpactSet = [NC_RFAlcohol,NC_RFInactivity,NC_RFSmoke];


  (*Risk Factors Diseases*)
  NC_RFIschemicHeart    = 1;
  NC_RFStroke           = 2;
  NC_RFBreastCncr       = 3;
  NC_RFCervicalCncr     = 4;
  NC_RFColorectalCncr   = 5;
  NC_RFLungCncr         = 6;
  NC_RFDiabetes         = 7;
  NC_RFAsthma           = 8;
  NC_RFCOPD             = 9;
  NC_RFEpilepsy         = 10;
  NC_RFDepression       = 11;
  NC_RFLiverCncr        = 12;
  NC_RFOralCncr         = 13;
  NC_RFOesophagealCncr  = 14;
  NC_RFPancreaticCncr   = 15;
  NC_RFLarynxCncr       = 16;
  NC_RFLRI              = 17; //Lower Respiratory Infections
  NC_RFHemorrStroke     = 18; //Hemorrhagic Stroke
  NC_RFTuberculosis     = 19;
  NC_RFHypertension     = 20;
  NC_RFLiverCirrhosis   = 21;
  NC_RFConduction       = 22; //Conduction Disorders
  NC_RFPancreatitis     = 23;
  NC_RFInjuries         = 24;//Injuries and Violins
  NC_RFARF_RHD          = 25;
  NC_RFBloodPressure    = 26;
  NC_RFCholesterol      = 27;
  NC_RFBodyMassIndex    = 28;
  NC_RFMaxDisease       = 28;

  NC_RFInModule  : TArray<Integer> = [
     NC_RFBloodPressure,  NC_RFCholesterol, NC_RFBodyMassIndex,
     NC_RFIschemicHeart,  NC_RFStroke,         NC_RFBreastCncr,
     NC_RFCervicalCncr,   NC_RFColorectalCncr, NC_RFDiabetes,
     NC_RFAsthma,         NC_RFCOPD,           NC_RFEpilepsy,
     NC_RFDepression,     NC_RFARF_RHD];

  NC_RiskRR         = 1;
  NC_RiskPAF        = 2;

   (*Smoking interventions*)
  NC_RFTobaccoPolicy             =  1;
  NC_RFTobaccoProtect            =  2;
  NC_RFTobaccoQuitBrief          =  3;
  NC_RFTobaccoQuitmCessation     =  4;
  NC_RFTobaccoWarnLabel          =  5;
  NC_RFTobaccoWarnMassMedia      =  6;
  NC_RFTobaccoBan                =  7;
  NC_RFTobaccoEnforceYouth       =  8;
  NC_RFTobaccoTax                =  9;
  NC_RFTobaccoPackaging          = 10;

  (*Alcohol interventions*)
  NC_RFAlcoholRestrict           = 11;
  NC_RFAlcoholBanAdvert          = 12;
  NC_RFAlcoholBanTax             = 13;
  NC_RFAlcoholDriveLaws          = 14;
  NC_RFAlcoholCounsel            = 15;

  (*Physical Interventions*)
  NC_RFPhysicalActivityAwreness  = 16;
  NC_RFPhysicalActivityAdvice    = 17;

  (*Sodium Interventions*)
  NC_RFSodiumSurveillance            = 18;
  NC_RFSodiumReformulation           = 19;
  NC_RFSodiumPackLabelling           = 20;
  NC_RFSodiumMisleadingMarket        = 21;
  NC_RFSodiumKnowledge               = 22;
  NC_RFSodiumEnvSaltReduct           = 23;

  (*TransFatIntake Interventions*)
  NC_RFTransFatPublicProcurement        = 24;
  NC_RFTransFatReformulation            = 25;
  NC_RFTransFatFrontPackLabelling       = 26;

  (*SSBIntake Interventions*)
  NC_RFSSBPublicProcurement        = 27;
  NC_RFSSBReformulation            = 28;
  NC_RFSSBFrontPackLabelling       = 29;
  NC_RFSSBTax                      = 30;

  (*FiberIntake Interventions*)
  NC_RFFiberPublicProcurement     = 31;
  NC_RFFiberReformulation         = 32;
  NC_RFFiberFrontPackLabelling    = 33;

 (*NC_FruitIntake Interventions*)
  NC_RFFruitPublicProcurement       = 34;
  NC_RFFruitReformulation           = 35;
  NC_RFFruitFrontPackLabelling      = 36;
  NC_RFFruitMassMedia               = 37;

  (*LegumeIntake Interventions*)
  NC_RFLegumePublicProcurement        = 38;
  NC_RFLegumeReformulation            = 39;
  NC_RFLegumeFrontPackLabelling       = 40;
  NC_RFLegumeMassMedia                = 41;

  NC_RFBreastFeedingCS                = 42;

  (*Obesity Interventions*)
  NC_RFObesityKillTransFats      = 43;
  NC_RFObesityReplaceSatFats     = 44;
  NC_RFObesityReduceSugarTax     = 45;

  (*HAP interventions*)
  NC_RFBiomass                   = 46;
  NC_RFCharcoal                  = 47;
  NC_RFICS_Charcoal              = 48;
  NC_RFICS_chimney               = 49;
  NC_RFICS_biomass_natural_draft = 50;
  NC_RFICS_biomass_forced_draft  = 51;
  NC_RFICS_pellet                = 52;
  NC_RFKerosene                  = 53;
  NC_RFLPG                       = 54;
  NC_RFBiogas                    = 55;
  NC_RFEthanol                   = 56;
  NC_RFElectric                  = 57;
  NC_RFHousehold_AP_Intrv        = 58;

  NC_RFIntervMax                 = 58;

  NC_RFSmokeInterv          = [NC_RFTobaccoPolicy..NC_RFTobaccoPackaging];
  NC_RFAlcoholInterv        = [NC_RFAlcoholRestrict..NC_RFAlcoholCounsel ];
  NC_RFPhysicalInterv       = [NC_RFPhysicalActivityAwreness,NC_RFPhysicalActivityAdvice];
  NC_RFSodiumInterv         = [NC_RFSodiumSurveillance  .. NC_RFSodiumEnvSaltReduct ];
  NC_RFTransFatInterv       = [NC_RFTransFatPublicProcurement   .. NC_RFTransFatFrontPackLabelling];
  NC_RFSSBInterv            = [NC_RFSSBPublicProcurement   .. NC_RFSSBTax];
  NC_RFFiberInterv          = [NC_RFFiberPublicProcurement   .. NC_RFFiberFrontPackLabelling];
  NC_RFFruitsInterv         = [NC_RFFruitPublicProcurement   .. NC_RFFruitMassMedia];
  NC_RFLEgumesInterv        = [NC_RFLegumePublicProcurement   .. NC_RFLegumeMassMedia];


  NC_RFInGramsList           = [NC_RFSodiumSurveillance..NC_RFSodiumPackLabelling,
                               NC_RFTransFatPublicProcurement  .. NC_RFTransFatFrontPackLabelling,
                               NC_RFSSBPublicProcurement  .. NC_RFSSBFrontPackLabelling,
                               NC_RFFiberPublicProcurement  .. NC_RFFiberFrontPackLabelling,
                               NC_RFFruitPublicProcurement  .. NC_RFFruitFrontPackLabelling, NC_RFFruitMassMedia,
                               NC_RFLegumePublicProcurement  .. NC_RFLegumeFrontPackLabelling, NC_RFLegumeMassMedia];


  NC_RFHousehold_APInterv   = [NC_RFBiomass..NC_RFElectric];
  NC_RFTaxSet               = [NC_RFTobaccoTax, NC_RFAlcoholBanTax];
  NC_RFExcInImpacts         = [NC_RFTobaccoQuitBrief,NC_RFAlcoholCounsel,NC_RFPhysicalActivityAdvice];

//  NC_RFOneLevelInterv = [NC_RFPhysicalActivityAwreness,NC_RFPhysicalActivityAdvice];
  NC_RFFourLevelInterv      = NC_RFSmokeInterv+[NC_RFAlcoholBanAdvert];

  (* ModData files and sheets *)

  //NC_CVDFile  = 'associations.csv';
  //NC_CVDFileF = 'associations_F.csv';
  //NC_CVDFileM = 'associations_M.csv';
  //NC_BreastCncrFile = 'BreastCncr.csv';
  //NC_StataRegionFileName = 'Stata_RegionTest.csv';

  NC_ReadMeFileName          = 'Readme.csv';
  NC_RiskFactorDataFileName  = 'RiskFactorData.xls';
  NC_CntryRegionListFileName = 'WhoRegions.csv';
  NC_AlcoholAFFileName       = 'AFs_ALC.xlsx';

  NC_RF_PopulationSheet    = 'Population';
  NC_RF_BloodPressureSheet = 'BloodPressure';
  NC_RF_CholesterolSheet   = 'Cholesterol';
  NC_RF_BMISheet           = 'BMI';
  NC_RF_InactivitySheet    = 'Inactivity';
  NC_RF_AlcoholUseSheet    = 'AlcoholUse';
  NC_RF_TobaccoSheet       = 'Tobacco';
  NC_RF_SaltIntakeSheet    = 'SaltIntake';
  NC_RF_RRSheet            = 'RR';
  NC_RF_AlcTaxSheet        = 'AlcTax';
  NC_RF_TabTaxSheet        = 'TabTax';
  NC_RF_ImpFactSheet       = 'ImpactFactors';
  NC_RF_Alc_BriefIntv      = 'Alc_BriefIntv';
  NC_RF_Alc_AvailRestr     = 'Alc_AvailRestr';
  NC_RF_Alc_MarktRestr     = 'Alc_MarktRestr';
  NC_RF_Alc_DriveImp       = 'AlcDrivingImpact';
  //NC_RF_Alc_DriveImpMort   = 'AlcDrivingImpactMort';
  //NC_RF_Alc_DriveImpYLD    = 'AlcDrivingImpactYLD';
  NC_RF_Household_AP       = 'HouseholdAirPollution';

  NC_ValidateBreastCancerName   = '\Diseases\Validation\BreastCancer.xlsx';
  NC_ValidateColonMCancerName   = '\Diseases\Validation\ColorectalCancer_Male.xlsx';
  NC_ValidateColonFCancerName   = '\Diseases\Validation\ColorectalCancer_Female.xlsx';
  NC_ValidateCervicalCancerName = '\Diseases\Validation\CervicalCancer.xlsx';

  NC_RHDFile = 'Diseases\RHDModelInputs.xlsx';
  NC_RHDModelInputSheet = 'RHDModelInputs';
  NC_RHDInterventionCoverage = 'RHDInterventionCoverage';

  NC_BMI_Max_SD=10;
  NC_SBP_Max_SD=20;



//  NC_DiseaseFolders = [NC_PsychFolder,NC_EpilepsyFolder];
  NC_MaxEditValue = 999999999999999;

  (*NC Extract Constants*)
  NC_exMaxSec = 3;

  NC_CC_S    =1; //cervical cancer S
  NC_CC_618  =2;
  NC_CC_MHR  =3;
  NC_CC_MLR  =4;
  NC_CC_Imun =5;

  NC_TaxTobacco    = 1;
  NC_TaxAlcBeer    = 2;
  NC_TaxAlcWine    = 3;
  NC_TaxAlcSpirits = 4;
  NC_TaxMax        = 4;

  NC_Liquors = [NC_TaxAlcBeer, NC_TaxAlcWine, NC_TaxAlcSpirits];

  NC_Level1 = 1;
  NC_Level2 = 2;
  NC_Level3 = 3;
  NC_Level4 = 4;
  NC_MaxLevel = 4;

  NC_RiskImpactDef = 1;
  NC_RiskBurden    = 1;
  NC_RiskFunction  = 2;
  NC_RiskMortality = 3;
  NC_RiskYLD       = 4;
  NC_RiskMaxImpact = 4;

  NC_FirstAgeDef = 9;
  NC_FinalAgeDef = 13;

  NC_ConfigBtn  = 1;
  NC_RiskBtn    = 2;
  NC_PrvntBtn   = 3;
  NC_DiseaseBtn = 4;
  NC_SexBtn     = 5;
  NC_EpiBtn     = 6;
  NC_TreatBtn   = 7;
  NC_ResultsBtn = 8;
  NC_DWBtn      = 9;

  NC_AlcAllCauses         = 0;
  NC_AlcAlcoholUse        = 1;
  NC_AlcEpilepsy          = 2;
  NC_AlcTuberculosis      = 3;
  NC_AlcPancreatitis      = 4;
  NC_AlcCirrhosis         = 5;
  NC_AlcLiverCncr         = 6;
  NC_AlcBreastCncr        = 7;
  NC_AlcColonCncr         = 8;
  NC_AlcLarynxCncr        = 9;
  NC_AlcOesophagusCncr    = 10;
  NC_AlcNasopharynxCncr   = 11;
  NC_AlcIschemicStroke    = 12;
  NC_AlcHemorrhagicStroke = 13;
  NC_AlcHypertension      = 14;
  NC_AlcTrafficFatal      = 15;
  NC_AlcPoisonings        = 16;
  NC_AlcFalls             = 17;
  NC_AlcFire              = 18;
  NC_AlcDrowning          = 19;
  NC_AlcUnintentional     = 20;
  NC_AlcSelfHarm          = 21;
  NC_AlcViolence          = 22;
  NC_MaxAlcConnections    = 22;

//  NC_ExcludedModels =
//    [NC_AlcAlcoholUse,   NC_AlcEpilepsy,     NC_AlcTuberculosis,   NC_AlcBreastCncr,
//     NC_AlcColonCncr,    NC_AlcIschemicStroke, NC_AlcHemorrhagicStroke,
//     NC_AlcHypertension];

  NC_ExcludedModels =
  [NC_AlcAlcoholUse,   NC_AlcEpilepsy, NC_AlcIschemicStroke, NC_AlcHemorrhagicStroke, NC_AlcHypertension];

  NC_RFDeathResID = 1;
  NC_RFYLDResID   = 2;
  NC_RFDeathsID   = 3;
  NC_RFYLDsID     = 4;
  NC_RFPopsID     = 5;
  NC_RFMaxResID   = 5;


  //bounds for cancer estimates
  NC_Low  = 1;
  NC_Med  = 2;
  NC_High = 3;

  //ages for historical cancer estimates
  NC_00_14  = 1;
  NC_15_39  = 2;
  NC_40_44  = 3;
  NC_45_49  = 4;
  NC_50_54  = 5;
  NC_55_59  = 6;
  NC_60_64  = 7;
  NC_65_69  = 8;
  NC_70_74  = 9;
  NC_75_100 = 10;

  //stages
  NC_Insitu    = 0;
  NC_Local     = 1;
  NC_Regional  = 2;
  NC_Distant   = 3;
  NC_StageIV   = 4;
  NC_LastStage = 4;

  //HPV stages
  NC_HPV_16_18_stage        = 0;
  NC_HPV_Protected_Stage    = 1;
  NC_HPV_NotProtected_Stage = 2;

  //HAP methods
//  NC_Chimney_ICS=1;
//  NC_Natural_draft_ICS=2;
//  NC_Forced_draft_ICS=3;
//  NC_Pellet_ICS=4;
//  NC_Biogas=5;
//  NC_LPG=6;
//  NC_Ethanol=7;
//  NC_Electric=8;




  //Files
  NC_HAP_Data = 'HAP_Database.xlsx';
  NC_HAP_IHMEData_Sheet = 'IHME_Data';
  NC_HAP_RR_Sheet = 'SpectrumModel';
  NC_HAP_RegrParams_Sheet = 'RegrParams';


  //HAP
  NC_HAP_ALL        =	0;
  NC_HAP_ALRI       =	1;
  NC_HAP_IHD  	    = 2;
  NC_HAP_Stroke     = 3;
  NC_HAP_COPD	      = 4;
  NC_HAP_LungCancer	= 5;
  NC_HAP_DsFreeSus  =	6;
  NC_HAP_Max        = 6;
  NC_HAP_DMax       = 5;


  //RR regression formula parameters
  NC_Alpha=1;
  NC_Beta=2;
  NC_Delta=3;
  NC_Zcf=4;
  NC_Aic=5;
  NC_Bic=6;

  NC_Traditional_biomass     = 1;
  NC_Traditional_charcoal    = 2;
  NC_Chimney_ICS             = 3;
  NC_BiomassRocketICS        = 4;
  NC_Forced_Draft_ICS        = 5;
  NC_Pellet_ICS_MML          = 6;
  NC_Charcoal_ICS            = 7;
  NC_Kerosene_Wick           = 8;
  NC_Electric                = 9;
  NC_Biogas                  = 10;
  NC_LPG                     = 11;
  NC_Ethanol                 = 12;
  NC_LPG_wrt_charcoal        = 13;
  NC_Ethanol_wrt_charcoal    = 14;
  NC_Electric_wrt_charcoal   = 15;
  NC_Kerosene_Wick2          = 16;
  NC_LPG_wrt_kerosene        = 17;
  NC_Ethanol_wrt_kerosene    = 18;
  NC_Electric_wrt_kerosene   = 19;
  NC_Electric_LPG	           = 20;
  NC_Electric_wrt_LPG        = 21;
  NC_LPG_Electric	           = 22;
  NC_LPG_wrt_electric        = 23;
  NC_HAP_RR_Max              = 23;

  NC_perc_sfu      = 1;
  NC_perc_char	   = 2;
  NC_perc_kerosene = 3;
  NC_perc_lpg      = 4;
  NC_perc_biogas   = 5;
  NC_perc_elec     = 6;
  NC_HAP_CovMax    = 6;

  NC_HIN_HH_Size                   = 1;
  NC_HIN_Health_spillovers         = 2;

  NC_HIN_ALL                       = 0;
  NC_HIN_Biomass                   = 1;
  NC_HIN_Charcoal                  = 2;
  NC_HIN_ICS_Charcoal              = 3;
  NC_HIN_ICS_chimney               = 4;
  NC_HIN_ICS_biomass_natural_draft = 5;
  NC_HIN_ICS_biomass_forced_draft  = 6;
  NC_HIN_ICS_pellet                = 7;
  NC_HIN_Kerosene                  = 8;
  NC_HIN_LPG                       = 9;
  NC_HIN_Biogas                    = 10;
  NC_HIN_Ethanol                   = 11;
  NC_HIN_Electric                  = 12;
  NC_HIN_Max                       = 12;


  ////////////////////////
  NC_HAP_PPM = 1;
  NC_HAP_ExpAdjust = 2;
  ////////////////////////
  NC_HAP_LifeSpan = 3;
  //////////////////////
  NC_HAP_Pmax = 4;
  NC_HAP_Pmin = 5;
  NC_HAP_Qmax = 6;
  //////////////////////
  NC_HAP_NoSubQty = 7;
  NC_HAP_SubOnlyQty =8;
  NC_HAP_SubBBCQty = 9;
  NC_HAP_SubFINQty = 10;

  NC_HAP_HYLNoSpillOver=1;
  NC_HAP_HYLWithSpillOver=2;
  NC_HAP_HYL=3;

  NC_HAP_YLDNoSpillOver=1;
  NC_HAP_YLDWithSpillOver=2;
  NC_HAP_YLD=3;

  NC_HAP_MorbidityNoSpillOver=1;
  NC_HAP_MorbidityWithSpillOver=2;
  NC_HAP_Morbidity=3;

  NC_HAP_MortalityNoSpillOver=1;
  NC_HAP_MortalityWithSpillOver=2;
  NC_HAP_Mortality=3;

  NC_HAP_PrivateBenefits = 1;
  NC_HAP_AddSocBenefits  = 2;
  NC_HAP_TotalBenefits   = 3;

//  New NCD ALC RF Feature
  NC_IncSpec = 0;
  NC_ExcSpec = 1;

  NC_GBD_NCD_DataFile  = 'GBD_Country_Data.xlsx';
  NC_GBD_NCD_DataSheet = 'NCD_GBD_Country_Data';
  NC_GBD_Smoking_DataSheet = 'Smoking_GBD_Country_Data';
  NC_GBD_DietaryRisk_DataSheet = 'DietaryRisk_GBD_CountryData';
  NC_Guthold2018_PIA_DataSheet = 'PIA_Guthold_2018';
  NC_Hypertension_DataSheet = 'SBPgt140_GHO2015';
  NC_Overweight_DataSheet = 'BMIgt25_GHO2016';
  NC_GHO_BMI_DataSheet = 'BMI_GHO_2016';
  NC_ALC_Dan_DataSheet = 'ALC_Dan_2019';
  NC_BF_DataSheet = 'BF_Impact_CS';
  NC_Weight_DataSheet = 'BodyWeight_GBD_2019';

  NC_TotalRisk_DataFile  = 'TotalRisk_RegionData.xlsx';


implementation

end.
