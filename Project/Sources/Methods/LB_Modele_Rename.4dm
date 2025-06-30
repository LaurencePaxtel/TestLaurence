//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 25/09/2020, 08:57:57
// ----------------------------------------------------
// Method: LB_Modele_Rename
// Description
// 
//
// Parameters
// ----------------------------------------------------

$nouveau_nom:=Request:C163("Nouveau nom du modèle de liste :"; Liste_formulaire{Liste_formulaire})

If (ok=1)
	
	If (Read only state:C362([Preferences:81]))
		READ WRITE:C146([Preferences:81])
	End if 
	
	QUERY:C277([Preferences:81]; [Preferences:81]UID:1=Liste_ref_formulaire{Liste_formulaire})
	[Preferences:81]PREF_Info_plus_2:24:=$nouveau_nom
	SAVE RECORD:C53([Preferences:81])
	
	UNLOAD RECORD:C212([Preferences:81])
	READ ONLY:C145([Preferences:81])
	
	Liste_formulaire{Liste_formulaire}:=$nouveau_nom
	
End if 