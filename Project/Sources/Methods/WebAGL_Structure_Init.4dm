//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 24/10/18, 08:37:35
// ----------------------------------------------------
// Méthode : WebAGL_Structure_Init
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var $2 : Text

var $structureUID_t; $erreur_t : Text
var $userUID_el : Integer
var $locked_b : Boolean

var w_structureID : Integer

var $structure_e : cs:C1710.StructuresEntity

$userUID_el:=$1
$structureUID_t:=$2

w_structureID:=0

If ($structureUID_t#"")
	QUERY:C277([Preferences:81]; [Preferences:81]PREF_Type:2="WEB_structure"; *)
	QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_UID_user:7=w_userUID)
	
	// Vérifier que la structure est autorisée ************
	QUERY:C277([Structure_User:80]; [Structure_User:80]UID_Utilisateur:2=w_userUID; *)
	QUERY:C277([Structure_User:80];  & ; [Structure_User:80]UID_Structure:1=$structureUID_t)
	
	RELATE ONE SELECTION:C349([Structure_User:80]; [Structures:79])
	
	If (Records in selection:C76([Structure_User:80])#0)
		w_structure:=$structureUID_t
		
		Case of 
			: (Records in selection:C76([Preferences:81])=0)
				CREATE RECORD:C68([Preferences:81])
			: (Records in selection:C76([Preferences:81])=1)
				$locked_b:=WEB_UTL_silentLoad(->[Preferences:81]; 60)
			Else 
				$erreur_t:="erreur"
		End case 
		TRACE:C157
		If ($erreur_t="")
			[Preferences:81]PREF_Type:2:="WEB_structure"
			[Preferences:81]PREF_UID_user:7:=w_userUID
			[Preferences:81]PREF_Info_plus_1:8:=w_structure
			[Preferences:81]PREF_Time_Stamp:9:=UTL_genere_timestamp
			SAVE RECORD:C53([Preferences:81])
		End if 
		
		UNLOAD RECORD:C212([Preferences:81])
		Web_Log_Connection(w_userUID; w_structure; "Connection Web")
	Else 
		WEB_UTL_Create_Log("hack : "+String:C10([Preferences:81]PREF_UID_user:7)+" demande structure "+$structureUID_t)
	End if 
	
End if 

READ WRITE:C146([Preferences:81])

QUERY:C277([Preferences:81]; [Preferences:81]PREF_Type:2="WEB_structure"; *)
QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_UID_user:7=$userUID_el)

Case of 
	: (Records in selection:C76([Preferences:81])=1)
		w_structure:=[Preferences:81]PREF_Info_plus_1:8
		
		READ ONLY:C145([Structures:79])
		QUERY:C277([Structures:79]; [Structures:79]UID:1=w_structure)
		
		// Modifié par : Scanu Rémy (14/04/2023)
		// Si la base de donnée est basé sur une copie d'une autre base de donnée et que l'utilisateur est encore relié à une ancienne structure il faut faire la bascule
		If (Records in selection:C76([Structures:79])=0)
			outilsOrdaSearchSimple(->[Structures:79]; ->[Structures:79]STRC_Initiales:2; Storage:C1525.structure[0]; ->$structure_e; "first")
			
			[Preferences:81]PREF_Info_plus_1:8:=$structure_e.UID
			SAVE RECORD:C53([Preferences:81])
			
			QUERY:C277([Structures:79]; [Structures:79]UID:1=$structure_e.UID)
		End if 
		
		Nom_structure:=[Structures:79]STRC_Nom:4
		
		
		ref_soc_active:=[Structures:79]Ref_Structure:3
		
		<>user_nom_entreprise:=[Structures:79]STRC_Nom:4
		<>user_uid_entreprise:=[Structures:79]UID:1
		<>info_structure_user:="Structure : "+<>user_nom_entreprise+" / Utilisateur : "+Current user:C182
		<>strc_logoClient:=[Structures:79]STRC_Logo:5
		
		READ ONLY:C145([SOciete:18])
		QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
		
		If (Records in selection:C76([SOciete:18])=1)
			w_structureID:=[SOciete:18]ID:94
		End if 
		
	: (Records in selection:C76([Preferences:81])=0)  // Préference structure web par défaut
		QUERY:C277([Structure_User:80]; [Structure_User:80]UID_Utilisateur:2=$userUID_el)
		
		If (Records in selection:C76([Structure_User:80])>0)
			CREATE RECORD:C68([Preferences:81])
			[Preferences:81]PREF_Type:2:="WEB_structure"
			[Preferences:81]PREF_UID_user:7:=$userUID_el
			[Preferences:81]PREF_Info_plus_1:8:=[Structure_User:80]UID_Structure:1
			[Preferences:81]PREF_Time_Stamp:9:=UTL_genere_timestamp
			SAVE RECORD:C53([Preferences:81])
			
			QUERY:C277([Structures:79]; [Structures:79]UID:1=[Structure_User:80]UID_Structure:1)
			
			Nom_structure:=[Structures:79]STRC_Nom:4
			ref_soc_active:=[Structures:79]Ref_Structure:3
			
			
			<>user_nom_entreprise:=[Structures:79]STRC_Nom:4
			<>user_uid_entreprise:=[Structures:79]UID:1
			<>info_structure_user:="Structure : "+<>user_nom_entreprise+" / Utilisateur : "+Current user:C182
			<>strc_logoClient:=[Structures:79]STRC_Logo:5
		End if 
		
	Else 
		TRACE:C157
End case 

UNLOAD RECORD:C212([Preferences:81])