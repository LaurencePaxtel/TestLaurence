var $libelle_t : Text
var $extra_c : Collection

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$libelle_t:=Request:C163("Libellé à ajouter ?"; ""; "Valider"; "Annuler")
		
		If ($libelle_t#"")
			$extra_c:=Form:C1466.detail.query("libelle = :1"; $libelle_t)
			
			If ($extra_c.length=0)
				Form:C1466.detail.push(New object:C1471("libelle"; $libelle_t; "montant"; 0))
			Else 
				ALERT:C41("Ajout impossible, cet extra est déjà présent dans la liste")
			End if 
			
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 