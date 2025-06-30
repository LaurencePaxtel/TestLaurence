C_LONGINT:C283($vl_Event)

$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		OBJECT SET VISIBLE:C603(*; "@_ico2"; False:C215)
	: ($vl_Event=Sur validation:K2:3)
		If (Modified record:C314([Dossier_SIAO:49]))
			[Dossier_SIAO:49]SI_Modifiéle:5:=Current date:C33
		End if 
End case 