//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{          Procédure : i_Version  
//{          Mercredi 29 Aôut 2001 à 11:08:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
ARRAY TEXT:C222(ta_LaVersio; 0)

C_TEXT:C284(<>va_Sirene; <>va_Version; <>va_VersDt; <>va_NomSoft; <>va_Raison; <>va_Siret; <>va_LaVersio)

<>va_Version:=""
<>va_VersDt:=""
<>va_NomSoft:=""
<>va_Raison:=""
<>va_LaVersio:=""

// STRING LIST TO ARRAY(30003;ta_LaVersio)

// #BS Migration v15 30/05/16
// Remplacement de la commande obsolète
// STRING LIST TO ARRAY par xliff_STRING_LIST_TO_ARRAY
xliff_STRING_LIST_TO_ARRAY_(30003; ->ta_LaVersio)

If (Size of array:C274(ta_LaVersio)>0)
	<>va_LaVersio:=ta_LaVersio{1}
	
	<>va_Version:=ta_LaVersio{2}
	<>va_VersDt:=ta_LaVersio{3}
	<>va_NomSoft:=ta_LaVersio{4}
	<>va_Raison:=ta_LaVersio{5}
End if 