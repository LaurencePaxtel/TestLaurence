//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Website
//{
//{          Vendredi 26 juin 2009 à 14:00:00
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

C_DATE:C307(vd_Date1)

C_DATE:C307(vd_ws_Date)
C_TIME:C306(vh_ws_DateHeure; vh_ws_Période)


C_TEXT:C284(vt_ws_Répertoire)
C_TEXT:C284(va_ws_NomDocument)
C_TEXT:C284(va_ws_Heures)




C_TEXT:C284(va_ws_Message)
C_BOOLEAN:C305(vb_ws_LancerFirst; vb_ws_Lancer)
vb_ws_LancerFirst:=True:C214
vb_ws_Lancer:=False:C215
va_ws_Message:="Utilisez le  bouton lancer pour démarrer le processus !"

C_BOOLEAN:C305(vb_SurServeur)
vb_SurServeur:=True:C214
//vb_SurServeur:=Faux

C_LONGINT:C283(h1; h2; h3; h4; h5; h6,h7; h8; h9; h10; h11; h12)
C_LONGINT:C283(h13; h14; h15; h16,h17; h18; h19; h20; h21; h22; h23; h24)

C_LONGINT:C283(vl_HeureNo; vl_MinuteNo; vl_HeureLast; vl_MinuteLast)


DébutInitWebsite(0)
vd_ws_Date:=Current date:C33
vh_ws_DateHeure:=Current time:C178
If (vb_SurServeur)
	P_ServeurDateHeure(->vd_ws_Date; ->vh_ws_DateHeure)
End if 
vh_ws_Période:=<>vh_ws_Période
vt_ws_Répertoire:=<>vt_ws_Répertoire
va_ws_NomDocument:=<>va_ws_NomDocument
va_ws_Heures:=<>va_ws_Heures

vd_Date1:=vd_ws_Date
C_LONGINT:C283(vl_TOC_Capacité; vl_TOC_Hébergés; vl_TOC_Hébergés_H; vl_TOC_Hébergés_F; vl_TOC_Hébergés_M; vl_TOC_Reste; vl_TOC_Taux)
P_TauxPresentation(0; 0)

$vl_Fenetre:=i_FenêtreNo(466; 462; 16; "Données pour le Website 115"; 3; "")
DIALOG:C40([DiaLogues:3]; "DL_Website")
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])


P_TauxPresentation(0; 0)

<>PR_Website:=0
If (vb_Show)
	Général_Show
End if 


//-60