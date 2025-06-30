//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 15/09/18, 06:20:39
// ----------------------------------------------------
// Méthode : USR_Get_Structures
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $LDAP_cs : cs:C1710.LDAP
var $intervenant_es : cs:C1710.INtervenantsSelection

ARRAY TEXT:C222($structure_at; 0)

// Modifié par : Scanu Rémy - remy@connect-io.fr (25/01/2022) et Re-modifié : par Scanu Rémy - remy@connect-io.fr (08/02/2022)
If (User in group:C338($1; <>Groupe_DEVELOP)=True:C214) | ($1="*Administrateur")
	ALL RECORDS:C47([Structures:79])
Else 
	
	// Modifié par : Scanu Rémy (17/01/2024)
	// Ajout connexion avec serveur LDAP
	If (Position:C15(Char:C90(Arobase:K15:46); $1)>0)
		$LDAP_cs:=cs:C1710.LDAP.new()
		$intervenant_es:=$LDAP_cs.searchEmailInHostBase(->[INtervenants:10]; ->[INtervenants:10]IN_Email:20; $1)
		
		USE ENTITY SELECTION:C1513($intervenant_es)
		LOAD RECORD:C52([INtervenants:10])
	Else 
		QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Login:3=$1)
	End if 
	
	If (Records in selection:C76([INtervenants:10])>0)
		QUERY:C277([Structure_User:80]; [Structure_User:80]UID_Utilisateur:2=[INtervenants:10]ID:16)
		
		SELECTION TO ARRAY:C260([Structure_User:80]UID_Structure:1; $structure_at)
		QUERY WITH ARRAY:C644([Structures:79]UID:1; $structure_at)
	Else 
		UNLOAD RECORD:C212([Structure_User:80])
		UNLOAD RECORD:C212([Structures:79])
		
		REDUCE SELECTION:C351([Structure_User:80]; 0)
		REDUCE SELECTION:C351([Structures:79]; 0)
	End if 
	
End if 