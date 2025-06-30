var $structureUser_e : cs:C1710.Structure_UserEntity
var $intervenants_e : cs:C1710.INtervenantsEntity

If (Form:C1466.lineCurrent#Null:C1517)
	outilsOrdaSearchSimple("INtervenants"; "ID"; Form:C1466.lineCurrent.ID; ->$intervenants_e; "first")
	
	If ($intervenants_e#Null:C1517)
		outilsOrdaSearchSimple("Structure_User"; "UID_Utilisateur"; $intervenants_e.ID; ->$structureUser_e; "first")
		
		If ($structureUser_e#Null:C1517)
			$structureUser_e.cgu.accept:=Form:C1466.lineCurrent.cgu.accept
			$structureUser_e.cgu.log:=New object:C1471("date"; !00-00-00!; "heure"; ?00:00:00?; "login"; $intervenant_o.IN_Login)
			$structureUser_e.save()
			
			POST OUTSIDE CALL:C329(Current process:C322)
			Form:C1466.notification_cs.popUp("information"; "Mise à jour effectuée"; "")
		Else 
			Form:C1466.lineCurrent.cgu.accept:=False:C215
			Form:C1466.notification_cs.popUp("warning"; "Mise à jour impossible"; "L'utilisateur n'a pas pu être trouvé dans la base de donnée.")
		End if 
		
	End if 
	
Else 
	Form:C1466.notification_cs.popUp("warning"; "Mise à jour impossible"; "Sélectionner une ligne dans le tableau.")
End if 