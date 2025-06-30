C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		P_HébergementSortant(1)
		
		vl_SourisXb:=0
		vl_SourisYb:=0
		vl_SourisBtb:=0
		
		OBJECT SET VISIBLE:C603(b_Send; <>vb_M_MailOui)
		
	: ($vl_Event=Sur double clic:K2:5)
		
		
		GET MOUSE:C468(vl_SourisXb; vl_SourisYb; vl_SourisBtb)
		If ((vl_SourisXb>6) & (vl_SourisXb<437)) & ((vl_SourisYb>82) & (vl_SourisYb<480))
			
			LOAD RECORD:C52([HeberGement:5])  // BS MIGRATION 11/6/16
			If ([HeberGement:5]HG_ReferenceID:1>0)
				
				If (Accès_Groupe(<>Groupe_Veille))
					Process_Go(-><>PR_HébergementVeille; "Go_HébergementVeille"; "LaVeille"; 64)
					
					Repeat 
						IDLE:C311
						DELAY PROCESS:C323(Current process:C322; 10)
					Until (<>PR_HébergementVeille>0)
					
					
					
					<>va_TransVeille_Message:="Sortants"
					<>vb_Sortants:=True:C214
					<>vl_RéfSortants:=[HeberGement:5]HG_ReferenceID:1
					POST OUTSIDE CALL:C329(<>PR_HébergementVeille)
				End if 
				
				
				
				
			End if 
		End if 
		
		FILTER EVENT:C321
		
	: ($vl_Event=Sur appel extérieur:K2:11)
		
		P_HébergementSortant(1)
End case 