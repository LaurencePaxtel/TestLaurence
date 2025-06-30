//%attributes = {}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_LONGINT:C283($ii)
C_TIME:C306($vh_RefDoc)
C_BOOLEAN:C305($vb_OK)

//Création du document sur disque ou fichier
$vh_RefDoc:=Create document:C266(<>vt_BDOS_DOSSIER+<>va_BDOS_FichierNom)
If (OK=1)
	USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
	
	<>vt_BDOS_VALEUR:=""
	If ($2)
		i_MessageSeul("  Export BDOS  en cours : "+<>ta_BDOS_FichierNom{$1}+" <> "+"1/1")
	End if 
	//•• 1 ere ligne
	$vb_OK:=F_BDOS_Tables(<>ta_BDOS_FichierCode{$1}; ""; 0)
	For ($ii; 1; Size of array:C274(<>ta_BDOS_ChampNom))
		<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>ta_BDOS_ChampNom{$ii}+va_SepCHAMP
	End for 
	<>vt_BDOS_VALEUR:=Substring:C12(<>vt_BDOS_VALEUR; 1; Length:C16(<>vt_BDOS_VALEUR)-1)
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+va_SepFICHE
	SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
	
	<>vt_BDOS_VALEUR:=F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+"115"+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->vd_BDOSDate)+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("DateSIAO"; ->[SIAO:50]Si_Demande_Etat_modifié_le:13)+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_00+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_CodePostal+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_InseeCode+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_Ville+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_TerritoireCode+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_TerritoireLibelle+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_Departement+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_DepartementLibelle+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_RegionCode+va_SepCHAMP
	<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>va_T_RegionLibelle+va_SepFICHE
	
	SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
	
	USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
	CLOSE DOCUMENT:C267($vh_RefDoc)
End if 