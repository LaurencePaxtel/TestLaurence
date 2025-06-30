Case of 
	: (Form event code:C388=Sur clic:K2:4)
	: (Form event code:C388=Sur affichage corps:K2:22)
		vl_NbHGi:=0  // #20180130-1
		vl_NbHGib:=0  // #20180130-1
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (22/12/2021)
		//FIXER DESTINATION RECHERCHE(Vers variable;vl_NbHGi)
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
		MultiSoc_Filter(->[HeberGement:5])
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (22/12/2021)
		//FIXER DESTINATION RECHERCHE(Vers variable;vl_NbHGib)
		//FIXER DESTINATION RECHERCHE(Vers sélection courante)
		
		If ([HeBerge:4]HB_ReferenceID:1#0)
			
			Case of 
				: (va_QuelDossier="MR")
					QUERY:C277([Maraude:24]; [Maraude:24]MR_HB_ID:10=[HeBerge:4]HB_ReferenceID:1)
				: (va_QuelDossier="DS")
					QUERY:C277([DossierSocial:25]; [DossierSocial:25]DS_HB_ID:10=[HeBerge:4]HB_ReferenceID:1)
				: (va_QuelDossier="Di")
					QUERY:C277([DossierInfirmie:27]; [DossierInfirmie:27]DI_HB_ID:10=[HeBerge:4]HB_ReferenceID:1)
				: (va_QuelDossier="Dy")
					QUERY:C277([DossierPsycho:28]; [DossierPsycho:28]DY_HB_ID:10=[HeBerge:4]HB_ReferenceID:1)
				: (va_QuelDossier="DM")
					QUERY:C277([DossierMedical:29]; [DossierMedical:29]DM_HB_ID:10=[HeBerge:4]HB_ReferenceID:1)
				: (va_QuelDossier="DE")
					
					// Modifié par : Scanu Rémy (22/12/2021)
					If (Value type:C1509(hebergeSelectID_el)#Est une variable indéfinie:K8:13) && (hebergeSelectID_el#0)
						
						If (hebergeSelectID_el>0) & ([HeBerge:4]ID:65=hebergeSelectID_el)
							QUERY:C277([DossierSante:33]; [DossierSante:33]DE_HB_ID:10=[HeBerge:4]HB_ReferenceID:1)
						End if 
						
					Else 
						QUERY:C277([DossierSante:33]; [DossierSante:33]DE_HB_ID:10=[HeBerge:4]HB_ReferenceID:1)
					End if 
					
			End case 
			
			ve_NbSP:=Num:C11([HeBerge:4]HB_Status:18)
		End if 
		
End case 