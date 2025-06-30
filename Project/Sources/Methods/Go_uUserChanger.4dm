//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uUserChanger
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée : Lundi 9 décembre 2009 à 14:27:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($vb_OK)

C_BOOLEAN:C305(vb_Show)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vb_Show:=False:C215
CHANGE CURRENT USER:C289

If (OK=1)
	POST OUTSIDE CALL:C329(<>PR_Appel)
	
	<>ve_GenéralQuitter:=-1
	POST OUTSIDE CALL:C329(<>PR_Genéral)
	
	P_LesLogs(<>va_Log_Entree; "")
	$vb_OK:=Debut_Connexion
Else 
	
	If (User in group:C338(Current user:C182; <>Groupe_PasQuitter)=False:C215)
		P_LesLogs(<>va_Log_Sortie; "")
		QUIT 4D:C291
	End if 
	
End if 

<>PR_INTChanger:=0