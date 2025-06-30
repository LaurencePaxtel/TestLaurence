If (Size of array:C274(tt_TransDocu)>0)
	If (tt_TransDocu>0)
		If (te_TransDocuCas{tt_TransDocu}=0)
			<>va_Trans_CleAccept:=va_DocuCle
			<>va_Trans_Nom:=va_DocuNom
			<>va_Trans_Prenom:=va_DocuPrenom
			<>vd_Trans_Nele:=Date:C102(va_DocuNele)
			<>va_Trans_EtCv:=va_DocuEtCv
			<>vt_Trans_DocuT:=vt_DocuT
			
			<>vd_Trans_FicheDate:=vd_DocuDateFiche
			<>vd_Trans_FicheDateJour:=Current date:C33
			<>vt_Trans_Infos:=""
			<>vd_Trans_FicheDateDu:=!00-00-00!
			<>vd_Trans_FicheDateAu:=!00-00-00!
			
			<>vl_Trans_HébergéRéf:=0
			<>vl_Trans_CentreRéf:=0
			<>vl_Trans_HébergementRéf:=0
			<>va_Trans_CentreNom:=""
			<>va_Trans_CentrePlateforme:=""
			<>ve_Trans_NuitTotal:=0
			<>va_Trans_Groupe:=""
			<>va_Trans_CleFam:=va_DocuCleFam
			<>vb_Trans_ChefFam:=vb_DocuChefFam
			
			
			<>vb_Trans_HébergéYaDéja:=False:C215
			<>vb_Trans_FicheYaDéja:=False:C215
			
			<>va_Trans_Plateforme:=<>va_UserPlateforme
			
			If (<>ve_Trans_NuitTotal<=0)
				<>ve_Trans_NuitTotal:=1
			End if 
			
			If (<>vb_T_ModeCHRS)
				If (Length:C16(<>va_UserPlateforme)>3)
					<>va_Trans_CentrePlateforme:=Substring:C12(<>va_UserPlateforme; 1; 4)
				Else 
					<>va_Trans_CentrePlateforme:=<>va_UserPlateforme
				End if 
			End if 
			
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=va_DocuCle)
			MultiSoc_Filter(->[HeBerge:4])
			If (Records in selection:C76([HeBerge:4])=1)
				<>vb_Trans_HébergéYaDéja:=True:C214
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1; *)
				QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Date:4>=Current date:C33)
				MultiSoc_Filter(->[HeberGement:5])
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215)
				<>vb_Trans_FicheYaDéja:=(Records in selection:C76([HeberGement:5])>=1)
			End if 
			
			<>vd_Trans_LastReportDate:=F_ReportLast
			If (<>vd_Trans_LastReportDate<Current date:C33)
				<>vt_Trans_Infos:="ATTENTION"+<>va_CR+"Veuillez vérifier que le report a été fait !"
			Else 
				If (<>vb_Trans_FicheYaDéja)
					<>vt_Trans_Infos:="ATTENTION"+<>va_CR+"Ce demandeur a déjà des hébergements pour les dates supérieures ou égales au "+String:C10(Current date:C33; Système date long:K1:3)
				End if 
			End if 
			
			OBJECT SET VISIBLE:C603(*; "PlateF_@"; (Character code:C91(<>va_Trans_Plateforme)=64))
			
			FORM GOTO PAGE:C247(2)
			//    INACTIVER BOUTON(b_OK)
		Else 
			
			
			vt_DocuDécode:=""
			va_DocuIndice:=""
			va_DocuTitre:=""
			va_DocuEtCv:=""
			va_DocuDateFiche:=""
			vd_DocuDateFiche:=!00-00-00!
			va_DocuNo:=""
			va_DocuCle:=""
			va_DocuNom:=""
			va_DocuPrenom:=""
			va_DocuNele:=""
			va_DocuOrient1:=""
			va_DocuAge:=""
			va_DocuNC:=""
			va_DocuNT:=""
			va_DocuCleFam:=""
			vb_DocuChefFam:=False:C215
			va_DocuE:=""
			vt_DocuT:=""
			ve_DocuStatut:=0
			va_DocuStatut:=""
			
			<>va_Trans_CleAccept:=""
			<>va_Trans_Nom:=""
			<>va_Trans_Prenom:=""
			<>vd_Trans_Nele:=!00-00-00!
			<>va_Trans_EtCv:=""
			<>vt_Trans_DocuT:=""
			
			<>vd_Trans_FicheDate:=!00-00-00!
			
			<>vt_Trans_Infos:=""
			<>vd_Trans_FicheDateDu:=!00-00-00!
			<>vd_Trans_FicheDateAu:=!00-00-00!
			
			<>vl_Trans_HébergéRéf:=0
			<>vl_Trans_CentreRéf:=0
			<>vl_Trans_HébergementRéf:=0
			<>va_Trans_CentreNom:=""
			<>va_Trans_CentrePlateforme:=""
			<>ve_Trans_NuitTotal:=0
			<>va_Trans_Groupe:=""
			<>va_Trans_CleFam:=""
			<>vb_Trans_ChefFam:=False:C215
			
			<>vb_Trans_HébergéYaDéja:=False:C215
			<>vb_Trans_FicheYaDéja:=False:C215
			BEEP:C151
		End if 
	End if 
End if 