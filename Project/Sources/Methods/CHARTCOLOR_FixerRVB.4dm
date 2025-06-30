//%attributes = {}
//COLOR_FixerRVB
//$4=ANGLE DE LA COULEUR DANS LA ROUE CHROMATIQUE ENTRE -360 ET 360°

C_POINTER:C301($1; $2; $3)
C_REAL:C285($4)

$1->:=CHART_COL_FixerComposante($4)  //Rouge
$2->:=CHART_COL_FixerComposante($4-120)  //Vert
$3->:=CHART_COL_FixerComposante($4-240)  //Bleu