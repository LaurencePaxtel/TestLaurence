var $pos_el : Integer

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (String:C10(Form:C1466.typeNoteSelected)#"")
			$pos_el:=Find in array:C230(typeNote_at; String:C10(Form:C1466.typeNoteSelected))
			
			typeNote_at:=$pos_el
			typeNote_at{typeNote_at}:=typeNote_at{$pos_el}
			
			OBJECT SET ENABLED:C1123(*; "Popup Liste déroulante"; False:C215)
			OBJECT SET TITLE:C194(*; "Texte"; "Modification de la note du "+String:C10(Form:C1466.date)+" de l'hébergé « "+[HeBerge:4]HB_Prénom:4+" "+[HeBerge:4]HB_Nom:3+" »")
		Else 
			OBJECT SET VISIBLE:C603(*; "Texte2"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Variable1"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Ligne1"; False:C215)
			
			OBJECT SET TITLE:C194(*; "Texte"; "Ajout d'une note pour l'hébergé « "+[HeBerge:4]HB_Prénom:4+" "+[HeBerge:4]HB_Nom:3+" »")
		End if 
		
End case 