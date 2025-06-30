//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_RG_Hébergé
//{
//{          Jeudi 13 mai 2010 à 16:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284($va_Table)

$va_Table:=String:C10(Table:C252(->[HeBerge:4]))

<>vt_TexteRegional_HB:="PERSONNE REGIONAL"+<>va_TAB+"PERSONNE REGIONAL"+$va_Table+<>va_Tab+"-1"
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_ReferenceID:1); 4)+<>va_TAB+String:C10([HeBerge:4]HB_ReferenceID:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_ReferenceID:1))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_Clé:2); 4)+<>va_TAB+[HeBerge:4]HB_Clé:2+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_Clé:2))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_Nom:3); 4)+<>va_TAB+[HeBerge:4]HB_Nom:3+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_Nom:3))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_Prénom:4); 4)+<>va_TAB+[HeBerge:4]HB_Prénom:4+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_Prénom:4))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_DateNéLe:5); 4)+<>va_TAB+String:C10([HeBerge:4]HB_DateNéLe:5; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_DateNéLe:5))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HG_Genre:39); 4)+<>va_TAB+String:C10(Num:C11([HeBerge:4]HG_Genre:39))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HG_Genre:39))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_CléFam:47); 4)+<>va_TAB+[HeBerge:4]HB_CléFam:47+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_CléFam:47))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_Status:18); 4)+<>va_TAB+String:C10(Num:C11([HeBerge:4]HB_Status:18))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_Status:18))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_PièceNéOu:57); 4)+<>va_TAB+[HeBerge:4]HB_PièceNéOu:57+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_PièceNéOu:57))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_PièceNationalité:58); 4)+<>va_TAB+[HeBerge:4]HB_PièceNationalité:58+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_PièceNationalité:58))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_PièceCNI:59); 4)+<>va_TAB+[HeBerge:4]HB_PièceCNI:59+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_PièceCNI:59))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_PiècePasseport:60); 4)+<>va_TAB+[HeBerge:4]HB_PiècePasseport:60+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_PiècePasseport:60))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_Trans_RéférenceID:55); 4)+<>va_TAB+String:C10([HeBerge:4]HB_Trans_RéférenceID:55)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_Trans_RéférenceID:55))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_Trans_CléFam:56); 4)+<>va_TAB+[HeBerge:4]HB_Trans_CléFam:56+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_Trans_CléFam:56))
<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR