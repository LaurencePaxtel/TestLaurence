C_TEXT:C284($choix_t)
C_LONGINT:C283($pos_el; $colonne_el; $ligne_el)
C_COLLECTION:C1488($collection_c)

If (Form event code:C388=Sur données modifiées:K2:15)
	
	If (Bool:C1537(Form:C1466.multiSelected)=False:C215)
		$pos_el:=-1
		
		LISTBOX GET CELL POSITION:C971(*; "LB"; $colonne_el; $ligne_el)
		$collection_c:=Form:C1466.t_TabNiv1.indices("checked = :1"; True:C214)
		
		Case of 
			: ($collection_c.length=1)
				$pos_el:=$collection_c[0]
			: ($collection_c.length=2)
				$pos_el:=$ligne_el-1
		End case 
		
		$collection_c:=Form:C1466.t_TabNiv1.copy()
		outilsApplyToCollection(->$collection_c; False:C215; "checked")
		
		Form:C1466.t_TabNiv1:=$collection_c.copy()
		
		If ($pos_el#-1)
			Form:C1466.t_TabNiv1[$pos_el].checked:=True:C214
			
			$choix_t:=Form:C1466.t_TabNiv1[$pos_el].choix
			
			// Modifié par : Scanu Rémy - remy@connect-io.fr (07/05/2021)
			
			// Il y a un filtre en place
			//Si (Form.filtre#"")
			$collection_c:=Form:C1466.t_TabNiv1Init.copy()
			outilsApplyToCollection(->$collection_c; False:C215; "checked")
			
			Form:C1466.t_TabNiv1Init:=$collection_c.copy()
			
			Form:C1466.t_TabNiv1Init.query("choix = :1"; $choix_t)[0].checked:=True:C214
			//Fin de si
			
		End if 
		
	End if 
	
End if 