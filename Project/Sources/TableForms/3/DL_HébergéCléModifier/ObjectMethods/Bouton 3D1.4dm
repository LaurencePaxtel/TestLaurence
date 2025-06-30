C_LONGINT:C283($vl_NbFiches)

If (Form event code:C388=Sur clic:K2:4)
	
	Case of 
		: (va_IDT_Nom<="")
			StrAlerte(31; "")
			
			REJECT:C38
		: (va_IDT_Pré="")
			StrAlerte(32; "")
			
			REJECT:C38
		: (vd_IDT_NéLe=!00-00-00!)
			StrAlerte(33; "")
			
			REJECT:C38
		Else 
			va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
			
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=va_IDT_Clé)
			MultiSoc_Filter(->[HeBerge:4])
			
			$vl_NbFiches:=Records in selection:C76([HeBerge:4])
			
			Case of 
				: ($vl_NbFiches>1)
					StrAlerte(11; va_IDT_Clé)
					
					REJECT:C38
				: ($vl_NbFiches=1) & ([HeBerge:4]HB_ReferenceID:1=vl_IDT_RéfU)
					StrAlerte(12; va_IDT_Clé)
					
					REJECT:C38
				: ($vl_NbFiches=1) & ([HeBerge:4]HB_ReferenceID:1#vl_IDT_RéfU)
					StrAlerte(11; va_IDT_Clé)
				: ($vl_NbFiches=0)
					READ WRITE:C146([HeBerge:4])
					
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_IDT_RéfU)
					MultiSoc_Filter(->[HeBerge:4])
					
					If (Records in selection:C76([HeBerge:4])=1)
						
						If (i_NonVerrou(->[HeBerge:4]))
							vb_Valider:=True:C214
							
							[HeBerge:4]HB_Clé:2:=va_IDT_Clé
							[HeBerge:4]HB_Nom:3:=va_IDT_Nom
							[HeBerge:4]HB_Prénom:4:=va_IDT_Pré
							[HeBerge:4]HB_DateNéLe:5:=vd_IDT_NéLe
							
							SAVE RECORD:C53([HeBerge:4])
							UNLOAD RECORD:C212([HeBerge:4])
							
							//****les hébergements
							READ WRITE:C146([HeberGement:5])
							
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_IDT_RéfU)
							MultiSoc_Filter(->[HeberGement:5])
							
							If (Records in selection:C76([HeberGement:5])>0)
								APPLY TO SELECTION:C70([HeberGement:5]; P_Clé_HG_App)
							End if 
							
							UNLOAD RECORD:C212([HeberGement:5])
							READ ONLY:C145([HeberGement:5])
							
							//****la maraude
							READ WRITE:C146([Maraude:24])
							
							QUERY:C277([Maraude:24]; [Maraude:24]MR_HB_ID:10=vl_IDT_RéfU)
							MultiSoc_Filter(->[Maraude:24])
							
							If (Records in selection:C76([Maraude:24])>0)
								APPLY TO SELECTION:C70([Maraude:24]; P_Clé_MR_App)
							End if 
							
							UNLOAD RECORD:C212([Maraude:24])
							READ ONLY:C145([Maraude:24])
							
							//****les dossiers sociaux
							READ WRITE:C146([DossierSocial:25])
							
							QUERY:C277([DossierSocial:25]; [DossierSocial:25]DS_HB_ID:10=vl_IDT_RéfU)
							MultiSoc_Filter(->[DossierSocial:25])
							
							If (Records in selection:C76([DossierSocial:25])>0)
								APPLY TO SELECTION:C70([DossierSocial:25]; P_Clé_DS_App)
							End if 
							
							UNLOAD RECORD:C212([DossierSocial:25])
							READ ONLY:C145([DossierSocial:25])
							
							//****les dossiers Infirmiers         
							READ WRITE:C146([DossierInfirmie:27])
							
							QUERY:C277([DossierInfirmie:27]; [DossierInfirmie:27]DI_HB_ID:10=vl_IDT_RéfU)
							MultiSoc_Filter(->[DossierInfirmie:27])
							
							If (Records in selection:C76([DossierInfirmie:27])>0)
								APPLY TO SELECTION:C70([DossierInfirmie:27]; P_Clé_DI_App)
							End if 
							
							UNLOAD RECORD:C212([DossierInfirmie:27])
							READ ONLY:C145([DossierInfirmie:27])
							
							//****les dossiers Psycho         
							READ WRITE:C146([DossierPsycho:28])
							
							QUERY:C277([DossierPsycho:28]; [DossierPsycho:28]DY_HB_ID:10=vl_IDT_RéfU)
							MultiSoc_Filter(->[DossierPsycho:28])
							
							If (Records in selection:C76([DossierPsycho:28])>0)
								APPLY TO SELECTION:C70([DossierPsycho:28]; P_Clé_DY_App)
							End if 
							
							UNLOAD RECORD:C212([DossierPsycho:28])
							READ ONLY:C145([DossierPsycho:28])
							
							//****les dossiers Médical         
							READ WRITE:C146([DossierMedical:29])
							
							QUERY:C277([DossierMedical:29]; [DossierMedical:29]DM_HB_ID:10=vl_IDT_RéfU)
							MultiSoc_Filter(->[DossierMedical:29])
							
							If (Records in selection:C76([DossierMedical:29])>0)
								APPLY TO SELECTION:C70([DossierMedical:29]; P_Clé_DM_App)
							End if 
							
							UNLOAD RECORD:C212([DossierMedical:29])
							READ ONLY:C145([DossierMedical:29])
							
							//****les dossiers SIAO         
							READ WRITE:C146([SIAO:50])
							
							QUERY:C277([SIAO:50]; [SIAO:50]Si_Demandeur_ID:21=vl_IDT_RéfU)
							MultiSoc_Filter(->[SIAO:50])
							
							If (Records in selection:C76([SIAO:50])>0)
								APPLY TO SELECTION:C70([SIAO:50]; P_Clé_SIAO_App)
							End if 
							
							UNLOAD RECORD:C212([SIAO:50])
							READ ONLY:C145([SIAO:50])
							
							//****les dossiers [SIAO_Personnes]         
							READ WRITE:C146([SIAO_Personnes:51])
							
							QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Personne_ID:3=vl_IDT_RéfU)
							MultiSoc_Filter(->[SIAO_Personnes:51])
							
							If (Records in selection:C76([SIAO_Personnes:51])>0)
								APPLY TO SELECTION:C70([SIAO_Personnes:51]; P_Clé_SIAOp_App)
							End if 
							
							UNLOAD RECORD:C212([SIAO_Personnes:51])
							READ ONLY:C145([SIAO_Personnes:51])
						Else 
							UNLOAD RECORD:C212([HeBerge:4])
						End if 
						
					End if 
					
					READ WRITE:C146([HeBerge:4])
			End case 
			
	End case 
	
End if 