//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : Go_PrésentationDesStats
//{
//{          Lundi 27 avril 2009 à 11:52:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


SET MENU BAR:C67(1)
READ ONLY:C145(*)
MESSAGES OFF:C175
C_DATE:C307(vd_Date1)
C_TIME:C306(vh_Heure1)
C_LONGINT:C283(vl_ii)
C_LONGINT:C283($vl_Fenetre)
C_TEXT:C284(va_Titre; va_DateMaJ; va_DateMaJNext)
vd_Date1:=Current date:C33
va_DateMaJ:="Mise à jour le …"

C_BOOLEAN:C305(vb_SurServeur)
vb_SurServeur:=False:C215


C_LONGINT:C283(vl_Rafraichir; vl_FixerMinuteur)
C_TIME:C306(vh_FixerMinuteur)

C_LONGINT:C283(vl_LeGraphe; vl_LeGraphe1; vl_LeGraphe2; vl_LeGraphe3)
C_LONGINT:C283(vl_IDLeGraphe; vl_IDLeGraphe1; vl_IDLeGraphe2; vl_IDLeGraphe3)

C_LONGINT:C283(vl_CHART_NbAbscisses; vl_CHART_NbOrdonnées)

C_LONGINT:C283(vl_CHART_Teinte; vl_CHART_Luminosite)
C_LONGINT:C283(vl_CHART_ProportionRouge; vl_CHART_ProportionVert; vl_CHART_ProportionBleu)

C_LONGINT:C283(vl_CHART_Rotation; vl_CHART_Elevation)

vl_Rafraichir:=1
vl_FixerMinuteur:=0
vh_FixerMinuteur:=vl_FixerMinuteur/60

C_LONGINT:C283(vl_TOC_Capacité; vl_TOC_Hébergés; vl_TOC_Hébergés_H; vl_TOC_Hébergés_F; vl_TOC_Hébergés_M; vl_TOC_Reste; vl_TOC_Taux)

C_LONGINT:C283(vl_GrapheZone_10; vl_GrapheZone_11; vl_GrapheZone_12)
C_LONGINT:C283(vl_GrapheID_10; vl_GrapheID_11; vl_GrapheID_12)
C_LONGINT:C283(vl_GrapheTitre_10; vl_GrapheTitre_11; vl_GrapheTitre_12)
C_LONGINT:C283(vl_GraphePosition_10; vl_GraphePosition_11; vl_GraphePosition_12)
C_LONGINT:C283(vl_Gauche; vl_Haut; vl_Droite; vl_Bas; vl_Gauche2; vl_Haut2; vl_Droite2; vl_Bas2)




P_TauxPresentation(0; 1)

va_Titre:="Données statistiques"


$vl_Fenetre:=i_FenêtreNo(876; 608; 4; va_Titre; 1; "Quit_Simple")

DIALOG:C40([DiaLogues:3]; "DL_Presentation")
CLOSE WINDOW:C154($vl_Fenetre)


P_TauxPresentation(0; 1)
<>PR_DesStats:=0