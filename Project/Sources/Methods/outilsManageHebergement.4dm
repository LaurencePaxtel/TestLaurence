//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 08/12/22, 17:04:44
// ----------------------------------------------------
// Méthode : outilsManageHebergement
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var ${2} : Variant

var $formEntree_t; $T_Window_titre : Text
var $ii; $vl_Fenetre : Integer
var $vb_Nuit; $vb_OK : Boolean
var $vb_Date : Date
var $position_o; $form_o : Object

Case of 
	: ($1=1)  // Création fiche hébergement après validation de la civilité depuis le formulaire DL_HebergementGpe
		$position_o:=New object:C1471("ecartHautEcran"; Tool bar height:C1016+Menu bar height:C440+10; "ecartBasEcran"; 70)
		P_HébergementProfil(va_JourNuit; "")
		
		If (vb_ResGroupe)
			F_VariablesTransite(5; 0; False:C215)
			P_Tab_GP(13; 1; ->va_HGGP_CléChéf)
			
			vl_GroupeNbHG:=0
			va_GPmembres:=F_HébergementGroupeActifs([GrouPe:36]GP_Intitulé:4; [GrouPe:36]GP_Famille:6; ->vl_GroupeNbHG)
			
			$vl_Fenetre:=i_FenêtreNo(786; 508; 4; "Hébergement "+("Jour"*Num:C11(va_JourNuit="J"))+("Nuit"*Num:C11(va_JourNuit="N"))+" : "+va_GPmembres; 1; "Quit_Passe")
			DIALOG:C40([DiaLogues:3]; "DL_HébergementGpeNew")
			
			CLOSE WINDOW:C154($vl_Fenetre)
		Else 
			$vb_Nuit:=(va_JourNuit="N")
			
			Repeat 
				vl_NbBoucle:=vl_NbBoucle-1
				
				If (vb_ResMulti)
					$ii:=$ii+1
					
					QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=<>tl_FamilleID{$ii})
					MultiSoc_Filter(->[HeberGement:5])
					
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
					
					vl_NbHéberGements:=Records in selection:C76([HeberGement:5])
					
					If (vl_NbHéberGements>0)
						
						// Modifié par : Scanu Rémy (10/03/2023)
						F_VariablesTransite(2; 1; True:C214)
						
					Else   // Nouveau
						QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=<>tl_FamilleID{$ii})
						MultiSoc_Filter(->[HeBerge:4])
						
						F_VariablesTransite(3; 1; False:C215)
					End if 
					
					va_IDT_Typ1:=<>ta_FamilleEtCv{$ii}
					P_EtatCivil("Sexe_rIDTG_1"; va_IDT_Typ1)
					
					x_IDTG_1:=rIDTG_1
					x_IDTG_2:=rIDTG_2
					
					vl_RéfU_HBB:=<>tl_FamilleID{$ii}
				End if 
				
				P_HébergementProfil(va_JourNuit; [HeberGement:5]HG_Permanencier:9)
				
				READ WRITE:C146([HeberGement:5])
				
				$vb_Date:=Current date:C33
				
				vl_Num_HBE:=Uut_Numerote115($vb_Date)  //?????(*))  `Uut_NumeroteMensuel 
				vl_RéfU_HG:=Uut_Numerote(->[HeberGement:5])
				
				If (<>vb_T_EcranGrand)
					$formEntree_t:="HG_EcranSaisie_B"
				Else 
					$formEntree_t:="HG_EcranSaisie"
				End if 
				
				FORM SET INPUT:C55([HeberGement:5]; $formEntree_t)
				
				If (User in group:C338(Current user:C182; <>Groupe_Asile))
					va_FormatFrom:="A"
				End if 
				
				If (<>ve_Si_ModeCHRS=1)
					$T_Window_titre:="Prestation"
				Else 
					$T_Window_titre:="Hébergement : "+("Jour"*Num:C11(va_JourNuit="J"))+("Nuit"*Num:C11(va_JourNuit="N"))
				End if 
				
				// Modifié par : Scanu Rémy (21/12/2021)
				outilsCreateWindowsForm($formEntree_t; ->$position_o; Null:C1517; ->[HeberGement:5]; Null:C1517; ->$vl_Fenetre)
				
				SET WINDOW TITLE:C213($T_Window_titre; $vl_Fenetre)
				CREATE RECORD:C68([HeberGement:5])
				[HeberGement:5]HG_Date:4:=Current date:C33(*)
				
				If (Value type:C1509(dateFiche_d)#Est une variable indéfinie:K8:13)
					
					If (dateFiche_d#!00-00-00!)
						[HeberGement:5]HG_Date:4:=dateFiche_d
					End if 
					
				End if 
				
				// Modifié par : Scanu Rémy (04/05/2022)
				//MODIFIER ENREGISTREMENT([HeberGement]
				$form_o:=New object:C1471("table"; "HeberGement"; "formName"; $formEntree_t)
				
				If (Bool:C1537(Form:C1466.dupliquerFiche)=True:C214)
					$form_o:=outilsObjectMerge($form_o; Form:C1466)
				End if 
				
				outilsCreateWindowsForm($formEntree_t; Null:C1517; \
					$form_o; \
					New object:C1471("table"; "HeberGement"; "useFormTable"; True:C214; "useSubForm"; True:C214; "useExternalWindows"; True:C214; "refExternalWindows"; $vl_Fenetre))
				//DIALOGUE([HeberGement]; "HG_EcranSaisie_B"; Créer objet)
				
				If (OK=1)
					MultiSoc_Init_Structure(->[HeBerge:4])
					SAVE RECORD:C53([HeBerge:4])
					
					If (<>vb_T_DosSIAO)
						
						If ([HeberGement:5]HG_NuitenCours:92=1)
							$vb_OK:=F_SIAO_DansHebergement("Validation")
						End if 
						
					End if 
					
					$vb_OK:=([HeberGement:5]HG_Nuit:2=False:C215)  // Modifié le 03/02/2009 avant c'était clôturé
					$vb_OK:=$vb_OK & [HeberGement:5]HG_Trans_DDASS:141
					
					If (<>vb_T_Fiches115)
						
						If (<>vb_T_ModeCHRS)
							$vb_OK:=$vb_OK & ([HeberGement:5]HG_Trans_FicheNuméro:143="")  // 25/05/2011 (c'est pas une fiche 115)
						End if 
						
					End if 
					
					If ($vb_OK)
						F_Report_FullReporté(->tl_Trans_Réf_HG; [HeberGement:5]HG_ReferenceID:1)
						$vb_OK:=F_Regional_Refs(->tl_Regional_Réf_HG; [HeberGement:5]HG_ReferenceID:1)
					End if 
					
					$vb_OK:=([HeberGement:5]HG_Nuit:2=False:C215)
					$vb_OK:=$vb_OK & [HeberGement:5]HG_Trans_DDASS:141
					
					If ($vb_OK)
						$vb_OK:=F_Regional_Refs(->tl_Regional_Réf_HG; [HeberGement:5]HG_ReferenceID:1)
					End if 
					
					$vb_OK:=([HeberGement:5]HG_Nuit:2=True:C214)  // le 29/04/2011
					
					If ($vb_OK)
						$vb_OK:=F_Prestation_RefsTableau(1; [HeberGement:5]HG_ReferenceID:1)
					End if 
					
				End if 
				
				//AJOUTER ENREGISTREMENT([HeberGement])  // lpc 14122017 ascenceur
				
				// Modifié par : Scanu Rémy (23/02/2023)
				// Depuis le formulaire [HeberGement]HG_Ecran_Saisie_B, on souhaite dupliquer la fiche nouvellement créée
				OB REMOVE:C1226(Form:C1466; "dupliquerFiche")
				
				OB REMOVE:C1226(Form:C1466; "dupliquerFicheHBID")
				OB REMOVE:C1226(Form:C1466; "dupliquerFicheHGID")
				OB REMOVE:C1226(Form:C1466; "dupliquerFicheType")
				
				If (Bool:C1537($form_o.dupliquerFiche)=True:C214)
					Form:C1466.dupliquerFiche:=$form_o.dupliquerFiche
					
					Form:C1466.dupliquerFicheHBID:=$form_o.dupliquerFicheHBID
					Form:C1466.dupliquerFicheHGID:=$form_o.dupliquerFicheHGID
					Form:C1466.dupliquerFicheType:=$form_o.dupliquerFicheType
				End if 
				
				UNLOAD RECORD:C212([HeBerge:4])
				UNLOAD RECORD:C212([HeberGement:5])
				
				If (Window process:C446($vl_Fenetre)#0)
					CLOSE WINDOW:C154($vl_Fenetre)
				End if 
				
				READ ONLY:C145([HeberGement:5])
				POST OUTSIDE CALL:C329(<>PR_HBNotes)
			Until (vl_NbBoucle<=0)
			
			//•Est ce une base CHRS  et y a til des fiches reportées
			$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Transfert ")
			$vb_OK:=F_Regional_Transfert(->tl_Regional_Réf_HG; False:C215; "Transfert régional")
			$vb_OK:=F_Prestation_Transfert(->tl_Presta_Réf_HG; False:C215; "Prestations")
			
			F_Report_FullDuplexTableau
			
			$vb_OK:=F_Regional_RefsTableau(0)
			$vb_OK:=F_Prestation_RefsTableau(0; 0)
		End if 
		
	: ($1=2)  // Report manuel depuis le web
		ds:C1482.HeberGement.reportManuel($2; $3)
	: ($1=10)  // Création fiche hébergement/prestation complet depuis le formulaire DL_HebergementGpe
		va_JourNuit:=$2
		outilsHebergeLoadRecord
		
		If (F_HebergementNewValider((b_ValHBnew=1); False:C215))
			outilsManageHebergement(1)
			vb_PasseR:=($2="N")
		End if 
		
End case 