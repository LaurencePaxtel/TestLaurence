//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatDirection2
//{
//{          Lundi 21 Juin 2004 à 12:07:00
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

v_Stat_DirectionCentre(0; 0)

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

ARRAY TEXT:C222(ta_xCentre; 0)
ARRAY LONGINT:C221(tl_xCentre; 0)
C_TEXT:C284(va_xCentreCritere; 0)
ALL RECORDS:C47([LesCentres:9])
MultiSoc_Filter(->[LesCentres:9])
ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tl_xCentre; [LesCentres:9]LC_Nom:4; ta_xCentre)
ARRAY INTEGER:C220(te_xCentre; Size of array:C274(tl_xCentre))
For ($ii; 1; Size of array:C274(tl_xCentre))
	te_xCentre{$ii}:=1
End for 
va_TailCtr:=""
C_LONGINT:C283(vl_CT_Col)

ARRAY TEXT:C222(ta_Page; 3)
ta_Page{1}:="Demandes"
ta_Page{2}:="Rapport"
ta_Page{3}:="Mensuel"
ta_Page:=1

CLOSE WINDOW:C154

READ WRITE:C146([DiaLogues:3])
CREATE EMPTY SET:C140([HeberGement:5]; "E_encours")
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatDirection2")
va_Titre:="Statistiques : Répartition calendaire"
$vl_Fenetre:=i_FenêtreNo(1300; 700; 4; va_Titre; 1; "Quit_StatDirection2")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

v_Stat_DirectionCentre(0; 0)

<>PR_StatD2:=0
If (vb_Show)
	Général_Show
End if 
