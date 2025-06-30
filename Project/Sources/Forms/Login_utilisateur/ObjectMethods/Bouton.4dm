// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 15/09/18, 03:11:50
// ----------------------------------------------------
// Méthode : Login_utilisateur.Bouton
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $UUID_t : Text
var $pos_el : Integer
var $continue_b; $LDAPAuthentification_b; $LDAPAuthentificationError_b : Boolean
var $statut_o : Object

var $loginMemo_e : cs:C1710.LoginMemoEntity
var $loginMemo_es : cs:C1710.LoginMemoSelection

var $societe_e : cs:C1710.SOcieteEntity
var $structure_e : cs:C1710.StructuresEntity

var $intervenant_e : cs:C1710.INtervenantsEntity
var $intervenant_es : cs:C1710.INtervenantsSelection


C_TEXT:C284(<>User_Actif_Login; <>User_Actif_Password)
C_REAL:C285(<>Ref_User_actif)


<>User_Actif_Login:=""
<>User_Actif_Password:=""

<>Ref_User_actif:=0

// Modifié par : Scanu Rémy (17/01/2024)
$UUID_t:=Liste_ref_entreprise{Liste_entreprise}

If ($UUID_t#"")
	outilsOrdaSearchSimple(->[Structures:79]; ->[Structures:79]UID:1; $UUID_t; ->$structure_e; "first")
	outilsOrdaSearchSimple(->[SOciete:18]; ->[SOciete:18]Ref_Structure:97; $structure_e.Ref_Structure; ->$societe_e; "first")
	
	If ($societe_e#Null:C1517)
		
		If ($societe_e.SO_LDAP#Null:C1517)
			$LDAPAuthentification_b:=(Bool:C1537($societe_e.SO_LDAP.activer) & (The_Login#"apaxtel"))
			
			If ($LDAPAuthentification_b=True:C214)
				$LDAPAuthentificationError_b:=True:C214
				$intervenant_es:=ds:C1482.INtervenants.query("IN_Email = :1 AND Ref_Structure = :2"; The_Login; $societe_e.Ref_Structure)
				
				If ($intervenant_es.length>0)
					$intervenant_e:=$intervenant_es.first()
					$LDAPAuthentificationError_b:=outilsLDAPConnection($societe_e.SO_LDAP.url; The_Login; The_PW; \
						$societe_e.SO_LDAP.entryPoint; $intervenant_e.IN_LDAP.group.connection)
				End if 
				
				If ($LDAPAuthentificationError_b=False:C215)
					
					If (outilsManagePassword(1; $intervenant_e.ID; "")=True:C214)
						<>Ref_User_actif:=$intervenant_e.IN_RéfUser
						<>User_Actif_Login:=$intervenant_e.IN_Login
						
						$continue_b:=True:C214
					End if 
					
					If ($continue_b=True:C214)
						CHANGE CURRENT USER:C289(<>User_Actif_Login; "")
					Else 
						ALERT:C41("Le logiciel vous a bien reconnu sur le serveur LDAP avec vos identifiants mais une erreur"+\
							" interne au logiciel empêche la poursuite de la connexion, veuillez contacter le support technique")
					End if 
					
				Else 
					ALERT:C41("Le logiciel n'a pas réussi à se connecter au serveur LDAP avec vos identifiants")
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End if 

If ($LDAPAuthentification_b=False:C215)
	The_Login:=Replace string:C233(The_Login; Char:C90(Arobase:K15:46); " ")
	outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]IN_Login:3; The_Login; ->$intervenant_es)
	
	If ($intervenant_es.length>0) | (The_Login="apaxtel")
		
		If (The_Login="apaxtel")
			GET USER LIST:C609(atUserName; alUserID)
			$pos_el:=Find in array:C230(atUserName; The_Login)
			
			$continue_b:=Validate password:C638(alUserID{$pos_el}; The_PW)
		Else 
			$intervenant_e:=$intervenant_es.first()
			$continue_b:=outilsManagePassword(1; $intervenant_e.ID; The_PW)
		End if 
		
		If ($continue_b=True:C214)
			<>User_Actif_Login:=The_Login
			<>User_Actif_Password:=The_PW
			
			If (The_Login="apaxtel")
				<>Ref_User_actif:=alUserID{$pos_el}
				CHANGE CURRENT USER:C289(The_Login; The_PW)
			Else 
				<>Ref_User_actif:=$intervenant_e.IN_RéfUser
				CHANGE CURRENT USER:C289(The_Login; "")
			End if 
			
			$continue_b:=True:C214
		Else 
			try:=try+1
		End if 
		
	Else 
		ALERT:C41("Ce login n'existe pas ! Veuillez essayer à nouveau.")
		
		The_Login:=""
		try:=0
		
		GOTO OBJECT:C206(The_Login)
	End if 
	
End if 

Case of 
	: ($continue_b)
		
		If (Memo_login=1)
			
			// Modifié par : Scanu Rémy (17/07/2023)
			// Sauvegarde du login par nom de machine / nom de session et plus par nom de machine uniquement
			$user_o:=Get system info:C1571
			$loginMemo_es:=ds:C1482.LoginMemo.query("machine = :1 AND session = :2"; $user_o.machineName; $user_o.accountName)
			
			If ($loginMemo_es.length=0)
				$loginMemo_e:=ds:C1482.LoginMemo.new()
			Else 
				$loginMemo_e:=$loginMemo_es.first()
			End if 
			
			$loginMemo_e.login:=The_Login
			$loginMemo_e.machine:=$user_o.machineName
			$loginMemo_e.session:=$user_o.accountName
			
			$loginMemo_e.structure:=Liste_initiale_entreprise{Liste_entreprise}
			
			$statut_o:=$loginMemo_e.save()
		End if 
		
		MultiSoc_Usr_Choix_entreprise
	: (try=1) & ($LDAPAuthentificationError_b=False:C215)
		ALERT:C41("Le mot de passe est incorrect"+Char:C90(13)+Char:C90(13)+"Il vous reste 2 essais")
		GOTO OBJECT:C206(The_PW)
	: (try=2) & ($LDAPAuthentificationError_b=False:C215)
		ALERT:C41("Le mot de passe est incorrect"+Char:C90(13)+Char:C90(13)+"Il vous reste 1 essai")
		GOTO OBJECT:C206(The_PW)
	: (try=3) & ($LDAPAuthentificationError_b=False:C215)
		ALERT:C41("Le mot de passe est incorrect"+Char:C90(13)+Char:C90(13)+"Le programme va etre quitté")
		QUIT 4D:C291
End case 