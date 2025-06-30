//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_SIAO_PEModCle
//{          Lundi 7 février 2010 à 10:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)



If (User in group:C338(Current user:C182; <>Groupe_SIAOModCle) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	vb_Valider:=False:C215
	If (tl_SP_Personne_ID{$1}>0)
		vl_HGUU:=tl_SP_Personne_ID{$1}
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_HGUU)
		MultiSoc_Filter(->[HeBerge:4])
		If (Records in selection:C76([HeBerge:4])=1)
			va_HGUU:=[HeBerge:4]HB_Nom:3
			va_CléClé:=[HeBerge:4]HB_Clé:2
			
			vl_IDT_RéfU:=[HeBerge:4]HB_ReferenceID:1
			va_IDT_Old:=[HeBerge:4]HB_Clé:2
			va_IDT_Nom:=[HeBerge:4]HB_Nom:3
			va_IDT_Pré:=[HeBerge:4]HB_Prénom:4
			vd_IDT_NéLe:=[HeBerge:4]HB_DateNéLe:5
			vl_IDT_Stat:=Num:C11([HeBerge:4]HB_Status:18=True:C214)
			$vl_Fenetre:=i_FenêtreNo(352; 362; 5; "Modifier la clé"; 3; "Quit_Simple")
			DIALOG:C40([DiaLogues:3]; "DL_HébergéCléModifierSIAO")
			CLOSE WINDOW:C154($vl_Fenetre)
			If (vb_Valider)
				If (ta_SP_SousTheme{$1}=ta_SIAO_PopSitFamCode{3})
					[SIAO:50]Si_Demandeur:20:=va_IDT_Clé
				End if 
				
				//****les dossiers [SIAO_Personnes]         
				READ WRITE:C146([SIAO_Personnes:51])
				QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Personne_ID:3=vl_IDT_RéfU)
				MultiSoc_Filter(->[SIAO_Personnes:51])
				If (Records in selection:C76([SIAO_Personnes:51])>0)
					APPLY TO SELECTION:C70([SIAO_Personnes:51]; P_Clé_SIAOp2_App)
				End if 
				UNLOAD RECORD:C212([SIAO_Personnes:51])
				READ ONLY:C145([SIAO_Personnes:51])
				ta_SP_Nom{$1}:=va_IDT_Nom
				ta_SP_Prenom{$1}:=va_IDT_Pré
				td_SP_NeLeDate{$1}:=vd_IDT_NéLe
				va_SP_Nom:=ta_SP_Nom{$1}
				va_SP_Prenom:=ta_SP_Prenom{$1}
				vd_SP_NeLeDate:=td_SP_NeLeDate{$1}
			End if 
		Else 
			va_HGUU:=""
			va_CléClé:=[SIAO:50]Si_Demandeur:20
			ALERT:C41("Cette personne : "+va_CléClé+" n'est plus référencée !"+<>va_CR+"Contactez le service informatique.")
		End if 
		
	End if 
Else 
	StrAlerte(6; "'Modifier clé")
End if 