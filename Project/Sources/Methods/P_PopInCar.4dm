//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_PopInCar
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Size of array:C274(t_TabNiv1)>0)
	$Car:=$1+"@"
	$Pos:=Find in array:C230(t_TabNiv1; $Car)
	If ($Pos>0)
		t_TabNiv1:=$Pos
		t_TabNiv1{0}:=t_TabNiv1{t_TabNiv1}
	Else 
		BEEP:C151
	End if 
End if 