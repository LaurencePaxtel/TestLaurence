//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 25/09/2020, 09:37:25
// ----------------------------------------------------
// Method: LB_store_LB
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BLOB:C604($1)
C_TEXT:C284($2)

C_BLOB:C604($blob)
C_TEXT:C284($nom_pref_liste_box)

$blob:=$1
$nom_pref_liste_box:=$2

If (Read only state:C362([Preferences:81]))
	READ WRITE:C146([Preferences:81])
End if 

If (Liste_ref_formulaire{Liste_formulaire}="")
	CREATE RECORD:C68([Preferences:81])
	MultiSoc_Init_Structure(->[Preferences:81])
	[Preferences:81]PREF_Type:2:="Format de liste"
	[Preferences:81]PREF_Info_plus_2:24:=Liste_formulaire{Liste_formulaire}
	
	Case of 
		: (Liste_type_formulaire{Liste_formulaire}="USR")
			[Preferences:81]PREF_UID_user:7:=<>Ref_User_actif
	End case 
	
	Liste_ref_formulaire{Liste_formulaire}:=String:C10([Preferences:81]UID:1)
Else 
	QUERY:C277([Preferences:81]; [Preferences:81]UID:1=Liste_ref_formulaire{Liste_formulaire})
	MultiSoc_Filter(->[Preferences:81])
End if 

[Preferences:81]PREF_Informations:11:=$1
SAVE RECORD:C53([Preferences:81])

UNLOAD RECORD:C212([Preferences:81])
READ ONLY:C145([Preferences:81])