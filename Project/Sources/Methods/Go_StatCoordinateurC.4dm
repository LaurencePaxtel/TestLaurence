//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatCoordinateurC
//{
//{          Lundi 26 janvier 2004 à 15:00:00
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
V_Stat_Coordinateur(0)
SORT ARRAY:C229(<>ta_TBEtCiv; >)
ARRAY TEXT:C222(ta_xGroupe; 0)
COPY ARRAY:C226(<>ta_FMGrp; ta_xGroupe)
INSERT IN ARRAY:C227(ta_xGroupe; 1; 1)
ta_xGroupe{1}:="Non saisi"
ARRAY INTEGER:C220(te_xGroupe; Size of array:C274(ta_xGroupe))
For ($ii; 1; Size of array:C274(ta_xGroupe))
	te_xGroupe{$ii}:=1
End for 
$TailleTab:=Size of array:C274(ta_xGroupe)
ARRAY LONGINT:C221(tl_xGroupe; $TailleTab)
C_LONGINT:C283(vl_xGroupe)



ARRAY TEXT:C222(ta_Page; 4)
ta_Page{1}:="Hébergements et Prestations"
ta_Page{2}:="Etats civils et Orientation effectuée par"
ta_Page{3}:="Services et autres critères"
ta_Page{4}:="Activités"
ta_Page:=1



CLOSE WINDOW:C154

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatCoordinateurC")
va_Titre:="Statistiques : Répartition par Etats civils"
$vl_Fenetre:=i_FenêtreNo(1100; 700; 4; va_Titre; 1; "Quit_StatCoordinateurC")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_StatC3:=0
If (vb_Show)
	Général_Show
End if 