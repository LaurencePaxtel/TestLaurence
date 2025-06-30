If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Reconstruction des clés hébergées à partir de Tables : "+<>va_CR+"HéberGement, Maraude"+<>va_CR+"et les dossiers  Social, Infirmier, Psycho, Médical, Santé"+<>va_CR+" date >= à : "+String:C10(<>vd_FusNote_Date)))
		C_TEXT:C284(va_PréfixNew)
		va_PréfixNew:=""
		MESSAGES ON:C181
		i_Message("Reconstruction des clés : HéberGement")
		
		If (<>vd_FusNote_Date=!00-00-00!)
			ALL RECORDS:C47([HeberGement:5])
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=<>vd_FusNote_Date)
		End if 
		MultiSoc_Filter(->[HeberGement:5])
		APPLY TO SELECTION:C70([HeberGement:5]; wUut_CléReconstruireHG)
		
		
		i_MessageSeul("Reconstruction des clés : Maraude")
		If (<>vd_FusNote_Date=!00-00-00!)
			ALL RECORDS:C47([Maraude:24])
		Else 
			QUERY:C277([Maraude:24]; [Maraude:24]MR_Date:4>=<>vd_FusNote_Date)
		End if 
		MultiSoc_Filter(->[Maraude:24])
		APPLY TO SELECTION:C70([Maraude:24]; wUut_CléReconstruireMR)
		
		
		i_MessageSeul("Reconstruction des clés : Dossier Social")
		If (<>vd_FusNote_Date=!00-00-00!)
			ALL RECORDS:C47([DossierSocial:25])
		Else 
			QUERY:C277([DossierSocial:25]; [DossierSocial:25]DS_Date:4>=<>vd_FusNote_Date)
		End if 
		MultiSoc_Filter(->[DossierSocial:25])
		APPLY TO SELECTION:C70([DossierSocial:25]; wUut_CléReconstruireDS)
		
		i_MessageSeul("Reconstruction des clés : Dossier Infirmier")
		If (<>vd_FusNote_Date=!00-00-00!)
			ALL RECORDS:C47([DossierInfirmie:27])
		Else 
			QUERY:C277([DossierInfirmie:27]; [DossierInfirmie:27]DI_Date:4>=<>vd_FusNote_Date)
		End if 
		MultiSoc_Filter(->[DossierInfirmie:27])
		APPLY TO SELECTION:C70([DossierInfirmie:27]; wUut_CléReconstruireDi)
		
		i_MessageSeul("Reconstruction des clés : Dossier Psycho")
		If (<>vd_FusNote_Date=!00-00-00!)
			ALL RECORDS:C47([DossierPsycho:28])
		Else 
			QUERY:C277([DossierPsycho:28]; [DossierPsycho:28]DY_Date:4>=<>vd_FusNote_Date)
		End if 
		MultiSoc_Filter(->[DossierPsycho:28])
		APPLY TO SELECTION:C70([DossierPsycho:28]; wUut_CléReconstruireDY)
		
		i_MessageSeul("Reconstruction des clés : Dossier Médical")
		If (<>vd_FusNote_Date=!00-00-00!)
			ALL RECORDS:C47([DossierMedical:29])
		Else 
			QUERY:C277([DossierMedical:29]; [DossierMedical:29]DM_Date:4>=<>vd_FusNote_Date)
		End if 
		MultiSoc_Filter(->[DossierMedical:29])
		APPLY TO SELECTION:C70([DossierMedical:29]; wUut_CléReconstruireDM)
		
		i_MessageSeul("Reconstruction des clés : Dossier Santé")
		If (<>vd_FusNote_Date=!00-00-00!)
			ALL RECORDS:C47([DossierSante:33])
		Else 
			QUERY:C277([DossierSante:33]; [DossierSante:33]DE_Date:4>=<>vd_FusNote_Date)
		End if 
		MultiSoc_Filter(->[DossierSante:33])
		APPLY TO SELECTION:C70([DossierSante:33]; wUut_CléReconstruireDE)
		CLOSE WINDOW:C154
		MESSAGES OFF:C175
	End if 
End if 
