//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : Go_Occupation
//{
//{          Jeudi 4 décembre 2008 à 12:12
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


SET MENU BAR:C67(1)
READ ONLY:C145(*)
MESSAGES OFF:C175
C_DATE:C307(vd_Date1)
C_LONGINT:C283(vl_ii)
C_LONGINT:C283($vl_Fenetre)
C_TEXT:C284(va_Titre; va_DateMaJ; va_DateMaJNext)
vd_Date1:=Current date:C33
va_DateMaJ:="Mise à jour le …"
If (<>vb_T_OccupMinuteur)
	If (<>vl_T_OccupMinuteurTicks>0)
		va_DateMaJNext:="Prochaine mise à jour à …"
	End if 
End if 
C_LONGINT:C283(vl_Rafraichir; vl_FixerMinuteur)
C_TIME:C306(vh_FixerMinuteur)

vl_Rafraichir:=1
vl_FixerMinuteur:=0
vh_FixerMinuteur:=vl_FixerMinuteur/60

C_LONGINT:C283(vl_TOC_Capacité; vl_TOC_Hébergés; vl_TOC_Hébergés_H; vl_TOC_Hébergés_F; vl_TOC_Hébergés_M; vl_TOC_Reste; vl_TOC_Taux)
C_LONGINT:C283(vl_Graphe1; vl_Graphe2)

C_LONGINT:C283(vl_GrapheZone_10; vl_GrapheZone_11; vl_GrapheZone_12)
C_LONGINT:C283(vl_GrapheID_10; vl_GrapheID_11; vl_GrapheID_12)
C_LONGINT:C283(vl_GrapheTitre_10; vl_GrapheTitre_11; vl_GrapheTitre_12)
C_LONGINT:C283(vl_GraphePosition_10; vl_GraphePosition_11; vl_GraphePosition_12)
C_LONGINT:C283(vl_Gauche; vl_Haut; vl_Droite; vl_Bas; vl_Gauche2; vl_Haut2; vl_Droite2; vl_Bas2)


P_OccupationTab(0)
va_Titre:="Taux d'occupation"

//$vl_Fenetre:=i_FenêtreNo (786;508;4;va_Titre;1;"Quit_Simple")
$vl_Fenetre:=i_FenêtreNo(876; 608; 4; va_Titre; 1; "Quit_Simple")

DIALOG:C40([DiaLogues:3]; "DL_Occupation")
CLOSE WINDOW:C154($vl_Fenetre)

P_OccupationTab(0)
<>PR_Occupation:=0