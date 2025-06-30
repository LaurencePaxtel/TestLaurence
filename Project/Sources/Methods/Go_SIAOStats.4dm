//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_SIAOStats
//{
//{          Mercredi 6 avril 2010 à 15:15
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
READ ONLY:C145(*)
SET MENU BAR:C67(1)
C_LONGINT:C283($vl_Fenetre)

C_BOOLEAN:C305(vb_Show; $vb_OK)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
$vb_OK:=P_DatesPlageEnCours(0; True:C214)

$vb_OK:=F_SIAOStatDonnees(-1)

$vb_OK:=F_SIAO_Var_Page(0)


If (7=8)
	$vl_Fenetre:=i_FenêtreNo(642; 500; 4; "Statistiques anonymisées"; 1; "Quit_Simple")
	DIALOG:C40([DiaLogues:3]; "SIAO_Stats_1")
	CLOSE WINDOW:C154($vl_Fenetre)
End if 

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "SIAO_Stats_1")
$vl_Fenetre:=i_FenêtreNo(642; 500; 4; "Statistiques : Dossier SIAO"; 1; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])


<>PR_SIAOStats:=0
If (vb_Show)
	Général_Show
End if 