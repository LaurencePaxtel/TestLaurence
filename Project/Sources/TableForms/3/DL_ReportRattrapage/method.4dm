C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		If (<>vl_RAP_Jours>0)
			OBJECT SET ENABLED:C1123(b_Val; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b_Val; False:C215)
		End if 
		
		E1:=Num:C11(<>vb_RAP_CréerDispo=True:C214)
		E2:=Num:C11(<>vb_RAP_CréerDispo=False:C215)
		
		W1:=Num:C11(vb_RatrapageSelection=True:C214)
		W2:=Num:C11(vb_RatrapageSelection=False:C215)
		
	: ($vl_Event=Sur données modifiées:K2:15)
		If (<>vl_RAP_Jours>0)
			OBJECT SET ENABLED:C1123(b_Val; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b_Val; False:C215)
		End if 
		
		
End case 
