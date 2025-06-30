//SCripte b_NumFno
$vb_OK:=False:C215
If (ve_DtMoisFno>0) & (ve_DtMoisFno<13)
	If (ve_DtAnnéeFno>1999) & (ve_DtAnnéeFno<2050)
		vd_DtDébFno:=Date:C102("1/"+String:C10(ve_DtMoisFno)+"/"+String:C10(ve_DtAnnéeFno))
		If (ve_DtMoisFno<12)
			vd_DtFinFno:=Date:C102("1/"+String:C10(ve_DtMoisFno+1)+"/"+String:C10(ve_DtAnnéeFno))-1
		Else 
			vd_DtFinFno:=Date:C102("31/12/"+String:C10(ve_DtAnnéeFno))
		End if 
		$vb_OK:=True:C214
	End if 
End if 

If ($vb_OK)
	CONFIRM:C162("Confirmez vous la renumérotation du n° de fiche des hébergements  ?")
	If (OK=1)
		MESSAGES ON:C181
		READ WRITE:C146([HeberGement:5])
		READ WRITE:C146([HebergementLie:15])
		
		// Modified by: Kevin HASSAL (06/05/2020)
		// Correction du bug de numérotation
		
		//--------------------------------------------------------------------------------------------/
		// Initialisation du compteur de numérotation
		//--------------------------------------------------------------------------------------------/
		Use (Storage:C1525.numerotation)
			Storage:C1525.numerotation.vaCPT_115:="HG"+Substring:C12(String:C10(ve_DtAnnéeFno; "0000"); 3; 2)+String:C10(ve_DtMoisFno; "00")
		End use 
		READ WRITE:C146([ReferenceUnique:2])
		
		QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Storage:C1525.numerotation.vaCPT_115)
		MultiSoc_Filter(->[ReferenceUnique:2]; False:C215)
		
		If (Records in selection:C76([ReferenceUnique:2])>0)
			DELETE SELECTION:C66([ReferenceUnique:2])
		End if 
		
		UNLOAD RECORD:C212([ReferenceUnique:2])
		READ ONLY:C145([ReferenceUnique:2])
		
		//--------------------------------------------------------------------------------------------/
		// Re-numérotation des fiches
		//--------------------------------------------------------------------------------------------/
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_DtDébFno; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_DtFinFno)
		MultiSoc_Filter(->[HeberGement:5])
		
		If (Records in selection:C76([HeberGement:5])>0)
			
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; >)
			vl_ii:=0
			
			APPLY TO SELECTION:C70([HeberGement:5]; wUut_MàjFnoHébergement2)
			
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_DtDébFno; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_DtFinFno)
			MultiSoc_Filter(->[HeberGement:5])
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; >)
			
			APPLY TO SELECTION:C70([HeberGement:5]; wUut_MàjFnoHébergement)
			
		Else 
			ALERT:C41("Aucune fiche trouvée !")
		End if 
		
		UNLOAD RECORD:C212([HeberGement:5])
		UNLOAD RECORD:C212([HebergementLie:15])
		READ ONLY:C145([HeberGement:5])
		READ ONLY:C145([HebergementLie:15])
		MESSAGES OFF:C175
		BEEP:C151
		BEEP:C151
	End if 
Else 
	ALERT:C41("Veuillez vérifier vos date !")
End if 