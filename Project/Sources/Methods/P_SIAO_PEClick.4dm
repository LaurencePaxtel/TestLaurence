//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : P_SIAO_PE_Click
//{          Dimanche 12 décembre 2010 à 14:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_LONGINT:C283($ii)
$ii:=0
C_BOOLEAN:C305($vb_OK)
$vb_OK:=True:C214
If (Size of array:C274($1->)>0)
	If (($1->)>0)
		$ii:=($1->)
	End if 
End if 

P_SIAO_Var_Affecter($ii)