//%attributes = {}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_DATE:C307($3)

C_LONGINT:C283($ii; $vl_fiche; $vl_Selection)
C_TIME:C306($vh_RefDoc)
C_BOOLEAN:C305($vb_OK)

C_DATE:C307($vd_Date; $vd_Date1)
C_TEXT:C284($va_Orienter; $va_TypePlace)
C_LONGINT:C283($vl_PersID; $vl_Nuits)
vb_OKFalse:=False:C215
//Création du document sur disque ou fichier
$vh_RefDoc:=Create document:C266(<>vt_BDOS_DOSSIER+<>va_BDOS_FichierNom)
If (OK=1)
	USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
	
	<>vt_BDOS_VALEUR:=""
	//•• 1 ere ligne
	$vb_OK:=F_BDOS_Tables(<>ta_BDOS_FichierCode{$1}; ""; 0)
	For ($ii; 1; Size of array:C274(<>ta_BDOS_ChampNom))
		<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>ta_BDOS_ChampNom{$ii}+va_SepCHAMP
	End for 
	<>vt_BDOS_VALEUR:=Substring:C12(<>vt_BDOS_VALEUR; 1; Length:C16(<>vt_BDOS_VALEUR)-1)
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+va_SepFICHE
	SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
	//•• Les entrants
	$vl_fiche:=Size of array:C274(tl_Parcours_Code)
	If ($vl_fiche>0)
		For ($ii; 1; $vl_fiche)
			If ($2)
				i_MessageSeul("  Export BDOS  en cours : "+<>ta_BDOS_FichierNom{$1}+" <> "+String:C10($ii)+"/"+String:C10($vl_fiche))
			End if 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=tl_Parcours_Code{$ii})
			MultiSoc_Filter(->[HeberGement:5])
			If (Records in selection:C76([HeberGement:5])=1)
				<>vt_BDOS_VALEUR:=F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_ReferenceID:1)+va_SepCHAMP
				<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_ReferenceID:1)+va_SepCHAMP
				<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_HB_ID:19)+va_SepCHAMP
				<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_ReferenceID:1)+va_SepCHAMP
				<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+"115"+va_SepCHAMP
				<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[HeberGement:5]HG_Date:4)+va_SepCHAMP
				<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAOSortie"; ->[HeberGement:5]HG_Date:4; ->[HeberGement:5]HG_NuitTOTAL:93)+va_SepCHAMP
				<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+[HeberGement:5]HG_Orientation2:60+va_SepCHAMP
				<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("TypeCentre"; ->[HeberGement:5]HG_CentreNom:62)+va_SepCHAMP
				<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("TypeAdmission"; ->[HeberGement:5]HG_Signalement:12)+va_SepFICHE  //ADMISSION DIRECTE
				
				
				SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
			End if 
		End for 
	End if 
	//•• Les sortants
	//vl_BDOSSortants:=F_SIAO_BDOS ("Sortants";->vd_BDOSDate1;->vd_BDOSDate2;->tl_LesS
	$vl_fiche:=Size of array:C274(tl_LesSorties)
	If ($vl_fiche>0)
		For ($ii; 1; $vl_fiche)
			If ($2)
				i_MessageSeul("  Export BDOS  en cours : "+<>ta_BDOS_FichierNom{$1}+" <> "+String:C10($ii)+"/"+String:C10($vl_fiche))
			End if 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=tl_LesSorties{$ii})
			MultiSoc_Filter(->[HeberGement:5])
			If (Records in selection:C76([HeberGement:5])=1)
				$vb_OK:=False:C215
				QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Personne_ID:3=[HeberGement:5]HG_HB_ID:19)
				If (Records in selection:C76([SIAO_Personnes:51])>0)
					SELECTION TO ARRAY:C260([SIAO_Personnes:51]Sp_SIAO_ID:2; $tl_SIAO)
					QUERY WITH ARRAY:C644([SIAO:50]Si_RéférenceID:1; $tl_SIAO)
					If (Records in selection:C76([SIAO:50])>0)
						QUERY SELECTION:C341([SIAO:50]; [SIAO:50]Si_DemandeAnnulee:29=False:C215)
						$vl_Selection:=Records in selection:C76([SIAO:50])
						$vb_OK:=($vl_Selection>0)
					End if 
				End if 
				If ($vb_OK)
					vd_SIAODateSortie:=[HeberGement:5]HG_Date:4
					$vl_PersID:=[HeberGement:5]HG_HB_ID:19
					$va_Orienter:=[HeberGement:5]HG_Orientation2:60
					$va_TypePlace:=F_Chaine("TypeCentre"; ->[HeberGement:5]HG_CentreNom:62)
					$vl_Nuits:=[HeberGement:5]HG_NuitTOTAL:93
					
					$vl_Selection:=0
					$vb_Ok:=False:C215
					If (7=7)
						$vd_Date1:=Add to date:C393(vd_SIAODateSortie; 0; 0; -$vl_Nuits+1)
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date1; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_HB_ID:19=$vl_PersID; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
						MultiSoc_Filter(->[HeberGement:5])
					Else 
						Repeat 
							$vd_Date1:=Add to date:C393($vd_Date; 0; 0; $vl_Nuits-$vl_Selection)
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date1; *)
							QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_HB_ID:19=$vl_PersID; *)
							QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
							QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
							MultiSoc_Filter(->[HeberGement:5])
							If (Records in selection:C76([HeberGement:5])=1)
								If ([HeberGement:5]HG_NuitenCours:92=1)
									$vb_Ok:=True:C214
								Else 
									$vl_Selection:=$vl_Selection+1
								End if 
							Else 
								$vl_Selection:=$vl_Selection+1
							End if 
							If ($vl_Selection=$vl_Nuits)
								$vb_Ok:=True:C214
							End if 
						Until ($vb_Ok)
					End if 
					If (Records in selection:C76([HeberGement:5])=1)
						If ([HeberGement:5]HG_NuitenCours:92=1)
							$vb_Ok:=True:C214
							<>vt_BDOS_VALEUR:=F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_ReferenceID:1)+va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_ReferenceID:1)+va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_HB_ID:19)+va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_ReferenceID:1)+va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+"115"+va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[HeberGement:5]HG_Date:4)+va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAOSortie"; ->[HeberGement:5]HG_Date:4; ->[HeberGement:5]HG_NuitTOTAL:93)+va_SepCHAMP
							//      ◊vt_BDOS_VALEUR:=◊vt_BDOS_VALEUR+F_Chaine ("DateSIAO";->vd_SIAODateSortie)
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+$va_Orienter+va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+$va_TypePlace+va_SepCHAMP
							<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("TypeAdmission"; ->[HeberGement:5]HG_Signalement:12)+va_SepFICHE  //ADMISSION DIRECTE
							
							SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
						End if 
					End if 
				End if 
			End if 
		End for 
	End if 
	
	USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
	CLOSE DOCUMENT:C267($vh_RefDoc)
End if 