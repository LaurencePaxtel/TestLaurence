//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Go_ConsoSIAO
//{          Lundi 6 juin 2011 à 15:46:00
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
C_TEXT:C284(vt_DTitreDocument)



vt_TitreDocument:=""
vt_FullDuplexDossier:=""
va_Titre:="Consolidation SIAO"

P_VarConso_SIAO(0)
P_VarConso_SIAO(1)
P_VarConso_SIAO(5)

//LECTURE ECRITURE([DiaLogues])
$vl_Fenetre:=i_FenêtreNo(466; 528; -((16*45))-2; "Boite SIAO "; 22; "")
DIALOG:C40([DiaLogues:3]; "DL_BoiteSIAO")

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_ConsoSIAO:=0
//Général_Show 
