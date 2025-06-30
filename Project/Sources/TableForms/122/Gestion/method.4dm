C_TEXT:C284($reference_t; $titre_t; $produit_t)
C_LONGINT:C283($nbResultat_el; $i_el; $j_el; $pageDebut_el; $nbLigne_el)
C_BOOLEAN:C305($selectLine_b)
C_OBJECT:C1216($produit_o; $table_o)
C_COLLECTION:C1488($collection_c; $autreCollection_c; $autreCollectionBis_c)

$collection_c:=New collection:C1472
$autreCollection_c:=New collection:C1472

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		Form:C1466.entitySelection:=ds:C1482.StockBis.newSelection()
		Form:C1466.entitySelectionDisplay:=Form:C1466.entitySelection.copy()
		
		Form:C1466.entitySelectionInit:=Form:C1466.entitySelection.copy()
		
		Form:C1466.goToPage:="1"
		
		Form:C1466.from:=0
		Form:C1466.to:=10
		
		Form:C1466.pageMinimum:=1
		Form:C1466.pageMaximum:=1
		
		// Permet de ne pas déclencher la commande Sur appel extérieur pour les deux inputs de Date
		Form:C1466.appelExterieur:=True:C214
		Form:C1466.reinitialisation:=True:C214
		
		POST OUTSIDE CALL:C329(Current process:C322)
	: (Form event code:C388=Sur appel extérieur:K2:11)
		
		If (Bool:C1537(Form:C1466.reinitialisation)=True:C214)
			$table_o:=ds:C1482.StockBis.all()
			outilsOrdaSearchByRefStctre(->$table_o; structure_at{structure_at})
			
			Form:C1466.entitySelectionInit:=$table_o.orderBy("date asc, produit asc")
			
			$autreCollectionBis_c:=$table_o.toCollection().extract("produit").distinct()
			$autreCollectionBis_c.unshift("Tous")
			
			CLEAR VARIABLE:C89(produit_at)
			COLLECTION TO ARRAY:C1562($autreCollectionBis_c; produit_at)
			
			produit_at{0}:="Choix du produit"
			produit_at:=1
			
			selectResult_at:=1
			
			ta_PlageEnCours:=1
			ve_Date_Cas:=0
			
			dateDu_d:=Current date:C33
			dateAu_d:=Current date:C33
			
			// Permet de ne pas déclencher la commande Sur appel extérieur pour les deux inputs de Date
			Form:C1466.appelExterieur:=True:C214
		End if 
		
		If (produit_at{produit_at}#"")
			
			If (produit_at{produit_at}#"Tous")
				Form:C1466.entitySelection:=Form:C1466.entitySelectionInit.query("produit = :1"; produit_at{produit_at}).orderBy("date asc")
			Else 
				Form:C1466.entitySelection:=Form:C1466.entitySelectionInit.copy()
			End if 
			
		End if 
		
		If (Bool:C1537(Form:C1466.changeProduit)=True:C214) | (Bool:C1537(Form:C1466.changeReference)=True:C214)
			dateDu_d:=Current date:C33
			dateAu_d:=Current date:C33
			
			// Permet de ne pas déclencher la commande Sur appel extérieur pour les deux inputs de Date
			Form:C1466.appelExterieur:=True:C214
		End if 
		
		If (Bool:C1537(Form:C1466.changeDate)=True:C214)
			$selectLine_b:=(Form:C1466.elementCourant#Null:C1517)
			
			If ($selectLine_b=True:C214)
				$produit_t:=Form:C1466.elementCourant.produit
				$nbLigne_el:=LISTBOX Get number of rows:C915(*; "List Box")
				
				For ($j_el; 1; $nbLigne_el)
					LISTBOX SELECT ROW:C912(*; "List Box"; $j_el; lk supprimer de sélection:K53:3)
				End for 
				
			End if 
			
		End if 
		
		If (dateDu_d#!00-00-00!)
			Form:C1466.entitySelection:=Form:C1466.entitySelection.query("date >= :1"; dateDu_d)
		End if 
		
		If (dateAu_d#!00-00-00!)
			Form:C1466.entitySelection:=Form:C1466.entitySelection.query("date <= :1"; dateAu_d)
		End if 
		
		If (Form:C1466.buttonNavigation#Null:C1517)  // Clic sur l'un des boutons de pagination [précédent] OU [1,2,3 ...] OU [suivant]
			
			Case of 
				: (Num:C11(Form:C1466.buttonNavigation)>0)  // Clic sur l'un des boutons de pagination [1,2,3 ...]
					Form:C1466.goToPage:=String:C10(Num:C11(OBJECT Get title:C1068(*; Form:C1466.buttonNavigation)))
				: (String:C10(Form:C1466.buttonNavigation)="buttonNavigationPrevious")  // Clic sur le bouton de pagination [précédent]
					Form:C1466.goToPage:=String:C10(Num:C11(Form:C1466.goToPage)-1)
				: (String:C10(Form:C1466.buttonNavigation)="buttonNavigationNext")  // Clic sur le bouton de pagination [suivant]
					Form:C1466.goToPage:=String:C10(Num:C11(Form:C1466.goToPage)+1)
			End case 
			
			OB REMOVE:C1226(Form:C1466; "buttonNavigation")
		End if 
		
		$nbResultat_el:=Num:C11(selectResult_at{selectResult_at})
		
		If ($nbResultat_el=0)
			Form:C1466.from:=0
			Form:C1466.to:=Form:C1466.entitySelection.length
		Else 
			Form:C1466.from:=((Num:C11(Form:C1466.goToPage)-1)*$nbResultat_el)
			Form:C1466.to:=Form:C1466.from+$nbResultat_el
		End if 
		
		Form:C1466.pageMinimum:=1
		
		If ($nbResultat_el>0)
			Form:C1466.pageMaximum:=Round:C94(Form:C1466.entitySelection.length/$nbResultat_el; 0)
		Else 
			Form:C1466.pageMaximum:=1
		End if 
		
		Form:C1466.entitySelectionDisplay:=Form:C1466.entitySelection.orderBy("date asc").slice(Form:C1466.from; Form:C1466.to).orderBy("date asc")
		
		If (Bool:C1537(Form:C1466.changeProduit)=True:C214)
			reference_at:=0
		End if 
		
		If (reference_at{reference_at}#"") & (reference_at{reference_at}#"Tous") & (reference_at{reference_at}#"Choix de référence produit")
			$table_o:=ds:C1482.StockBis.newSelection()
			
			For each ($produit_o; Form:C1466.entitySelectionDisplay.configuration)
				$autreCollectionBis_c:=$produit_o.detail.extract("reference"; "reference")
				
				If ($autreCollectionBis_c.query("reference = :1"; reference_at{reference_at}).length>0)
					$table_o.add(Form:C1466.entitySelectionDisplay[$i_el])
				End if 
				
				$i_el:=$i_el+1
			End for each 
			
			Form:C1466.entitySelectionDisplay:=$table_o.orderBy("date asc")
		End if 
		
		If (Bool:C1537(Form:C1466.changeProduit)=True:C214) | (Bool:C1537(Form:C1466.changeStructure)=True:C214) | (Bool:C1537(Form:C1466.reinitialisation)=True:C214) | (Bool:C1537(Form:C1466.changeDate)=True:C214)
			CLEAR VARIABLE:C89($i_el)
			
			outilsProgressBar(0; "Initialisation"; True:C214)
			
			For each ($produit_o; Form:C1466.entitySelectionDisplay.configuration)
				outilsProgressBar($i_el/Form:C1466.entitySelectionDisplay.configuration.length; "Extraction des références produit en cours..."; True:C214)
				
				$autreCollection_c:=New collection:C1472
				$autreCollection_c.combine($produit_o.detail.extract("reference"))
				
				For each ($reference_t; $autreCollection_c)
					$autreCollectionBis_c:=$collection_c.query("reference = :1"; $reference_t)
					
					If ($autreCollectionBis_c.length=0)
						$collection_c.push(New object:C1471("reference"; $reference_t))
					End if 
					
				End for each 
				
				$i_el:=$i_el+1
			End for each 
			
			outilsProgressBar(1; "arrêt")
			
			$collection_c:=$collection_c.extract("reference")
			$collection_c.unshift("Tous")
			
			If (Bool:C1537(Form:C1466.changeReference)=False:C215)
				CLEAR VARIABLE:C89(reference_at)
				COLLECTION TO ARRAY:C1562($collection_c; reference_at)
				
				reference_at{0}:="Choix de référence produit"
				reference_at:=0
			End if 
			
			OBJECT SET ENABLED:C1123(*; "Popup Liste déroulante3"; True:C214)
			
			If ($selectLine_b=True:C214)
				$autreCollection_c:=Form:C1466.entitySelectionDisplay.toCollection().indices("produit = :1"; $produit_t)
				
				If ($autreCollection_c.length>0)
					LISTBOX SELECT ROW:C912(*; "List Box"; $autreCollection_c[0]+1; lk ajouter à sélection:K53:2)
				End if 
				
			End if 
			
			OB REMOVE:C1226(Form:C1466; "changeDate")
			OB REMOVE:C1226(Form:C1466; "changeProduit")
			OB REMOVE:C1226(Form:C1466; "changeStructure")
			
			OB REMOVE:C1226(Form:C1466; "reinitialisation")
		End if 
		
		If (Bool:C1537(Form:C1466.changeReference)=True:C214)
			OB REMOVE:C1226(Form:C1466; "changeReference")
		End if 
		
		$pageDebut_el:=Num:C11(Form:C1466.goToPage)
		
		For ($i_el; 1; 4)
			
			If ($i_el=1)  // Il faut déterminer quelle est la première page de la série de 4 page par rapport à la page souhaitée de l'utilisateur
				
				Repeat 
					
					If (Mod:C98($pageDebut_el; 4)=1)
						OBJECT SET TITLE:C194(*; "buttonNavigation"+String:C10($i_el); String:C10($pageDebut_el))
					End if 
					
					$pageDebut_el:=$pageDebut_el-1
				Until (Mod:C98($pageDebut_el; 4)=0)
				
			Else 
				OBJECT SET TITLE:C194(*; "buttonNavigation"+String:C10($i_el); String:C10($pageDebut_el+$i_el))
			End if 
			
		End for 
		
		For ($i_el; 1; 4)
			$titre_t:=OBJECT Get title:C1068(*; "buttonNavigation"+String:C10($i_el))
			
			OBJECT SET FONT STYLE:C166(*; "buttonNavigation"+String:C10($i_el); Normal:K14:1)
			OBJECT SET ENABLED:C1123(*; "buttonNavigation"+String:C10($i_el); True:C214)
			
			If ($titre_t=Form:C1466.goToPage)
				OBJECT SET FONT STYLE:C166(*; "buttonNavigation"+String:C10($i_el); Gras:K14:2)
				OBJECT SET ENABLED:C1123(*; "buttonNavigation"+String:C10($i_el); False:C215)
			End if 
			
			If (Num:C11($titre_t)>Form:C1466.pageMaximum)
				OBJECT SET ENABLED:C1123(*; "buttonNavigation"+String:C10($i_el); False:C215)
			End if 
			
		End for 
		
		OBJECT SET ENABLED:C1123(*; "buttonNavigationPrevious"; True:C214)
		OBJECT SET ENABLED:C1123(*; "buttonNavigationNext"; True:C214)
		
		If (Num:C11(Form:C1466.goToPage)=Form:C1466.pageMinimum)
			OBJECT SET ENABLED:C1123(*; "buttonNavigationPrevious"; False:C215)
		End if 
		
		If (Num:C11(Form:C1466.goToPage)=Form:C1466.pageMaximum)
			OBJECT SET ENABLED:C1123(*; "buttonNavigationNext"; False:C215)
		End if 
		
		If ($nbResultat_el>0) & (Form:C1466.entitySelectionDisplay.length<$nbResultat_el)
			OBJECT SET ENABLED:C1123(*; "buttonNavigationNext"; False:C215)
		End if 
		
End case 