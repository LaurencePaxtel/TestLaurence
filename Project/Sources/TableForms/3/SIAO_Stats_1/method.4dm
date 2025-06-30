C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		[DiaLogues:3]DL_Date:2:=Current date:C33(*)
		[DiaLogues:3]DL_Date2:8:=Current date:C33(*)
		ve_Date_Cas:=0
		
		rAn1:=1
		rAn2:=1
		trans1:=1
		trans2:=1
		Dem1:=1
		Dem2:=1
		Dem3:=1
		Ferm1:=0
		
		
		vL_NbFiches:=0
		
		
End case 