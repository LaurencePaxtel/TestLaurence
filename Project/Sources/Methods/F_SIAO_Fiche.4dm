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
$va_Table:=String:C10(Table:C252(->[Dossier_SIAO:49]))
<>vt_SIAO_Texte:="SIAO SIAO"+<>va_TAB+"SIAO SIAO"+$va_Table+<>va_Tab+"-1"
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_RéférenceID:1))+<>va_TAB+String:C10([Dossier_SIAO:49]SI_RéférenceID:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_RéférenceID:1))

<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_HB_ID:2))+<>va_TAB+String:C10([Dossier_SIAO:49]SI_HB_ID:2)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_HB_ID:2))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Date:3))+<>va_TAB+String:C10([Dossier_SIAO:49]SI_Date:3; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Date:3))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Heure:4))+<>va_TAB+String:C10([Dossier_SIAO:49]SI_Heure:4)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Heure:4))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Modifiéle:5))+<>va_TAB+String:C10([Dossier_SIAO:49]SI_Modifiéle:5; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Modifiéle:5))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_HG_ID:6))+<>va_TAB+String:C10([Dossier_SIAO:49]SI_HG_ID:6)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_HG_ID:6))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_EtatCivil:7))+<>va_TAB+[Dossier_SIAO:49]SI_EtatCivil:7+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_EtatCivil:7))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Nom:8))+<>va_TAB+[Dossier_SIAO:49]SI_Nom:8+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Nom:8))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Prénom:10))+<>va_TAB+[Dossier_SIAO:49]SI_Prénom:10+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Prénom:10))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Date_Néle:11))+<>va_TAB+String:C10([Dossier_SIAO:49]SI_Date_Néle:11; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Date_Néle:11))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Age:12))+<>va_TAB+String:C10([Dossier_SIAO:49]SI_Age:12)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Age:12))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Genre:13))+<>va_TAB+String:C10(Num:C11([Dossier_SIAO:49]SI_Genre:13))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Genre:13))

<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Structure:14))+<>va_TAB+[Dossier_SIAO:49]SI_Chargé_Structure:14+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Structure:14))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Service:15))+<>va_TAB+[Dossier_SIAO:49]SI_Chargé_Service:15+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Service:15))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Civilité:16))+<>va_TAB+[Dossier_SIAO:49]SI_Chargé_Civilité:16+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Civilité:16))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Nom:17))+<>va_TAB+[Dossier_SIAO:49]SI_Chargé_Nom:17+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Nom:17))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Prénom:18))+<>va_TAB+[Dossier_SIAO:49]SI_Chargé_Prénom:18+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Prénom:18))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Téléphone:19))+<>va_TAB+[Dossier_SIAO:49]SI_Chargé_Téléphone:19+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Téléphone:19))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_TéléphoneMobile:20))+<>va_TAB+[Dossier_SIAO:49]SI_Chargé_TéléphoneMobile:20+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_TéléphoneMobile:20))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Fax:21))+<>va_TAB+[Dossier_SIAO:49]SI_Chargé_Fax:21+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Fax:21))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Courriel:22))+<>va_TAB+[Dossier_SIAO:49]SI_Chargé_Courriel:22+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Chargé_Courriel:22))

<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Structure_d_accueil:23))+<>va_TAB+[Dossier_SIAO:49]SI_Structure_d_accueil:23+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Structure_d_accueil:23))
<>vt_SIAO_Texte:=<>vt_SIAO_Texte+<>va_CR+$va_Table+"/"+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Role:24))+<>va_TAB+[Dossier_SIAO:49]SI_Role:24+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[Dossier_SIAO:49]SI_Role:24))
