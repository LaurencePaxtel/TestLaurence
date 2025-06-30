C_OBJECT:C1216($param_o)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(stockProduit_at; 0)
		ARRAY BOOLEAN:C223(stockHeberge_ab; 0)
		
		If ([SOciete:18]SO_StockHeberge:131#Null:C1517)
			
			For each ($param_o; [SOciete:18]SO_StockHeberge:131.param)
				APPEND TO ARRAY:C911(stockProduit_at; $param_o.produit)
				APPEND TO ARRAY:C911(stockHeberge_ab; $param_o.check)
			End for each 
			
		End if 
		
End case 