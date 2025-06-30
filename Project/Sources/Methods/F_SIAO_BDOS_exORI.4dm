//%attributes = {}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_DATE:C307($3)

C_LONGINT:C283($ii; $vl_fiche)
C_TIME:C306($vh_RefDoc)
C_BOOLEAN:C305($vb_OK)
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
	
	FIRST RECORD:C50([SIAO:50])
	$vl_fiche:=0
	<>vt_BDOS_VALEUR:=""
	Repeat 
		$vl_fiche:=$vl_fiche+1
		If ($2)
			i_MessageSeul("  Export BDOS  en cours : "+<>ta_BDOS_FichierNom{$1}+" <> "+String:C10($vl_fiche)+"/"+String:C10(vl_BDOSDossiers))
		End if 
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
		If (Records in selection:C76([SIAO_Personnes:51])>0)
			ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >)
			// FIRST RECORD([SIAO_Personnes])
			Repeat 
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=$3; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_HB_ID:19=[SIAO_Personnes:51]Sp_Personne_ID:3; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
				MultiSoc_Filter(->[HeberGement:5])
				If (Records in selection:C76([HeberGement:5])=1)
					<>vt_BDOS_VALEUR:=F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_ReferenceID:1)+va_SepCHAMP
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_ReferenceID:1)+va_SepCHAMP
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[SIAO_Personnes:51]Sp_Personne_ID:3)+va_SepCHAMP
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+"115"+va_SepCHAMP
					QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
					If (Records in selection:C76([LesCentres:9])=1)
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+[LesCentres:9]LC_Répertoire:54+va_SepCHAMP
					Else 
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+F_Chaine("ReferenceID"; ->[HeberGement:5]HG_LC_ID:61)+va_SepCHAMP
					End if 
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[HeberGement:5]HG_Date:4)+va_SepCHAMP
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[HeberGement:5]HG_Date:4)+va_SepCHAMP
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolAlphaSIAO"; ->[HeberGement:5]HG_Cloturée:67)+va_SepCHAMP
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolAlphaSIAO"; ->[HeberGement:5]HG_Flag_OrientCorrespondant:161)+va_SepCHAMP
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolReferent"; ->[HeberGement:5]HG_AssistSocial:87)+va_SepCHAMP
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolAlphaSIAO"; ->[HeberGement:5]HG_Flag_RefusParStructure:162)+va_SepCHAMP
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("BoolAlphaSIAO"; ->[HeberGement:5]HG_Flag_RefusParDemandeur:163)+va_SepCHAMP
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("TypeCentre"; ->[HeberGement:5]HG_CentreNom:62)+va_SepCHAMP
					<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("TypeAdmission"; ->[HeberGement:5]HG_Signalement:12)+va_SepFICHE  //ADMISSION DIRECTE
					
					SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
				End if 
				NEXT RECORD:C51([SIAO_Personnes:51])
			Until (End selection:C36([SIAO_Personnes:51]))
		End if 
		NEXT RECORD:C51([SIAO:50])
	Until (End selection:C36([SIAO:50]))
	
	USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
	CLOSE DOCUMENT:C267($vh_RefDoc)
End if 