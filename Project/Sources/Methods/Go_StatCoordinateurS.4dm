//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatCoordinateurS
//{
//{          Lundi 17 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
READ ONLY:C145(*)

i_Message("Chargement en cours …")
V_Stat_Coordinateur(0)
SORT ARRAY:C229(<>ta_TBEtCiv; >)
ARRAY TEXT:C222(ta_xGroupe; 0)
COPY ARRAY:C226(<>ta_FMGrp; ta_xGroupe)
INSERT IN ARRAY:C227(ta_xGroupe; 1; 1)
ta_xGroupe{1}:="115"
ARRAY INTEGER:C220(te_xGroupe; Size of array:C274(ta_xGroupe))
For ($ii; 1; Size of array:C274(ta_xGroupe))
	te_xGroupe{$ii}:=1
End for 
$TailleTab:=Size of array:C274(ta_xGroupe)
ARRAY LONGINT:C221(tl_xGroupe; $TailleTab)
C_LONGINT:C283(vl_xGroupe)

ARRAY TEXT:C222(ta_Page; 7)
ta_Page{1}:="Demandeur"
ta_Page{2}:="Centres d'hébergement"
ta_Page{3}:="Orientation"
ta_Page{4}:="Prestations"
ta_Page{5}:="Prestations détail"
ta_Page{6}:="Groupes"
ta_Page{7}:="Rapport"
ta_Page:=1

CLOSE WINDOW:C154

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatCoordinateurS")
va_Titre:="Statistiques : "+$1
$vl_Fenetre:=i_FenêtreNo(752; 436; 4; va_Titre; 1; "Quit_StatCoordinateurS")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_StatC2:=0
If (vb_Show)
	Général_Show
End if 