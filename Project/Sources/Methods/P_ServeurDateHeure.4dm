//%attributes = {}
C_POINTER:C301($2)
C_POINTER:C301($2)

C_DATE:C307($vd_DateServeur; $vd_DateRéelle)
C_TIME:C306($vh_HeureServeur; $vh_HeureRéelle)



$vd_DateServeur:=$1->
$vh_HeureServeur:=$2->
$vd_DateRéelle:=$vd_DateServeur
$vh_HeureRéelle:=$vh_HeureServeur+(8*3600)
If ($vh_HeureRéelle>?23:59:59?)
	$vd_DateRéelle:=$vd_DateRéelle+1
	$vh_HeureRéelle:=$vh_HeureRéelle-(24*3600)
End if 

$1->:=$vd_DateRéelle
$2->:=$vh_HeureRéelle
