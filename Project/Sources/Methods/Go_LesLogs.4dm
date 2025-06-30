//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_LesLogs
//{
//{          Mercredi 13 avril 2011 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)
C_LONGINT:C283($vl_Fenetre)
C_TEXT:C284(va_lesLogsDateHeure)
va_lesLogsDateHeure:=""
ARRAY TEXT:C222(ta_LesLogs_User; 0)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
READ ONLY:C145(*)
i_Message("Chargement en cours …")

P_LesLogs_Users
P_LesLogs_UsersSel


CLOSE WINDOW:C154


FORM SET OUTPUT:C54([LesLogs:59]; "LL_Liste")
FORM SET INPUT:C55([LesLogs:59]; "LL_Visu")
$vl_Fenetre:=i_FenêtreNo(716; 466; 8; ""; 8; "Quit_Simple")
DISPLAY SELECTION:C59([LesLogs:59]; *)
CLOSE WINDOW:C154($vl_Fenetre)


<>PR_LesLogs:=0
If (vb_Show)
	Général_Show
End if 