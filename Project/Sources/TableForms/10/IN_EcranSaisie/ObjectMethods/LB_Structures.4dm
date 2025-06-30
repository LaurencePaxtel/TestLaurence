// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 27/08/18, 02:37:56
// ----------------------------------------------------
// Méthode : [INtervenants].IN_EcranSaisie.LB2
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $a; $menu; $menu2 : Text
var $colonne; $ligne : Integer

var $structure_e : cs:C1710.StructuresEntity
var $structure_es : cs:C1710.StructuresSelection

var $structureUser_e : cs:C1710.Structure_UserEntity
var $structureUser_es : cs:C1710.Structure_UserSelection

var ref_soc_active : Text
ARRAY TEXT:C222($temp; 0)

ref_soc_active:="PAX"

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		QUERY:C277([Structures:79]; [Structure_User:80]UID_Utilisateur:2=[INtervenants:10]ID:16)
	: (Form event code:C388=Sur clic:K2:4)
		LISTBOX GET CELL POSITION:C971(*; "LB_Structures"; $colonne; $ligne)
		
		If (Contextual click:C713)
			$menu2:=Create menu:C408
			
			// Modifié par : Scanu Rémy (20/12/2023)
			// On autorise seulement l'accès à la structure de la personne connectée sauf pour l'utilisateur apaxtel
			If (Current user:C182="apaxtel")
				ALL RECORDS:C47([Structures:79])
			Else 
				QUERY:C277([Structures:79]; [Structures:79]Ref_Structure:3=<>ref_soc_active)
			End if 
			
			ORDER BY:C49([Structures:79]; [Structures:79]STRC_Nom:4; >)
			
			COPY NAMED SELECTION:C331([Structures:79]; "sel2")
			
			For ($i; 1; Records in selection:C76([Structures:79]))
				APPEND MENU ITEM:C411($menu2; [Structures:79]STRC_Nom:4)
				
				SET MENU ITEM PARAMETER:C1004($menu2; -1; [Structures:79]UID:1)
				NEXT RECORD:C51([Structures:79])
			End for 
			
			$menu:=Create menu:C408
			APPEND MENU ITEM:C411($menu; "Ajouter une structure"; $menu2)
			
			APPEND MENU ITEM:C411($menu; "(-")
			APPEND MENU ITEM:C411($menu; "Retirer cette structure")
			SET MENU ITEM PARAMETER:C1004($menu; -1; "retrait")
			
			$a:=Dynamic pop up menu:C1006($menu)
			
			Case of 
				: ($a="retrait")
					QUERY:C277([Structures:79]; [Structure_User:80]UID_Utilisateur:2=[INtervenants:10]ID:16)
					GOTO SELECTED RECORD:C245([Structures:79]; $ligne+1)
					
					READ WRITE:C146([Structure_User:80])
					
					QUERY:C277([Structure_User:80]; [Structure_User:80]UID_Structure:1=[Structures:79]UID:1; *)
					QUERY:C277([Structure_User:80];  & ; [Structure_User:80]UID_Utilisateur:2=[INtervenants:10]ID:16)
					DELETE RECORD:C58([Structure_User:80])
					
					READ ONLY:C145([Structure_User:80])
				: ($a#"")
					QUERY:C277([Structure_User:80]; [Structure_User:80]UID_Structure:1=$a; *)
					QUERY:C277([Structure_User:80];  & ; [Structure_User:80]UID_Utilisateur:2=[INtervenants:10]ID:16)
					
					If (Records in selection:C76([Structure_User:80])=0)
						outilsOrdaSearchSimple(->[Structures:79]; ->[Structures:79]UID:1; $a; ->$structure_e; "first")
						
						If ($structure_e#Null:C1517)
							$structureUser_e:=ds:C1482.Structure_User.searchAndCreateRecordIfDontExist($structure_e.UID; [INtervenants:10]ID:16; $structure_e.Ref_Structure)
						End if 
						
					End if 
					
			End case 
			
			CLEAR NAMED SELECTION:C333("sel2")
			
			QUERY:C277([Structure_User:80]; [Structure_User:80]UID_Utilisateur:2=[INtervenants:10]ID:16)
			SELECTION TO ARRAY:C260([Structure_User:80]UID_Structure:1; $temp)
			
			QUERY WITH ARRAY:C644([Structures:79]UID:1; $temp)
			ORDER BY:C49([Structures:79]; [Structures:79]STRC_Nom:4; >)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "cgu@"; False:C215)
		
		If ($ligne>0)
			$structure_es:=Create entity selection:C1512([Structures:79])
			$structure_e:=$structure_es[$ligne-1]
			
			$structureUser_es:=ds:C1482.Structure_User.query("UID_Structure = :1 AND UID_Utilisateur = :2"; $structure_e.UID; [INtervenants:10]ID:16)
			
			If ($structureUser_es.length=1)
				$structureUser_e:=$structureUser_es.first()
				
				Form:C1466.cguAccept:=False:C215
				Form:C1466.cguLog:="CGU pas encore accepté"
				
				If ($structureUser_e.cgu#Null:C1517)
					Form:C1466.cguAccept:=Bool:C1537($structureUser_e.cgu.accept)
					
					If (Form:C1466.cguAccept=True:C214)
						Form:C1466.cguLog:="CGU accepté le "+String:C10($structureUser_e.cgu.log.date)+" à "+String:C10($structureUser_e.cgu.log.heure)
					End if 
					
				End if 
				
				OBJECT SET VISIBLE:C603(*; "cgu@"; True:C214)
			End if 
			
		End if 
		
End case 