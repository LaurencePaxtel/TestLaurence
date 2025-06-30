//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatCoordinateur
//{
//{          Lundi 17 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)
//la note : =-2  : ◊ve_StatCoordinateur
C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
READ ONLY:C145(*)
i_Message("Chargement en cours …")
V_Stat_Coordinateur(0)
ARRAY TEXT:C222(ta_xGroupe; 0)
COPY ARRAY:C226(<>ta_FMGrp; ta_xGroupe)
INSERT IN ARRAY:C227(ta_xGroupe; 1; 1)
ta_xGroupe{1}:="115"
ARRAY INTEGER:C220(te_xGroupe; Size of array:C274(ta_xGroupe))

C_LONGINT:C283($ii)
For ($ii; 1; Size of array:C274(ta_xGroupe))
	te_xGroupe{$ii}:=1
End for 

C_LONGINT:C283($TailleTab)
$TailleTab:=Size of array:C274(ta_xGroupe)
ARRAY LONGINT:C221(tl_xGroupe; $TailleTab)
C_LONGINT:C283(vl_xGroupe)

ARRAY TEXT:C222(ta_Page; 5)
ta_Page{1}:="Demandeur"
ta_Page{2}:="Centres d'hébergement"
ta_Page{3}:="Orientation"
ta_Page{4}:="Prestations"
ta_Page{5}:="Rapport"
ta_Page:=1

CLOSE WINDOW:C154

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatCoordinateur")
va_Titre:="Statistiques : Coordinateur"

C_LONGINT:C283($vl_Fenetre)
$vl_Fenetre:=i_FenêtreNo(632; 436; 4; va_Titre; 1; "Quit_StatCoordinateur")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_StatC:=0
If (vb_Show)
	Général_Show
End if 