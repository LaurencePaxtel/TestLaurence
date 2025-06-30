//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Accès_User  
//{          Procédure : StartUser
//{          Dimanche 3 Décembre 1995 15:25 GUEDJ.P
//{          Lundi 28 mars 2011 à 15:27:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
var $0 : Boolean

var $user_t : Text
var $ii; $vl_Fenetre; $intervenantID_el : Integer
var $vb_OK; $LDAPConnection_b : Boolean
var $statut_o : Object

var $structureUser_e : cs:C1710.Structure_UserEntity
var $structureUser_es : cs:C1710.Structure_UserSelection

ARRAY TEXT:C222($type_at; 0)
ARRAY TEXT:C222(<>ta_UserPlateforme; 0)

$user_t:=Current user:C182
LIST TO ARRAY:C288("eTypes"; $type_at)

If (Value type:C1509(w_userLogin)#Est une variable indéfinie:K8:13) && (w_userLogin#"")
	$user_t:=w_userLogin
End if 

$0:=True:C214
Case of 
	: (User in group:C338($user_t; <>Groupe_DEVELOP))
		<>va_User:=$user_t
		<>va_UserCourant:=$user_t
		<>va_ProfUser:=<>Groupe_DEVELOP
		<>vl_UserRéfU:=1
		<>vl_UserLogRéfU:=1
		<>vb_UserLOFT:=False:C215
		<>vb_UserPointage:=True:C214
		<>vb_UserMessagerie:=True:C214
		<>va_UserPlateforme:="@"
		
	: (User in group:C338($user_t; <>Groupe_ADMIN))
		<>va_User:=$user_t
		<>va_UserCourant:=$user_t
		<>va_ProfUser:=<>Groupe_ADMIN
		<>vl_UserRéfU:=-1
		<>vl_UserLogRéfU:=2
		<>vb_UserLOFT:=False:C215
		<>vb_UserPointage:=True:C214
		<>vb_UserMessagerie:=True:C214
		<>va_UserPlateforme:="@"
	Else 
		P_LesLogs(<>va_Log_Entree; "")
		
		// La liste des utilisateurs référencés
		ARRAY LONGINT:C221(tl_UserNo; 0)
		ARRAY TEXT:C222(ta_UserLog; 0)
		
		QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Login:3=$user_t)
		MultiSoc_Filter(->[INtervenants:10])
		
		$ii:=Records in selection:C76([INtervenants:10])
		
		Case of 
			: ($ii=0)  // Aucun enregistrement trouvé
				READ WRITE:C146([INtervenants:10])
				FORM SET INPUT:C55([INtervenants:10]; "IN_EcranSaisieStart")
				
				$vl_Fenetre:=i_FenêtreNo(519; 419; 4; "Intervenant"; 3; "")
				ADD RECORD:C56([INtervenants:10])  // lpc 08122017 ascenceur
				
				If (OK=1)
					<>va_ProfUser:=Substring:C12(<>ta_Types{[INtervenants:10]IN_Type:2}; 5)
					<>va_User:=[INtervenants:10]IN_Prénom:5+" "+[INtervenants:10]IN_Nom:4
					<>va_UserCourant:=[INtervenants:10]IN_Login:3
					<>vl_UserRéfU:=[INtervenants:10]IN_RéférenceID:1
					<>vl_UserLogRéfU:=[INtervenants:10]IN_RéfUser:11
					<>vb_UserLOFT:=[INtervenants:10]IN_LOFT:10
					<>vb_UserPointage:=[INtervenants:10]IN_Pointage:14
					<>va_UserMessagerie:=""
					<>vb_UserMessagerie:=[INtervenants:10]IN_Messagerie:12
					<>va_UserPlateforme:=[INtervenants:10]IN_Plateforme:13
					
					$vb_OK:=Acces_Plateforme(1; [INtervenants:10]IN_Notes:6)
					
					outilsManageStorage("intervenant")
					UNLOAD RECORD:C212([INtervenants:10])
				Else 
					P_LesLogs(<>va_Log_Sortie; "")
					QUIT 4D:C291
					
					$0:=False:C215
				End if 
				
				CLOSE WINDOW:C154($vl_Fenetre)
				READ ONLY:C145([INtervenants:10])
			: ($ii=1)  // Un  enregistrement trouvé
				<>va_ProfUser:=Substring:C12($type_at{[INtervenants:10]IN_Type:2}; 5)
				<>va_User:=[INtervenants:10]IN_Prénom:5+" "+[INtervenants:10]IN_Nom:4
				<>va_UserCourant:=$user_t
				<>vl_UserRéfU:=[INtervenants:10]IN_RéférenceID:1
				<>vl_UserLogRéfU:=[INtervenants:10]IN_RéfUser:11
				<>vb_UserLOFT:=[INtervenants:10]IN_LOFT:10
				<>vb_UserPointage:=[INtervenants:10]IN_Pointage:14
				<>va_UserMessagerie:=""
				<>vb_UserMessagerie:=[INtervenants:10]IN_Messagerie:12
				<>va_UserPlateforme:=[INtervenants:10]IN_Plateforme:13
				
				$intervenantID_el:=[INtervenants:10]ID:16
				$vb_OK:=Acces_Plateforme(1; [INtervenants:10]IN_Notes:6)
				
				// Modifié par : Scanu Rémy (18/01/2024)
				If ([INtervenants:10]IN_LDAP:21#Null:C1517)
					$LDAPConnection_b:=([INtervenants:10]IN_LDAP:21.group.connection#"")
				End if 
				
				// Modifié par : Scanu Rémy (20/02/2024)
				// On abandonne la gestion des mots de passe sur 4D mais on passe par la table [INtervenants]
				If (outilsManagePassword(1; [INtervenants:10]ID:16; "")=True:C214) & ($LDAPConnection_b=False:C215)
					StrAlerte(25; "")
					Go_uMotPasseChanger
					
					If (OK#1)
						P_LesLogs(<>va_Log_Sortie; "")
						QUIT 4D:C291
						
						$0:=False:C215
					End if 
					
				End if 
				
				// Modifié par : Scanu Rémy (22/04/2022)
				QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=$intervenantID_el)
				$structureUser_es:=ds:C1482.Structure_User.query("UID_Utilisateur = :1 AND Ref_Structure = :2"; [INtervenants:10]ID:16; [INtervenants:10]Ref_Structure:17)
				
				If ($structureUser_es.length>0)
					$structureUser_e:=$structureUser_es.first()
					$cguDisplay_b:=($structureUser_e.cgu=Null:C1517)
					
					If ($cguDisplay_b=False:C215)
						$cguDisplay_b:=(Bool:C1537($structureUser_e.cgu.accept)=False:C215)
					End if 
					
					If ($cguDisplay_b=True:C214) & ($LDAPConnection_b=False:C215)
						$position_t:="center"
						outilsCreateWindowsForm("FormCGU"; ->$position_t)
						
						If (OK=1)
							
							If ($structureUser_e.cgu=Null:C1517)
								$structureUser_e.cgu:=New object:C1471()
							End if 
							
							OB SET:C1220($structureUser_e.cgu; "accept"; True:C214)
							OB SET:C1220($structureUser_e.cgu; "log"; New object:C1471("date"; Current date:C33; "heure"; String:C10(Current time:C178); "login"; [INtervenants:10]IN_Login:3))
							
							$statut_o:=$structureUser_e.save()
						Else 
							QUIT 4D:C291
							$0:=False:C215
						End if 
						
					End if 
					
				Else 
					ALERT:C41("Votre utilisateur n'est relié à aucune structure, ID intervenant : "+String:C10([INtervenants:10]ID:16)+", Structure : "+[INtervenants:10]Ref_Structure:17)
					
					QUIT 4D:C291
					$0:=False:C215
				End if 
				
				If (<>vb_T_MPMasquePlus)  // 06/04/2011
					
					If ($0=True:C214)
						QUERY:C277([INtervenants:10]; [INtervenants:10]IN_RéférenceID:1=<>vl_UserRéfU)
						
						//MultiSoc_Filter (->[INtervenants])
						$vb_OK:=(Add to date:C393([INtervenants:10]IN_DateDeModifDuMP:15; 0; 0; <>vl_T_MPJoursValide)<Current date:C33(*))
						
						If ($vb_OK)  //Le mot de passe n'est plus valide
							
							If (i_Confirmer("-> Date de validité du mot de passe"+<>va_CR+<>va_CR+"          Vous devez modifier votre mot de passe."+<>va_CR+<>va_CR+"Confirmez-vous ?"))
								Go_uMotPasseChanger
								
								If (OK=0)
									P_LesLogs(<>va_Log_Sortie; "")
									QUIT 4D:C291
									
									$0:=False:C215
								End if 
								
							Else 
								P_LesLogs(<>va_Log_Sortie; "")
								QUIT 4D:C291
								
								$0:=False:C215
							End if 
							
						End if 
						
					End if 
					
				End if 
				
			: ($ii>1)  // Plusieurs  enregistrements trouvés     
				ALERT:C41("Plusieurs utilisateurs référencés par le même login."+Char:C90(13)+Char:C90(13)+"Veuillez consulter le service informatique.")
				P_LesLogs(<>va_Log_Sortie; "")
				
				QUIT 4D:C291
				$0:=False:C215
		End case 
		
		// La liste des utilisateurs référencés
		ARRAY LONGINT:C221(tl_UserNo; 0)
		ARRAY TEXT:C222(ta_UserLog; 0)
End case 

If (Storage:C1525.intervenantsDetail=Null:C1517)
	Use (Storage:C1525)
		Storage:C1525.intervenantsDetail:=New shared object:C1526
	End use 
	Use (Storage:C1525.intervenantsDetail)
		Storage:C1525.intervenantsDetail.ProfUser:=<>va_ProfUser
		Storage:C1525.intervenantsDetail.User:=<>va_User
		Storage:C1525.intervenantsDetail.UserCourant:=<>va_UserCourant
		Storage:C1525.intervenantsDetail.UserRéfU:=<>vl_UserRéfU
		Storage:C1525.intervenantsDetail.UserLogRéfU:=<>vl_UserLogRéfU
		Storage:C1525.intervenantsDetail.UserLOFT:=<>vb_UserLOFT
		Storage:C1525.intervenantsDetail.UserPointage:=<>vb_UserPointage
		
		Storage:C1525.intervenantsDetail.UserMessagerie:=<>vb_UserMessagerie
		Storage:C1525.intervenantsDetail.UserPlateforme:=<>va_UserPlateforme
		
		Storage:C1525.intervenantsDetail.Privileges:=New shared collection:C1527()
	End use 
	
	Use (Storage:C1525.intervenantsDetail.Privileges)
		Storage:C1525.intervenantsDetail.Privileges:=ds:C1482.Privilege.all().toCollection("nom").copy(ck shared:K85:29; Storage:C1525.intervenantsDetail.Privileges)
	End use 
End if 