//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 13/07/21, 15:12:24
// ----------------------------------------------------
// Méthode : P_Pointage
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($1)  // Indique si l'appel provient de l'ancien formulaire [DiaLogues]DL_HébergementGpeOld, s'il est indiqué Pointage fiche hébergement (Pas Prestation) [Optionnel]
C_BOOLEAN:C305($2)  // Indique si l'appel provient du nouveau formulaire [DiaLogues]DL_HébergementGpe, si Vrai Pointagee fiche Hébergement [Optionnel]

C_TEXT:C284($va_JN)
C_DATE:C307($vb_Date)

// Modifié par : Scanu Rémy (21/06/2022)
// Ajout d'un appel différent depuis le nouveau formulaire DL_HébergementGpe
Case of 
	: (Count parameters:C259=0)
		LOAD RECORD:C52([HeBerge:4])  // #20180119-1
	: (Count parameters:C259=2)
		outilsHebergeLoadRecord
		
		If ($2=True:C214)
			va_JourNuit:="J"
		Else 
			va_JourNuit:="N"
		End if 
		
End case 

If ([HeBerge:4]HB_ReferenceID:1>0)
	
	// Modifié par : Scanu Rémy (21/06/2022)
	// Ajout d'un appel différent depuis le nouveau formulaire DL_HébergementGpe
	If (Count parameters:C259<=1)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
		
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
	End if 
	
	If (Records in selection:C76([HeberGement:5])>0)
		
		If (i_Confirmer("Voulez-vous pointer le passage du demandeur ?"+<>va_CR+va_NNN))
			vb_PasseR:=True:C214
			vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
			
			<>vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
			
			$va_JN:=va_JourNuit
			
			// Modifié par : Scanu Rémy (13/07/2021) et Re-Modifié par Scanu Rémy (21/06/2022)
			// Ajout d'un appel différent depuis le nouveau formulaire DL_HébergementGpe
			If (Count parameters:C259<=1)
				
				If (Count parameters:C259=1)
					va_JourNuit:="J"
				Else 
					va_JourNuit:="N"
				End if 
				
			End if 
			
			If (F_HébergementCtrlCréation(va_JourNuit))
				
				If (vl_NbHéberGements>0)
					F_VariablesTransite(2; 1; False:C215)
				Else 
					F_VariablesTransite(3; 1; False:C215)
				End if 
				
			Else 
				vb_PasseR:=False:C215
			End if 
			
			If (vb_PasseR)
				i_Message("Fiche de pointage en cours de création...")
				
				READ WRITE:C146([HeberGement:5])
				
				$vb_Date:=Current date:C33
				
				vl_Num_HBE:=Uut_Numerote115($vb_Date)  //?????(*))  `Uut_NumeroteMensuel 
				vl_RéfU_HG:=Uut_Numerote(->[HeberGement:5])
				
				// Modifié par : Scanu Rémy (13/07/2021) et Re-Modifié par Scanu Rémy (21/06/2022)
				// Ajout d'un appel différent depuis le nouveau formulaire DL_HébergementGpe
				Case of 
					: (Count parameters:C259=0)
						DébutInitPointage(0)
					: (Count parameters:C259=1)
						DébutInitPointage(0; True:C214)
					: (va_JourNuit="J")
						DébutInitPointage(0; True:C214)
					Else 
						DébutInitPointage(0)
				End case 
				
				CREATE RECORD:C68([HeberGement:5])
				MultiSoc_Init_Structure(->[HeberGement:5])
				
				//Numérotation et affectation de la fiche d'hébergement
				P_HébergementNo(va_JourNuit)
				P_HébergementNoRéf
				
				//Affectation des champs (dans le cas d'un nvle hébegement avec historique)
				If (va_IDT_TypTrans>"")
					F_VariablesTransite(4; 1; False:C215)
					
					If (<>vb_T_ModeCHRS)
						[HeberGement:5]HG_Plateforme:139:=<>va_UserPlateforme
					Else 
						[HeberGement:5]HG_Plateforme:139:=""
					End if 
					
					[HeberGement:5]HG_FamGroupe:102:=<>va_PointeFMGroupe
					[HeberGement:5]HG_EtatCivil:20:=va_IDT_TypTrans
					[HeberGement:5]HG_DateCreationFiche:149:=Current date:C33(*)
					
					[HeberGement:5]HG_LC_ID:61:=<>vl_PointeCtrRéf
					[HeberGement:5]HG_CentreNom:62:=<>va_PointeCtrNom
					
					[HeberGement:5]HG_CentreARR:63:=<>va_PointeCtrCP
					[HeberGement:5]HG_Médicalisé:56:=<>vb_PointeCtrMéd
					
					[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
					
					[HeberGement:5]HG_Signalement:12:=<>va_T_HBsignal
					
					// Modifié par : Scanu Rémy (13/07/2021) et Re-Modifié par Scanu Rémy (21/06/2022)
					// Ajout d'un appel différent depuis le nouveau formulaire DL_HébergementGpe
					If (Count parameters:C259>=1)
						
						Case of 
							: (Count parameters:C259=1)
								[HeberGement:5]HG_NuitTOTAL:93:=Num:C11(Request:C163("Pour combien de nuits ?"; "1"; "Valider"; "Annuler"))
							: (va_JourNuit="J")
								[HeberGement:5]HG_NuitTOTAL:93:=Num:C11(Request:C163("Pour combien de nuits ?"; "1"; "Valider"; "Annuler"))
						End case 
						
					End if 
					
					SAVE RECORD:C53([HeberGement:5])
				End if 
				
				UNLOAD RECORD:C212([HeberGement:5])
				
				READ ONLY:C145([HeberGement:5])
				CLOSE WINDOW:C154
			End if 
			
			va_JourNuit:=$va_JN
		End if 
		
	Else 
		ALERT:C41("Pas de compte ouvert !")
	End if 
	
	// Modifié par : Scanu Rémy (21/06/2022)
	// Ajout d'un appel différent depuis le nouveau formulaire DL_HébergementGpe
	If (Count parameters:C259=2)
		va_JourNuit:="JN"
	End if 
	
	If (Count parameters:C259<=1)
		Rec_Hébergements1(->vL_Nb_HG_F)
	End if 
	
Else 
	StrAlerte(2; "")
End if 

If (Count parameters:C259=2)
	va_JourNuit:="JN"
	vb_PasseR:=False:C215
End if 