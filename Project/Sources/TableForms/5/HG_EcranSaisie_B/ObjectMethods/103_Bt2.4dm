

If (7=7)
	If ([HeberGement:5]HG_FamChef:103)
		//   Si (i_Confirmer ("Cette personne n'est plus le chef de famille."+◊va_CR+"Conf
		If (i_Confirmer("Vous déclarez que cette personne n'est plus le chef de famille."+<>va_CR+"Cliquez sur OK pour confirmer sinon Annuler !"))
			[HeberGement:5]HG_FamChef:103:=(x2=0)
			[HeberGement:5]HG_FamClé:104:=""
			P_HG_FamilleChef(0)
		Else 
			x1:=1
			x2:=0
		End if 
	End if 
	
	If (F_SIAO_Dossier("SIAODossierNonChef"))
	End if 
	
Else 
	//Ancienne méthode : jusqu'au 03/02/2010  
	[HeberGement:5]HG_FamChef:103:=(x2=0)
	P_HG_FamilleChef(0)
End if 



