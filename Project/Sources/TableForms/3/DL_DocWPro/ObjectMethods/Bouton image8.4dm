var $lib_t; $position_t : Text
var $collection_c : Collection

var $docWritePro_es : cs:C1710.DOCWPROSelection

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Records in selection:C76([DOCWPRO:121])=1) & ([DOCWPRO:121]nom:3#"NOUVEAU DOCUMENT")
			$docWritePro_es:=ds:C1482.DOCWPRO.all()
			$collection_c:=ds:C1482.DOCWPRO.getUniqueTags($docWritePro_es)
			
			$collection_c.unshift(New object:C1471("tag"; "Créer un nouveau tag"))
			
			$position_t:="center"
			outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; $collection_c; "property"; "tag"; "selectSubTitle"; "Merci de sélectionner un tag"; \
				"title"; "Choix d'un tag :"))
			
			If (selectValue_t#"")
				$lib_t:=selectValue_t
				
				If ($lib_t="Créer un nouveau tag")
					$lib_t:=Request:C163("Libellé du tag ?"; ""; "Ajouter"; "Annuler")
				End if 
				
			End if 
			
			If (Form:C1466.tag=Null:C1517)
				Form:C1466.tag:=New collection:C1472
			End if 
			
			Case of 
				: (Form:C1466.tag.query("lib = :1"; $lib_t).length>0)
					ALERT:C41("Impossible de rajouter ce tag, il existe déjà")
				: ($lib_t#"")
					Form:C1466.tag.push(New object:C1471("lib"; $lib_t))
					[DOCWPRO:121]tag:5:=JSON Stringify:C1217(Form:C1466.tag.extract("lib"))
			End case 
			
		Else 
			ALERT:C41("Merci d'ouvrir un document avant de pouvoir ajouter un tag")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 