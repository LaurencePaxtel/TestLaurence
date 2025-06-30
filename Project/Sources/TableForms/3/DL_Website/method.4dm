C_LONGINT:C283($vl_Event; $ii)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		
		SET TIMER:C645(((((vh_ws_Période\3600)*3600)+(((vh_ws_Période\60)%60)*60)+(vh_ws_Période%60))*60))
		
		For ($ii; 1; 24)
			vp_Ptr:=Get pointer:C304("H"+String:C10($ii))
			vp_Ptr->:=Num:C11(va_ws_Heures[[$ii]])
		End for 
		
		
		
	: ($vl_Event=Sur minuteur:K2:25)
		If (vb_ws_LancerFirst=False:C215)
			P_CalcWebSite
			REDRAW:C174(va_ws_Message)
		End if 
End case 
