C_LONGINT:C283($vl_Event)

$vl_Event:=Form event code:C388

Case of 
	: ($vl_Event=Sur chargement:K2:1)
		rJourNuit1:=1
		rJourNuit2:=0
	: ($vl_Event=Sur double clic:K2:5)
		
		If ([HeberGement:5]HG_ReferenceID:1>0)
			va_IDT_Typ2:=String:C10(tp_ItemRub{ta_ItemRub}->)
		Else 
			ALERT:C41("Vous devez vous positionner dans la liste !")
		End if 
		
End case 