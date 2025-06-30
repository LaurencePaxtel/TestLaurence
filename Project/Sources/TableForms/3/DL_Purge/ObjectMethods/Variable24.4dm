If (vd_DtDébL>!00-00-00!)
	i_Message("Recherche en cours …")
	
	If (vd_DtFinL<=vd_DtDébL)
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=vd_DtDébL)
	End if 
	
	If (vd_DtFinL>vd_DtDébL)
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3>=vd_DtDébL; *)
		QUERY:C277([CentresLits:16];  & [CentresLits:16]CL_Date:3<=vd_DtFinL)
	End if 
	
	MultiSoc_Filter(->[CentresLits:16])
	CLOSE WINDOW:C154
	
	If (Records in selection:C76([CentresLits:16])>0)
		CONFIRM:C162("Il y a "+String:C10(Records in selection:C76([CentresLits:16]))+" fiches."+Char:C90(13)+"Confirmez-vous la suppression ?")
		
		If (OK=1)
			i_Message("Suppression en cours …")
			READ WRITE:C146([CentresLits:16])
			
			DELETE SELECTION:C66([CentresLits:16])
			READ ONLY:C145([CentresLits:16])
			CLOSE WINDOW:C154
		End if 
		
	Else 
		ALERT:C41("Aucune fiche trouvée !")
	End if 
	
Else 
	ALERT:C41("Vous devez saisir une date !")
End if 