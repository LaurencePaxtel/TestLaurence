Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT SET ENTERABLE:C238(*; "montantSaisie"; False:C215)
	: (Form event code:C388=Sur clic:K2:4)
		OB REMOVE:C1226(Form:C1466; "montant")
		
		If (Form:C1466.refCourant#Null:C1517)
			Form:C1466.montant:=Num:C11(Form:C1466.refCourant.montant)
		End if 
		
		OBJECT SET ENTERABLE:C238(*; "montantSaisie"; (Form:C1466.refCourant#Null:C1517))
		
		If (Form:C1466.refCourant#Null:C1517)
			HIGHLIGHT TEXT:C210(*; "montantSaisie"; 0; 100)
		End if 
		
End case 