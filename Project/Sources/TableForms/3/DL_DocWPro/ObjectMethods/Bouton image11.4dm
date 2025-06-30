var $nomDocument_t : Text
var $docWritePro_es : cs:C1710.DOCWPROSelection

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		Case of 
			: (Records in selection:C76([DOCWPRO:121])=1) & ([DOCWPRO:121]nom:3#"NOUVEAU DOCUMENT")
				$nomDocument_t:=Request:C163("Nouveau nom du document..."; [DOCWPRO:121]nom:3; "Renommer"; "Annuler")
				
				If ($nomDocument_t#"")
					outilsOrdaSearchSimple("DOCWPRO"; "nom"; $nomDocument_t; ->$docWritePro_es)
					outilsOrdaSearchByRefStctre(->$docWritePro_es; <>ref_soc_active; "structureRef")
					
					If ($docWritePro_es.length=0)
						[DOCWPRO:121]nom:3:=$nomDocument_t
						SET WINDOW TITLE:C213("Modification de la lettre "+[DOCWPRO:121]nom:3)
					Else 
						ALERT:C41("Le nom du fichier est déjà utilisé par un autre document, merci d'en saisir un autre")
					End if 
					
				Else 
					ALERT:C41("Merci de saisir un nom de document non-vide")
				End if 
				
			Else 
				ALERT:C41("Aucun document n'est pré-chargé")
		End case 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 