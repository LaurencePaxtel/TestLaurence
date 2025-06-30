C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388

Case of 
	: ($vl_Event=Sur chargement:K2:1)
		P_ConsoRégion_Divers(0)
		P_ConsoRégion_Divers(1)
	: ($vl_Event=Sur appel extérieur:K2:11)
		
		Case of 
			: (<>va_TransfertRegional_Action=<>va_TransfertRegional_Action0)  //"Thermo init"        
				vl_Thermomètre:=0
				
			: (<>va_TransfertRegional_Action=<>va_TransfertRegional_Action1)  //"Thermo"
				If (vl_Thermomètre>100)
					vl_Thermomètre:=0
				Else 
					vl_Thermomètre:=vl_Thermomètre+1
				End if 
			: (<>va_TransfertRegional_Action=<>va_TransfertRegional_Action2)  //"Etat"
				P_ConsoRégion_Divers(1)
			: (<>va_TransfertRegional_Action=<>va_TransfertRegional_Action3)  //"Etat Endormi"
				P_ConsoRégion_Divers(1)
				va_ConsoProcessEtat:=Replace string:C233(va_ConsoProcessEtat; "En exécution"; "Endormi")
		End case 
		<>va_TransfertRegional_Action:=""
		REDRAW:C174(va_ConsoProcessEtat)
End case 