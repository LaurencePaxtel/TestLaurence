//%attributes = {}


If (Size of array:C274(t_TabNiv1)>0)
	$Car:=$1+"@"
	$Pos:=Find in array:C230(t_TabNiv1; $Car)
	If ($Pos>0)
		t_TabNiv1:=$Pos
		Tab_PopIn2Rec
		t_TabNiv1{0}:=t_TabNiv1{t_TabNiv1}
	Else 
		BEEP:C151
	End if 
End if 