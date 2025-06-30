If (va_IDT_Typ1>"")
	
	If (Size of array:C274(tl_Fu_Référence)>0)
		CREATE SET:C116([HeBerge:4]; "E_HBliste")
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_IDT_Réf1)
		MultiSoc_Filter(->[HeBerge:4])
		
		If (Records in selection:C76([HeBerge:4])=1)
			va_FusNom:=[HeBerge:4]HB_Nom:3
			va_FusPré:=[HeBerge:4]HB_Prénom:4
			vd_FusNé:=[HeBerge:4]HB_DateNéLe:5
			vb_FusSex:=[HeBerge:4]HG_Genre:39
			
			vt_FusNote_Notes:=""
			vt_FusNote_Commentaire:=""
			vt_FusNote_Actions:=""
			vt_FusNote_Maraude:=""
			vt_FusNote_Social:=""
			vt_FusNote_Infirmier:=""
			vt_FusNote_Psycho:=""
			vt_FusNote_Médical:=""
			vt_FusNote_Santé:=""
			vt_FusNote_ActionsF:=""
			vt_FusNote_Notes2:=""
			
			If (i_Confirmer("Confirmez-vous la fusion de "+String:C10(Size of array:C274(tl_Fu_Référence))+\
				" clé(s) vers la clé maîtresse : "+va_IDT_Typ1+<>va_CR+("Avec fusion automatique des notes"*Num:C11(<>vb_FusNote_Notes=True:C214))+\
				("Sans fusion des notes"*Num:C11(<>vb_FusNote_Notes=False:C215))))
				i_Message("Fusion en cours...")
				
				READ WRITE:C146([HeBerge:4])
				READ WRITE:C146([HeberGement:5])
				READ WRITE:C146([Maraude:24])
				READ WRITE:C146([DossierSocial:25])
				READ WRITE:C146([DossierInfirmie:27])
				READ WRITE:C146([DossierPsycho:28])
				READ WRITE:C146([DossierMedical:29])
				READ WRITE:C146([DossierSante:33])
				READ WRITE:C146([Base_documentaire:90])
				
				For ($ii; 1; Size of array:C274(tl_Fu_Référence))
					QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=tl_Fu_Référence{$ii})
					MultiSoc_Filter(->[HeberGement:5])
					
					APPLY TO SELECTION:C70([HeberGement:5]; P_Fusion)
					UNLOAD RECORD:C212([HeberGement:5])
					
					//26/11/2004
					QUERY:C277([Maraude:24]; [Maraude:24]MR_HB_ID:10=tl_Fu_Référence{$ii})
					MultiSoc_Filter(->[Maraude:24])
					
					APPLY TO SELECTION:C70([Maraude:24]; P_FusionMaraude)
					UNLOAD RECORD:C212([Maraude:24])
					
					QUERY:C277([DossierSocial:25]; [DossierSocial:25]DS_HB_ID:10=tl_Fu_Référence{$ii})
					MultiSoc_Filter(->[DossierSocial:25])
					
					APPLY TO SELECTION:C70([DossierSocial:25]; P_FusionDS)
					UNLOAD RECORD:C212([DossierSocial:25])
					
					QUERY:C277([DossierInfirmie:27]; [DossierInfirmie:27]DI_HB_ID:10=tl_Fu_Référence{$ii})
					MultiSoc_Filter(->[DossierInfirmie:27])
					
					APPLY TO SELECTION:C70([DossierInfirmie:27]; P_FusionDi)
					UNLOAD RECORD:C212([DossierInfirmie:27])
					
					QUERY:C277([DossierPsycho:28]; [DossierPsycho:28]DY_HB_ID:10=tl_Fu_Référence{$ii})
					MultiSoc_Filter(->[DossierPsycho:28])
					
					APPLY TO SELECTION:C70([DossierPsycho:28]; P_FusionPsy)
					UNLOAD RECORD:C212([DossierPsycho:28])
					
					QUERY:C277([DossierMedical:29]; [DossierMedical:29]DM_HB_ID:10=tl_Fu_Référence{$ii})
					MultiSoc_Filter(->[DossierMedical:29])
					
					APPLY TO SELECTION:C70([DossierMedical:29]; P_FusionMed)
					UNLOAD RECORD:C212([DossierMedical:29])
					
					QUERY:C277([DossierSante:33]; [DossierSante:33]DE_HB_ID:10=tl_Fu_Référence{$ii})
					MultiSoc_Filter(->[DossierSante:33])
					
					APPLY TO SELECTION:C70([DossierSante:33]; P_FusionSté)
					UNLOAD RECORD:C212([DossierSante:33])
					
					// Modifié par : Scanu Rémy (19/07/2023)    
					QUERY:C277([Base_documentaire:90]; [Base_documentaire:90]DOC_Origine_ID:4=tl_Fu_Référence{$ii})
					MultiSoc_Filter(->[Base_documentaire:90])
					
					APPLY TO SELECTION:C70([Base_documentaire:90]; P_FusionBD(<>ref_soc_active; vl_IDT_Réf1))
					
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=tl_Fu_Référence{$ii})
					MultiSoc_Filter(->[HeBerge:4])
					
					If (Records in selection:C76([HeBerge:4])>0)
						vt_FusNote_Notes:=vt_FusNote_Notes+<>va_CR+(([HeBerge:4]Notes:6+<>va_CR)*Num:C11([HeBerge:4]Notes:6>""))
						vt_FusNote_Commentaire:=vt_FusNote_Actions+<>va_CR+(([HeBerge:4]HB_Commentaire:17+<>va_CR)*Num:C11([HeBerge:4]HB_Commentaire:17>""))
						vt_FusNote_Actions:=vt_FusNote_Actions+<>va_CR+(([HeBerge:4]HG_Actions:40+<>va_CR)*Num:C11([HeBerge:4]HG_Actions:40>""))
						vt_FusNote_Maraude:=vt_FusNote_Maraude+<>va_CR+(([HeBerge:4]HB_Maraude:41+<>va_CR)*Num:C11([HeBerge:4]HB_Maraude:41>""))
						vt_FusNote_Social:=vt_FusNote_Social+<>va_CR+(([HeBerge:4]HB_Social:42+<>va_CR)*Num:C11([HeBerge:4]HB_Social:42>""))
						vt_FusNote_Infirmier:=vt_FusNote_Infirmier+<>va_CR+(([HeBerge:4]HB_Infirmier:43+<>va_CR)*Num:C11([HeBerge:4]HB_Infirmier:43>""))
						vt_FusNote_Psycho:=vt_FusNote_Psycho+<>va_CR+(([HeBerge:4]HB_Psycho:44+<>va_CR)*Num:C11([HeBerge:4]HB_Psycho:44>""))
						vt_FusNote_Médical:=vt_FusNote_Médical+<>va_CR+(([HeBerge:4]HB_Médical:45+<>va_CR)*Num:C11([HeBerge:4]HB_Médical:45>""))
						vt_FusNote_Santé:=vt_FusNote_Santé+<>va_CR+(([HeBerge:4]HB_Santé:48+<>va_CR)*Num:C11([HeBerge:4]HB_Santé:48>""))
						vt_FusNote_ActionsF:=vt_FusNote_ActionsF+<>va_CR+(([HeBerge:4]HB_ActionsF:49+<>va_CR)*Num:C11([HeBerge:4]HB_ActionsF:49>""))
						vt_FusNote_Notes2:=vt_FusNote_Notes2+<>va_CR+(([HeBerge:4]HB_Notes2:50+<>va_CR)*Num:C11([HeBerge:4]HB_Notes2:50>""))
						DELETE SELECTION:C66([HeBerge:4])
						UNLOAD RECORD:C212([HeBerge:4])
					End if 
					
				End for 
				
				If (<>vb_FusNote_Notes)
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_IDT_Réf1)
					MultiSoc_Filter(->[HeBerge:4])
					
					If (Records in selection:C76([HeBerge:4])=1)
						LOAD RECORD:C52([HeBerge:4])
						
						[HeBerge:4]Notes:6:=[HeBerge:4]Notes:6+vt_FusNote_Notes
						[HeBerge:4]HG_Actions:40:=[HeBerge:4]HG_Actions:40+vt_FusNote_Actions
						[HeBerge:4]HB_Maraude:41:=[HeBerge:4]HB_Maraude:41+vt_FusNote_Maraude
						
						[HeBerge:4]HB_Social:42:=[HeBerge:4]HB_Social:42+vt_FusNote_Social
						[HeBerge:4]HB_Infirmier:43:=[HeBerge:4]HB_Infirmier:43+vt_FusNote_Infirmier
						[HeBerge:4]HB_Psycho:44:=[HeBerge:4]HB_Psycho:44+vt_FusNote_Psycho
						[HeBerge:4]HB_Médical:45:=[HeBerge:4]HB_Médical:45+vt_FusNote_Médical
						[HeBerge:4]HB_Santé:48:=[HeBerge:4]HB_Santé:48+vt_FusNote_Santé
						[HeBerge:4]HB_ActionsF:49:=[HeBerge:4]HB_ActionsF:49+vt_FusNote_ActionsF
						[HeBerge:4]HB_Notes2:50:=[HeBerge:4]HB_Notes2:50+vt_FusNote_Notes2
						
						SAVE RECORD:C53([HeBerge:4])
						UNLOAD RECORD:C212([HeBerge:4])
					End if 
					
				End if 
				
				READ ONLY:C145([HeBerge:4])
				READ ONLY:C145([HeberGement:5])
				
				READ ONLY:C145([Maraude:24])
				READ ONLY:C145([DossierSocial:25])
				READ ONLY:C145([DossierInfirmie:27])
				READ ONLY:C145([DossierPsycho:28])
				READ ONLY:C145([DossierMedical:29])
				READ ONLY:C145([DossierSante:33])
				
				CLOSE WINDOW:C154
				Tab_Fusion(0; 0; 0)
			End if 
			
		Else 
			ALERT:C41("La clé maîtresse n'existe pas !")
		End if 
		
		USE SET:C118("E_HBliste")
		vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
		
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		FIRST RECORD:C50([HeBerge:4])
		
		PREVIOUS RECORD:C110([HeBerge:4])
		CLEAR SET:C117("E_HBliste")
	Else 
		ALERT:C41("Il n'y a pas de clé à fusionner !")
	End if 
	
Else 
	ALERT:C41("Il n'y a pas de clé maîtresse  !")
End if 