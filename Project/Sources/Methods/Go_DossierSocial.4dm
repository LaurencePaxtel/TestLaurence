//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_DossierSocial  
//{
//{          Lundi 18 juin 2001 à 11:27:55
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

C_BOOLEAN:C305(vb_passe1)
C_BOOLEAN:C305(vb_TuQuitte)
C_LONGINT:C283(vL_Nb_HB_F)
C_LONGINT:C283(vL_Nb_HG_F)
C_TEXT:C284(va_Nb_HG_F)
C_TIME:C306(vh_Clic1)
C_TIME:C306(vh_Clic2)
vL_Nb_HB_F:=0
vL_Nb_HG_F:=0
vb_passe1:=False:C215
ve_NbMar:=0

C_BOOLEAN:C305(vb_MRferme)

V_HG_Dec(0)
V_HG_Dec(1)

If (F_VariablesTransite(0; 1; False:C215))
End if 
If (F_VariablesTransite(1; 1; False:C215))
End if 
P_VarDS(0)

ARRAY TEXT:C222(ta_MRLib; 10)
ARRAY TEXT:C222(ta_MRCode; 10)
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

C_TEXT:C284(va_HGRPré)
C_DATE:C307(va_HGRNé)
va_HGRPré:=""
va_HGRNé:=!00-00-00!
vb_TuQuitte:=False:C215
C_LONGINT:C283(vL_RéfHBOld)
C_LONGINT:C283(vL_RéfHBNew)
C_TEXT:C284(vt_Texte)
C_TEXT:C284(va_MRsexe)




ARRAY TEXT:C222(ta_Page; 4)
ta_Page{1}:="Dossier social"
ta_Page{2}:="Sortie"
ta_Page{3}:="Enfants"
ta_Page{4}:="Référents"
ta_Page:=1

C_TEXT:C284(va_QuelDossier)
va_QuelDossier:="DS"

C_TEXT:C284($T_Window_titre)
$T_Window_titre:="Dossier Social"


F_LesOrientes(-1)
F_LesOrientes(0)


READ WRITE:C146([DePart:1])
FORM SET INPUT:C55([DePart:1]; "DP_DosSocial")
va_Titre:="Dossier social"
//$vl_Fenetre:=i_FenêtreNo (786;508;4;va_Titre;1;"Quit_Show")
$vl_Fenetre:=FEN_OpenFormWindow(->[DePart:1]; "DP_DosSocial"; Form fenêtre standard:K39:10; $T_Window_titre)  //lpc plein écran 12/10/2018
//lpc plein écran 12/10/2018
ADD RECORD:C56([DePart:1])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DePart:1])

<>PR_DoS:=0
If (vb_Show)
	Général_Show
End if 