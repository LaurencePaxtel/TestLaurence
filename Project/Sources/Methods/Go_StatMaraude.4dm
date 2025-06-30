//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatSpécific
//{
//{          Lundi 17 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
READ ONLY:C145(*)

i_Message("Chargement en cours …")
V_Stat_Maraude(0)

ARRAY TEXT:C222(ta_Page; 2)
ta_Page{1}:="Recherche"
ta_Page{2}:="Rapport"
ta_Page:=1


CLOSE WINDOW:C154

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatMaraude")
va_Titre:="Statistiques : Maraude Spécifique"

C_LONGINT:C283($vl_Fenetre)
$vl_Fenetre:=i_FenêtreNo(632; 436; 4; va_Titre; 1; "Quit_StatMaraude")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_StatSM:=0
If (vb_Show)
	Général_Show
End if 
