// Method [DiaLogues].DL_DossierEtatCivil.LB  
// 
// 
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur clic:K2:4)
		
		If (Size of array:C274(t_TabNiv1)>0)
			If (t_TabNiv1>0)
				t_TabNiv1{0}:=t_TabNiv1{t_TabNiv1}
				OBJECT SET ENABLED:C1123(b_ValTab1; True:C214)
			Else 
				t_TabNiv1{0}:=""
				OBJECT SET ENABLED:C1123(b_ValTab1; False:C215)
			End if 
		Else 
			OBJECT SET ENABLED:C1123(b_ValTab1; False:C215)
		End if 
		
	: ($vl_EventFF=Sur double clic:K2:5)
		
		If (Size of array:C274(t_TabNiv1)>0)
			If (t_TabNiv1>0)
				t_TabNiv1{0}:=t_TabNiv1{t_TabNiv1}
				OBJECT SET ENABLED:C1123(b_ValTab1; True:C214)
			Else 
				t_TabNiv1{0}:=""
				OBJECT SET ENABLED:C1123(b_ValTab1; False:C215)
			End if 
		Else 
			OBJECT SET ENABLED:C1123(b_ValTab1; False:C215)
		End if 
End case 