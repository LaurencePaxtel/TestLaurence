//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_ServeurVAR
//{
//{          Vendrdi 31 octobre 2008 à 15:00
//{          Modifiée : 31 octobre 2008 à 15:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)


C_TEXT:C284(<>va_T_Site)  //Code du site
<>va_T_Site:=""
C_TEXT:C284(<>va_T_00)  //Titre  : SAMU SOCIAL DE PARIS
C_TEXT:C284(<>va_T_01)  //Titre  : SAMU SOCIAL DE PARIS
C_TEXT:C284(<>va_T_02)  //Nom suite  : Groupement d'intérêt public - Arrété du 19 décembre 1994
C_TEXT:C284(<>va_T_03)  //Adresse :35, avenue de Courteline - 75012 Paris - Tél 43 88 38 18 - Fax 43 98 39
C_TEXT:C284(<>va_T_04)  // Administration : 2-4, rue Saint-Martin - 75004 Paris - Tél 40 27 42 21 - Fax 40
C_TEXT:C284(<>va_T_05)  //CCP 0921738 V PARIS
C_TEXT:C284(<>vt_T_CheminRép)
C_TEXT:C284(<>vt_T_DossierRep)
C_BOOLEAN:C305(<>vb_T_BoiteLettres)
C_LONGINT:C283(<>vl_T_ColorCadreH)
C_LONGINT:C283(<>vl_T_ColorCadreC)
C_LONGINT:C283(<>vl_T_ColorCadreB)
C_BOOLEAN:C305(<>vb_T_ModeCHRS)
C_BOOLEAN:C305(<>vb_T_Ecran115)
C_BOOLEAN:C305(<>vb_T_MasqueETCV)
C_BOOLEAN:C305(<>vb_T_Cryptage)
C_BOOLEAN:C305(<>vb_T_TransTransfert)
C_BOOLEAN:C305(<>vb_T_FullDuplex)
C_LONGINT:C283(<>ve_T_CentreCode)
C_LONGINT:C283(<>vl_T_CentreCodeDebut; <>vl_T_CentreCodeFin)
C_BOOLEAN:C305(<>vb_T_EcranGrand)

C_LONGINT:C283(<>ve_Quel_MasqueETCV)
<>ve_Quel_MasqueETCV:=0

READ ONLY:C145([SOciete:18])
QUERY:C277([SOciete:18]; [SOciete:18]SO_ReferenceID:1=1)
MultiSoc_Filter(->[SOciete:18])
If (Records in selection:C76([SOciete:18])=1)
	<>va_T_00:=[SOciete:18]SO_Libel00:2
	<>va_T_01:=[SOciete:18]SO_Libel01:3
	<>va_T_02:=[SOciete:18]SO_Libel02:4
	<>va_T_03:=[SOciete:18]SO_Libel03:5
	<>va_T_04:=[SOciete:18]SO_Libel04:6
	<>va_T_05:=[SOciete:18]SO_Libel05:7
	<>va_T_Site:=[SOciete:18]SO_Site:8
	<>vt_T_CheminRép:=[SOciete:18]SO_CheminRépertoire:11
	<>vt_T_DossierRep:=[SOciete:18]SO_RépertoireSite:12
	<>vb_T_BoiteLettres:=[SOciete:18]SO_BoiteLettres:13
	<>vl_T_ColorCadreH:=[SOciete:18]SO_CouleurCadreH:14
	<>vl_T_ColorCadreC:=[SOciete:18]SO_CouleurCadreC:15
	<>vl_T_ColorCadreB:=[SOciete:18]SO_CouleurCadreB:16
	
	<>vb_T_ModeCHRS:=[SOciete:18]SO_ModeCHRS:17
	<>vb_T_Ecran115:=[SOciete:18]SO_Ecran115:18
	<>vb_T_MasqueETCV:=[SOciete:18]SO_MasqueEtatCivil:19
	<>vb_T_Cryptage:=[SOciete:18]SO_Cryptage:20
	<>vb_T_TransTransfert:=[SOciete:18]SO_TransTransfert:21
	<>vb_T_FullDuplex:=[SOciete:18]SO_155FullDuplex:22
	<>ve_T_CentreCode:=[SOciete:18]SO_CodeCentre:23
	P_CodeCentre(-><>vl_T_CentreCodeDebut; -><>vl_T_CentreCodeFin)
	<>vb_T_EcranGrand:=[SOciete:18]SO_EcranGrand:24
End if 

C_TEXT:C284(<>va_CR; <>va_Tab)
<>va_CR:=Char:C90(13)
<>va_Tab:=Char:C90(10)