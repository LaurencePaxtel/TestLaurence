//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplexVAR
//{
//{          Vendrdi 31 octobre 2008 à 15:00
//{          Modifiée : 31 octobre 2008 à 15:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)

C_BOOLEAN:C305(vb_Serveur)

// Variables dates et heures Serveur/Poste client
C_DATE:C307(vd_DateServeur; vd_DateRéelle)
C_TIME:C306(vd_HeureServeur; vd_HeureRéelle)

// Pour l'export
C_TEXT:C284(vt_FullDuplexDossier; vt_FullDuplexDossierLu; vt_TitreDocument; vt_TitreDocumentLu; vt_Full_HB_Notes; va_FullHB_Clé; va_Trans_CodeSite; va_Trans_CodeSiteB; va_Trans_DateSite)
C_DATE:C307(vd_Trans_DateSite)

C_LONGINT:C283(vl_LC_Réf)  //vl_LC_Réf:=[LesCentres]LC_RéférenceID
C_TEXT:C284(va_LC_Nom)  //va_LC_Nom:=[LesCentres]LC_Nom
C_TEXT:C284(va_LC_Ad1)  //va_LC_Ad1:=[LesCentres]LC_Adr1
C_TEXT:C284(va_LC_Ad2)  //va_LC_Ad2:=[LesCentres]LC_Adr2
C_TEXT:C284(va_LC_CP)  //va_LC_CP:=[LesCentres]LC_CP
C_TEXT:C284(va_LC_Ville)  //va_LC_Ville:=[LesCentres]LC_Ville
C_TEXT:C284(va_LC_Fax1)  //va_LC_Fax1:=[LesCentres]LC_Télécopie1
C_TEXT:C284(va_LC_Tel)  //va_LC_Tel:=[LesCentres]LC_Téléphone
C_TEXT:C284(va_LC_Fax)  //va_LC_Fax:=[LesCentres]LC_Télécopie2
C_TEXT:C284(va_LC_Pers)  //va_LC_Pers:=[LesCentres]LC_Responsable2
C_TEXT:C284(va_LC_Plateforme)  //va_LC_Plateforme:=[LesCentres]LC_Plateforme
C_LONGINT:C283(vl_LC_Niveau)  //vl_LC_Niveau:=[LesCentres]LC_Niveau
C_LONGINT:C283(vl_LC_Capacité)  //vl_LC_Capacité:=[LesCentres]LC_DispoJour
C_TEXT:C284(va_LC_Dossier)  //va_LC_Dossier:=[LesCentres]LC_Répertoire
C_LONGINT:C283(vl_LC_RéfTrans)  //vl_LC_RéfTrans:=[LesCentres]LC_Trans_RéférenceID
C_LONGINT:C283(vl_LC_Prestation)  //vl_LC_Prestation:=[LesCentres]LC_Prestation 02052011

C_LONGINT:C283(vl_Trans_Réf_HG)

ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
ARRAY LONGINT:C221(tl_RATTRAPE_Réf_HG; 0)

vb_Serveur:=False:C215

// Variables dates et heures Serveur/Poste client
vd_DateServeur:=!00-00-00!
vd_HeureServeur:=?00:00:00?
vd_DateRéelle:=!00-00-00!
vd_HeureRéelle:=?00:00:00?

// Pour l'export
vt_FullDuplexDossier:=""
vt_TitreDocument:=""
vt_Full_HB_Notes:=""
va_FullHB_Clé:=""


vl_LC_Réf:=0
va_LC_Nom:=""
va_LC_Ad1:=""
va_LC_Ad2:=""
va_LC_CP:=""
va_LC_Ville:=""
va_LC_Tel:=""
va_LC_Fax:=""
va_LC_Pers:=""
va_LC_Plateforme:=""
vl_LC_Niveau:=0
vl_LC_Capacité:=0
va_LC_Dossier:=""
vl_LC_RéfTrans:=0
vl_LC_Prestation:=0

vl_Trans_Réf_HG:=0