//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_BAL_C
//{
//{          Lundi 26 février 2007 à 18:34:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii; $jj; $vl_Décalage)
C_TIME:C306($h_RefDoc; vh_Réf)
$h_RefDoc:=?00:00:00?

Case of 
		
		
	: ($1=11)  //1er     inactivée
		If (Size of array:C274(tt_TransDocu)>0)
			tt_TransDocu:=1
			P_BAL_B(3)
		Else 
			BEEP:C151
		End if 
	: ($1=10)  //Précédent    inactivée
		If (Size of array:C274(tt_TransDocu)>0)
			If ((tt_TransDocu-1)>=1)
				tt_TransDocu:=tt_TransDocu-1
				P_BAL_B(3)
			Else 
				BEEP:C151
			End if 
		End if 
	: ($1=20)  //Suivant    inactivée
		If (Size of array:C274(tt_TransDocu)>0)
			If ((tt_TransDocu+1)<=Size of array:C274(tt_TransDocu))
				tt_TransDocu:=tt_TransDocu+1
				P_BAL_B(3)
			Else 
				BEEP:C151
			End if 
		End if 
	: ($1=21)  //Last    inactivée
		If (Size of array:C274(tt_TransDocu)>0)
			tt_TransDocu:=Size of array:C274(tt_TransDocu)
			P_BAL_B(3)
		Else 
			BEEP:C151
		End if 
		
	: ($1=30)  //Appeler le process de nouvel hébergement
		<>va_Trans_Cle:=va_DocuCle
		<>va_Trans_Nom:=va_DocuNom
		<>va_Trans_Prenom:=va_DocuPrenom
		<>vd_Trans_Nele:=Date:C102(va_DocuNele)
		<>va_Trans_EtCv:=va_DocuEtCv
		<>vt_Trans_DocuT:=vt_DocuT
		POST OUTSIDE CALL:C329(<>PR_Hébergement)
		
	: ($1=40)  //Appeler le process de nouvel hébergement pour affecter les données
		<>va_MessageAE_HG:=<>va_MessageAE_HGTranfert
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
		
		POST OUTSIDE CALL:C329(<>PR_Hébergement)
		POST OUTSIDE CALL:C329(<>PR_HébergementR)
		
		
		
	: ($1=41)  //Appeler le process de nouvel hébergement pour affecter les données
		BEEP:C151
		If (i_Confirmer("Confirmez-vous le transfert des données ?"))
			If (Size of array:C274(<>te_ConsoT_Ligne)>0)
				
				If (<>vb_FullDuplexDataB)
					$vl_Décalage:=44
				Else 
					$vl_Décalage:=35
				End if 
				For ($ii; 1; Size of array:C274(<>te_ConsoT_Ligne))
					Case of 
						: ($ii=1)
							[HeberGement:5]HG_EtatCivil:20:=<>tt_ConsoT_Valeur{$ii}
						: ($ii=3)
							[HeberGement:5]HG_Trans_FicheNuméro:143:=<>tt_ConsoT_Valeur{$ii}
						: ($ii=4)  //Clé
						: ($ii=5)  //Nom
						: ($ii=6)  //Prénom
						: ($ii=7)  //Date naissance        
						: ($ii=8)  //Age                    
						: ($ii=9)
						: ($ii=10)
						: ($ii=11)  //Note de transfert
							If (<>vb_T_TransTransfert)
								READ WRITE:C146([HeBerge:4])
								QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
								MultiSoc_Filter(->[HeBerge:4])
								If (Records in selection:C76([HeBerge:4])=1)
									Repeat 
										LOAD RECORD:C52([HeBerge:4])
										$jj:=$jj+1
									Until (Not:C34(Locked:C147([HeBerge:4])))
									[HeBerge:4]HB_NotesTrans:53:=<>vt_Trans_DocuT
									SAVE RECORD:C53([HeBerge:4])
								End if 
								UNLOAD RECORD:C212([HeBerge:4])
								READ ONLY:C145([HeBerge:4])
							End if 
						: ($ii=12)  //Réf Hébergement                  
							[HeberGement:5]HG_Trans_RéférenceID:142:=Num:C11(<>tt_ConsoT_Valeur{$ii})
						: ($ii=13)  //Réf Hébergé             
							[HeberGement:5]HG_Trans_HB_ID:144:=Num:C11(<>tt_ConsoT_Valeur{$ii})
						: ($ii=14)  //Réf Centre             
							[HeberGement:5]HG_Trans_LC_ID:145:=Num:C11(<>tt_ConsoT_Valeur{$ii})
						: ($ii=15)  //Nom Centre             
							[HeberGement:5]HG_Trans_CentreNom:146:=<>tt_ConsoT_Valeur{$ii}
						: ($ii=16)
						: ($ii=17)
						: ($ii=32)  //Clé de famille
							//    [HéberGement]HG_Trans_FamClé:=◊tt_ConsoT_Valeur{$ii}
					End case 
					If (<>vb_FullDuplexDataB)
						Case of 
							: ($ii=34)
								[HeberGement:5]HG_Signalement:12:=<>tt_ConsoT_Valeur{$ii}
							: ($ii=35)
								[HeberGement:5]HG_Orientation1:58:=<>tt_ConsoT_Valeur{$ii}
							: ($ii=36)
								[HeberGement:5]HG_Orientation2:60:=<>tt_ConsoT_Valeur{$ii}
							: ($ii=37)
								//   [HéberGement]HG_AutreSolutio:=◊tt_ConsoT_Valeur{$ii}
							: ($ii=38)
								// [HéberGement]HG_Plateforme:=◊tt_ConsoT_Valeur{$ii}
							: ($ii=39)
								[HeberGement:5]HG_FamGroupe:102:=<>tt_ConsoT_Valeur{$ii}
							: ($ii=40)
								//  [HéberGement]HG_FamChef:=(◊tt_ConsoT_Valeur{$ii}="O")
							: ($ii=41)
								// [HéberGement]HG_FamClé:=◊tt_ConsoT_Valeur{$ii}
							: ($ii=42)
								[HeberGement:5]HG_FamCompoVar:117:=<>tt_ConsoT_Valeur{$ii}
						End case 
					End if 
					If ($ii>=$vl_Décalage)
						Case of 
							: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Coordinateur:7))
								[HeberGement:5]HG_Coordinateur:7:=<>tt_ConsoT_Valeur{$ii}
								
							: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Régulateur:8))
								[HeberGement:5]HG_Régulateur:8:=<>tt_ConsoT_Valeur{$ii}
							: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_Permanencier:9))
								[HeberGement:5]HG_Permanencier:9:=<>tt_ConsoT_Valeur{$ii}
								
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
								[HeberGement:5]HG_FamGroupe:102:=<>tt_ConsoT_Valeur{$ii}
							: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_FamChef:103))
								[HeberGement:5]HG_FamChef:103:=(<>tt_ConsoT_Valeur{$ii}="O")
								x1:=Num:C11([HeberGement:5]HG_FamChef:103)
								x2:=Num:C11([HeberGement:5]HG_FamChef:103=False:C215)
								P_HG_FamilleChef(Num:C11(x1=1))
								// [HéberGement]HG_FamCompo:=""
								//  [HéberGement]HG_FamNbPers:=0
								
							: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_FamCasSpéc:111))
								[HeberGement:5]HG_FamCasSpéc:111:=<>tt_ConsoT_Valeur{$ii}
							: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_FamCompo:105))
								[HeberGement:5]HG_FamCompo:105:=<>tt_ConsoT_Valeur{$ii}
								//      [HéberGement]HG_FamCompoVar:=[HéberGement]HG_FamCompo
								//   P_HG_Famille (2)
								
							: (Field:C253(<>te_ConsoT_Table{$ii}; <>te_ConsoT_Champ{$ii})=(->[HeberGement:5]HG_FamNbPers:106))
								[HeberGement:5]HG_FamNbPers:106:=Num:C11(<>tt_ConsoT_Valeur{$ii})
						End case 
					End if 
					
				End for 
				DebutInitTabConso(1; 0)
			End if 
		End if 
		
End case 