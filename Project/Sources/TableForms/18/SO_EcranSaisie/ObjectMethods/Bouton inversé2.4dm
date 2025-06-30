C_TEXT:C284($base_documentaire_path)
C_LONGINT:C283($i_el)
C_COLLECTION:C1488($collection_c)

$collection_c:=New collection:C1472

If (Form event code:C388=Sur clic:K2:4)
	
	// Modifié par : Scanu Rémy (04/01/2022)
	If ([SOciete:18]SO_StockHeberge:131#Null:C1517)
		
		For ($i_el; 1; Size of array:C274(stockProduit_at))
			$collection_c:=[SOciete:18]SO_StockHeberge:131.param.query("produit = :1"; stockProduit_at{$i_el})
			
			If ($collection_c.length=1)
				$collection_c[0].check:=stockHeberge_ab{$i_el}
			End if 
			
		End for 
		
	End if 
	
	SAVE RECORD:C53([SOciete:18])
	DebutDécVar
	
	<>vb_FondCouleur:=True:C214
	POST OUTSIDE CALL:C329(<>PR_Genéral)
	
	SAVE RECORD:C53([Banques:91])
	
	//=============================//
	// GED
	// Modified by: Kevin HASSAL (10/09/2020)
	//=============================//
	
	$base_documentaire_path:=[SOciete:18]SO_Chemin_GED:96+"base_documentaire"+Séparateur dossier:K24:12
	
	If (Test path name:C476($base_documentaire_path)#0)
		CREATE FOLDER:C475($base_documentaire_path)
	End if 
	
	$base_documentaire_path:=$base_documentaire_path+<>ref_soc_active+Séparateur dossier:K24:12
	
	If (Test path name:C476($base_documentaire_path)#0)
		CREATE FOLDER:C475($base_documentaire_path)
	End if 
	
End if 