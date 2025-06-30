If (Form:C1466.refSelection.length=1)  // Une seule référence produit sélectionnée
	
	If (Form:C1466.refSelection[0].quantiteMax#Form:C1466.oldQuantiteMax)
		OBJECT SET TITLE:C194(*; "Texte9"; "L'édition de la quantité maximale peut faire varier la quantité restante. De ce fait son édition est impossible. Pour pouvoir l'éditer veuillez remettre la valeur initiale « "\
			+String:C10(Form:C1466.oldQuantiteMax)+" » dans le champ « Quantité maximale »")
		
		Form:C1466.refSelection[0].quantite:=Form:C1466.oldQuantite
		
		OBJECT SET RGB COLORS:C628(*; "Variable4"; "#CCCCCC")
		OBJECT SET FONT STYLE:C166(*; "Variable4"; Gras:K14:2)
		OBJECT SET RGB COLORS:C628(*; "Variable5"; "#CCCCCC")
		OBJECT SET FONT STYLE:C166(*; "Variable5"; Gras:K14:2)
		OBJECT SET RGB COLORS:C628(*; "Variable6"; "#CCCCCC")
		OBJECT SET FONT STYLE:C166(*; "Variable6"; Gras:K14:2)
	Else 
		OBJECT SET TITLE:C194(*; "Texte9"; "L'édition de la quantité restante n'est possible que si une seule référence est sélectionnée")
		
		OBJECT SET RGB COLORS:C628(*; "Variable4"; "#000000")
		OBJECT SET FONT STYLE:C166(*; "Variable4"; Normal:K14:1)
		OBJECT SET RGB COLORS:C628(*; "Variable5"; "#000000")
		OBJECT SET FONT STYLE:C166(*; "Variable5"; Normal:K14:1)
		OBJECT SET RGB COLORS:C628(*; "Variable6"; "#000000")
		OBJECT SET FONT STYLE:C166(*; "Variable6"; Normal:K14:1)
	End if 
	
	OBJECT SET VISIBLE:C603(*; "Texte9"; (Form:C1466.refSelection[0].quantiteMax#Form:C1466.oldQuantiteMax))
	
	OBJECT SET ENTERABLE:C238(*; "Variable4"; (Form:C1466.refSelection[0].quantiteMax=Form:C1466.oldQuantiteMax))
	OBJECT SET ENTERABLE:C238(*; "Variable5"; (Form:C1466.refSelection[0].quantiteMax=Form:C1466.oldQuantiteMax))
	OBJECT SET ENTERABLE:C238(*; "Variable6"; (Form:C1466.refSelection[0].quantiteMax=Form:C1466.oldQuantiteMax))
End if 