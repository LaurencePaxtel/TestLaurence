//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 25/09/2020, 08:14:01
// ----------------------------------------------------
// Method: LB_new_format
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_REAL:C285($x; $y)
C_LONGINT:C283($souris; $gauche; $haut; $droite; $bas; $b)

GET MOUSE:C468($x; $y; $souris)
GET WINDOW RECT:C443($gauche; $haut; $droite; $bas; Frontmost window:C447)

$b:=Open window:C153($gauche+$x-320; $haut+$y-20; $gauche+$x+140; $haut+$y+80; Dialogue modal déplaçable:K34:7; "Enregistrement du modèle d'affichage")
DIALOG:C40("Save_LB_Liste")

If (ok=1)
	
	If (Read only state:C362([Preferences:81]))
		READ WRITE:C146([Preferences:81])
	End if 
	
	CREATE RECORD:C68([Preferences:81])
	MultiSoc_Init_Structure(->[Preferences:81])
	[Preferences:81]PREF_Type:2:="Modèle de liste"
	[Preferences:81]PREF_Info_plus_2:24:=Nom_Modele
	[Preferences:81]PREF_Informations:11:=LB_tableau_LB_vers_BLOB
	
	Case of 
		: (b1=1)  // Sauvegarde d'un modèle perso
			[Preferences:81]PREF_UID_user:7:=<>Ref_User_actif
	End case 
	
	SAVE RECORD:C53([Preferences:81])
	
	APPEND TO ARRAY:C911(Liste_type_formulaire; "USR")
	APPEND TO ARRAY:C911(Liste_ref_formulaire; String:C10([Preferences:81]UID:1))
	APPEND TO ARRAY:C911(Liste_formulaire; Nom_Modele)
	
	UNLOAD RECORD:C212([Preferences:81])
	READ ONLY:C145([Preferences:81])
	
	Liste_formulaire:=Size of array:C274(Liste_formulaire)
End if 