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
C_LONGINT:C283($ii; $vl_Fenetre)

C_TEXT:C284(va_TailCtr; va_xCentreCritere)
C_LONGINT:C283(vl_CT_Col)
C_BOOLEAN:C305(vb_Show)

ARRAY TEXT:C222(ta_xCentre; 0)
ARRAY TEXT:C222(ta_Page; 2)

ARRAY LONGINT:C221(tl_xCentre; 0)

SET MENU BAR:C67(1)
READ ONLY:C145(*)

vb_Show:=False:C215

ALL RECORDS:C47([LesCentres:9])
MultiSoc_Filter(->[LesCentres:9])

ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)

SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tl_xCentre; [LesCentres:9]LC_Nom:4; ta_xCentre)
ARRAY INTEGER:C220(te_xCentre; Size of array:C274(tl_xCentre))

For ($ii; 1; Size of array:C274(tl_xCentre))
	te_xCentre{$ii}:=1
End for 

va_TailCtr:=""
vl_CT_Col:=Size of array:C274(tl_xCentre)

i_Message("Chargement en cours …")
V_Stat_Spécific(0)

ta_Page{1}:="Recherche"
ta_Page{2}:="Rapport"
ta_Page:=1

CLOSE WINDOW:C154

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatSpécific")

va_Titre:="Statistiques : Statistiques croisées"

$vl_Fenetre:=i_FenêtreNo(1450; 800; 4; va_Titre; 1; "Quit_StatSpécific")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur

CLOSE WINDOW:C154($vl_Fenetre)

READ ONLY:C145([DiaLogues:3])
V_Stat_Spécific(0)

<>PR_StatS:=0

If (vb_Show)
	Général_Show
End if 