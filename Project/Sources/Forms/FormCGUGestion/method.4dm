var $i_el : Integer
var $intervenant_o : Object

var $structure_e : cs:C1710.StructuresEntity
var $structureUser_es : cs:C1710.Structure_UserSelection
var $structureUser_e : cs:C1710.Structure_UserEntity
var $intervenant_es; $autreIntervenant_es : cs:C1710.INtervenantsSelection

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		Form:C1466.intervenants:=New collection:C1472
		Form:C1466.notification_cs:=cuToolGetClass("Notification").new()
		
		POST OUTSIDE CALL:C329(Current process:C322)
	: (Form event code:C388=Sur appel extérieur:K2:11)
		$intervenant_es:=ds:C1482.INtervenants.all()
		
		If (String:C10(Form:C1466.login)#"")
			$intervenant_es:=$intervenant_es.query("IN_Login = :1"; "@"+Form:C1466.login+"@")
		End if 
		
		If (structure_at{structure_at}#"") & (structure_at{structure_at}#"Tous") & (structure_at{structure_at}#"Sélectionner une structure")
			outilsOrdaSearchSimple("Structures"; "STRC_Nom"; structure_at{structure_at}; ->$structure_e; "first")
			$structureUser_es:=$structure_e.AllStructure_User
			
			$autreIntervenant_es:=outilsOrdaSearch($structureUser_es; "UID_Utilisateur"; "INtervenants"; "ID")
			$intervenant_es:=$intervenant_es.and($autreIntervenant_es)
		End if 
		
		Form:C1466.intervenants:=$intervenant_es.toCollection().orderBy("IN_Login asc")
		
		For each ($intervenant_o; Form:C1466.intervenants)
			$i_el:=Form:C1466.intervenants.indexOf($intervenant_o)
			outilsOrdaSearchSimple("Structure_User"; "UID_Utilisateur"; $intervenant_o.ID; ->$structureUser_e; "first")
			
			If ($structureUser_e#Null:C1517)
				$structureUser_e.reload()
				
				If ($structureUser_e.cgu=Null:C1517)
					$structureUser_e.cgu:=New object:C1471
					
					$structureUser_e.cgu.accept:=False:C215
					$structureUser_e.cgu.log:=New object:C1471("date"; !00-00-00!; "heure"; ""; "login"; $intervenant_o.IN_Login)
					
					$structureUser_e.save()
				End if 
				
				$intervenant_o:=outilsObjectMerge($intervenant_o; $structureUser_e.toObject())
				Form:C1466.intervenants[$i_el]:=OB Copy:C1225($intervenant_o)
			Else 
				$intervenant_o.cgu:=New object:C1471("accept"; False:C215; "log"; New object:C1471("date"; !00-00-00!; "heure"; ""; "login"; $intervenant_o.IN_Login))
			End if 
			
		End for each 
		
End case 