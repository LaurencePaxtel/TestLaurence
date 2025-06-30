Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (Form:C1466.refSelection.length=1)
			Form:C1466.oldReference:=Form:C1466.refSelection[0].reference
			
			OBJECT SET TITLE:C194(*; "Texte"; "Édition de la référence produit « "+Form:C1466.oldReference+" »")
		Else 
			OBJECT SET TITLE:C194(*; "Texte"; "Édition des références produits appartenant au stock produit « "+Form:C1466.elementCourant.produit+" »")
			
			OBJECT SET RGB COLORS:C628(*; "Variable"; "#CCCCCC")
			OBJECT SET FONT STYLE:C166(*; "Variable"; Gras:K14:2)
			
			OBJECT SET RGB COLORS:C628(*; "Variable4"; "#CCCCCC")
			OBJECT SET FONT STYLE:C166(*; "Variable4"; Gras:K14:2)
			OBJECT SET RGB COLORS:C628(*; "Variable5"; "#CCCCCC")
			OBJECT SET FONT STYLE:C166(*; "Variable5"; Gras:K14:2)
			OBJECT SET RGB COLORS:C628(*; "Variable6"; "#CCCCCC")
			OBJECT SET FONT STYLE:C166(*; "Variable6"; Gras:K14:2)
		End if 
		
		OBJECT SET ENTERABLE:C238(*; "Variable"; (Form:C1466.refSelection.length=1))
		
		OBJECT SET ENTERABLE:C238(*; "Variable4"; (Form:C1466.refSelection.length=1))
		OBJECT SET ENTERABLE:C238(*; "Variable5"; (Form:C1466.refSelection.length=1))
		OBJECT SET ENTERABLE:C238(*; "Variable6"; (Form:C1466.refSelection.length=1))
		
		OBJECT SET VISIBLE:C603(*; "Texte2"; (Form:C1466.refSelection.length#1))
		OBJECT SET VISIBLE:C603(*; "Texte9"; (Form:C1466.refSelection.length#1))
		
		Form:C1466.oldQuantiteMax:=Form:C1466.refSelection[0].quantiteMax
		Form:C1466.oldQuantite:=Form:C1466.refSelection[0].quantite
		
		Form:C1466.quantiteMaxDateDu:=String:C10(Form:C1466.elementCourant.date)
		Form:C1466.quantiteMaxDateAu:=String:C10(Form:C1466.elementCourant.date)
		
		Form:C1466.quantiteDateDu:=String:C10(Form:C1466.elementCourant.date)
		Form:C1466.quantiteDateAu:=String:C10(Form:C1466.elementCourant.date)
End case 