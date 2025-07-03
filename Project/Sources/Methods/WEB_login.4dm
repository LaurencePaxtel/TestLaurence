//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 00:57:00
// ----------------------------------------------------
// Méthode : WEB_login
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $http_redirect; $redirect_action : Text
var $pos_el : Integer
var $go; $resetPassword_b; $LDAPAuthentification_b; $LDAPAuthentificationError_b : Boolean
var $statut_o : Object

var firstname; lastname; email; identifier; password; w_mess : Text

var $structureUser_e : cs:C1710.Structure_UserEntity

var $intervenant_e : cs:C1710.INtervenantsEntity
var $intervenant_es : cs:C1710.INtervenantsSelection

var $societe_e : cs:C1710.SOcieteEntity

$go:=True:C214

w_mess:=""

If (w_post)
	$identifier:=WEB_UTL_getVal("identifier")
	$password:=WEB_UTL_getVal("password")
	
	$key:=WEB_UTL_getVal("key")
	$redirect_action:=WEB_UTL_getVal("redirect_action")
	
	If ($redirect_action="planning")
		$http_redirect:="/USR?action=planning"
	End if 
	
	If ((Position:C15("@"; $key)#0) | (w_cookie=""))
		w_mess:="Username or password incorrect!"
		CLEAR VARIABLE:C89($go)
	End if 
	
	If ($go)
		// Modifié par : Scanu Rémy (19/01/2024)
		// Intégration de l'identification par LDAP
		$pos_el:=Position:C15(Char:C90(Arobase:K15:46); $identifier)
		
		If ($pos_el>0)  // Identification par adresse email (LDAP)
			outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]IN_Email:20; $identifier; ->$intervenant_es)
		Else   // Identification par identifiant 4D
			outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]IN_Login:3; $identifier; ->$intervenant_es)
		End if 
		
		Case of 
			: ($intervenant_es.length=0)
				w_mess:="Identifiant ou mot de passe incorrect !"
				CLEAR VARIABLE:C89($go)
			: ($intervenant_es.length>1)
				w_mess:="Plusieurs personnes avec le même identifiant ont été trouvées !"
				CLEAR VARIABLE:C89($go)
			: ($intervenant_es.length=1)
				$intervenant_e:=$intervenant_es.first()
				
				// Utilisation du Session.storage
				Use (Session:C1714.storage.intervenant)
					
					Session:C1714.storage.intervenant.ID:=$intervenant_e.ID
					Session:C1714.storage.intervenant.Login:=$intervenant_e.IN_Login
					Session:C1714.storage.intervenant.Email:=$intervenant_e.IN_Email
					Session:C1714.storage.intervenant.Ref_Structure:=$intervenant_e.Ref_Structure
					Session:C1714.storage.intervenant.Nom_Structure:=ds:C1482.SOciete.query("Ref_Structure = :1"; $intervenant_e.Ref_Structure).first().SO_Libel00
					Session:C1714.storage.intervenant.Plateforme:=$intervenant_e.IN_Plateforme
					Session:C1714.storage.intervenant.Privileges:=New shared collection:C1527()
				End use 
				Use (Session:C1714.storage.intervenant.Privileges)
					Session:C1714.storage.intervenant.Privileges:=$intervenant_e.AllIntervenantPrivilege.OnePrivilege.toCollection("nom").copy(ck shared:K85:29; Session:C1714.storage.intervenant.Privileges)
				End use 
				
				Use (Session:C1714.storage)
					Session:C1714.storage.enumeration:=Null:C1517
				End use 
				
				outilsOrdaSearchSimple(->[SOciete:18]; ->[SOciete:18]Ref_Structure:97; $intervenant_e.Ref_Structure; ->$societe_e; "first")
				
				If ($societe_e#Null:C1517)
					
					If ($societe_e.SO_LDAP#Null:C1517)
						$LDAPAuthentification_b:=(Bool:C1537($societe_e.SO_LDAP.activer) & ($identifier#"*Administrateur"))
					End if 
					Use (Session:C1714.storage.societe)
						Session:C1714.storage.societe.codeCentre:=$societe_e.SO_CodeCentre
						Session:C1714.storage.societe.ModeCHRS:=$societe_e.SO_ModeCHRS
						Session:C1714.storage.societe.ID:=$societe_e.ID
						Session:C1714.storage.societe.site:=$societe_e.Site
						Session:C1714.storage.societe.nom:=$societe_e.SO_Libel00
						
					End use 
				End if 
				If ($pos_el>0)  // Identification par adresse email (LDAP)
					If ($LDAPAuthentification_b=True:C214)
						$LDAPAuthentificationError_b:=outilsLDAPConnection($societe_e.SO_LDAP.url; $identifier; $password; \
							$societe_e.SO_LDAP.entryPoint; $intervenant_e.IN_LDAP.group.connection)
						
						If ($LDAPAuthentificationError_b=False:C215)
							$identifier:=$intervenant_e.IN_Login
							CLEAR VARIABLE:C89($password)
						Else 
							w_mess:="Le logiciel n'a pas réussi à se connecter au serveur LDAP avec vos identifiants"
						End if 
						
					End if 
					
				End if 
				
				Case of 
					: (outilsManagePassword(1; $intervenant_e.ID; $password)=True:C214) & ($LDAPAuthentificationError_b=False:C215)
						//CHANGER UTILISATEUR COURANT($identifier; "")
						
						// Modifié par : Scanu Rémy (01/12/2023)
						OB REMOVE:C1226(w_visiteur; "resetPassword")
						$resetPassword_b:=(($password="") & ($LDAPAuthentification_b=False:C215))
						
						outilsOrdaSearchSimple(->[Structure_User:80]; ->[Structure_User:80]UID_Utilisateur:2; $intervenant_e.ID; ->$structureUser_e; "first")
						$cguDisplay_b:=($structureUser_e=Null:C1517)
						
						If ($identifier#"*Administrateur")
							
							If ($cguDisplay_b=False:C215)
								$cguDisplay_b:=($structureUser_e.cgu=Null:C1517)
							End if 
							
							If ($cguDisplay_b=False:C215)
								$cguDisplay_b:=(Bool:C1537($structureUser_e.cgu.accept)=False:C215)
							End if 
							
						End if 
						
					: (w_mess="")
						w_mess:="Identifiant ou mot de passe incorrect !"
				End case 
				
				If (w_mess#"")
					CLEAR VARIABLE:C89($go)
				End if 
				
		End case 
		
		If ($go)
			
			Use (Session:C1714.storage.intervenant)
				Session:C1714.storage.intervenant.cookie:=w_cookie
			End use 
			
			$intervenant_e.IN_Cookie:=w_cookie
			$statut_o:=$intervenant_e.save()
			
			Case of 
				: ($http_redirect#"")
					WEB SEND HTTP REDIRECT:C659($http_redirect)
				: ($resetPassword_b=True:C214)
					// WEB ENVOYER REDIRECTION HTTP("/INT?action=usager-list&login=true&resetPassword=Vrai"+Choisir($cguDisplay_b=Vrai; "&cgu=Vrai"; ""))
					WEB SEND HTTP REDIRECT:C659("/home?login=true&resetPassword=Vrai"+Choose:C955($cguDisplay_b=True:C214; "&cgu=Vrai"; ""))
				Else 
					// WEB ENVOYER REDIRECTION HTTP("/INT?action=usager-list&login=true")
					WEB SEND HTTP REDIRECT:C659("/home?login=true")
			End case 
			
		End if 
		
	End if 
	
End if 

If ($go=False:C215) | (Not:C34(w_post))
	Web_Login_Form
End if 