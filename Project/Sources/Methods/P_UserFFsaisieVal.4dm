//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_UserFFsaisieVal
//{          Mardi 12 avril 2011 à 11:55:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
var $utilisateurCourant_t : Text
var $pos_el; $typeUser_el : Integer
var $vb_OK : Boolean
var $privilege_o : Object
var $privilege_c : Collection

var $privilege_e : cs:C1710.PrivilegeEntity

var $intervenantPrivilege_e : cs:C1710.IntervenantsPrivilegeEntity
var $intervenantPrivilege_es : cs:C1710.IntervenantsPrivilegeSelection


gError:=0
Acces_Plateforme(3; "")

If ([INtervenants:10]IN_Login:3>"")
	$utilisateurCourant_t:=Current user:C182
	
	If ($utilisateurCourant_t#"apaxtel")
		CHANGE CURRENT USER:C289("apaxtel"; "opsys$017734")
	End if 
	
	If (Is new record:C668([INtervenants:10]))
		MultiSoc_Init_Structure(->[INtervenants:10])
		
		ON ERR CALL:C155("i_Error")
		
		If ([INtervenants:10]IN_Initiales:7#"")
			// Modifié par : Scanu Rémy (20/12/2023)
			// Afin de permettre à des utilisateurs ayant le droit de le faire de créer d'autres utilisateurs, je change vers le Super Utilisateur apaxtel temporairement
			$typeUser_el:=-2
			
			// Modifié par : Scanu Rémy (25/10/2022)
			If ($utilisateurCourant_t="apaxtel")
				CONFIRM:C162("Voulez-vous créer un utilisateur ayant le type utilisateur « Développeur »"; "Oui"; "Non")
				
				If (OK=1)
					$typeUser_el:=-1
				End if 
				
			End if 
			
			$pos_el:=Set user properties:C612($typeUser_el; [INtervenants:10]IN_Login:3; ""; ""; 0; Current date:C33; tl_UserGroupe)
			
			// Modifié par : Scanu Rémy (20/02/2024)
			// Utilisation de la table [INtervenants] pour stocker le mot de passe
			[INtervenants:10]IN_HashPassword:22:=Generate password hash:C1533("")
			[INtervenants:10]IN_RéfUser:11:=$pos_el
			$vb_OK:=True:C214
			
			ON ERR CALL:C155("")
			
			If ($pos_el=0)
				ALERT:C41("Le login existe déja")
			End if 
			
		Else 
			ALERT:C41("Merci de renseigner le champ [INtervenants]IN_Initiales")
		End if 
		
	Else 
		ON ERR CALL:C155("i_Error")
		
		// Modifié par : Scanu Rémy (03/02/2023)
		// On prend les IDS des groupes qui a dans la listBox
		//LIRE PROPRIÉTÉS UTILISATEUR([INtervenants]IN_RéfUser; $nom_t; $methode_t; $motDePasse_t; $nbUtilisation_el; $dateModif_d; $adhesion_ai; $proprietaire_el)
		$pos_el:=Set user properties:C612([INtervenants:10]IN_RéfUser:11; [INtervenants:10]IN_Login:3; ""; *; 0; Current date:C33; tl_UserGroupe)
		
		If ($pos_el>0)
			$vb_OK:=True:C214
		Else 
			ALERT:C41("Le login : "+[INtervenants:10]IN_Login:3+" n'est pas référencé !")
		End if 
		
		ON ERR CALL:C155("")
	End if 
	
	If ($utilisateurCourant_t#"apaxtel")
		CHANGE CURRENT USER:C289(<>User_Actif_Login; "")
	End if 
	
Else 
	ALERT:C41("Veuillez saisir un Login !")
End if 

If ($vb_OK=False:C215)
	REJECT:C38
Else 
	
	// Modifié par : Scanu Rémy (02/02/2024)
	// Nouvelle gestion des privilèges par la table [IntervenantsPrivilege]
	$privilege_c:=New collection:C1472
	
	ARRAY TO COLLECTION:C1563($privilege_c; ta_UserGroupe; "nom"; tl_UserGroupe; "id")
	$intervenantPrivilege_es:=ds:C1482.IntervenantsPrivilege.query("intervenantID = :1"; [INtervenants:10]ID:16)
	
	If ($intervenantPrivilege_es.length>0)
		$intervenantPrivilege_es.drop()
	End if 
	
	For each ($privilege_o; $privilege_c)
		// Modifié par : Scanu Rémy (10/04/2024)
		// Création du privilège à la volée, plus besoin de faire la méthode rétroactif
		$privilege_e:=ds:C1482.Privilege.searchAndCreateRecordIfDontExist($privilege_o.nom)
		
		If ($privilege_e#Null:C1517)
			$intervenantPrivilege_e:=ds:C1482.IntervenantsPrivilege.searchAndCreateRecordIfDontExist([INtervenants:10]ID:16; $privilege_e.UUID)
		End if 
		
	End for each 
	
	ACCEPT:C269
End if 