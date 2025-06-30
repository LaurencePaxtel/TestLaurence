//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uAutreSolD
//{
//{          Vendredi 21 mai 2004 à 09:14:00
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

C_TEXT:C284(va_HG_AutreSolStd)
C_TEXT:C284(va_HG_AutreSolExc)
C_TEXT:C284(va_HG_AutreSolRemp)
va_HG_AutreSolStd:=<>va_HG_AutreSolStd
va_HG_AutreSolExc:=<>va_HG_AutreSolExc
va_HG_AutreSolRemp:=<>va_HG_AutreSolRemp
Case of 
	: (User in group:C338(Current user:C182; <>Groupe_Externe))
		<>vlSTR_Std:=<>vlSTR_HGE
	: (User in group:C338(Current user:C182; <>Groupe_Asile))
		<>vlSTR_Std:=30108
	Else 
		<>vlSTR_Std:=<>vlSTR_HG1
End case 

<>vlSTR_Std_Soc:=(<>vlSTR_Std*1000)+<>ID_Societe_Active

va_Titre:="Paramétrage du Champs autres solutions"
$vl_Fenetre:=i_FenêtreNo(466; 272; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_AutreSolD")
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_DupChamp:=0
If (vb_Show)
	Général_Show
End if 
//DébutInitASol (1)
<>PR_AutreSolD:=0