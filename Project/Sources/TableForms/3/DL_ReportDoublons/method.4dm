C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		
		E1:=Num:C11(<>vb_REPORT_DOUBLONS=True:C214)
		E2:=Num:C11(<>vb_REPORT_DOUBLONS=False:C215)
		
		
	: ($vl_Event=Sur données modifiées:K2:15)
		
		
End case 
