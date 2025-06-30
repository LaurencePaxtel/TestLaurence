
C_LONGINT:C283($i_el)
C_OBJECT:C1216($table_o; $enregistrement_o; $produit_o; $refProduit_o)
C_COLLECTION:C1488($collection_c)

$collection_c:=New collection:C1472

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		Form:C1466.entitySelectionInit:=ds:C1482.StockBis.newSelection()
		
		outilsOrdaSearchSimple("SOciete"; "Ref_Structure"; <>ref_soc_active; ->$enregistrement_o; "first")
		
		If ($enregistrement_o#Null:C1517)
			
			If ($enregistrement_o.SO_StockHeberge#Null:C1517)
				$collection_c:=$enregistrement_o.SO_StockHeberge.param.query("check = :1"; True:C214)
				
				If ($collection_c.length>0)
					$table_o:=ds:C1482.StockBis.all()
					outilsOrdaSearchByRefStctre(->$table_o; <>ref_soc_active)
					
					Form:C1466.entitySelectionInit:=$table_o.query("produit in :1 AND date >= :2 AND date <= :3"; $collection_c.extract("produit"); [HeberGement:5]HG_Date:4; [HeberGement:5]HG_RéservationDateFin:134).orderBy("date asc, produit asc")
				End if 
				
			End if 
			
		End if 
		
		date_d:=[HeberGement:5]HG_Date:4
		
		// Permet de ne pas déclencher la commande Sur appel extérieur pour l'input de Date
		Form:C1466.appelExterieur:=True:C214
		
		POST OUTSIDE CALL:C329(Current process:C322)
	: (Form event code:C388=Sur appel extérieur:K2:11)
		Form:C1466.reference:=New collection:C1472
		Form:C1466.entitySelection:=Form:C1466.entitySelectionInit.copy()
		
		If (date_d#!00-00-00!)
			Form:C1466.entitySelection:=Form:C1466.entitySelectionInit.query("date = :1"; date_d)
		End if 
		
		If (Bool:C1537(Form:C1466.changeProduit)=False:C215)
			$collection_c:=Form:C1466.entitySelection.toCollection().extract("produit").distinct()
			$collection_c.unshift("Tous")
			
			CLEAR VARIABLE:C89(produit_at)
			COLLECTION TO ARRAY:C1562($collection_c; produit_at)
			
			produit_at{0}:="Choix du produit"
			produit_at:=1
		End if 
		
		If (Bool:C1537(Form:C1466.changeProduit)=True:C214)
			
			If (produit_at{produit_at}#"") & (produit_at{produit_at}#"Tous")
				Form:C1466.entitySelection:=Form:C1466.entitySelection.query("produit = :1"; produit_at{produit_at}).orderBy("date asc")
			End if 
			
		End if 
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($produit_o; Form:C1466.entitySelection)
			outilsProgressBar($i_el/Form:C1466.entitySelection.configuration.length; "Extraction des références produit en cours..."; True:C214)
			
			For each ($refProduit_o; $produit_o.configuration.detail)
				
				Form:C1466.reference.push(New object:C1471("reference"; $refProduit_o.reference; \
					"quantite"; $refProduit_o.quantite; \
					"produit"; $produit_o.produit; \
					"hebergeID"; Num:C11($refProduit_o.hebergeID)))
				
			End for each 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
		
		If (Bool:C1537(Form:C1466.changeProduit)=True:C214)
			OB REMOVE:C1226(Form:C1466; "changeProduit")
		End if 
		
End case 