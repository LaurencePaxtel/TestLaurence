If (Size of array:C274(ta_SIAO_PopModFam)>0)
	If (ta_SIAO_PopModFam>0)
		If (ta_SIAO_PopModFam=1)
			ALERT:C41("Vous pouvez modifier la clé ou supprimer de la liste une personne.")
		Else 
			If (ta_SP_Nom>0)
				Case of 
					: (ta_SIAO_PopModFam=3)
						P_SIAO_PEModCle(ta_SP_Nom)
					: (ta_SIAO_PopModFam=5)
						P_SIAO_PEsup(ta_SP_Nom)
				End case 
			Else 
				ALERT:C41("Vous devez sélectionner une personne dans la liste.")
			End if 
		End if 
	End if 
	
	ta_SIAO_PopModFam:=1
End if 

