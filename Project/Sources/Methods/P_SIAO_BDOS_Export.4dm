//%attributes = {}
// Ancienne et première version
C_DATE:C307($1)
C_DATE:C307($2)
C_LONGINT:C283($ii; $jj; $vl_Dossiers; $vl_fiche)
C_TIME:C306($vh_RefDoc)
C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($va_SepChamp; $va_SepFICHE)
$va_SepCHAMP:=Char:C90(126)
$va_SepFICHE:=Char:C90(13)
$vl_Dossiers:=Records in selection:C76([SIAO:50])
$vb_OK:=($vl_Dossiers>0)
If ($vb_OK)
	$vb_OK:=i_Confirmer("Confirmez-vous l'export BDOS  de "+String:C10($vl_Dossiers; "### ### ##0")+" dossier"+("s"*Num:C11($vl_Dossiers>1))+" ?")
	If ($vb_OK)
		$vb_OK:=i_Confirmer("Confirmez-vous l'export BDOS  de "+String:C10($vl_Dossiers; "### ### ##0")+" dossier"+("s"*Num:C11($vl_Dossiers>1))+" ?"+Char:C90(13)+"Seconde confirmation ?")
	End if 
Else 
	ALERT:C41("Aucun dossier SIAO !")
End if 

If ($vb_OK)
	<>vt_BDOS_DOSSIER:=Select folder:C670("Veuillez sélectioner le dossier destinataire des fichiers BDOS .")
	If (OK=1)
		i_Message("  Export BDOS  en cours ")
		For ($ii; 1; Size of array:C274(<>ta_BDOS_FichierNom))
			//Charger la définition de la structure à exporter
			$vb_OK:=F_BDOS_Tables(<>ta_BDOS_FichierCode{$ii}; ""; 0)
			//Nom que le ficher aura sur le disque
			<>va_BDOS_FichierNom:=F_BDOS_Fichier($ii)
			i_MessageSeul("  Export BDOS  en cours : "+<>ta_BDOS_FichierNom{$ii})
			//Création du document sur disque ou fichier
			$vh_RefDoc:=Create document:C266(<>vt_BDOS_DOSSIER+<>va_BDOS_FichierNom)
			If (OK=1)
				USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
				
				<>vt_BDOS_VALEUR:=""
				//•• 1 ere ligne
				For ($jj; 1; Size of array:C274(<>ta_BDOS_ChampNom))
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>ta_BDOS_ChampNom{$jj}+$va_SepCHAMP
				End for 
				<>vt_BDOS_VALEUR:=Substring:C12(<>vt_BDOS_VALEUR; 1; Length:C16(<>vt_BDOS_VALEUR)-1)
				<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+$va_SepFICHE
				SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
				Case of 
					: ($ii=1)  //• SIA
						FIRST RECORD:C50([SIAO:50])
						<>vt_BDOS_VALEUR:=""
						$vl_fiche:=0
						Repeat 
							$vl_fiche:=$vl_fiche+1
							i_MessageSeul("  Export BDOS  en cours : "+<>ta_BDOS_FichierNom{$ii}+" <> "+String:C10($vl_fiche)+""+String:C10($vl_Dossiers))
							
							<>vt_BDOS_VALEUR:=F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[SIAO:50]Si_RéférenceID:1)+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[SIAO:50]Si_Demande_Date:2)+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[SIAO:50]Si_Demande_Etat_modifié_le:13)+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+[SIAO:50]Si_Demande_Numero:3+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_CodePostal+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_InseeCode+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_Ville+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_TerritoireCode+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_TerritoireLibelle+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_Departement+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_DepartementLibelle+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_RegionCode+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_RegionLibelle+$va_SepCHAMP
							<>vt_BDOS_VALEUR:=Substring:C12(<>vt_BDOS_VALEUR; 1; Length:C16(<>vt_BDOS_VALEUR)-1)
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+$va_SepFICHE
							SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
							
							NEXT RECORD:C51([SIAO:50])
						Until (End selection:C36([SIAO:50]))
						
					: ($ii=2)  //• DEMANDEUR            
						FIRST RECORD:C50([SIAO:50])
						<>vt_BDOS_VALEUR:=""
						$vl_fiche:=0
						Repeat 
							$vl_fiche:=$vl_fiche+1
							i_MessageSeul("  Export BDOS  en cours : "+<>ta_BDOS_FichierNom{$ii}+" <> "+String:C10($vl_fiche)+""+String:C10($vl_Dossiers))
							
							QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
							If (Records in selection:C76([SIAO_Personnes:51])>0)
								ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >)
								FIRST RECORD:C50([SIAO_Personnes:51])
								Repeat 
									<>vt_BDOS_VALEUR:=F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[SIAO_Personnes:51]Sp_Personne_ID:3)+$va_SepCHAMP
									<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[SIAO_Personnes:51]Sp_SIAO_ID:2)+$va_SepCHAMP
									<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[SIAO:50]Si_Demande_Date:2)+$va_SepCHAMP
									<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[SIAO:50]Si_Demande_Etat_modifié_le:13)+$va_SepCHAMP
									<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+""+$va_SepCHAMP  //NUMERO IDENTIFICATION
									<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[SIAO_Personnes:51]Sp_Date_de_naissance:14)+$va_SepCHAMP
									<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->[SIAO_Personnes:51]Sp_Genre:10)+$va_SepCHAMP
									
									QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=$1; *)
									QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$2; *)
									QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[SIAO_Personnes:51]Sp_Personne_ID:3)
									MultiSoc_Filter(->[HeberGement:5])
									If (Records in selection:C76([HeberGement:5])>0)
										ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+[HeberGement:5]HG_EtatCivil:20+$va_SepCHAMP
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->[HeberGement:5]HG_Flag_DAHO:156)+$va_SepCHAMP
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->[HeberGement:5]HG_Flag_DAHO:156)+$va_SepCHAMP
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+[HeberGement:5]HG_DernierHéber:35+$va_SepCHAMP
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->[HeberGement:5]HG_Flag_CapaciteAcces:158)+$va_SepCHAMP
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->[HeberGement:5]HG_Flag_LogAutonome:159)+$va_SepCHAMP
									Else 
										vb_OKFalse:=False:C215
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+""+$va_SepCHAMP
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->vb_OKFalse)+$va_SepCHAMP
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->vb_OKFalse)+$va_SepCHAMP
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->vb_OKFalse)+$va_SepCHAMP
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->vb_OKFalse)+$va_SepCHAMP
										<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->vb_OKFalse)+$va_SepCHAMP
									End if 
									<>vt_BDOS_VALEUR:=Substring:C12(<>vt_BDOS_VALEUR; 1; Length:C16(<>vt_BDOS_VALEUR)-1)
									<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+$va_SepFICHE
									SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
									NEXT RECORD:C51([SIAO_Personnes:51])
								Until (End selection:C36([SIAO_Personnes:51]))
							End if 
							NEXT RECORD:C51([SIAO:50])
						Until (End selection:C36([SIAO:50]))
						
					: ($ii=3)  //• DEMANDES     
						FIRST RECORD:C50([SIAO:50])
						<>vt_BDOS_VALEUR:=""
						$vl_fiche:=0
						Repeat 
							$vl_fiche:=$vl_fiche+1
							i_MessageSeul("  Export BDOS  en cours : "+<>ta_BDOS_FichierNom{$ii}+" <> "+String:C10($vl_fiche)+""+String:C10($vl_Dossiers))
							
							QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
							If (Records in selection:C76([SIAO_Personnes:51])>0)
								ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >)
								FIRST RECORD:C50([SIAO_Personnes:51])
								Repeat 
									QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=$1; *)
									QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$2; *)
									QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[SIAO_Personnes:51]Sp_Personne_ID:3)
									MultiSoc_Filter(->[HeberGement:5])
									If (Records in selection:C76([HeberGement:5])>0)
										ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >)
										FIRST RECORD:C50([HeberGement:5])
										Repeat 
											<>vt_BDOS_VALEUR:=F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_ReferenceID:1)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[SIAO_Personnes:51]Sp_Personne_ID:3)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+""+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[SIAO_Personnes:51]Sp_SIAO_ID:2)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[HeberGement:5]HG_Date:4)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[HeberGement:5]HG_Date:4)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[HeberGement:5]HG_Date:4)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("TypeSIAO"; ->[SIAO:50]Si_Trans_Type:34)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+[HeberGement:5]HG_NiveauEtude:43+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+"0"+$va_SepCHAMP  //DAMISSION DIRECTE
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("TypePlace"; ->[HeberGement:5]HG_CentreNom:62)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->[HeberGement:5]HG_Flag_Souhait:160)+$va_SepCHAMP
											
											<>vt_BDOS_VALEUR:=Substring:C12(<>vt_BDOS_VALEUR; 1; Length:C16(<>vt_BDOS_VALEUR)-1)
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+$va_SepFICHE
											SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
											
											NEXT RECORD:C51([HeberGement:5])
										Until (End selection:C36([HeberGement:5]))
									End if 
									NEXT RECORD:C51([SIAO_Personnes:51])
								Until (End selection:C36([SIAO_Personnes:51]))
							End if 
							NEXT RECORD:C51([SIAO:50])
						Until (End selection:C36([SIAO:50]))
						
						
					: ($ii=4)  //• ORIENTATIONS     
						FIRST RECORD:C50([SIAO:50])
						<>vt_BDOS_VALEUR:=""
						$vl_fiche:=0
						Repeat 
							$vl_fiche:=$vl_fiche+1
							i_MessageSeul("  Export BDOS  en cours : "+<>ta_BDOS_FichierNom{$ii}+" <> "+String:C10($vl_fiche)+""+String:C10($vl_Dossiers))
							
							QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
							MultiSoc_Filter(->[SIAO_Personnes:51])
							If (Records in selection:C76([SIAO_Personnes:51])>0)
								ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >)
								FIRST RECORD:C50([SIAO_Personnes:51])
								Repeat 
									QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=$1; *)
									QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$2; *)
									QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[SIAO_Personnes:51]Sp_Personne_ID:3)
									
									MultiSoc_Filter(->[HeberGement:5])
									
									If (Records in selection:C76([HeberGement:5])>0)
										ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >)
										FIRST RECORD:C50([HeberGement:5])
										Repeat 
											<>vt_BDOS_VALEUR:=F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_LC_ID:61)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_ReferenceID:1)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[SIAO_Personnes:51]Sp_Personne_ID:3)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[SIAO_Personnes:51]Sp_SIAO_ID:2)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+""+$va_SepCHAMP  //CODE STRUCTURE
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[HeberGement:5]HG_Date:4)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[HeberGement:5]HG_Date:4)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->[HeberGement:5]HG_Cloturée:67)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->[HeberGement:5]HG_Flag_OrientCorrespondant:161)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolAlphaSIAO"; ->[HeberGement:5]HG_AssistSocial:87)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->[HeberGement:5]HG_Flag_RefusParStructure:162)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolSIAO"; ->[HeberGement:5]HG_Flag_RefusParDemandeur:163)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("TypePlace"; ->[HeberGement:5]HG_CentreNom:62)+$va_SepCHAMP
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+"0"+$va_SepCHAMP  //DAMISSION DIRECTE
											
											<>vt_BDOS_VALEUR:=Substring:C12(<>vt_BDOS_VALEUR; 1; Length:C16(<>vt_BDOS_VALEUR)-1)
											<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+$va_SepFICHE
											SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
											
											NEXT RECORD:C51([HeberGement:5])
										Until (End selection:C36([HeberGement:5]))
									End if 
									NEXT RECORD:C51([SIAO_Personnes:51])
								Until (End selection:C36([SIAO_Personnes:51]))
							End if 
							NEXT RECORD:C51([SIAO:50])
						Until (End selection:C36([SIAO:50]))
						
					: ($ii=5)  //• PARCOURS     
					: ($ii=6)  //• OFFRES OU STRUCTURES     
				End case 
				
				USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15 
				CLOSE DOCUMENT:C267($vh_RefDoc)
			End if 
		End for 
		
		CLOSE WINDOW:C154
	End if 
End if 
<>vt_BDOS_VALEUR:=""
