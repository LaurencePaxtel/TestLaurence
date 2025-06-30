//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_PopInCar80
//{
//{          Mardi 18 janvier 2011 à 11:15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Size of array:C274(t_TabNiv80)>0)
	$Car:=$1+"@"
	$Pos:=Find in array:C230(t_TabNiv80; $Car)
	If ($Pos>0)
		t_TabNiv80:=$Pos
		t_TabNiv80{0}:=t_TabNiv80{t_TabNiv80}
	Else 
		BEEP:C151
	End if 
End if 