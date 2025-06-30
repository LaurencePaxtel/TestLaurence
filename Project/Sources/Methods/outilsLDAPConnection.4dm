//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : remyscanu
// Date et heure : 16/01/24, 18:16:10
// ----------------------------------------------------
// Méthode : outilsLDAPConnection
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Boolean  // Echec authentification LDAP
var $1 : Text  // Url LDAP
var $2 : Text  // Login LDAP
var $3 : Text  // Mot de passe LDAP
var $4 : Text  // Point d'entrée
var $5 : Text  // Groupe auquel doit appartenir l'utilisateur connecté au serveur LDAP [Optionnel]

var $LDAPGroupConnection_t : Text
var $groupeTrouver_b : Boolean
var $result_o : Object
var $result_c : Collection

var $LDAP_cs : cs:C1710.LDAP

$LDAP_cs:=cs:C1710.LDAP.new()
$LDAP_cs.setLDAPInformation($1; $2; $3)
$LDAP_cs.setLDAPEntryPoint($4)

$LDAP_cs.connectionToServer(LDAP mot de passe en clair:K83:5)
$0:=$LDAP_cs.loginError

If ($0=False:C215)  // Connexion avec le serveur LDAP réussie
	
	If (Count parameters:C259=5)
		$result_c:=$LDAP_cs.searchInLDAPServer("mail="+$2; \
			New collection:C1472(\
			New object:C1471("name"; "cn"; "booleanValue"; False:C215); \
			New object:C1471("name"; "mail"; "booleanValue"; False:C215); \
			New object:C1471("name"; "memberOf"; "booleanValue"; True:C214)))
		
		$LDAPGroupConnection_t:="@"+$5+"@"
		
		For each ($result_o; $result_c) Until ($groupeTrouver_b=True:C214)
			
			Case of 
				: (Value type:C1509($result_o.memberOf)=Est une collection:K8:32)
					$groupeTrouver_b:=($result_o.memberOf.indexOf($LDAPGroupConnection_t)>=0)
				: (Value type:C1509($result_o.memberOf)=Est un texte:K8:3)
					$groupeTrouver_b:=($result_o.memberOf=$LDAPGroupConnection_t)
			End case 
			
		End for each 
		
		// Vérification si l'utilisateur appartient au groupe auquel il doit appartenir pour pouvoir utiliser le logiciel
		$0:=Not:C34($groupeTrouver_b)
	End if 
	
	$LDAP_cs.disconnectionToServer()
End if 