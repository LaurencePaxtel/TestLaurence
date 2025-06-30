//%attributes = {}
// ------------------------------------------------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 24/10/18, 08:50:06
// ------------------------------------------------------------------------------------------
// Méthode : WebAGL_ChoixStructure
// Description
//
//Cette methode fixe sur quelle structure (= société) on travaille
// une fois ce choix effectué, on redirige sur la page d'accueil
// Est appelée dans 3 cas :
//
// 1/ par WEB_accueil lors de la premiere connexion
// si possible, on réutilise le choix de structure fait lors de la dernière utilisation
// sinon si il n'y a qu'une seule structure, elle est choisie automatiquement
// sinon on propose à l'utilisateur la liste des structures auxquelles il a droit
//
// 2/ sur demande de l'utilisateur via le lien /choixSociete
// on propose à l'utilisateur la liste de structures auxquelles il a droit
//
// 3/ suite au choix par l'utilisateur (w_post=vrai)
// on mémorise le choix et on retourne à l'accueil
// ------------------------------------------------------------------------------------------
var $nouvelleStructure : Text
var $nbStructures : Integer
var $proposer : Boolean
var $statut_o : Object

var $intervenant_e : cs:C1710.HeBergeEntity

var $preference_e : cs:C1710.PreferencesEntity
var $preference_es : cs:C1710.PreferencesSelection

$preference_es:=ds:C1482.Preferences.query("PREF_Type = :1 AND PREF_UID_user = :2"; "WEB_structure"; w_userUID)

QUERY:C277([Structure_User:80]; [Structure_User:80]UID_Utilisateur:2=w_userUID)
QUERY:C277([Structures:79]; [Structures:79]UID:1=[Structure_User:80]UID_Structure:1)

If (w_action="choixSociete")
	
	If (w_get)
		$proposer:=True:C214
	Else 
		$nouvelleStructure:=WEB_UTL_getVal("choixStruct")
		
		// Vérifier que la structure est autorisée ************
		QUERY:C277([Structure_User:80]; [Structure_User:80]UID_Utilisateur:2=w_userUID; *)
		QUERY:C277([Structure_User:80];  & ; [Structure_User:80]UID_Structure:1=$nouvelleStructure)
		
		If (Records in selection:C76([Structure_User:80])#0)
			w_structure:=$nouvelleStructure
		Else   // Probable tentative de hack
			WEB_UTL_Create_Log("hack : "+String:C10($preference_e.PREF_UID_user)+" demande structure "+$nouvelleStructure)
			$proposer:=True:C214
		End if 
		
	End if 
	
Else   // Requete ordinaire, en général après le login, normalement un choix précédent est mémorisé sauf à la première connexion d'un nouvel utilisateur.
	
	Case of 
		: ($preference_es.length=1)
			$preference_e:=$preference_es.first()
			
			If ($preference_e.PREF_Info_plus_1="")
				$intervenant_e:=ds:C1482.INtervenants.get(w_userUID)
				
				$preference_e.PREF_Info_plus_1:=$intervenant_e.Ref_Structure
				$statut_o:=$preference_e.save()
			End if 
			
			w_structure:=$preference_e.PREF_Info_plus_1
			$proposer:=(w_structure="")  // Normalement FAUX
		: ($preference_es.length=0)
			$proposer:=True:C214
		Else 
			WEB_UTL_Create_Log("WEB_structure : doublon pour "+String:C10($preference_e.PREF_UID_user))
	End case 
	
End if 

If ($proposer)
	QUERY:C277([Structure_User:80]; [Structure_User:80]UID_Utilisateur:2=w_userUID)
	$nbStructures:=Records in selection:C76([Structure_User:80])
	
	If ($nbStructures=1)  // Si l'utilisateur n'a accès qu'à une seule structure, il ne choisit pas
		
		// Modifié par : Kevin HASSAL - (08/10/2013)
		QUERY:C277([Structures:79]; [Structures:79]UID:1=[Structure_User:80]UID_Structure:1)
		$nouvelleStructure:=[Structures:79]STRC_Initiales:2
		
		CLEAR VARIABLE:C89($proposer)
	Else 
		RELATE ONE SELECTION:C349([Structure_User:80]; [Structures:79])
	End if 
	
End if 

Case of 
	: ($proposer)
		WEB_UTL_page("structures.shtml")
	: ($nouvelleStructure#"")
		
		If ($preference_es.length=0)
			// WARNING : le risque de créer cet enregistrement en double est très faible mais non nul
			// cela peu se produire si l'utilisateur clique F5 lors de sa première connexion la protection par sémaphore serait génante ici je recommanderais plutôt de créer automatiquement la [pref] pour chaque utilisateur
			// autorisé a se connecter au Web, ou, encore plus simple, de mettre ce champ DANS la fiche utilisateur
			$preference_e:=ds:C1482.Preferences.new()
		Else 
			$loaded:=WEB_UTL_silentLoad(->[Preferences:81]; 60)
		End if 
		
		w_structure:=$nouvelleStructure
		
		$preference_e.PREF_Type:="WEB_structure"
		$preference_e.PREF_UID_user:=w_userUID
		$preference_e.PREF_Info_plus_1:=w_structure
		$preference_e.PREF_Time_Stamp:=UTL_genere_timestamp
		$statut_o:=$preference_e.save()
		
		WEB SEND HTTP REDIRECT:C659("/")
	: (w_structure="")  // Laisser continuer normalement
		WEB_UTL_Create_Log("WEB_structure : rien trouvé pour "+String:C10($preference_e.PREF_UID_user))
	Else 
		WEB SEND HTTP REDIRECT:C659("/")
End case 