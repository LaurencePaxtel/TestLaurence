//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_BAL_D
//{
//{          Lundi 26 février 2007 à 18:34:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_BOOLEAN:C305($vb_OK)
C_BOOLEAN:C305($vb_Creation)
C_TIME:C306($h_RefDoc)
$vb_OK:=False:C215
$vb_Creation:=False:C215
Case of 
	: ($1=1)
		i_Message("Acceptation en cours d'enregistrement…")
		//Découpage du contenu du document
		DebutInitTabConso(1; 0)
		If (<>vb_CestUnMac)
			vt_TitreDocument:=vt_RépCentre+tt_TransDocuDisk{tt_TransDocuDisk}
		Else 
			vt_TitreDocument:=vt_RépCentre+tt_TransDocuDisk{tt_TransDocuDisk}+".TXT"
		End if 
		If (Test path name:C476(vt_TitreDocument)=Est un document:K24:1)
			$h_RefDoc:=Open document:C264(vt_TitreDocument)
			If (OK=1)
				
				USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
				//(•Découpage du nom du document Facultatif ici à préciser
				//   $vb_OK:=F_Report_FullDuplexTitre (tt_TransDocuDisk{tt_TransDocuDisk})
				//L'idée est de créer un tableau en mémoire et de l'enregistrer ensuite
				//(•Ligne de titre dans le document
				RECEIVE PACKET:C104($h_RefDoc; <>vt_Buffer; <>va_CR)
				<>vt_Buffer:=Replace string:C233(<>vt_Buffer; <>va_LF; "")
				//(•Découpage du contenu du document
				$vb_OK:=F_Trans_FullDuplexDecoupage($h_RefDoc)
				CLOSE DOCUMENT:C267($h_RefDoc)
				
				USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
			End if 
		End if 
		
		//Clé		
		If (<>vb_Trans_HébergéYaDéja)
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=<>va_Trans_CleAccept)
			MultiSoc_Filter(->[HeBerge:4])
			If (Records in selection:C76([HeBerge:4])=1)
				<>vl_Trans_HébergéRéf:=[HeBerge:4]HB_ReferenceID:1
				$vb_OK:=False:C215
				If (<>vb_Trans_ChefFam)
					If ([HeBerge:4]HB_CléFam:47=<>va_Trans_CleFam)
						<>va_Trans_CleFamCHRS:=[HeBerge:4]HB_CléFam:47
					Else 
						$vb_OK:=True:C214
					End if 
				End if 
				
				
				If (<>vb_T_TransTransfert | $vb_OK)
					READ WRITE:C146([HeBerge:4])
					Repeat 
						IDLE:C311
						LOAD RECORD:C52([HeBerge:4])
					Until (Not:C34(Locked:C147([HeBerge:4])))
					If (<>vb_T_TransTransfert)
						[HeBerge:4]HB_NotesTrans:53:=<>vt_Trans_DocuT
					End if 
					If ($vb_OK)
						<>va_Trans_CleFamCHRS:=[HeBerge:4]HB_CléFam:47
						[HeBerge:4]HB_Trans_CléFam:56:=<>va_Trans_CleFam
					End if 
					SAVE RECORD:C53([HeBerge:4])
					UNLOAD RECORD:C212([HeBerge:4])
					READ ONLY:C145([HeBerge:4])
				End if 
			End if 
			
			If (7=8)  // 23/4/2012 pour importer les données du 115 
				//        et non plus récupérer en partie l'historique
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=<>vl_Trans_HébergéRéf)
				MultiSoc_Filter(->[HeberGement:5])
				If (Records in selection:C76([HeberGement:5])>0)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
					FIRST RECORD:C50([HeberGement:5])
					va_IDT_Typ1:=<>va_Trans_EtCv
					If (F_VariablesTransite(2; 1; False:C215))
					End if 
					$vb_Creation:=False:C215
				Else 
					$vb_Creation:=True:C214
				End if 
			Else 
				$vb_Creation:=True:C214
			End if 
		Else 
			READ WRITE:C146([HeBerge:4])
			CREATE RECORD:C68([HeBerge:4])
			MultiSoc_Init_Structure(->[HeBerge:4])
			[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
			<>vl_Trans_HébergéRéf:=[HeBerge:4]HB_ReferenceID:1
			[HeBerge:4]HB_Clé:2:=<>va_Trans_CleAccept
			[HeBerge:4]HB_Nom:3:=<>va_Trans_Nom
			[HeBerge:4]HB_Prénom:4:=<>va_Trans_Prenom
			[HeBerge:4]HB_DateNéLe:5:=<>vd_Trans_Nele
			[HeBerge:4]HG_Genre:39:=F_EtatCivilGenre(<>va_Trans_EtCv)
			[HeBerge:4]HB_FicheCrééele:46:=Current date:C33
			If (<>vb_T_TransTransfert)
				[HeBerge:4]HB_NotesTrans:53:=<>vt_Trans_DocuT
			End if 
			
			[HeBerge:4]HB_Trans_RéférenceID:55:=Num:C11(<>tt_ConsoT_Valeur{13})
			If (<>vb_Trans_ChefFam)
				[HeBerge:4]HB_CléFam:47:=<>va_Trans_CleFam
				<>va_Trans_CleFamCHRS:=<>va_Trans_CleFam
			End if 
			
			//   [HeBerge]HB_CléFam:=◊va_Trans_CleFam
			//    Si (◊vb_Trans_ChefFam)
			//    [HeBerge]HB_Trans_CléFam:=◊va_Trans_CleFam
			//   Fin de si 
			
			SAVE RECORD:C53([HeBerge:4])
			If (F_VariablesTransite(3; 1; False:C215))
			End if 
			UNLOAD RECORD:C212([HeBerge:4])
			READ ONLY:C145([HeBerge:4])
			$vb_Creation:=True:C214
		End if 
		
		
		
		F_Report_FullDuplexTableau
		
		//Hébergement
		READ WRITE:C146([HeberGement:5])
		CREATE RECORD:C68([HeberGement:5])
		MultiSoc_Init_Structure(->[HeberGement:5])
		[HeberGement:5]HG_FamGroupe:102:=<>va_Trans_Groupe
		[HeberGement:5]HG_Permanencier:9:=Current user:C182
		
		[HeberGement:5]HG_DateCreationFiche:149:=Current date:C33
		[HeberGement:5]HG_DateDuJour:82:=Current date:C33
		[HeberGement:5]HG_ReferenceID:1:=Uut_Numerote(->[HeberGement:5])
		<>vl_Trans_HébergementRéf:=[HeberGement:5]HG_ReferenceID:1
		
		[HeberGement:5]HG_Nuit:2:=False:C215
		[HeberGement:5]HG_Date:4:=Date:C102(<>tt_ConsoT_Valeur{2})
		[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche(<>tt_ConsoT_Valeur{3}[[1]]; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
		[HeberGement:5]HG_HB_ID:19:=<>vl_Trans_HébergéRéf
		
		
		[HeberGement:5]HG_EtatCivil:20:=<>tt_ConsoT_Valeur{1}
		[HeberGement:5]HG_Nom:21:=<>tt_ConsoT_Valeur{5}
		[HeberGement:5]HG_Prénom:22:=<>tt_ConsoT_Valeur{6}
		[HeberGement:5]HG_DateNéLe:24:=Date:C102(<>tt_ConsoT_Valeur{7})
		[HeberGement:5]HG_Age:23:=Num:C11(<>tt_ConsoT_Valeur{8})
		[HeberGement:5]HG_Genre:96:=F_EtatCivilGenre(<>tt_ConsoT_Valeur{1})
		
		[HeberGement:5]HG_NuitenCours:92:=1
		[HeberGement:5]HG_NuitTOTAL:93:=<>ve_Trans_NuitTotal
		
		[HeberGement:5]HG_Réservation:91:=([HeberGement:5]HG_NuitTOTAL:93>1)
		
		[HeberGement:5]HG_Reporté:94:=""
		[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-1
		[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
		
		[HeberGement:5]HG_LC_ID:61:=<>vl_Trans_CentreRéf
		[HeberGement:5]HG_CentreNom:62:=<>va_Trans_CentreNom
		
		
		[HeberGement:5]HG_CentreARR:63:=""
		[HeberGement:5]HG_Priorité:57:=0
		[HeberGement:5]HG_DispoSpé:90:=False:C215
		
		[HeberGement:5]HG_ER_Excuse:124:=False:C215
		[HeberGement:5]HG_ER_NuitEnCours:127:=0
		[HeberGement:5]HG_ER_NuitTotal:128:=0
		[HeberGement:5]HG_ER_NuitReste:129:=0
		
		[HeberGement:5]HG_ER_DateDébut:125:=!00-00-00!
		[HeberGement:5]HG_ER_DateFin:126:=!00-00-00!
		
		[HeberGement:5]HG_ER_Remplaçant:130:=False:C215
		[HeberGement:5]HG_ER_RemplaceQuiRéf:131:=0
		[HeberGement:5]HG_ER_RemplaceQui:132:=""
		
		[HeberGement:5]HG_EnAttente:64:=True:C214
		[HeberGement:5]HG_AttenteHeur:83:=Current time:C178
		[HeberGement:5]HG_Transmis:65:=False:C215
		[HeberGement:5]HG_TransmisHeur:84:=?00:00:00?
		[HeberGement:5]HG_PriseCharge:66:=False:C215
		[HeberGement:5]HG_PrChargeHeur:85:=?00:00:00?
		[HeberGement:5]HG_Cloturée:67:=False:C215
		[HeberGement:5]HG_CloturéeHeur:86:=?00:00:00?
		
		[HeberGement:5]HG_Plateforme:139:=<>tt_ConsoT_Valeur{34}
		[HeberGement:5]HG_Plateforme:139:=<>va_UserPlateforme
		[HeberGement:5]HG_Plateforme:139:=<>va_Trans_Plateforme  //Dermodif
		
		F_Report_FullPlateforme(->[HeberGement:5]HG_Trans_DDASS:141; [HeberGement:5]HG_Plateforme:139)
		
		[HeberGement:5]HG_PlateformeCentre:140:=""
		
		[HeberGement:5]HG_Trans_DDASS:141:=True:C214
		[HeberGement:5]HG_Trans_RéférenceID:142:=Num:C11(<>tt_ConsoT_Valeur{12})
		[HeberGement:5]HG_Trans_FicheNuméro:143:=<>tt_ConsoT_Valeur{3}
		[HeberGement:5]HG_Trans_HB_ID:144:=Num:C11(<>tt_ConsoT_Valeur{13})
		[HeberGement:5]HG_Trans_LC_ID:145:=Num:C11(<>tt_ConsoT_Valeur{14})
		[HeberGement:5]HG_Trans_CentreNom:146:=<>tt_ConsoT_Valeur{15}
		[HeberGement:5]HG_Trans_FamClé:147:=<>va_Trans_CleFam
		[HeberGement:5]HG_Trans_Plateforme:148:=<>tt_ConsoT_Valeur{33}
		
		//35 c'est le debut de la suite
		
		If ($vb_Creation)
			C_LONGINT:C283($ii)
			For ($ii; 1; Size of array:C274(<>te_ConsoT_Ligne))
				Case of 
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Coordinateur:7))
						[HeberGement:5]HG_Coordinateur:7:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Régulateur:8))
						[HeberGement:5]HG_Régulateur:8:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Permanencier:9))
						//`[HéberGement]HG_Permanencier:=◊tt_ConsoT_Valeur{$ii}
						
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Maraude1_1:10))
						[HeberGement:5]HG_Maraude1_1:10:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_DateEntree:186))
						[HeberGement:5]HG_DateEntree:186:=Date:C102(<>tt_ConsoT_Valeur{$ii})
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Maraude2_1:98))
						[HeberGement:5]HG_Maraude2_1:98:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Maraude2_2:99))
						[HeberGement:5]HG_Maraude2_2:99:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Maraude3_1:100))
						[HeberGement:5]HG_Maraude3_1:100:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_DateSortie:185))
						[HeberGement:5]HG_DateSortie:185:=Date:C102(<>tt_ConsoT_Valeur{$ii})
						
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Signalement:12))
						[HeberGement:5]HG_Signalement:12:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_SignalCentre:13))
						[HeberGement:5]HG_SignalCentre:13:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_CodePostal:14))
						[HeberGement:5]HG_CodePostal:14:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Gare:15))
						[HeberGement:5]HG_Gare:15:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Métro:16))
						[HeberGement:5]HG_Métro:16:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Emplacement:17))
						[HeberGement:5]HG_Emplacement:17:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Nationalité:25))
						[HeberGement:5]HG_Nationalité:25:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Lien:18))
						[HeberGement:5]HG_Lien:18:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_LieuNéOù:28))
						[HeberGement:5]HG_LieuNéOù:28:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_SituFamille:29))
						[HeberGement:5]HG_SituFamille:29:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Nationalité:25))
						[HeberGement:5]HG_Nationalité:25:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_PiècesIdté1:31))
						[HeberGement:5]HG_PiècesIdté1:31:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_PiècesIdté2:32))
						[HeberGement:5]HG_PiècesIdté2:32:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_PiècesIdté3:33))
						[HeberGement:5]HG_PiècesIdté3:33:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_TempsErrance:34))
						[HeberGement:5]HG_TempsErrance:34:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_DernierHéber:35))
						[HeberGement:5]HG_DernierHéber:35:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_SituProfess:36))
						[HeberGement:5]HG_SituProfess:36:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_DernierEmplo:37))
						[HeberGement:5]HG_DernierEmplo:37:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_DuréSanEmplo:38))
						[HeberGement:5]HG_DuréSanEmplo:38:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_RupMajeur1:40))
						[HeberGement:5]HG_RupMajeur1:40:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_RupMajeur2:41))
						[HeberGement:5]HG_RupMajeur2:41:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_RupMajeur3:42))
						[HeberGement:5]HG_RupMajeur3:42:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Ressources1:45))
						[HeberGement:5]HG_Ressources1:45:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Ressources2:46))
						[HeberGement:5]HG_Ressources2:46:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Ressources3:47))
						[HeberGement:5]HG_Ressources3:47:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_SuiviSocial1:49))
						[HeberGement:5]HG_SuiviSocial1:49:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_SuiviSocial2:50))
						[HeberGement:5]HG_SuiviSocial2:50:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_SuiviSocial3:51))
						[HeberGement:5]HG_SuiviSocial3:51:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_CouvSocial1:53))
						[HeberGement:5]HG_CouvSocial1:53:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_CouvSocial2:54))
						[HeberGement:5]HG_CouvSocial2:54:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_CouvSocial3:55))
						[HeberGement:5]HG_CouvSocial3:55:=<>tt_ConsoT_Valeur{$ii}
						
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_NiveauEtude:43))
						[HeberGement:5]HG_NiveauEtude:43:=<>tt_ConsoT_Valeur{$ii}
						
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_RupMajeur1_2:72))
						[HeberGement:5]HG_RupMajeur1_2:72:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_RupMajeur2_2:73))
						[HeberGement:5]HG_RupMajeur2_2:73:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_RupMajeur3_2:74))
						[HeberGement:5]HG_RupMajeur3_2:74:=<>tt_ConsoT_Valeur{$ii}
						
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Ressource1_2:75))
						[HeberGement:5]HG_Ressource1_2:75:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Ressource2_2:76))
						[HeberGement:5]HG_Ressource2_2:76:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Ressource3_2:77))
						[HeberGement:5]HG_Ressource3_2:77:=<>tt_ConsoT_Valeur{$ii}
						
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_AssistSocial:87))
						[HeberGement:5]HG_AssistSocial:87:=<>tt_ConsoT_Valeur{$ii}
						
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Orientation1:58))
						[HeberGement:5]HG_Orientation1:58:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Orientation2:60))
						[HeberGement:5]HG_Orientation2:60:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_AutreSolutio:88))
						[HeberGement:5]HG_AutreSolutio:88:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_AutreSolSuite:123))
						[HeberGement:5]HG_AutreSolSuite:123:=<>tt_ConsoT_Valeur{$ii}
						
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_FamGroupe:102))
						//[HéberGement]HG_FamGroupe:=◊tt_ConsoT_Valeur{$ii}
						
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_FamChef:103))
						[HeberGement:5]HG_FamChef:103:=(<>tt_ConsoT_Valeur{$ii}="O")
						x1:=Num:C11([HeberGement:5]HG_FamChef:103)
						x2:=Num:C11([HeberGement:5]HG_FamChef:103=False:C215)
						[HeberGement:5]HG_FamClé:104:=<>va_Trans_CleFamCHRS  //`23/12/2012  
						
						
						If (7=8)  //23/12/2012  
							If (7=8)  //16/12/2012  
								va_Identité:=[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22
								P_HG_FamilleChef(Num:C11(x1=1))
								// [HéberGement]HG_FamCompo:=""
								//  [HéberGement]HG_FamNbPers:=0
								If ([HeberGement:5]HG_FamChef:103=False:C215)
									If (<>va_Trans_CleFam>"")
										QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Trans_CléFam:56=<>va_Trans_CleFam)
										MultiSoc_Filter(->[HeBerge:4])
										If (Records in selection:C76([HeBerge:4])=1)
											[HeberGement:5]HG_FamClé:104:=[HeBerge:4]HB_CléFam:47
											[HeberGement:5]HG_Trans_FamClé:147:=<>va_Trans_CleFam
										End if 
									End if 
								End if 
							Else 
								[HeberGement:5]HG_FamClé:104:=<>va_Trans_CleFam
								If ([HeberGement:5]HG_FamClé:104>"")
									QUERY:C277([HeBerge:4]; [HeBerge:4]HB_CléFam:47=[HeberGement:5]HG_FamClé:104)
									MultiSoc_Filter(->[HeBerge:4])
									If (Records in selection:C76([HeBerge:4])=1)
									Else 
										QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Trans_CléFam:56=[HeberGement:5]HG_FamClé:104)
										MultiSoc_Filter(->[HeBerge:4])
										If (Records in selection:C76([HeBerge:4])=1)
											[HeberGement:5]HG_FamClé:104:=[HeBerge:4]HB_CléFam:47
										End if 
									End if 
								End if 
								
							End if 
						End if 
						
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_FamCasSpéc:111))
						[HeberGement:5]HG_FamCasSpéc:111:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_FamCompo:105))
						[HeberGement:5]HG_FamCompo:105:=<>tt_ConsoT_Valeur{$ii}
						//      [HéberGement]HG_FamCompoVar:=[HéberGement]HG_FamCompo
						//   P_HG_Famille (2)
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_FamNbPers:106))
						[HeberGement:5]HG_FamNbPers:106:=Num:C11(<>tt_ConsoT_Valeur{$ii})
						
						
						//23/4/2012
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Flag_DAHO:156))
						[HeberGement:5]HG_Flag_DAHO:156:=(<>tt_ConsoT_Valeur{$ii}="O")
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Flag_FemViolence:157))
						[HeberGement:5]HG_Flag_FemViolence:157:=(<>tt_ConsoT_Valeur{$ii}="O")
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Flag_CapaciteAcces:158))
						[HeberGement:5]HG_Flag_CapaciteAcces:158:=(<>tt_ConsoT_Valeur{$ii}="O")
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Flag_LogAutonome:159))
						[HeberGement:5]HG_Flag_LogAutonome:159:=(<>tt_ConsoT_Valeur{$ii}="O")
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Flag_Souhait:160))
						[HeberGement:5]HG_Flag_Souhait:160:=(<>tt_ConsoT_Valeur{$ii}="O")
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Flag_OrientCorrespondant:161))
						[HeberGement:5]HG_Flag_OrientCorrespondant:161:=(<>tt_ConsoT_Valeur{$ii}="O")
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Flag_RefusParStructure:162))
						[HeberGement:5]HG_Flag_RefusParStructure:162:=(<>tt_ConsoT_Valeur{$ii}="O")
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Flag_RefusParDemandeur:163))
						[HeberGement:5]HG_Flag_RefusParDemandeur:163:=(<>tt_ConsoT_Valeur{$ii}="O")
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_DossierSIAO:164))
						[HeberGement:5]HG_DossierSIAO:164:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Type_Demande:165))
						[HeberGement:5]HG_Type_Demande:165:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Type_Prescripteur:166))
						[HeberGement:5]HG_Type_Prescripteur:166:=<>tt_ConsoT_Valeur{$ii}
					: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Type_de_Place:167))
						[HeberGement:5]HG_Type_de_Place:167:=<>tt_ConsoT_Valeur{$ii}
						
						
						
				End case 
				
				
				
				
			End for 
		Else 
			//AFFECTATION DES CHAMPS
			//Affectation des champs (dans le cas d'un nvle hébegement avec historique)
			//F_VariablesTransite (4;1;Faux))
			
			[HeberGement:5]HG_LienParenté:26:=vl_IDT_Lier
			
			[HeberGement:5]HG_Orientation2:60:=va_IDT_Or2
			
			
			[HeberGement:5]HG_AssistSocial:87:=va_IDT_AsSo
			[HeberGement:5]HG_Nationalité:25:=va_IDT_Nat
			[HeberGement:5]HG_CodePostal:14:=va_IDT_CP
			[HeberGement:5]HG_Gare:15:=va_IDT_Gare
			[HeberGement:5]HG_Métro:16:=va_IDT_Metr
			
			[HeberGement:5]HG_Signalement:12:=va_IDT_SG
			[HeberGement:5]HG_SignalCentre:13:=va_IDT_SGct
			//FIN Affectation dans tous les cas le 12/1/2009
			//10/1/2008
			[HeberGement:5]HG_Plateforme:139:=va_IDT_Plateforme
			//FIN 10/1/2008
			//4/11/2008 et le 26/11/2008
			[HeberGement:5]HG_PlateformeCentre:140:=va_IDT_PlateformeCentre
			[HeberGement:5]HG_Trans_DDASS:141:=vb_IDT_TransDDASS
			[HeberGement:5]HG_Trans_RéférenceID:142:=vl_IDT_TransRéf
			[HeberGement:5]HG_Trans_FicheNuméro:143:=va_IDT_TransFiche
			[HeberGement:5]HG_Trans_HB_ID:144:=vl_IDT_Trans_HBID
			[HeberGement:5]HG_Trans_LC_ID:145:=vl_IDT_Trans_CLD
			[HeberGement:5]HG_Trans_CentreNom:146:=va_IDT_TransCentre
			[HeberGement:5]HG_Trans_FamClé:147:=va_IDT_TransFamClé
			[HeberGement:5]HG_Trans_Plateforme:148:=va_IDT_TransPlateforme
			//FIN 4/11/2008
			[HeberGement:5]HG_Emplacement:17:=va_IDT_Emp
			[HeberGement:5]HG_Lien:18:=va_IDT_Lien
			[HeberGement:5]HG_SituFamille:29:=va_IDT_SitF
			[HeberGement:5]HG_DernierHéber:35:=va_IDT_DerH
			[HeberGement:5]HG_TempsErrance:34:=va_IDT_TpEr
			
			[HeberGement:5]HG_SituProfess:36:=va_IDT_SitP
			// [HéberGement]HG_DernierEmplo:=◊va_Dup_DSEmpLib `4/12/2008
			[HeberGement:5]HG_DernierEmplo:37:=va_IDT_DerE
			
			[HeberGement:5]HG_NiveauEtude:43:=va_IDT_NivE
			
			[HeberGement:5]HG_PiècesIdté1:31:=va_IDT_Pt1
			[HeberGement:5]HG_PiècesIdté2:32:=va_IDT_Pt2
			[HeberGement:5]HG_PiècesIdté3:33:=va_IDT_Pt3
			
			[HeberGement:5]HG_SuiviSocial1:49:=va_IDT_Sv1
			[HeberGement:5]HG_SuiviSocial2:50:=va_IDT_Sv2
			[HeberGement:5]HG_SuiviSocial3:51:=va_IDT_Sv3
			
			[HeberGement:5]HG_CouvSocial1:53:=va_IDT_Cv1
			[HeberGement:5]HG_CouvSocial2:54:=va_IDT_Cv2
			[HeberGement:5]HG_CouvSocial3:55:=va_IDT_Cv3
			
			[HeberGement:5]HG_RupMajeur1:40:=va_IDT_RM1
			[HeberGement:5]HG_RupMajeur2:41:=va_IDT_RM2
			[HeberGement:5]HG_RupMajeur3:42:=va_IDT_RM3
			[HeberGement:5]HG_RupMajeur1_2:72:=va_IDT_RM11
			[HeberGement:5]HG_RupMajeur2_2:73:=va_IDT_RM21
			[HeberGement:5]HG_RupMajeur3_2:74:=va_IDT_RM31
			
			[HeberGement:5]HG_Ressources1:45:=va_IDT_RA1
			[HeberGement:5]HG_Ressources2:46:=va_IDT_RA2
			[HeberGement:5]HG_Ressources3:47:=va_IDT_RA3
			[HeberGement:5]HG_Ressource1_2:75:=va_IDT_RA11
			[HeberGement:5]HG_Ressource2_2:76:=va_IDT_RA21
			[HeberGement:5]HG_Ressource3_2:77:=va_IDT_RA31
			
			[HeberGement:5]HG_Status:89:=(ve_IDT_St=1)
			
			[HeberGement:5]HG_Maraude1_1:10:=va_IDT_Mar  //Placé le 23/2/2009
			
			//================================
			// Added by: Kevin HASSAL (15/02/2020)
			//================================
			
			[HeberGement:5]HG_DateEntree:186:=va_IDT_Mar_1_2
			[HeberGement:5]HG_Maraude2_1:98:=va_IDT_Mar_2_1
			[HeberGement:5]HG_Maraude2_2:99:=va_IDT_Mar_2_2
			[HeberGement:5]HG_Maraude3_1:100:=va_IDT_Mar_3_1
			[HeberGement:5]HG_DateSortie:185:=va_IDT_Mar_3_2
			
			[HeberGement:5]HG_Coordinateur:7:=va_IDT_Coo
			[HeberGement:5]HG_Régulateur:8:=va_IDT_Rég
			[HeberGement:5]HG_Permanencier:9:=va_IDT_Per
			[HeberGement:5]HG_Orientation1:58:=va_IDT_Or1
			[HeberGement:5]HG_Orientation1Suite:59:=va_IDT_Or1Suite
			//================================
			
			[HeberGement:5]HG_DuréSanEmplo:38:=va_IDT_DurE
			
			[HeberGement:5]HG_FamChef:103:=vb_IDT_FRes
			[HeberGement:5]HG_FamClé:104:=va_IDT_Ffam
			[HeberGement:5]HG_FamCompo:105:=va_IDT_FCom
			[HeberGement:5]HG_FamNbPers:106:=ve_IDT_FPer
			
			
			[HeberGement:5]HG_FamCompo:105:=va_IDT_FCom
			[HeberGement:5]HG_FamCompoVar:117:=va_IDT_Fvar
			//24/01/2005
			[HeberGement:5]HG_FamDistri1:112:=""  //va_IDT_FDi1
			[HeberGement:5]HG_FamDistri2:113:=""  //va_IDT_FDi2
			[HeberGement:5]HG_FamDistri3:114:=""  //va_IDT_FDi3
			[HeberGement:5]HG_FamDistri4:115:=""  //va_IDT_FDi4
			[HeberGement:5]HG_FamDistri5:116:=""  //va_IDT_FDi5
			//fin 26/01/2004
			[HeberGement:5]HG_FamCasSpéc:111:=va_IDT_FCSp
			//26/01/2004 puis annulé le 24/01/2005
			[HeberGement:5]HG_FamDistri1M:118:=0  //vr_IDT_FDi1
			[HeberGement:5]HG_FamDistri2M:119:=0  //vr_IDT_FDi2
			[HeberGement:5]HG_FamDistri3M:120:=0  //vr_IDT_FDi3
			[HeberGement:5]HG_FamDistri4M:121:=0  //vr_IDT_FDi4
			[HeberGement:5]HG_FamDistri5M:122:=0  //vr_IDT_FDi5
			//fin 26/01/2004
			//fin 24/01/2005
			[HeberGement:5]HG_GestionCentreNuit:133:=va_IDT_CtrJN
		End if 
		
		[HeberGement:5]HG_Cloturée:67:=True:C214
		P_BoolHeureCommute(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
		[HeberGement:5]HG_EnAttente:64:=False:C215
		P_ReportFlux("J"; 1)
		
		P_HébergementRubNR(<>vlSTR_Std-<>vlSTR)
		
		//  $vb_OK:=[HéberGement]HG_Cloturée
		$vb_OK:=([HeberGement:5]HG_Nuit:2=False:C215)  //Modifié le 3/2/2009 avant c'était clôturé
		$vb_OK:=$vb_OK & [HeberGement:5]HG_Trans_DDASS:141
		If (<>vb_T_Fiches115)
			$vb_OK:=$vb_OK & ([HeberGement:5]HG_Trans_FicheNuméro:143="")  //25/5/2011 (c'est pas une fiche 115)
		End if 
		If ($vb_OK)
			F_Report_FullReporté(->tl_Trans_Réf_HG; [HeberGement:5]HG_ReferenceID:1)
		End if 
		
		[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
		
		SAVE RECORD:C53([HeberGement:5])
		UNLOAD RECORD:C212([HeberGement:5])
		READ ONLY:C145([HeberGement:5])
		
		
		
		//•Est ce une base CHRS  et y a til des fiches reportées
		$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Tranfert ")
		F_Report_FullDuplexTableau
		
		CLOSE WINDOW:C154
		P_BAL_E(1)
		P_BAL_B(1)
		FORM GOTO PAGE:C247(1)
	: ($1=2)
		
End case 

