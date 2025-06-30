//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 26/01/22, 11:43:42
// ----------------------------------------------------
// Méthode : outilsStockGetFullDay
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($0)
C_OBJECT:C1216($1)  // EntitySelection de la table [StockBis]
C_DATE:C307($2)  // Date à partir de laquelle on cherche pendant combien de temps la référence de produit est bloquée
C_TEXT:C284($3)  // Produit
C_TEXT:C284($4)  // Référence produit
C_LONGINT:C283($5)  // [HeberGement]HG_HB_ID

C_BOOLEAN:C305($stop_b)
C_OBJECT:C1216($table_o; $produit_o)
C_COLLECTION:C1488($collection_c)

Repeat 
	$table_o:=$1.query("date = :1 AND produit = :2"; $2+$0; $3)
	$stop_b:=True:C214
	
	If ($table_o.length=1)  // Le produit est bien dans le stock pour $2+$0
		$produit_o:=$table_o[0]
		$produit_o.reload()
		
		// On vérifie que pour les jours suivants la référence produit est bien disponible également
		$collection_c:=$produit_o.configuration.detail.query("reference = :1"; $4)
		
		If ($collection_c.length=1)
			
			If ($collection_c[0].quantite=0)  // La date est dépourvue en quantité restante suffisante, ça veux dire que cette référence produit a déjà été affecté à quelqu'un, reste à savoir qui... :D
				$stop_b:=(Num:C11($collection_c[0].hebergeID)#$5)
			End if 
			
		End if 
		
	End if 
	
	If ($stop_b=False:C215)
		$0:=$0+1
	End if 
	
Until ($stop_b=True:C214)