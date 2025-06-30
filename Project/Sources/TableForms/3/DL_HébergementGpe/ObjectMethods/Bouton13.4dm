var $proprieteToKeep_c : Collection

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CONFIRM:C162("Voulez-vous importer un fichier de note (excel, csv) ?"; "Oui"; "Non")
		
		If (OK=1)
			$proprieteToKeep_c:=New collection:C1472
			
			outilsManageNote(99; ->$proprieteToKeep_c; <>ref_soc_active; Current user:C182)
			outilsManageNote(3; $proprieteToKeep_c)
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 