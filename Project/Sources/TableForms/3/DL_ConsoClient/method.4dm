C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		r1:=Num:C11(<>vb_Conso115Clt=True:C214)
		r2:=Num:C11(<>vb_Conso115Clt=False:C215)
		s1:=Num:C11(<>vb_Conso115ServeurCltAuto=True:C214)
		s2:=Num:C11(<>vb_Conso115ServeurCltAuto=False:C215)
		
		<>vh_Conso115CltTicks:=<>vl_Conso115CltTicks/60
		<>va_Conso_ChronoTrans:=""
		
		
	: ($vl_Event=Sur appel extérieur:K2:11)
		REDRAW:C174(<>va_Conso_ChronoTrans)
End case 