//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Conso_Liste
//{
//{          Mardi 17 février 2009 à 13:35:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

READ ONLY:C145(*)
SET MENU BAR:C67(1)
//Général_Hide 
C_BOOLEAN:C305(vb_OK)
C_LONGINT:C283($vl_Fenetre; vl_ii)
C_TEXT:C284(va_Titre)
C_TEXT:C284(vt_TitreDocument; vt_FullDuplexDossier)
ARRAY TEXT:C222(ta_Conso_Document; 0)
C_TEXT:C284(vt_DTitreDocument)
vt_TitreDocument:=""
vt_FullDuplexDossier:=""
va_Titre:="Consolidation"

P_VarConso_Liste(0)
P_VarConso_Liste(1)

//P_VarConso_Liste (5)
va_ConsoB_DocumentLignes:="0 fiche le 00/00/00 à 00:00"
READ WRITE:C146([DiaLogues:3])

FORM SET INPUT:C55([DiaLogues:3]; "DL_ConsoListe")
$vl_Fenetre:=i_FenêtreNo(326; 436; 4; va_Titre; 33; "Quit_Simple")

ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_ConsoListe:=0
//Général_Show 
