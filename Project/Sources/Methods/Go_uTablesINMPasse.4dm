//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uTablesINMPasse
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
i_Message("Chargement en cours…")
C_LONGINT:C283(vL_Nb_User; vL_Nb_Groupe)
C_BOOLEAN:C305(vb_OK)
vb_OK:=False:C215
P_uTablesINMPasse(0; 0)


CLOSE WINDOW:C154

va_Titre:="Liste des utilisateurs et des privilèges"


$vl_Fenetre:=i_FenêtreNo(586; 436; 8; va_Titre; 1; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_uUtilisateurs")
CLOSE WINDOW:C154($vl_Fenetre)

<>PR_DévTablesMP:=0
If (vb_Show)
	Général_Show
End if 