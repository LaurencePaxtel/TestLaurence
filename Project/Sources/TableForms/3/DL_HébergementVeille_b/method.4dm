C_TEXT:C284($vaUn)
C_LONGINT:C283($vl_EventFF; $colonne; $ligne; $i_el)
C_BOOLEAN:C305($vb_OK)
C_TIME:C306($vh_HeurC)

var $centre_e : cs:C1710.LesCentresEntity

$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		// Modifié par : Scanu Rémy - remy@connect-io.fr (24/06/2021)
		// Ajout filtre date PEC
		C_DATE:C307(vDateAnneeEntreeDu; vDateAnneeEntreeAu; vDateDebutPECDu; vDateDebutPECAu; vDateFinPECDu; vDateFinPECAu)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (07/05/2021)
		ARRAY TEXT:C222(filtreNbFichesDe_at; 0)
		ARRAY TEXT:C222(filtreNbFichesA_at; 0)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (22/02/2022)
		ARRAY TEXT:C222(filtreAgeDe_at; 0)
		ARRAY TEXT:C222(filtreAgeA_at; 0)
		
		outilsCleanVariable(->vDateAnneeEntreeDu; ->vDateAnneeEntreeAu; ->vDateDebutPECDu; ->vDateDebutPECAu; ->vDateFinPECDu; ->vDateFinPECAu)
		SOC_Get_Config
		
		If (Not:C34(SO_Activer_Module_Facturation))
			OBJECT SET VISIBLE:C603(*; "@Facturation@"; False:C215)
		End if 
		
		If (Not:C34(SO_DOS_Encours_Activer))
			OBJECT SET VISIBLE:C603(*; "@dossiers_encours@"; False:C215)
		End if 
		
		OBJECT SET VISIBLE:C603(b_xx; False:C215)
		
		[DiaLogues:3]DL_Date:2:=Current date:C33(*)
		[DiaLogues:3]DL_Date2:8:=Current date:C33(*)
		[DiaLogues:3]DL_LibelAutre:5:=""
		[DiaLogues:3]DL_Libellé:3:=""
		[DiaLogues:3]DL_LibelPlus:6:=""
		[DiaLogues:3]DL_LibelléN:9:=""
		[DiaLogues:3]DL_LibelléG:10:=""
		[DiaLogues:3]DL_LibelléL:11:=""
		
		uEmplace:=1
		
		OBJECT SET TITLE:C194(uEmplace; "Affichage: "+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 48))
		
		OBJECT SET VISIBLE:C603(b_RecEditeur; User in group:C338(Current user:C182; <>Groupe_DEVELOP))
		OBJECT SET VISIBLE:C603(b_RecSup; User in group:C338(Current user:C182; <>Groupe_DEVELOP))
		OBJECT SET VISIBLE:C603(b_TExp; User in group:C338(Current user:C182; <>Groupe_VeilleExport))
		OBJECT SET VISIBLE:C603(b_Doublons; User in group:C338(Current user:C182; <>Groupe_DEVELOP))
		OBJECT SET VISIBLE:C603(*; "CritDept_@"; (<>ve_ConsoRegion_Mode=2))  //6/12/2011 : IMPORT pour le régional
		OBJECT SET VISIBLE:C603(b_DossierSIAO; User in group:C338(Current user:C182; <>Groupe_DEVELOP))
		OBJECT SET VISIBLE:C603(r10; User in group:C338(Current user:C182; <>Groupe_DEVELOP))
		
		r1:=1
		r2:=0
		r3:=0
		r4:=0
		r5:=0
		r6:=0
		r7:=0
		r8:=0
		r9:=0
		r10:=0
		
		sOr1:=0
		tLocal:=0
		rDernièreF:=0
		
		fFicheNuit:=0
		rDossierSIAO:=0
		rSurDateEcheance:=0
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (28/05/2021)
		// Ajout d'une boite à cocher "Fiche Unique"
		rFicheUnique:=0
		
		w115:=0
		wLien:=0
		
		OBJECT SET VISIBLE:C603(rSurDateEcheance; False:C215)
		OBJECT SET VISIBLE:C603(*; "LeRadioSP"; False:C215)  //r7
		
		// Modifié par : Scanu Rémy (14/02/2022)
		rJourNuit1:=1  //Jour
		rJourNuit2:=0  //Nuit
		
		wSansFiltre:=Num:C11(<>vb_T_ModeCHRS)
		
		OBJECT SET VISIBLE:C603(*; "115_Jour"; Not:C34(<>vb_T_ModeCHRS))
		OBJECT SET VISIBLE:C603(*; "115_Nuit"; Not:C34(<>vb_T_ModeCHRS))
		
		OBJECT SET VISIBLE:C603(*; "CHRS_Jour"; <>vb_T_ModeCHRS)
		OBJECT SET VISIBLE:C603(*; "CHRS_Nuit"; <>vb_T_ModeCHRS)
		
		OBJECT SET VISIBLE:C603(*; "Maraude_CHRS"; <>vb_T_ModeCHRS)
		OBJECT SET VISIBLE:C603(*; "Maraude_115"; Not:C34(<>vb_T_ModeCHRS))
		
		OBJECT SET VISIBLE:C603(w115; Not:C34(<>vb_T_ModeCHRS))
		
		$vh_HeurC:=Current time:C178
		
		// Modifié par : Scanu Rémy (14/02/2022)
		Case of 
			: (<>vb_ParamDisActivée) & (((<>vb_ParamDisJour) & (<>vb_ParamDisNuit=False:C215)) | ((<>vb_ParamDisJour=False:C215) & (<>vb_ParamDisNuit=True:C214)))
				rJourNuit1:=Num:C11(<>vb_ParamDisJour)
				rJourNuit2:=Num:C11(<>vb_ParamDisNuit)
			: (<>vb_CentreEXC)
				rJourNuit1:=1
				rJourNuit2:=0
			Else 
				rJourNuit1:=Num:C11(($vh_HeurC>=?08:00:00?) & ($vh_HeurC<=?19:59:59?))  //Jour
				rJourNuit2:=Num:C11(rJourNuit1=0)  //Nuit
		End case 
		
		// Modifié par : Scanu Rémy (14/02/2022)
		JourNuit1:=rJourNuit1  //Jour
		JourNuit2:=rJourNuit2  //Nuit
		
		OBJECT SET VISIBLE:C603(wSansFiltre; User in group:C338(Current user:C182; <>Groupe_SansFiltre))
		
		rReports:=1
		rDoublons:=0
		
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		P_HébergementVeilleFind
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (07/05/2021)
		// Ajout d'un filtre pour trouver un nombre de fiches (hébergements) par usager
		For ($i_el; 1; 2000)
			
			If ($i_el>=1) & ($i_el<=100)
				APPEND TO ARRAY:C911(filtreAgeDe_at; String:C10($i_el-1))
				APPEND TO ARRAY:C911(filtreAgeA_at; String:C10($i_el-1))
			End if 
			
			APPEND TO ARRAY:C911(filtreNbFichesDe_at; String:C10($i_el))
			APPEND TO ARRAY:C911(filtreNbFichesA_at; String:C10($i_el))
		End for 
		
		OBJECT SET ENABLED:C1123(b_RecNomClé; False:C215)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (09/06/2021)
		// Ajout d'un groupe pour pouvoir supprimer une ou plusieurs fiches
		OBJECT SET VISIBLE:C603(*; "Bouton8"; User in group:C338(Current user:C182; "Suppression fiches groupées"))
		OBJECT SET ENABLED:C1123(*; "Bouton8"; User in group:C338(Current user:C182; "Suppression fiches groupées"))
		
		// Modifié par : Scanu Rémy (06/09/2023)
		Form:C1466.clicEnteteSpecifique:=New object:C1471
		
		Form:C1466.clicEnteteSpecifique.PARMontantParticipation:=""
		Form:C1466.clicEnteteSpecifique.HBFACModeFacturation:=""
	: ($vl_EventFF=Sur données modifiées:K2:15)
		
		Case of 
			: (Modified:C32([DiaLogues:3]DL_Libellé:3))
				POST OUTSIDE CALL:C329(<>PR_HBNotesV)
				
				P_HébergementVeilleFind
			: (Modified:C32([DiaLogues:3]DL_LibelAutre:5))
				POST OUTSIDE CALL:C329(<>PR_HBNotesV)
				
				P_HébergementVeilleFind
			: (Modified:C32([DiaLogues:3]DL_LibelPlus:6))
				P_HébergementVeilleFind
		End case 
		
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		
		Case of 
			: (<>va_TransVeille_Message="Sortants")
				<>va_TransVeille_Message:=""
				
				If (<>vb_Sortants)
					<>vb_Sortants:=False:C215
					
					P_HébergementSortant(2)
				Else 
					ALERT:C41("Vous devez vous rafraîchir la liste !"+Char:C90(13)+"Un report de réservation a été effectué.")
				End if 
				
			: (<>va_TransVeille_Message="Somme")
				<>va_TransVeille_Message:=""
				
				<>vb_TransVeille:=True:C214
				
				F_SommeVeilleAppel(<>vd_TransVeille_Date; <>va_TransVeille_Valeur)
				
				<>vb_TransVeille:=False:C215
		End case 
		
	: ($vl_EventFF=Sur clic:K2:4)
		LISTBOX GET CELL POSITION:C971(The_List_box; $colonne; $ligne)
		GOTO SELECTED RECORD:C245([HeberGement:5]; $ligne)
		
		If ([HeberGement:5]HG_ReferenceID:1>0)
			P_HébergementNotesBt(1)
			
			OBJECT SET ENABLED:C1123(b_ModCléHG; True:C214)
			OBJECT SET ENABLED:C1123(b_PrtAct; True:C214)
			OBJECT SET ENABLED:C1123(b_PrtActF; True:C214)
			OBJECT SET ENABLED:C1123(b_Excuse; True:C214)
			OBJECT SET ENABLED:C1123(b_RecNomClé; True:C214)
		Else 
			P_HébergementNotesBt(0)
			
			OBJECT SET ENABLED:C1123(b_ModCléHG; False:C215)
			OBJECT SET ENABLED:C1123(b_PrtAct; False:C215)
			OBJECT SET ENABLED:C1123(b_PrtActF; False:C215)
			OBJECT SET ENABLED:C1123(b_Excuse; False:C215)
			OBJECT SET ENABLED:C1123(b_RecNomClé; False:C215)
		End if 
		
		// Modified by: Kevin HASSAL (06/07/2020)
		// Pour la gestion des participations
		If ([HeberGement:5]HG_HB_ID:19>0)
			VAR_HB_ReferenceID:=[HeberGement:5]HG_HB_ID:19
			
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=VAR_HB_ReferenceID)
			MultiSoc_Filter(->[HeBerge:4])
			
			If ([HeBerge:4]HB_FAC_Mode_Facturation:80="Participations")
				OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; False:C215)
				OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; True:C214)
				OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; False:C215)
			End if 
			
		End if 
		
	: ($vl_EventFF=Sur double clic:K2:5)
		C_LONGINT:C283($colonne; $ligne)
		
		LISTBOX GET CELL POSITION:C971(The_List_box; $colonne; $ligne)
		GOTO SELECTED RECORD:C245([HeberGement:5]; $ligne)
		
		If ([HeberGement:5]HG_ReferenceID:1>0)
			$vaUn:=(("N"*Num:C11([HeberGement:5]HG_Nuit:2))+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215)))
			
			If (<>vb_T_ModeCHRS)
				$vb_OK:=([HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
				
				If ($vb_OK)
					$vb_OK:=False:C215
					
					Case of 
						: (User in group:C338(Current user:C182; <>Groupe_Jour) & User in group:C338(Current user:C182; <>Groupe_Nuit))
							$vb_OK:=True:C214
						: (User in group:C338(Current user:C182; <>Groupe_Jour))
							$vb_OK:=($vaUn="J")
						: (User in group:C338(Current user:C182; <>Groupe_Nuit))
							$vb_OK:=($vaUn="N")
					End case 
					
				End if 
				
			Else 
				$vb_OK:=True:C214
			End if 
			
			// Modifié par : Scanu Rémy (16/02/2024)
			If ($vb_OK=True:C214)
				outilsOrdaSearchSimple(->[LesCentres:9]; ->[LesCentres:9]LC_Nom:4; [HeberGement:5]HG_CentreNom:62; ->$centre_e; "first")
				
				If ($centre_e#Null:C1517)
					
					If ($centre_e.LC_Sante=True:C214)
						$vb_OK:=User in group:C338(Current user:C182; "Santé")
					End if 
					
				End if 
				
			End if 
			
			If ($vb_OK)
				Process_Go7(-><>PR_HébergementV; "Go_HébergementR"; "FicheSignal"; 64; $vaUn; "V"; [HeberGement:5]HG_FicheNuméro:3)
			Else 
				StrAlerte(6; "")
			End if 
			
		End if 
		
	: ($vl_EventFF=Sur menu sélectionné:K2:14)
		// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
		// Ajout d'un menu pour accéder à la barre d'appel sans que l'utilisateur ait besoin de redémarrer le programme
		i_MenuChoisi
End case 