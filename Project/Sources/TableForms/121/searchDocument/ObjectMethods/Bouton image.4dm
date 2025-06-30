Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_OBJECT:C1216($table_o; $info_o)
		
		If (Form:C1466.elementSelection#Null:C1517)
			CONFIRM:C162("Supprimer "+String:C10(Form:C1466.elementSelection.length)+" document(s) ? (cette action est irréversible)"; "Supprimer"; "Annuler")
			
			If (OK=1)
				outilsOrdaSearchSimple("DOCWPRO"; "nom"; Form:C1466.elementSelection[0].nom; ->$table_o)
				
				$table_o.drop()
			End if 
			
			outilsWProChargerDocument("enCours"; False:C215; ->$info_o)
			Form:C1466.DOCWPRO:=$info_o.DOCWPRO
		End if 
		
		Form:C1466.nomDocument:=""
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 