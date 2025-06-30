//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_RG_Hébergements
//{
//{          Jeudi 13 mai 2010 à 16:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284($va_Table)
C_LONGINT:C283($vlSTR_Std)
$vlSTR_Std:=30108
$va_Table:=String:C10(Table:C252(->[HeberGement:5]))

<>vt_TexteRegional_HG:="HEBERGEMENT REGIONAL"+<>va_TAB+"HEBERGEMENT REGIONAL"+$va_Table+<>va_Tab+"-1"
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_ReferenceID:1); 4)+<>va_TAB+String:C10([HeberGement:5]HG_ReferenceID:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ReferenceID:1))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_Nuit:2); 4)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Nuit:2))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Nuit:2))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+"Fiche n°"+<>va_TAB+[HeberGement:5]HG_FicheNuméro:3+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FicheNuméro:3))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+"Gestion"+<>va_TAB+[HeberGement:5]HG_GestionCentreNuit:133+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_GestionCentreNuit:133))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_Date:4); 4)+<>va_TAB+String:C10([HeberGement:5]HG_Date:4; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Date:4))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_HeureAppel:5); 4)+<>va_TAB+String:C10([HeberGement:5]HG_HeureAppel:5; h mn s:K7:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_HeureAppel:5))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_DateDuJour:82); 4)+<>va_TAB+String:C10([HeberGement:5]HG_DateDuJour:82; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DateDuJour:82))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_DateCreationFiche:149); 4)+<>va_TAB+String:C10([HeberGement:5]HG_DateCreationFiche:149; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DateCreationFiche:149))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_ModifDateHeures:152); 4)+<>va_TAB+[HeberGement:5]HG_ModifDateHeures:152+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ModifDateHeures:152))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_RegionalDateHeure:153); 4)+<>va_TAB+[HeberGement:5]HG_RegionalDateHeure:153+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RegionalDateHeure:153))

//Identité
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_EtatCivil:20+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_EtatCivil:20))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+"HB ID"+<>va_TAB+String:C10([HeberGement:5]HG_HB_ID:19)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_HB_ID:19))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_Genre:96); 4)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Genre:96))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Genre:96))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_Nom:21); 4)+<>va_TAB+[HeberGement:5]HG_Nom:21+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Nom:21))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_Prénom:22); 4)+<>va_TAB+[HeberGement:5]HG_Prénom:22+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Prénom:22))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_DateNéLe:24); 4)+<>va_TAB+String:C10([HeberGement:5]HG_DateNéLe:24; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DateNéLe:24))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_Age:23); 4)+<>va_TAB+String:C10([HeberGement:5]HG_Age:23)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Age:23))
//Plateforme
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 100)+<>va_TAB+[HeberGement:5]HG_Plateforme:139+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Plateforme:139))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 101)+<>va_TAB+[HeberGement:5]HG_PlateformeCentre:140+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_PlateformeCentre:140))
//Famille
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 62)+<>va_TAB+[HeberGement:5]HG_FamGroupe:102+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamGroupe:102))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 63)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_FamChef:103))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamChef:103))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 64)+<>va_TAB+[HeberGement:5]HG_FamClé:104+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamClé:104))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 65)+<>va_TAB+[HeberGement:5]HG_FamCompo:105+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamCompo:105))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_FamCompoVar:117); 4)+<>va_TAB+[HeberGement:5]HG_FamCompoVar:117+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamCompoVar:117))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 73)+<>va_TAB+String:C10([HeberGement:5]HG_FamNbPers:106)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamNbPers:106))

//Famille suite
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 74)+<>va_TAB+String:C10([HeberGement:5]HG_FamNbJour:107)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamNbJour:107))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 75)+<>va_TAB+String:C10([HeberGement:5]HG_FamNbChambre:108)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamNbChambre:108))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 76)+<>va_TAB+String:C10([HeberGement:5]HG_FamPrixJour:109)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamTotal:110))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 77)+<>va_TAB+String:C10([HeberGement:5]HG_FamTotal:110)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamPrixJour:109))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 98)+<>va_TAB+String:C10([HeberGement:5]HG_FamNoDeBon:136)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamNoDeBon:136))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 99)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Participation:138))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Participation:138))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 78)+<>va_TAB+[HeberGement:5]HG_FamDistri1:112+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamDistri1:112))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 84)+<>va_TAB+String:C10([HeberGement:5]HG_FamDistri1M:118)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamDistri1M:118))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 79)+<>va_TAB+[HeberGement:5]HG_FamDistri2:113+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamDistri2:113))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 85)+<>va_TAB+String:C10([HeberGement:5]HG_FamDistri2M:119)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamDistri2M:119))


<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 80)+<>va_TAB+[HeberGement:5]HG_FamDistri3:114+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamDistri3:114))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 86)+<>va_TAB+String:C10([HeberGement:5]HG_FamDistri3M:120)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamDistri3M:120))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 81)+<>va_TAB+[HeberGement:5]HG_FamDistri4:115+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamDistri4:115))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 87)+<>va_TAB+String:C10([HeberGement:5]HG_FamDistri4M:121)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamDistri4M:121))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 82)+<>va_TAB+[HeberGement:5]HG_FamDistri5:116+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamDistri5:116))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 88)+<>va_TAB+String:C10([HeberGement:5]HG_FamDistri5M:122)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamDistri5M:122))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 83)+<>va_TAB+[HeberGement:5]HG_FamCasSpéc:111+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamCasSpéc:111))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_FamVérifiéeLe:137); 4)+<>va_TAB+String:C10([HeberGement:5]HG_FamVérifiéeLe:137; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamVérifiéeLe:137))

//Réservation
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 44)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Réservation:91))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Réservation:91))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 45)+<>va_TAB+String:C10([HeberGement:5]HG_NuitenCours:92)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_NuitenCours:92))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 46)+<>va_TAB+String:C10([HeberGement:5]HG_NuitTOTAL:93)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_NuitTOTAL:93))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_NuitReste:95); 4)+<>va_TAB+String:C10([HeberGement:5]HG_NuitReste:95)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_NuitReste:95))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_RéservationDateFin:134); 4)+<>va_TAB+String:C10([HeberGement:5]HG_RéservationDateFin:134; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RéservationDateFin:134))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 47)+<>va_TAB+[HeberGement:5]HG_Reporté:94+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Reporté:94))
//Excusé
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 89)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_ER_Excuse:124))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_Excuse:124))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 90)+<>va_TAB+String:C10([HeberGement:5]HG_ER_DateDébut:125; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_DateDébut:125))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 91)+<>va_TAB+String:C10([HeberGement:5]HG_ER_DateFin:126; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_DateFin:126))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 92)+<>va_TAB+String:C10([HeberGement:5]HG_ER_NuitEnCours:127)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_NuitEnCours:127))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 93)+<>va_TAB+String:C10([HeberGement:5]HG_ER_NuitTotal:128)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_NuitTotal:128))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 94)+<>va_TAB+String:C10([HeberGement:5]HG_ER_NuitReste:129)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_NuitReste:129))
//Remplaçant
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 95)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_ER_Remplaçant:130))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_Remplaçant:130))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 96)+<>va_TAB+String:C10([HeberGement:5]HG_ER_RemplaceQuiRéf:131)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_RemplaceQuiRéf:131))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 97)+<>va_TAB+[HeberGement:5]HG_ER_RemplaceQui:132+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_RemplaceQui:132))
//Centre
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+"LC ID"+<>va_TAB+String:C10([HeberGement:5]HG_LC_ID:61)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_LC_ID:61))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 51)+<>va_TAB+[HeberGement:5]HG_CentreNom:62+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CentreNom:62))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 52)+<>va_TAB+[HeberGement:5]HG_CentreARR:63+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CentreARR:63))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_Priorité:57); 4)+<>va_TAB+String:C10([HeberGement:5]HG_Priorité:57)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Priorité:57))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 53)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_DispoSpé:90))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DispoSpé:90))
//Statut de la fiche
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 54)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_EnAttente:64))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_EnAttente:64))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 55)+<>va_TAB+String:C10([HeberGement:5]HG_AttenteHeur:83; h mn s:K7:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_AttenteHeur:83))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 56)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Transmis:65))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Transmis:65))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 57)+<>va_TAB+String:C10([HeberGement:5]HG_TransmisHeur:84; h mn s:K7:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_TransmisHeur:84))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 58)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_PriseCharge:66))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_PriseCharge:66))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 59)+<>va_TAB+String:C10([HeberGement:5]HG_PrChargeHeur:85; h mn s:K7:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_PrChargeHeur:85))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 60)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Cloturée:67))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Cloturée:67))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 61)+<>va_TAB+String:C10([HeberGement:5]HG_CloturéeHeur:86; h mn s:K7:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CloturéeHeur:86))
//Champs
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_UtilisateurP:6); 4)+<>va_TAB+[HeberGement:5]HG_UtilisateurP:6+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_UtilisateurP:6))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 1)+<>va_TAB+[HeberGement:5]HG_Coordinateur:7+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Coordinateur:7))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 2)+<>va_TAB+[HeberGement:5]HG_Régulateur:8+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Régulateur:8))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 3)+<>va_TAB+[HeberGement:5]HG_Permanencier:9+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Permanencier:9))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 4)+<>va_TAB+[HeberGement:5]HG_AssistSocial:87+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_AssistSocial:87))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 19)+<>va_TAB+[HeberGement:5]HG_Maraude1_1:10+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Maraude1_1:10))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 20)+<>va_TAB+String:C10([HeberGement:5]HG_DateEntree:186)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DateEntree:186))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 21)+<>va_TAB+[HeberGement:5]HG_Maraude2_1:98+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Maraude2_1:98))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 22)+<>va_TAB+[HeberGement:5]HG_Maraude2_2:99+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Maraude2_2:99))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 23)+<>va_TAB+[HeberGement:5]HG_Maraude3_1:100+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Maraude3_1:100))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 24)+<>va_TAB+String:C10([HeberGement:5]HG_DateSortie:185)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DateSortie:185))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 5)+<>va_TAB+[HeberGement:5]HG_Signalement:12+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Signalement:12))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 6)+<>va_TAB+[HeberGement:5]HG_SignalCentre:13+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SignalCentre:13))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 7)+<>va_TAB+[HeberGement:5]HG_CodePostal:14+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CodePostal:14))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 8)+<>va_TAB+[HeberGement:5]HG_Gare:15+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Gare:15))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 9)+<>va_TAB+[HeberGement:5]HG_Métro:16+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Métro:16))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 10)+<>va_TAB+[HeberGement:5]HG_Emplacement:17+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Emplacement:17))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 11)+<>va_TAB+[HeberGement:5]HG_Lien:18+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Lien:18))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 12)+<>va_TAB+[HeberGement:5]HG_Nationalité:25+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Nationalité:25))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 13)+<>va_TAB+[HeberGement:5]HG_SituFamille:29+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SituFamille:29))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 14)+<>va_TAB+[HeberGement:5]HG_TempsErrance:34+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_TempsErrance:34))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 15)+<>va_TAB+[HeberGement:5]HG_DernierHéber:35+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DernierHéber:35))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 16)+<>va_TAB+[HeberGement:5]HG_SituProfess:36+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SituProfess:36))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 17)+<>va_TAB+[HeberGement:5]HG_DernierEmplo:37+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DernierEmplo:37))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 18)+<>va_TAB+[HeberGement:5]HG_DuréSanEmplo:38+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DuréSanEmplo:38))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 41)+<>va_TAB+[HeberGement:5]HG_NiveauEtude:43+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_NiveauEtude:43))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 25)+<>va_TAB+[HeberGement:5]HG_PiècesIdté1:31+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_PiècesIdté1:31))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 26)+<>va_TAB+[HeberGement:5]HG_PiècesIdté2:32+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_PiècesIdté2:32))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 27)+<>va_TAB+[HeberGement:5]HG_PiècesIdté3:33+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_PiècesIdté3:33))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 28)+<>va_TAB+[HeberGement:5]HG_RupMajeur1:40+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur1:40))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 28)+"2"+<>va_TAB+[HeberGement:5]HG_RupMajeur1_2:72+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur1_2:72))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 29)+<>va_TAB+[HeberGement:5]HG_RupMajeur2:41+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur2:41))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 29)+"2"+<>va_TAB+[HeberGement:5]HG_RupMajeur2_2:73+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur2_2:73))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 30)+<>va_TAB+[HeberGement:5]HG_RupMajeur3:42+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur3:42))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 30)+"2"+<>va_TAB+[HeberGement:5]HG_RupMajeur3_2:74+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur3_2:74))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 31)+<>va_TAB+[HeberGement:5]HG_Ressources1:45+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressources1:45))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 31)+"2"+<>va_TAB+[HeberGement:5]HG_Ressource1_2:75+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressource1_2:75))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 32)+<>va_TAB+[HeberGement:5]HG_Ressources2:46+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressources2:46))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 32)+"2"+<>va_TAB+[HeberGement:5]HG_Ressource2_2:76+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressource2_2:76))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 33)+<>va_TAB+[HeberGement:5]HG_Ressources3:47+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressources3:47))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 33)+"2"+<>va_TAB+[HeberGement:5]HG_Ressource3_2:77+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressource3_2:77))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 34)+<>va_TAB+[HeberGement:5]HG_SuiviSocial1:49+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SuiviSocial1:49))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 35)+<>va_TAB+[HeberGement:5]HG_SuiviSocial2:50+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SuiviSocial2:50))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 36)+<>va_TAB+[HeberGement:5]HG_SuiviSocial3:51+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SuiviSocial3:51))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 37)+<>va_TAB+[HeberGement:5]HG_CouvSocial1:53+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CouvSocial1:53))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 38)+<>va_TAB+[HeberGement:5]HG_CouvSocial2:54+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CouvSocial2:54))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 39)+<>va_TAB+[HeberGement:5]HG_CouvSocial3:55+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CouvSocial3:55))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 42)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Médicalisé:56))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Médicalisé:56))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 43)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Status:89))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Status:89))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 48)+<>va_TAB+[HeberGement:5]HG_Orientation1:58+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Orientation1:58))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 49)+<>va_TAB+[HeberGement:5]HG_Orientation1Suite:59+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Orientation1Suite:59))

<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 50)+<>va_TAB+[HeberGement:5]HG_AutreSolutio:88+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_AutreSolutio:88))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 50)+"2"+<>va_TAB+[HeberGement:5]HG_AutreSolSuite:123+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_AutreSolSuite:123))

//Autres
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_VstVsm:135); 4)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_VstVsm:135))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_VstVsm:135))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_1_TransHeure:70); 4)+<>va_TAB+String:C10([HeberGement:5]HG_1_TransHeure:70; h mn s:K7:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_1_TransHeure:70))

//Fax
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_CléFax:69); 4)+<>va_TAB+[HeberGement:5]HG_CléFax:69+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CléEtat:68))

//Trans
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 102)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Trans_DDASS:141))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Trans_DDASS:141))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 103)+<>va_TAB+String:C10([HeberGement:5]HG_Trans_RéférenceID:142)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Trans_RéférenceID:142))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 104)+<>va_TAB+[HeberGement:5]HG_Trans_FicheNuméro:143+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Trans_FicheNuméro:143))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 105)+<>va_TAB+String:C10([HeberGement:5]HG_Trans_HB_ID:144)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Trans_HB_ID:144))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 106)+<>va_TAB+String:C10([HeberGement:5]HG_Trans_LC_ID:145)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Trans_LC_ID:145))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 107)+<>va_TAB+[HeberGement:5]HG_Trans_FamClé:147+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Trans_FamClé:147))
<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 108)+<>va_TAB+[HeberGement:5]HG_Trans_Plateforme:148+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Trans_Plateforme:148))

//PAS TRANSMIS
//[HéberGement]HG_LS_Signalnt

//[HéberGement]HG_LienParenté
//[HéberGement]HG_RéfEtatCiviL
//[HéberGement]HG_LieuNéOù

//[HéberGement]HG_LS_PiècesIdt
//[HéberGement]HG_LS_RupMajeur
//[HéberGement]HG_LS_Ressource
//[HéberGement]HG_LS_SuiSocial
//[HéberGement]HG_LS_CouvSocia
//[HéberGement]HG_LS_Orienter2

//[HéberGement]HG_CléEtat

//[HéberGement]HG_2_NA

//[HéberGement]HG_YaFicheLiée
//[HéberGement]HG_NbFicheLiée
//[HéberGement]HG_1erFicheLiée
//[HéberGement]HG_TypFicheLiée

//[HéberGement]HG_CléCodée_Etat
//[HéberGement]HG_CléCodée
//[HéberGement]HG_Regional_Departement


<>vt_TexteRegional_HG:=<>vt_TexteRegional_HG+<>va_CR