If ((qNoLien+qChef+qNonChef+qOrientation+qDossier+qBasculeCf+qBasculeNonCf)>0)
	
	If (i_Confirmer("Appliquer les critères ?"))
		CREATE SET:C116([HeberGement:5]; "E_LDF_Selection")
		
		//•1 Renuméroter      
		If (qNoLien=1)
			P_LienDeFamilleCritere("Renuméroter")
		End if 
		
		//•2 ChefDefamille      
		If (qChef=1)
			P_LienDeFamilleCritere("ChefDefamille")
		End if 
		
		//•2bis NonChefDefamille      
		If (qNonChef=1)
			P_LienDeFamilleCritere("NonCheffamille")
		End if 
		
		
		//•3 Orientation      
		If (qOrientation=1)
			P_LienDeFamilleCritere("Orientation")
		End if 
		
		//•4 Dossier      
		If (qDossier=1)
			P_LienDeFamilleCritere("Dossier")
		End if 
		
		
		//•5 Basculer en chef de famille      
		If (qBasculeCf=1)
			P_LienDeFamilleCritere("BasculeChef")
		End if 
		
		//•6 Basculer en non chef de famille      
		If (qBasculeNonCf=1)
			P_LienDeFamilleCritere("BasculeNonChef")
		End if 
		
		
		USE SET:C118("E_LDF_Selection")
		
		CLEAR SET:C117("E_LDF_Selection")
		
		P_HébergementVeilleSort(2)
		
	End if 
	
Else 
	ALERT:C41("Aucun critère sélectionné .")
End if 