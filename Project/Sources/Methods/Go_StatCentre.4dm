//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatCentre
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
V_Stat_Centre(0)

ALL RECORDS:C47([LesCentres:9])
MultiSoc_Filter(->[LesCentres:9])
ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; t_CT_ID; [LesCentres:9]LC_Nom:4; ta_Centre)

C_LONGINT:C283($TailleTab)
$TailleTab:=Size of array:C274(ta_Centre)
ARRAY INTEGER:C220(t_CT_Sel; $TailleTab)
ARRAY LONGINT:C221(t_CT_Hgé; $TailleTab)
ARRAY LONGINT:C221(t_CT_Hgnt; $TailleTab)
C_LONGINT:C283(vl_CT_Hgé)
C_LONGINT:C283(vl_CT_Hgnt)
ARRAY LONGINT:C221(t_CT_THgé; $TailleTab)
C_LONGINT:C283(vl_CT_THgé)
ARRAY LONGINT:C221(t_CT_THgnt; $TailleTab)
C_LONGINT:C283(vl_CT_THgnt)

ARRAY TEXT:C222(ta_Page; 2)
ta_Page{1}:="Coûts"
ta_Page{2}:="Rapport"
ta_Page:=1


rNonVérif:=0

CLOSE WINDOW:C154

CREATE EMPTY SET:C140([HeberGement:5]; "E_encours")
READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatCentre")
va_Titre:="Statistiques : Centres"

C_LONGINT:C283($vl_Fenetre)
$vl_Fenetre:=i_FenêtreNo(752; 456; 4; va_Titre; 1; "Quit_StatCentre")

ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_StatCtr:=0
If (vb_Show)
	Général_Show
End if 