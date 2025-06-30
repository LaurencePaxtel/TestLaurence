//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementSortants
//{
//{          Mercredi 28 avril 2010 à 12:54:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

READ ONLY:C145(*)
SET MENU BAR:C67(1)
//Général_Hide 
C_BOOLEAN:C305(vb_OK)
C_LONGINT:C283($vl_Fenetre; vl_ii; vL_NbFiches; vL_NoTri)
vL_NoTri:=3

C_TEXT:C284(va_Titre; va_TitreRecherche; va_Réserve)
va_Titre:="Liste de fin d'hébergement"
va_TitreRecherche:=""
//◊vl_T_JourSortant
READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_Sortants")
$vl_Fenetre:=i_FenêtreNo(487; 518; 4; va_Titre; 22; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>vb_Sortants:=False:C215
<>PR_Sortants:=0