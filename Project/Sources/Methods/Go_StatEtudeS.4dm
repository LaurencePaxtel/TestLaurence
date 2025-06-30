//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatEtude
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

V_Stat_Etude(0)

ARRAY TEXT:C222(ta_xGroupe; 0)
COPY ARRAY:C226(<>ta_FMGrp; ta_xGroupe)
INSERT IN ARRAY:C227(ta_xGroupe; 1; 1)
ta_xGroupe{1}:="115"
ARRAY INTEGER:C220(te_xGroupe; Size of array:C274(ta_xGroupe))
For ($ii; 1; Size of array:C274(ta_xGroupe))
	te_xGroupe{$ii}:=1
End for 
$TailleTab:=Size of array:C274(ta_xGroupe)
ARRAY LONGINT:C221(te_xxGroupe; $TailleTab)
ARRAY LONGINT:C221(tl_xxGroupe; $TailleTab)
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



CLOSE WINDOW:C154

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatEtudeS")
va_Titre:="Statistiques : Etude S"
$vl_Fenetre:=i_FenêtreNo(632; 436; 4; va_Titre; 1; "Quit_Show")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
V_Stat_Etude(0)

<>PR_StatE:=0
If (vb_Show)
	Général_Show
End if 