If (Records in table:C83([HeberGement:5])>0)
	CONFIRM:C162("Il y a "+String:C10(Records in table:C83([HeberGement:5]))+" fiches d'hébergement."+Char:C90(13)+"Confirmez-vous la suppression ?")
	If (OK=1)
		i_Message("Suppression en cours …")
		READ WRITE:C146([HeBerge:4])
		READ WRITE:C146([HeberGement:5])
		READ WRITE:C146([FicheMedicaleOl:6])
		READ WRITE:C146([LeMedical:7])
		READ WRITE:C146([LeSignaletique:8])
		READ WRITE:C146([HebergementLie:15])
		READ WRITE:C146([CentresLits:16])
		
		
		READ WRITE:C146([GrouPe:36])
		READ WRITE:C146([GroupeHeberges:37])
		
		ALL RECORDS:C47([HeBerge:4])
		MultiSoc_Filter(->[HeBerge:4])
		DELETE SELECTION:C66([HeBerge:4])
		
		ALL RECORDS:C47([HeberGement:5])
		MultiSoc_Filter(->[HeberGement:5])
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Facture:172=False:C215)
		DELETE SELECTION:C66([HeberGement:5])
		
		ALL RECORDS:C47([FicheMedicaleOl:6])
		MultiSoc_Filter(->[FicheMedicaleOl:6])
		DELETE SELECTION:C66([FicheMedicaleOl:6])
		
		ALL RECORDS:C47([LeMedical:7])
		MultiSoc_Filter(->[LeMedical:7])
		DELETE SELECTION:C66([LeMedical:7])
		
		ALL RECORDS:C47([LeSignaletique:8])
		MultiSoc_Filter(->[LeSignaletique:8])
		DELETE SELECTION:C66([LeSignaletique:8])
		
		ALL RECORDS:C47([HebergementLie:15])
		MultiSoc_Filter(->[HebergementLie:15])
		DELETE SELECTION:C66([HebergementLie:15])
		
		ALL RECORDS:C47([GroupeHeberges:37])
		MultiSoc_Filter(->[GroupeHeberges:37])
		DELETE SELECTION:C66([GroupeHeberges:37])
		
		ALL RECORDS:C47([GrouPe:36])
		MultiSoc_Filter(->[GrouPe:36])
		DELETE SELECTION:C66([GrouPe:36])
		
		
		ALL RECORDS:C47([CentresLits:16])
		MultiSoc_Filter(->[CentresLits:16])
		APPLY TO SELECTION:C70([CentresLits:16]; [CentresLits:16]CL_Distribué:6:=0)
		APPLY TO SELECTION:C70([CentresLits:16]; [CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_DispoTotal:5)
		
		READ ONLY:C145([HeberGement:5])
		READ ONLY:C145([FicheMedicaleOl:6])
		READ ONLY:C145([LeMedical:7])
		READ ONLY:C145([LeSignaletique:8])
		READ ONLY:C145([HebergementLie:15])
		READ ONLY:C145([HeBerge:4])
		READ ONLY:C145([CentresLits:16])
		READ WRITE:C146([GrouPe:36])
		READ WRITE:C146([GroupeHeberges:37])
		
		
		CLOSE WINDOW:C154
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_Param:3=True:C214)
		MultiSoc_Filter(->[DePart:1])
		[DePart:1]DP_NumHeberg:4:=0
		SAVE RECORD:C53([DePart:1])
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
	End if 
End if 