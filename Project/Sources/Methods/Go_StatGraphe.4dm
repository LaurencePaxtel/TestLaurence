//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatGraphe
//{
//{          Lundi 5 Juillet 2004 à 15:47:00
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
C_TEXT:C284(<>ta_Graphe2; 19; 0; 0)

<>ta_GrapheRépartition{1}:="Nombre de personnes différentes"
<>ta_GrapheRépartition{2}:="Répartition selon le sexe et l'état civil"
<>ta_GrapheRépartition{3}:="Répartition par classe d'âge"
<>ta_GrapheRépartition{4}:="Répartition selon l'heure d'appel"
<>ta_GrapheRépartition{5}:="Répartition selon le signalement"
<>ta_GrapheRépartition{6}:="Répartition par nationalité"
<>ta_GrapheRépartition{7}:="Répartition selon le temps d'errance"
<>ta_GrapheRépartition{8}:="Répartition selon la situation de famille"
<>ta_GrapheRépartition{9}:="Répartition par CP"
<>ta_GrapheRépartition{10}:="Répartition par gare"
<>ta_GrapheRépartition{11}:="Répartition par ville"
<>ta_GrapheRépartition{12}:="Répartition par rupture"
<>ta_GrapheRépartition{13}:="Répartition selon les ressources"
<>ta_GrapheRépartition{14}:="Répartition selon le suivi social"
<>ta_GrapheRépartition{15}:="Répartition selon la couverture sociale"
<>ta_GrapheRépartition{16}:="Répartition selon la première orientation"
<>ta_GrapheRépartition{17}:="Répartition selon la seconde orientation"
<>ta_GrapheRépartition{18}:="Répartition selon les autres solutions"
<>ta_GrapheRépartition{19}:="Lits médicalisés"


CLOSE WINDOW:C154

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatGraphe")
va_Titre:="Statistiques : Graphes"
$vl_Fenetre:=i_FenêtreNo(786; 508; 4; va_Titre; 1; "Quit_StatGraphe")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)




<>PR_StatGraphe:=0
If (vb_Show)
	Général_Show
End if 