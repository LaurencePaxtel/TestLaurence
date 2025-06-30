C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		r1:=Num:C11(<>vb_ConsoRAuto=True:C214)
		r2:=Num:C11(<>vb_ConsoRAuto=False:C215)
		
		<>vh_ConsoRTicks:=<>vl_ConsoRTicks/60
		<>va_ConsoR_ChronoTrans:=""
		
		
	: ($vl_Event=Sur appel extérieur:K2:11)
		REDRAW:C174(<>va_ConsoR_ChronoTrans)
End case 