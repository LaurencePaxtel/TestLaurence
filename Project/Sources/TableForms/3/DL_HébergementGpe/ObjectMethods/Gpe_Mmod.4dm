//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_GPMod
//{
//{          Vendredi 27 février 2004 à 11:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($vb_OK)

If (Form event code:C388=Sur clic:K2:4)
	
	If (Size of array:C274(<>te_GpCheck)>0)
		
		If (<>ta_GpClé>0)
			READ WRITE:C146([GroupeHeberges:37])
			QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_ReferenceID:1=<>tl_GpRéfi{<>ta_GpClé})
			
			If (Records in selection:C76([GroupeHeberges:37])=1)
				
				If (i_NonVerrou(->[GroupeHeberges:37]))
					va_IDT_TypTrans:=<>ta_GpEtCv{<>ta_GpClé}
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=<>tl_GpHBID{<>ta_GpClé})
					
					If (Records in selection:C76([HeBerge:4])=1)
						$vb_OK:=F_HébergementEtatCivilAge([HeBerge:4]HB_DateNéLe:5; Current date:C33)
					End if 
					
					Repeat 
						Tab_PopIn1o("Type"; -><>ta_TBEtCiv; ->va_IDT_Typ1)
						
						If ((<>vb_EtatCivilAge) & ($vb_OK))
							$vb_OK:=F_HébergementEtatCivil(va_IDT_Typ1; ve_HébergéAge)
						Else 
							$vb_OK:=True:C214
						End if 
						
					Until ($vb_OK)
					
					va_IDT_TypTrans:=""
					
					If (va_IDT_Typ1>"")
						[GroupeHeberges:37]GH_EtatCivil:5:=va_IDT_Typ1
						
						<>ta_GpEtCv{<>ta_GpClé}:=[GroupeHeberges:37]GH_EtatCivil:5
						va_IDT_Typ1:=""
						
						SAVE RECORD:C53([GroupeHeberges:37])
					End if 
					
					UNLOAD RECORD:C212([GroupeHeberges:37])
				End if 
				
			End if 
			
			READ ONLY:C145([GroupeHeberges:37])
		Else 
			ALERT:C41("Veuillez sélectionner un membre !")
		End if 
		
	Else 
		ALERT:C41("Aucun membre présent !")
	End if 
	
End if 