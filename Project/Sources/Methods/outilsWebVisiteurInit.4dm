//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 22/07/24, 17:11:37
// ----------------------------------------------------
// Méthode : outilsWebVisiteurInit
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $userPreferences_t : Text
var $userPreferences_o; $societe_o : Object

var userPlateForme_c : Collection

var $intervenant_e : cs:C1710.INtervenantsEntity
var $intervenant_es : cs:C1710.INtervenantsSelection

var $societe_e : cs:C1710.SOcieteEntity
var $societe_es : cs:C1710.SOcieteSelection

userPlateForme_c:=New collection:C1472

// Initialisation de l'objet w_visiteur
Web_Int_Custom_Content

$intervenant_e:=ds:C1482.INtervenants.get(Session:C1714.storage.intervenant.ID)

If ($intervenant_e#Null:C1517)
	
	w_visiteur.Ref_Structure:=$intervenant_e.Ref_Structure
	ref_soc_active:=w_visiteur.Ref_Structure
	
	w_userUID:=$intervenant_e.ID
	w_userNom:=$intervenant_e.IN_NomPrénom
	
	// Modifié par : Scanu Rémy (21/06/2023)
	w_visiteur.Ref_Structure:=ref_soc_active
	
	va_UserPlateforme:=$intervenant_e.IN_Plateforme
	
	// Modifié par : Scanu Rémy (17/07/2023)
	// Variable qui liste toutes les plateformes auxquelles à droit l'utilisateur
	userPlateForme_c:=Split string:C1554($intervenant_e.IN_Notes; ";"; sk ignorer chaîne vide:K86:1)
	
	userPlateForme_c.push(va_UserPlateforme)
	userPlateForme_c:=userPlateForme_c.distinct()
	
	
	// Conserve la liste des plateformes dans la session pour l'API
	Use (Session:C1714.storage.intervenant)
		Session:C1714.storage.intervenant.Plateformes:=userPlateForme_c
	End use 
	
	// Modifié par : Scanu Rémy (22/09/2023)
	If (String:C10(w_visiteur.login)="true")  // L'utilisateur vient de la page de connexion
		$userPreferences_t:=Document to text:C1236(w_visiteur.customPath; "UTF-8"; Document inchangé:K24:18)
		$userPreferences_o:=JSON Parse:C1218($userPreferences_t)
		
		$userPreferences_o.plateforme:=va_UserPlateforme
		TEXT TO DOCUMENT:C1237(w_visiteur.customPath; JSON Stringify:C1217($userPreferences_o); "UTF-8"; Document inchangé:K24:18)
		
		w_userPreferences:=Document to text:C1236(w_visiteur.customPath; "UTF-8"; Document inchangé:K24:18)
	Else   // L'utilisateur est déjà authentifié
		$userPreferences_t:=Document to text:C1236(w_visiteur.customPath; "UTF-8"; Document inchangé:K24:18)
		$userPreferences_o:=JSON Parse:C1218($userPreferences_t)
	End if 
	
	w_visiteur.User_Plateforme:=$userPreferences_o.plateforme
	w_visiteur.User_Preferences:=$userPreferences_o
	
	w_visiteur.Privilege:=outilsManagePrivilege(2; ""; w_userUID)
	va_UserPlateforme:=w_visiteur.User_Plateforme
	
	// Modifié par : Scanu Rémy (18/07/2023)
	// On stock dans w_visiteur l'entity de la societe connecté
	$societe_es:=ds:C1482.SOciete.query("Ref_Structure = :1"; w_visiteur.Ref_Structure)
	
	If ($societe_es.length>0)
		$societe_e:=$societe_es.first()
		$societe_o:=$societe_e.toObject()
	End if 
	
	w_visiteur.societe:=$societe_o
	w_visiteur.intervenant:=$intervenant_e.toObject()
End if 