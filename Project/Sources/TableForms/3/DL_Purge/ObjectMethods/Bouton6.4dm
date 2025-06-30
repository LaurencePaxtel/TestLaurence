//Script b_SHGDT

If (vd_DtDébR>!00-00-00!)
	i_Message("Recherche en cours …")
	If (vd_DtFinR<=vd_DtDébR)
		QUERY:C277([RenseiGnements:20]; [RenseiGnements:20]RG_Date:3=vd_DtDébR)
		MultiSoc_Filter(->[RenseiGnements:20])
	End if 
	If (vd_DtFinR>vd_DtDébR)
		QUERY:C277([RenseiGnements:20]; [RenseiGnements:20]RG_Date:3>=vd_DtDébR; *)
		QUERY:C277([RenseiGnements:20];  & [RenseiGnements:20]RG_Date:3<=vd_DtFinR)
		MultiSoc_Filter(->[RenseiGnements:20])
	End if 
	CLOSE WINDOW:C154
	If (Records in selection:C76([RenseiGnements:20])>0)
		CONFIRM:C162("Il y a "+String:C10(Records in selection:C76([RenseiGnements:20]))+" Prestations."+Char:C90(13)+"Confirmez-vous la suppression ?")
		If (OK=1)
			i_Message("Suppression en cours …")
			READ WRITE:C146([RenseiGnements:20])
			DELETE SELECTION:C66([RenseiGnements:20])
			READ ONLY:C145([RenseiGnements:20])
			CLOSE WINDOW:C154
		End if 
	Else 
		ALERT:C41("Aucune fiche trouvée !")
	End if 
Else 
	ALERT:C41("Vous devez saisir une date !")
End if 