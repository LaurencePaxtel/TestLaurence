//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Attestations
//{
//{          Mardi 24 juin 2008 à 16:43:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)

C_TEXT:C284($T_Path_Folder_attestations; $T_Selecteur)
C_POINTER:C301($P_Pop)

$T_Selecteur:=$1
$P_Pop:=OBJECT Get pointer:C1124

// Modified by: Scanu Rémy - remy@connect-io.fr (17/02/2021)
// Prise en compte d'un répertoire unique pour chaque structure
$T_Path_Folder_attestations:=Get 4D folder:C485(Dossier Resources courant:K5:16)+"Attestations"+Séparateur dossier:K24:12+<>ref_soc_active+Séparateur dossier:K24:12

//Si (Tester chemin acces($T_Path_Folder_attestations)#Est un dossier)
//CRÉER DOSSIER($T_Path_Folder_attestations;*)
//Fin de si 
outilsManageFolder(1; $T_Path_Folder_attestations; True:C214)

Case of 
	: ($T_Selecteur="init")
		// construction du pop up
		C_LONGINT:C283($i)
		ARRAY TEXT:C222($rT_Documents; 0)
		
		DOCUMENT LIST:C474($T_Path_Folder_attestations; $rT_Documents)
		
		$i:=Size of array:C274($rT_Documents)
		
		If ($i>0)
			
			Repeat 
				
				If ($rT_Documents{$i}="ssp@")
					DELETE FROM ARRAY:C228($rT_Documents; $i; 1)
				End if 
				
				$i:=$i-1
			Until ($i=0)
			
		End if 
		
		COPY ARRAY:C226($rT_Documents; $P_Pop->)
	: ($T_Selecteur="attestation")
		C_TEXT:C284($T_CRLF; $T_Tab; $T_Path_modele_Attestation)
		
		$T_CRLF:=Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40)
		$T_Tab:=Char:C90(Tabulation:K15:37)
		
		$T_Path_modele_Attestation:=$P_Pop->{$P_Pop->}  // on a fait un choix  // #REW20170428-1
		
		If (Length:C16($T_Path_modele_Attestation)=0)
			$L_MyError:=-2
		Else 
			
			If ($T_Path_Folder_attestations[[Length:C16($T_Path_Folder_attestations)]]=Séparateur dossier:K24:12)
				$T_Path_modele_Attestation:=$T_Path_Folder_attestations+$T_Path_modele_Attestation
			Else 
				$T_Path_modele_Attestation:=$T_Path_Folder_attestations+Séparateur dossier:K24:12+$T_Path_modele_Attestation
			End if 
			
			If (Test path name:C476($T_Path_modele_Attestation)#Est un document:K24:1)
				
				ALERT:C41($T_Path_modele_Attestation+"\rDocument introuvable")
			Else 
				C_TEXT:C284($T_Path_DocumentFusion; $T_MaLigneTitre)
				
				$T_Path_DocumentFusion:=$T_Path_Folder_attestations+"SSPFUSE.TXT"
				
				If (Test path name:C476($T_Path_DocumentFusion)=Est un document:K24:1)
					DELETE DOCUMENT:C159($T_Path_DocumentFusion)
				End if 
				
				$T_MaLigneTitre:="Civilité"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"Nom"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"Prénom"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"Date de naissance"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"Participation"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"Participation montant"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"Centre"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"Adresse1"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"Adresse2"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"Code postal"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"Ville"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"SP1"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"SP2"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"SP3"
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"SP4"
				
				C_LONGINT:C283($i)
				
				For ($i; 1; 6)
					$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"CF"+String:C10($i)+"Civilité"
					$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"CF"+String:C10($i)+"Nom"
					$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"CF"+String:C10($i)+"Prénom"
					$T_MaLigneTitre:=$T_MaLigneTitre+$T_Tab+"CF"+String:C10($i)+"Date de naissance"
				End for 
				
				$T_MaLigneTitre:=$T_MaLigneTitre+$T_CRLF
				
				C_TEXT:C284($T_MaLigne)
				
				$T_MaLigne:=("Monsieur"*Num:C11([HeBerge:4]HG_Genre:39=False:C215))+("Madame"*Num:C11([HeBerge:4]HG_Genre:39=True:C214))
				$T_MaLigne:=$T_MaLigne+$T_Tab+[HeBerge:4]HB_Nom:3
				$T_MaLigne:=$T_MaLigne+$T_Tab+[HeBerge:4]HB_Prénom:4
				$T_MaLigne:=$T_MaLigne+$T_Tab+String:C10([HeBerge:4]HB_DateNéLe:5; Interne date court:K1:7)
				
				C_TEXT:C284($T_KeyFam)
				
				If ([HeBerge:4]HB_CléFam:47>"")  // #Fix20170428-1  nom de la table était sans crochet
					$T_KeyFam:=[HeBerge:4]HB_CléFam:47
				Else 
					$T_KeyFam:=""
				End if 
				
				C_LONGINT:C283($L_KeySelection)
				
				$L_KeySelection:=[HeBerge:4]HB_ReferenceID:1
				
				C_TEXT:C284($T_SP1; $T_SP2; $T_SP3; $T_SP4)
				
				$T_SP1:=[HeBerge:4]HB_PièceNéOu:57
				$T_SP2:=[HeBerge:4]HB_PièceNationalité:58
				$T_SP3:=[HeBerge:4]HB_PièceCNI:59
				$T_SP4:=[HeBerge:4]HB_PiècePasseport:60
				
				
				C_TEXT:C284($T_MaLigneCentre)
				$T_MaLigneCentre:=""
				
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$L_KeySelection; *)  // #REW20170428-1
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
				
				MultiSoc_Filter(->[HeberGement:5])
				
				C_TEXT:C284($T_ParticipationLib; $T_Participation)
				If (Records in selection:C76([HeberGement:5])>0)
					
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
					
					C_LONGINT:C283($L_KeyCentre)
					$L_KeyCentre:=[HeberGement:5]HG_LC_ID:61
					C_DATE:C307($D_DateSelection; $D_DateSelectionD)
					$D_DateSelection:=[HeberGement:5]HG_Date:4
					$D_DateSelectionD:=Add to date:C393($D_DateSelection; 0; -1; 0)
					
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4>=$D_DateSelectionD; *)
					QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$D_DateSelection; *)
					QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_FamDistri5:116#"")  // #REW20170428-1 ajout du &
					
					MultiSoc_Filter(->[HeberGement:5])
					
					$T_ParticipationLib:=""
					$T_Participation:=""
					If (Records in selection:C76([HeberGement:5])>0)
						ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
						ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
						
						$T_ParticipationLib:=[HeberGement:5]HG_FamDistri5:116
						
						If ([HeberGement:5]HG_FamDistri5M:122>0)
							$T_Participation:=String:C10([HeberGement:5]HG_FamDistri5M:122)
						End if 
					End if 
					
					QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=$L_KeyCentre)
					MultiSoc_Filter(->[LesCentres:9])
					If (Records in selection:C76([LesCentres:9])=1)
						$T_MaLigneCentre:=[LesCentres:9]LC_Adr1:24
						$T_MaLigneCentre:=$T_MaLigneCentre+$T_Tab+[LesCentres:9]LC_Adr2:25
						$T_MaLigneCentre:=$T_MaLigneCentre+$T_Tab+[LesCentres:9]LC_Adr3:26
						$T_MaLigneCentre:=$T_MaLigneCentre+$T_Tab+[LesCentres:9]LC_CP:27
						$T_MaLigneCentre:=$T_MaLigneCentre+$T_Tab+[LesCentres:9]LC_Ville:28
					End if 
				End if 
				$T_MaLigne:=$T_MaLigne+$T_Tab+$T_ParticipationLib
				$T_MaLigne:=$T_MaLigne+$T_Tab+$T_Participation
				
				If ($T_MaLigneCentre="")
					$T_MaLigneCentre:=$T_MaLigneCentre+$T_Tab
					$T_MaLigneCentre:=$T_MaLigneCentre+$T_Tab
					$T_MaLigneCentre:=$T_MaLigneCentre+$T_Tab
					$T_MaLigneCentre:=$T_MaLigneCentre+$T_Tab
				End if 
				
				$T_MaLigne:=$T_MaLigne+$T_Tab+$T_MaLigneCentre
				$T_MaLigne:=$T_MaLigne+$T_Tab+$T_SP1
				$T_MaLigne:=$T_MaLigne+$T_Tab+$T_SP2
				$T_MaLigne:=$T_MaLigne+$T_Tab+$T_SP3
				$T_MaLigne:=$T_MaLigne+$T_Tab+$T_SP4
				
				
				C_LONGINT:C283($j)
				$j:=0
				
				If ($T_KeyFam#"")
					QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FamClé:104=$T_KeyFam)
					MultiSoc_Filter(->[HeberGement:5])
					
					If (Records in selection:C76([HeberGement:5])>0)
						
						ARRAY LONGINT:C221($rL_Heberge; 0)
						SELECTION TO ARRAY:C260([HeberGement:5]HG_HB_ID:19; $rL_Heberge)
						QUERY WITH ARRAY:C644([HeBerge:4]HB_ReferenceID:1; $rL_Heberge)
						
						If (Records in selection:C76([HeBerge:4])>0)
							ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_DateNéLe:5; >)
							
							Repeat 
								If ([HeBerge:4]HB_ReferenceID:1#$L_KeySelection)
									$j:=$j+1
									$T_MaLigne:=$T_MaLigne+$T_Tab+("Monsieur"*Num:C11([HeBerge:4]HG_Genre:39=False:C215))+("Madame"*Num:C11([HeBerge:4]HG_Genre:39=True:C214))
									$T_MaLigne:=$T_MaLigne+$T_Tab+[HeBerge:4]HB_Nom:3
									$T_MaLigne:=$T_MaLigne+$T_Tab+[HeBerge:4]HB_Prénom:4
									$T_MaLigne:=$T_MaLigne+$T_Tab+String:C10([HeBerge:4]HB_DateNéLe:5; Interne date court:K1:7)
								End if 
								NEXT RECORD:C51([HeBerge:4])
							Until (End selection:C36([HeBerge:4]))
						End if 
					End if 
				End if 
				
				If ($j<6)
					For ($i; 1; (6-$j))
						$T_MaLigne:=$T_MaLigne+$T_Tab
						$T_MaLigne:=$T_MaLigne+$T_Tab
						$T_MaLigne:=$T_MaLigne+$T_Tab
						$T_MaLigne:=$T_MaLigne+$T_Tab
					End for 
				End if 
				
				$T_MaLigne:=$T_MaLigne+$T_CRLF
				
				
				C_TIME:C306($H_Doc)
				$H_Doc:=Create document:C266($T_Path_DocumentFusion)
				If (OK=1)
					SEND PACKET:C103($H_Doc; $T_MaLigneTitre+$T_MaLigne)  // #REW20170428-1
					CLOSE DOCUMENT:C267($H_Doc)
					
					C_LONGINT:C283($L_Erreur)
					C_TEXT:C284($T_Message)
					$L_Erreur:=LPE_Ouvrir_document($T_Path_modele_Attestation; ->$T_Message)
					If ($L_Erreur#1)
						$L_MyError:=-3
					End if 
					
					
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$L_KeySelection)
					MultiSoc_Filter(->[HeBerge:4])
					
					If ([HeBerge:4]HB_ReferenceID:1>0)
						va_NNN:=F_AfficheCléHébergé
						Rec_Hébergements1(->vL_Nb_HG_F)
						P_HébergementNotesBt(1)
					Else 
						REDUCE SELECTION:C351([HeberGement:5]; 0)
						vL_Nb_HG_F:=0
						va_NNN:=""
						P_HébergementNotesBt(0)
						OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
					End if 
					
				End if 
				
			End if 
			
		End if 
		
End case 