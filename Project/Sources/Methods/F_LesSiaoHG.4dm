//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : F_LesSIAOHG
//{          Vendredi 2 judécembrein 2011 à 10:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($va_Cas)



C_LONGINT:C283($ii; $vl_fiches)
Case of 
	: ($1=-1)
		ARRAY LONGINT:C221(tl_SiaoHG_RefHB; 0)
		ARRAY LONGINT:C221(tl_SiaoHG_RefSIAO; 0)
		ARRAY TEXT:C222(ta_SiaoHG_Theme; 0)
		
		ARRAY DATE:C224(td_SiaoHG_Date; 0)
		ARRAY TEXT:C222(ta_SiaoHG_No; 0)
		ARRAY TEXT:C222(ta_SiaoHG_Type; 0)
		
		
	: ($1=1)
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Personne_ID:3=$2)
		MultiSoc_Filter(->[SIAO_Personnes:51])
		If (Records in selection:C76([SIAO_Personnes:51])>0)
			SELECTION TO ARRAY:C260([SIAO_Personnes:51]Sp_Personne_ID:3; tl_SiaoHG_RefHB; [SIAO_Personnes:51]Sp_SIAO_ID:2; tl_SiaoHG_RefSIAO; [SIAO_Personnes:51]Sp_SousTheme:6; ta_SiaoHG_Theme)
			$vl_fiches:=Size of array:C274(tl_SiaoHG_RefHB)
			ARRAY DATE:C224(td_SiaoHG_Date; $vl_fiches)
			ARRAY TEXT:C222(ta_SiaoHG_No; $vl_fiches)
			ARRAY TEXT:C222(ta_SiaoHG_Type; $vl_fiches)
			
			For ($ii; 1; $vl_fiches)
				QUERY:C277([SIAO:50]; [SIAO:50]Si_RéférenceID:1=tl_SiaoHG_RefSIAO{$ii})
				MultiSoc_Filter(->[SIAO:50])
				
				If (Records in selection:C76([SIAO:50])=1)
					td_SiaoHG_Date{$ii}:=[SIAO:50]Si_Demande_Date:2
					ta_SiaoHG_No{$ii}:=[SIAO:50]Si_Demande_Numero:3
					ta_SiaoHG_Type{$ii}:=F_SIAO_DemandeType([SIAO:50]Si_Demande_Type:5)
				Else 
					td_SiaoHG_Date{$ii}:=!00-00-00!
					ta_SiaoHG_No{$ii}:=""
					ta_SiaoHG_Type{$ii}:=""
				End if 
			End for 
			
			SORT ARRAY:C229(td_SiaoHG_Date; tl_SiaoHG_RefHB; tl_SiaoHG_RefSIAO; ta_SiaoHG_Theme; ta_SiaoHG_No; ta_SiaoHG_Type; <)
			
			
		Else 
			F_LesSiaoHG(-1; 0)
		End if 
		OBJECT SET VISIBLE:C603(*; "SIAO_HG_@"; False:C215)
		OBJECT SET VISIBLE:C603(b_SIAODossier; True:C214)
		
		vl_AccesDossierSIAO_HG0:=0
		vt_AccesDossierSIAO_HG:=""
		Case of 
			: ($vl_fiches=0)
				vt_AccesDossierSIAO_HG:="Créer un dossier SIAO"
				OBJECT SET VISIBLE:C603(b_SIAODossier; False:C215)
			: ($vl_fiches=1)
				vl_AccesDossierSIAO_HG:=tl_SiaoHG_RefSIAO{1}
				vt_AccesDossierSIAO_HG:="SIAO n° "+ta_SiaoHG_No{1}+" ("+ta_SiaoHG_Theme{$1}+")"
				
			: ($vl_fiches>1)
				vt_AccesDossierSIAO_HG:="Voir un dossier SIAO"
				OBJECT SET VISIBLE:C603(*; "SIAO_HG_@"; True:C214)
				OBJECT SET VISIBLE:C603(b_SIAODossier; False:C215)
		End case 
		OBJECT SET TITLE:C194(b_SIAODossier; vt_AccesDossierSIAO_HG)
		
	: ($1=4)
		If (vl_AccesDossierSIAO_HG>0)
			If (i_Confirmer("Confirmez-vous la visualisation  du dossier "+vt_AccesDossierSIAO_HG+" ?"))
				
				vl_SIAO_RefAttestation:=vl_AccesDossierSIAO_HG
				Process_Go10(-><>PR_SIAOFiche; "Go_SIAOFiche"; "SIAO fiche"; 128; vl_AccesDossierSIAO_HG; "M"; 0; 0; "")
			End if 
		Else 
			If (i_Confirmer("Créer un n° de dossier SIAO pour le demandeur ?"))
				
				If ([HeberGement:5]HG_HB_ID:19>0)
					i_Message("Création du dossier SIAO …")
					va_IDT_Typ1:=[HeberGement:5]HG_EtatCivil:20
					vd_IDT_NéLe:=[HeberGement:5]HG_DateNéLe:24
					ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
					vb_Sel_CleUnique:=True:C214
					vl_Sel_CleUnique:=[HeberGement:5]HG_HB_ID:19
					P_SIAO_Var(2; 0)
					//vl_SIAO_Action
					//vl_SIAO_Referent
					
					//1 INSERTION/2 URGENCE/3 LES DEUX
					F_LesSiaoHG(7; <>vl_T_SIAOType)
					
					
					
					
					
					
					OBJECT SET TITLE:C194(b_SIAODossier; vt_AccesDossierSIAO_HG)
					CLOSE WINDOW:C154
				End if 
				
			End if 
		End if 
		
	: ($1=5)
		If ($2>0)
			vl_AccesDossierSIAO_HG:=tl_SiaoHG_RefSIAO{$2}
			vl_SIAO_RefAttestation:=vl_AccesDossierSIAO_HG
			Process_Go10(-><>PR_SIAOFiche; "Go_SIAOFiche"; "SIAO fiche"; 128; vl_AccesDossierSIAO_HG; "M"; 0; 0; "")
		End if 
		
		
	: ($1=6)
		//[HeberGement]HG_DossierSIAO
		//1 - Indéterminé
		//2 - Non
		//3 - Urgence
		//4 - Insertion
		//   New au 26/12/2011
		//1 - Urgence
		//2 - Insertion
		//3 - X3
		//4 - X4
		
		
		$vb_OK:=False:C215
		$va_Cas:=""
		
		If (<>vb_T_ModeCHRS)
		Else 
			If (Size of array:C274(tl_SiaoHG_RefHB)>0)
			Else 
				If ([HeberGement:5]HG_DossierSIAO:164>"")
					$va_Cas:=Substring:C12([HeberGement:5]HG_DossierSIAO:164; 1; 1)
					//1 INSERTION/2 URGENCE/3 LES DEUX    
					$vb_OK:=($va_Cas="1")
					$vb_OK:=$vb_OK | ($va_Cas="2")
					If ($vb_OK)
						Case of 
							: ($va_Cas="1")
								F_LesSiaoHG(7; 1)
							: ($va_Cas="2")
								F_LesSiaoHG(7; 2)
						End case 
					End if 
					
					
				End if 
			End if 
		End if 
		
		
		
	: ($1=61)
		//[HeberGement]HG_DossierSIAO
		//1 - Indéterminé
		//2 - Non
		//3 - Urgence
		//4 - Insertion
		// New au 26/12/2011
		//1 - Urgence
		//2 - Insertion
		//3 - X3
		//4 - X4
		
		$vb_OK:=False:C215
		$va_Cas:=""
		
		If (<>vb_T_ModeCHRS)
		Else 
			If (Size of array:C274(tl_SiaoHG_RefHB)>0)
			Else 
				If ([HeberGement:5]HG_DossierSIAO:164>"")
					QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Personne_ID:3=[HeberGement:5]HG_HB_ID:19)
					MultiSoc_Filter(->[SIAO_Personnes:51])
					If (Records in selection:C76([SIAO_Personnes:51])>0)
					Else 
						$va_Cas:=Substring:C12([HeberGement:5]HG_DossierSIAO:164; 1; 1)
						//1 INSERTION/2 URGENCE/3 LES DEUX    
						$vb_OK:=($va_Cas="1")
						$vb_OK:=$vb_OK | ($va_Cas="4")
						If ($vb_OK)
							Case of 
								: ($va_Cas="1")
									F_LesSiaoHG(7; 1)
								: ($va_Cas="2")
									F_LesSiaoHG(7; 2)
							End case 
						End if 
					End if 
					
				End if 
			End if 
		End if 
		
		
	: ($1=7)
		READ WRITE:C146([SIAO:50])
		CREATE RECORD:C68([SIAO:50])
		MultiSoc_Init_Structure(->[SIAO:50])
		[SIAO:50]Si_RéférenceID:1:=Uut_Numerote(->[SIAO:50])
		[SIAO:50]Si_Demande_Date:2:=[HeberGement:5]HG_Date:4
		[SIAO:50]Si_Demandeur_ID:21:=[HeberGement:5]HG_HB_ID:19
		[SIAO:50]Si_Demande_Nombre:4:=""
		[SIAO:50]Si_Demande_Numero:3:=F_Site(<>va_T_Site)+F_SIAO_Numero([SIAO:50]Si_Demande_Date:2)
		[SIAO:50]Si_Demandeur:20:=F_CléUnique_Clé([SIAO:50]Si_Demandeur_ID:21)
		[SIAO:50]Si_Demande_Type:5:=1
		//[SIAO]Si_Origine_Referent_ID:=vl_SIAO_Referent
		[SIAO:50]Si_Origine_SiteReference_ID:15:=1
		[SIAO:50]Si_Demande_fichecreeepar:6:=Current user:C182
		
		
		//1 INSERTION/2 URGENCE/3 LES DEUX
		Case of 
			: ($2=1)  //URGENCE          
				[SIAO:50]Si_Trans_Type:34:=False:C215
			: ($2=2)  //INSERTION
				[SIAO:50]Si_Trans_Type:34:=True:C214
			Else 
				//URGENCE      
				[SIAO:50]Si_Trans_Type:34:=False:C215
		End case 
		
		
		//•• Référent
		QUERY:C277([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_RéférenceID:1=[SIAO:50]Si_OrigineSiteAccueil_ID:19)
		MultiSoc_Filter(->[SIAO_SiteAccueil:55])
		If (Records in selection:C76([SIAO_SiteAccueil:55])=1)
			[SIAO:50]Si_Origine_SiteAccueil:18:=[SIAO_SiteAccueil:55]Sr_Nom:5+" "+[SIAO_SiteAccueil:55]Sr_Prénom:6
		End if 
		UNLOAD RECORD:C212([SIAO_SiteAccueil:55])
		//•• Accueil
		QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_RéférenceID:1=[SIAO:50]Si_Origine_SiteReference_ID:15)
		MultiSoc_Filter(->[SIAO_SiteReference:54])
		If (Records in selection:C76([SIAO_SiteReference:54])=1)
			[SIAO:50]Si_Origine_SiteReference:14:=[SIAO_SiteReference:54]Sa_ReferenceNom:6
		End if 
		UNLOAD RECORD:C212([SIAO_SiteReference:54])
		SAVE RECORD:C53([SIAO:50])
		
		vl_AccesDossierSIAO_HG:=[SIAO:50]Si_RéférenceID:1
		vt_AccesDossierSIAO_HG:="SIAO n° "+[SIAO:50]Si_Demande_Numero:3+"  (Demandeur)"
		
		
		READ WRITE:C146([SIAO_Personnes:51])
		CREATE RECORD:C68([SIAO_Personnes:51])
		MultiSoc_Init_Structure(->[SIAO_Personnes:51])
		[SIAO_Personnes:51]Sp_RéférenceID:1:=Uut_Numerote(->[SIAO_Personnes:51])
		
		[SIAO_Personnes:51]Sp_SIAO_ID:2:=[SIAO:50]Si_RéférenceID:1
		[SIAO_Personnes:51]Sp_Personne_ID:3:=[HeberGement:5]HG_HB_ID:19
		[SIAO_Personnes:51]Sp_Famille:4:="SITUATION DE FAMILLE"
		[SIAO_Personnes:51]Sp_Theme:5:="ELEMENTS DE LA DEMANDE"
		[SIAO_Personnes:51]Sp_SousTheme:6:="Demandeur"
		
		[SIAO_Personnes:51]Sp_Rang:7:=1
		
		[SIAO_Personnes:51]Sp_EtatCivil:8:=[HeberGement:5]HG_EtatCivil:20
		[SIAO_Personnes:51]Sp_Civilite:9:=""
		[SIAO_Personnes:51]Sp_Genre:10:=F_EtatCivilGenre([SIAO_Personnes:51]Sp_EtatCivil:8)
		[SIAO_Personnes:51]Sp_Nom:11:=[HeBerge:4]HB_Nom:3  //modif lpc 24/10/2018
		[SIAO_Personnes:51]Sp_Nom_de_jeune_fille:12:=""
		[SIAO_Personnes:51]Sp_Prenom:13:=[HeBerge:4]HB_Prénom:4  //modif lpc 24/10/2018
		[SIAO_Personnes:51]Sp_Date_de_naissance:14:=[HeberGement:5]HG_DateNéLe:24
		[SIAO_Personnes:51]Sp_Age:15:=0
		[SIAO_Personnes:51]Sp_Age_plus:16:="MiseàJour"
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[SIAO_Personnes:51]Sp_Personne_ID:3)
		MultiSoc_Filter(->[HeBerge:4])
		If (Records in selection:C76([HeBerge:4])=1)
			[SIAO_Personnes:51]Sp_Nom:11:=[HeBerge:4]HB_Nom:3
			[SIAO_Personnes:51]Sp_Prenom:13:=[HeBerge:4]HB_Prénom:4
			[SIAO_Personnes:51]Sp_Date_de_naissance:14:=[HeBerge:4]HB_DateNéLe:5
			[SIAO_Personnes:51]Sp_Genre:10:=[HeBerge:4]HG_Genre:39
			[SIAO_Personnes:51]Sp_Age:15:=Uut_HébergéAgePlus(->[SIAO_Personnes:51]Sp_Date_de_naissance:14; ->[SIAO:50]Si_Demande_Date:2)
		End if 
		SAVE RECORD:C53([SIAO_Personnes:51])
		UNLOAD RECORD:C212([SIAO_Personnes:51])
		READ ONLY:C145([SIAO_Personnes:51])
		
		UNLOAD RECORD:C212([SIAO:50])
		READ ONLY:C145([SIAO:50])
		
	: ($1=8)
		
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Personne_ID:3=$2)
		MultiSoc_Filter(->[SIAO_Personnes:51])
		If (Records in selection:C76([SIAO_Personnes:51])>0)
		Else 
			$va_Cas:=""
			If ([HeberGement:5]HG_DossierSIAO:164>"")
				$va_Cas:=Substring:C12([HeberGement:5]HG_DossierSIAO:164; 1; 1)
			End if 
			//1 INSERTION/2 URGENCE/3 LES DEUX    
			$vb_OK:=($va_Cas="3")
			$vb_OK:=$vb_OK | ($va_Cas="4")
			If ($vb_OK)
				Case of 
					: ($va_Cas="1")
						F_LesSiaoHG(7; 2)
					: ($va_Cas="2")
						F_LesSiaoHG(7; 1)
				End case 
			End if 
		End if 
		
		
End case 