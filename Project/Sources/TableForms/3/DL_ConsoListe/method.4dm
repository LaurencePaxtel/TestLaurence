C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		
		If (User in group:C338(Current user:C182; <>Groupe_Conso))
			
			If (<>PR_ConsoLocal=0)
				OBJECT SET ENABLED:C1123(b_Lancer; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(b_Lancer; False:C215)
			End if 
			
		Else 
			//  OBJECT SET ENABLED(b_Lancer;False)
		End if 
		
	: ($vl_Event=Sur appel extérieur:K2:11)
		
		BEEP:C151
		
		If (User in group:C338(Current user:C182; <>Groupe_Conso))
			OBJECT SET ENABLED:C1123(b_Lancer; True:C214)
		End if 
		
		
		ARRAY TEXT:C222(ta_ConsoB_Document; 0)
		
End case 