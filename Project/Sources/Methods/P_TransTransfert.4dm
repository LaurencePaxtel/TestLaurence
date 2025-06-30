//%attributes = {}

//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_TransTransfert
//{
//{          Lundi 26 février 2007 à 11:35:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}



C_TIME:C306($h_RefDoc)
$h_RefDoc:=?00:00:00?
C_TEXT:C284(vt_NomFic; vt_texte)
C_TEXT:C284($vt_RépCentre; $vt_RépCentreLu; $vt_RépDocu)
C_TEXT:C284($va_Temp)
C_LONGINT:C283($vl_Sel)
C_BOOLEAN:C305($vb_OK)
//◊vt_T_CheminRép:=[SOciété]SO_CheminRépertoire
//◊vt_T_DossierLu:=[SOciété]SO_Dossierlu
//Existance du répértoire Trans

//Tester l'éxistance du répertoire
$vb_OK:=F_Répertoire(<>vt_T_CheminRép)
If ($vb_OK=False:C215)
	ALERT:C41("Veuillez vérifier le chemin d'accès du répertoire de transfert !")
End if 


vd_DtJF:=Current date:C33
vh_HrJF:=Current time:C178
If ($vb_OK)
	For ($ii; 1; Size of array:C274(ta_CTNom))
		$vb_OK:=False:C215
		If (tl_CTSél{$ii}=1)
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tl_CTRéf{$ii})
			If (Records in selection:C76([LesCentres:9])=1)
				va_LC_Nom:=[LesCentres:9]LC_Nom:4
				va_LC_Ad1:=[LesCentres:9]LC_Adr1:24
				va_LC_Ad2:=[LesCentres:9]LC_Adr2:25
				va_LC_CP:=[LesCentres:9]LC_CP:27
				va_LC_Ville:=[LesCentres:9]LC_Ville:28
				va_LC_Tel:=[LesCentres:9]LC_Téléphone:29
				va_LC_Fax:=[LesCentres:9]LC_Télécopie2:31
				va_LC_Pers:=[LesCentres:9]LC_Responsable:32
				va_LC_Dossier:=[LesCentres:9]LC_Répertoire:54
				
				If (va_LC_Dossier>"")
					$vt_RépCentre:=F_RépertoireCréer(<>vt_T_CheminRép+va_LC_Dossier+Séparateur dossier:K24:12; 1)  //!!!!!!!!!!!!!!!!!!!
					If ($vt_RépCentre>"")
						$vt_RépCentreLu:=F_RépertoireCréer(<>vt_T_CheminRép+va_LC_Dossier+Séparateur dossier:K24:12+va_LC_Dossier+" LU"+Séparateur dossier:K24:12; 1)
						$vb_OK:=True:C214
					End if 
				End if 
			End if 
		End if 
		
		If ($vb_OK)
			$vb_OK:=False:C215
			$vl_Fenetre:=i_FenêtreNo(500; 20; 5; ""; 8; "")
			MESSAGE:C88("Centre : "+[LesCentres:9]LC_Nom:4+" - "+[LesCentres:9]LC_Lieu:5+" / Transfert ")
			USE SET:C118("E_Hébergé")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=tl_CTRéf{$ii})
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FamClé:104; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >)
			vl_NbHB:=Records in selection:C76([HeberGement:5])
			If (vl_NbHB>0)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_HG_ID; [HeberGement:5]HG_Date:4; $tl_HG_Date; [HeberGement:5]HG_1_TransHeure:70; $tl_HG_TransHeure)
				$vl_Sel:=0
				For ($jj; 1; vl_NbHB)
					
					If ($tl_HG_TransHeure{$jj}=0)
						$vl_Sel:=$vl_Sel+1
						$vb_OK:=True:C214
					End if 
				End for 
				
				If ($vb_OK)
					READ WRITE:C146([HeberGement:5])
					For ($jj; 1; vl_NbHB)
						If ($tl_HG_TransHeure{$jj}=0)
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=$tl_HG_ID{$jj})
							If (Records in selection:C76([HeberGement:5])=1)
								Repeat 
									LOAD RECORD:C52([HeberGement:5])
								Until (Not:C34(Locked:C147([HeberGement:5])))
								
								vh_HrJF:=Current time:C178
								//•••• Construire le nom du fichier sur disque
								If ($vb_OK)
									$vb_Ok:=F_Report_FullDuplexFichier(->vt_TitreDocument; vd_DtJF; vh_HrJF; <>va_T_Site; [HeberGement:5]HG_FicheNuméro:3; [HeberGement:5]HG_EtatCivil:20; [HeberGement:5]HG_Age:23)
								End if 
								
								
								$h_RefDoc:=Create document:C266($vt_RépCentre+vt_TitreDocument)
								If (OK=1)
									USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
									
									If (<>vb_FullDuplexDataB)
										$vb_Ok:=F_Report_FullDuplexDonnées_B($h_RefDoc; vd_DtJF; vh_HrJF; 8; False:C215)  //8 pour STR de l'Ecran ASILE                  
									Else 
										$vb_Ok:=F_Report_FullDuplexDonnées($h_RefDoc; vd_DtJF; vh_HrJF; 8; False:C215)  //8 pour STR de l'Ecran ASILE                  
									End if 
									If (7=8)
										SEND PACKET:C103($h_RefDoc; <>va_T_Site+", Le "+String:C10(vd_DtJF; Interne date court:K1:7)+" à "+String:C10(vh_HrJF; h mn s:K7:1)+<>va_CR)
										SEND PACKET:C103($h_RefDoc; "Etat civil  :"+<>va_Tab+[HeberGement:5]HG_EtatCivil:20+<>va_CR)
										vt_TitreDocument:=""
										$va_Temp:=""
										QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
										$vt_RépDocu:=[HeBerge:4]HB_NotesTrans:53
										$va_Temp:=[HeBerge:4]HB_Clé:2
										SEND PACKET:C103($h_RefDoc; "Fiche n°"+<>va_Tab+[HeberGement:5]HG_FicheNuméro:3)
										SEND PACKET:C103($h_RefDoc; <>va_CR)
										SEND PACKET:C103($h_RefDoc; "Clé"+<>va_Tab+$va_Temp)
										SEND PACKET:C103($h_RefDoc; <>va_CR)
										SEND PACKET:C103($h_RefDoc; "Nom"+<>va_Tab+[HeBerge:4]HB_Nom:3)
										SEND PACKET:C103($h_RefDoc; <>va_CR)
										SEND PACKET:C103($h_RefDoc; "Prénom"+<>va_Tab+[HeBerge:4]HB_Prénom:4)
										SEND PACKET:C103($h_RefDoc; <>va_CR)
										SEND PACKET:C103($h_RefDoc; "Né(e) le"+<>va_Tab+String:C10([HeBerge:4]HB_DateNéLe:5; Interne date court:K1:7))
										SEND PACKET:C103($h_RefDoc; <>va_CR)
										SEND PACKET:C103($h_RefDoc; "Age"+<>va_Tab+String:C10([HeberGement:5]HG_Age:23; "000"))
										SEND PACKET:C103($h_RefDoc; <>va_CR)
										SEND PACKET:C103($h_RefDoc; "Nuit en cours"+<>va_Tab+String:C10([HeberGement:5]HG_NuitenCours:92))
										SEND PACKET:C103($h_RefDoc; <>va_CR)
										SEND PACKET:C103($h_RefDoc; "Nuits totales"+<>va_Tab+String:C10([HeberGement:5]HG_NuitTOTAL:93))
										SEND PACKET:C103($h_RefDoc; <>va_CR)
										SEND PACKET:C103($h_RefDoc; "</TD>")
										SEND PACKET:C103($h_RefDoc; <>va_CR)
										SEND PACKET:C103($h_RefDoc; <>va_CR)
										$vt_RépDocu:=Replace string:C233($vt_RépDocu; "≤"; "-")
										$vt_RépDocu:=Replace string:C233($vt_RépDocu; Char:C90(13); "≤")
										SEND PACKET:C103($h_RefDoc; $vt_RépDocu)
										SEND PACKET:C103($h_RefDoc; "</TD>")
									End if 
									
									USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
									CLOSE DOCUMENT:C267($h_RefDoc)
									//        [HéberGement]HG_1_TransHeure:=vh_HrJF
									SAVE RECORD:C53([HeberGement:5])
									UNLOAD RECORD:C212([HeberGement:5])
									
								End if 
							End if 
							
						End if 
					End for 
					UNLOAD RECORD:C212([HeberGement:5])
					READ ONLY:C145([HeberGement:5])
					
				End if 
			End if 
		End if 
		
		
	End for 
	
	If (Size of array:C274(ta_CTNom)>0)
		Rec_TransFamille(2; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; ta_CTNom)
	Else 
		Rec_TransFamille(2; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; 0)
	End if 
	
	
	vl_NbHB:=Records in selection:C76([HeberGement:5])
End if 