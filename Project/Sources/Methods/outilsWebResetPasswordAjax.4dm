//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 04/12/23, 16:42:50
// ----------------------------------------------------
// Méthode : outilsWebResetPasswordAjax
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $intervenantID_t : Text
var $statut_o; $retour_o : Object

var $intervenant_e : cs:C1710.INtervenantsEntity
var $structureUser_e : cs:C1710.Structure_UserEntity

$retour_o:=New object:C1471

$intervenantID_t:=Web_Form_Get_Post_Value("intervenantID")
$motDePasse_t:=Web_Form_Get_Post_Value("motDePasse")

/*
$utilisateurCourant_t:=Current user:C182

If ($utilisateurCourant_t#"apaxtel")
	CHANGE CURRENT USER:C289("apaxtel"; "opsys$017734")
End if 
*/

Case of 
	: (String:C10(w_visiteur.action)="resetPassword")
		outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]ID:16; Num:C11($intervenantID_t); ->$intervenant_e; "first")
		
		If ($intervenant_e#Null:C1517)
			// Modifié par : Scanu Rémy (20/02/2024)
			// Utilisation de la table [INtervenants] pour stocker le mot de passe
			$intervenant_e.IN_HashPassword:=Generate password hash:C1533($motDePasse_t)
			$intervenant_e.IN_DateDeModifDuMP:=Current date:C33(*)
			$statut_o:=$intervenant_e.save()
			
			// Modifié par : Scanu Rémy (23/05/2024)
			OB REMOVE:C1226(w_visiteur; "resetPassword")
/*
$utilisateurSupprime_b:=Utilisateur supprimé($intervenant_e.IN_RéfUser)
			
LIRE PROPRIÉTÉS UTILISATEUR($intervenant_e.IN_RéfUser; $login_t; $methodeDemarrage_t; $motDePasseB_t; $nbUtilisation_el; $derniereUtilisation_d; $userGroupe_ai)
$position_el:=Écrire propriétés utilisateur($intervenant_e.IN_RéfUser; $login_t; $methodeDemarrage_t; $motDePasse_t; 0; Date du jour; $userGroupe_ai)
			
$retour_o.utilisateurCourant:=$utilisateurCourant_t
$retour_o.refUser:=$intervenant_e.IN_RéfUser
$retour_o.position:=$position_el
$retour_o.login:=$login_t
$retour_o.motDePasseAncien:=$motDePasseB_t
$retour_o.motDePasse:=$motDePasse_t
$retour_o.methodeDemarrage:=$methodeDemarrage_t
$retour_o.userGroupe:=JSON Stringify tableau($userGroupe_ai; *)
$retour_o.utilisateurSupprime:=$utilisateurSupprime_b
*/
			
			If (String:C10(w_visiteur.acceptCGU)="on")
				outilsOrdaSearchSimple(->[Structure_User:80]; ->[Structure_User:80]UID_Utilisateur:2; $intervenant_e.ID; ->$structureUser_e; "first")
				
				If ($structureUser_e.cgu=Null:C1517)
					$structureUser_e.cgu:=New object:C1471
				End if 
				
				$structureUser_e.cgu.accept:=True:C214
				$structureUser_e.cgu.log:=New object:C1471("date"; Current date:C33; "heure"; String:C10(Current time:C178); "login"; $intervenant_e.IN_Login)
				
				$statut_o:=$structureUser_e.save()
			End if 
			
		Else 
			$retour_o.notificationError:="Votre identifiant n'a pas pu être trouvé dans la base de données, veuillez vous rapprocher du service informatique."
		End if 
		
End case 

/*
If ($utilisateurCourant_t#"apaxtel")
	CHANGE CURRENT USER:C289(<>User_Actif_Login; "")
End if 

LIRE PROPRIÉTÉS UTILISATEUR(368; $login_t; $methodeDemarrage_t; $motDePasseB_t; $nbUtilisation_el; $derniereUtilisation_d; $userGroupe_ai)

$retour_o.utilisateurCourant:=$utilisateurCourant_t
$retour_o.position:=$position_el
$retour_o.login:=$login_t
$retour_o.motDePasseAncien:=$motDePasseB_t
$retour_o.methodeDemarrage:=$methodeDemarrage_t
$retour_o.userGroupe:=JSON Stringify tableau($userGroupe_ai; *)
*/

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))