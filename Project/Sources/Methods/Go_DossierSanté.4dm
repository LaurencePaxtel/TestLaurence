//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_DossierSocial  
//{
//{          Vendredi 22 mars 2002 à 14:12
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($T_Window_titre; $position_t)
C_LONGINT:C283($vl_Fenetre)

C_TEXT:C284(va_Nb_HG_F; va_Rép; va_Rép2; va_HGRPré; vt_Texte; va_MRsexe; va_QuelDossier; vt_TempObs; vt_TempTrans; vt_TempPans; vt_TempAS)
C_LONGINT:C283(vL_Nb_HB_F; vL_Nb_HG_F; vl_RéfU_HB; vl_RéfU_HG; vL_RéfHBOld; vL_RéfHBNew; vl_ListePage; ve_Durée)
C_BOOLEAN:C305(vb_Show; vb_passe1; vb_TuQuitte; vb_MRferme)
C_TIME:C306(vh_Clic1; vh_Clic2)
C_DATE:C307(va_HGRNé)

ARRAY TEXT:C222(ta_Page; 0)
ARRAY TEXT:C222(ta_MRLib; 10)
ARRAY TEXT:C222(ta_MRCode; 10)

SET MENU BAR:C67(1)

vb_Show:=False:C215

If (vb_Show)
	Général_Hide
End if 

READ ONLY:C145(*)

vL_Nb_HB_F:=0
vL_Nb_HG_F:=0

vb_passe1:=False:C215

vl_RéfU_HB:=0
vl_RéfU_HG:=0
ve_NbMar:=0

va_Rép:=""
va_Rép2:=""

V_HG_Dec(0)
V_HG_Dec(1)

F_VariablesTransite(0; 1; False:C215)
F_VariablesTransite(1; 1; False:C215)

V_DosSanté_Déc(0)

ta_MRLib{1}:="Papiers d'identité"
ta_MRLib{2}:="Couverture sociale"
ta_MRLib{3}:="Ressources"
ta_MRLib{4}:="Régime"
ta_MRLib{5}:="Suivi social"
ta_MRLib{6}:="Orientation sociale"
ta_MRLib{7}:="Aide"
ta_MRLib{8}:="Prolongation dans le centre"
ta_MRLib{9}:="-"
ta_MRLib{10}:="Tous"

ta_MRCode{1}:="Identité"
ta_MRCode{2}:="Couverture"
ta_MRCode{3}:="Ressources"
ta_MRCode{4}:="Régime"
ta_MRCode{5}:="Suivi"
ta_MRCode{6}:="Orientation"
ta_MRCode{7}:="Aide"
ta_MRCode{8}:="Prolongation"
ta_MRCode{9}:="-"
ta_MRCode{10}:="@"

va_HGRPré:=""
va_HGRNé:=!00-00-00!
vb_TuQuitte:=False:C215

LIST TO ARRAY:C288("TabSanté"; ta_Page)

// Modifié par : Scanu Rémy - remy@connect-io.fr (07/10/2021)
vl_ListePage:=Load list:C383("TabSanté")

ta_Page:=1
va_QuelDossier:="DE"

$T_Window_titre:="Dossier Santé"  //lpc plein écran 12/10/2018

F_LesOrientes(-1)
F_LesOrientes(0)

ve_Durée:=0
P_DS_SavePrescription(0)

READ WRITE:C146([DePart:1])
FORM SET INPUT:C55([DePart:1]; "DP_DosSanté")

va_Titre:="Dossier santé"

// Modifié par : Scanu Rémy (21/12/2021)
$position_t:="center"
outilsCreateWindowsForm("DP_DosSanté"; ->$position_t; Null:C1517; ->[DePart:1]; Null:C1517; ->$vl_Fenetre)

ADD RECORD:C56([DePart:1])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)

READ ONLY:C145([DePart:1])

<>PR_DoE:=0

If (vb_Show)
	Général_Show
End if 