C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		If (<>vb_T_OccupMinuteur)
			SET TIMER:C645(<>vl_T_OccupMinuteurTicks)
		End if 
		vl_Rafraichir:=1
		P_OccupationRafraichir(->vl_Rafraichir)
		vd_Date1:=!2009-01-01!
		vd_Date1:=Current date:C33
		GOTO OBJECT:C206(vd_Date1)
		If (7=8)
			OBJECT SET VISIBLE:C603(b_DétailPlus; (User in group:C338(Current user:C182; <>Groupe_DEVELOP)))
		End if 
		OBJECT SET VISIBLE:C603(b_DonnesPlus; False:C215)
		
		
	: ($vl_EventFF=Sur minuteur:K2:25)
		If (<>vl_T_OccupMinuteurTicks>0)
			P_TauxOccupation(1)
		End if 
		
End case 