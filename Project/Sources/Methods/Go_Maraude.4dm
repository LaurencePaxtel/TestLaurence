//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_MaraudeVeille
//{
//{          Mercredi 23 mars 2001 à 16:43
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
C_LONGINT:C283(vl_RéfU_HB)
C_LONGINT:C283(vl_RéfU_HG)
C_LONGINT:C283(vl_NbHGi; vl_NbHGib)
vL_Nb_HB_F:=0
vL_Nb_HG_F:=0
vb_Show:=False:C215
vb_passe1:=False:C215
vl_RéfU_HB:=0
vl_RéfU_HG:=0
ve_NbMar:=0
C_TEXT:C284(va_Rép)
C_TEXT:C284(va_Rép2)
va_Rép:=""
va_Rép2:=""
C_BOOLEAN:C305(vb_JouN)
vb_JouN:=True:C214  //nuit
C_BOOLEAN:C305(vb_MRferme)
C_LONGINT:C283(r1; r2)
r1:=Num:C11(<>vb_MarNuit=False:C215)
r2:=Num:C11(<>vb_MarNuit=True:C214)
vb_JouN:=<>vb_MarNuit

V_HG_Dec(0)
V_HG_Dec(1)
p_VarMR(0)
If (F_VariablesTransite(0; 0; False:C215))
End if 
If (F_VariablesTransite(1; 0; False:C215))
End if 

ARRAY TEXT:C222(ta_MRLib; 7)
ARRAY TEXT:C222(ta_MRCode; 7)
ta_MRLib{1}:="Papiers d'identité"
ta_MRLib{2}:="Couverture sociale"
ta_MRLib{3}:="Ressources"
ta_MRLib{4}:="Régime"
ta_MRLib{5}:="Suivi social"
ta_MRLib{6}:="-"
ta_MRLib{7}:="Tous"

ta_MRCode{1}:="Identité"
ta_MRCode{2}:="Couverture"
ta_MRCode{3}:="Ressources"
ta_MRCode{4}:="Régime"
ta_MRCode{5}:="Suivi"
ta_MRCode{6}:="-"
ta_MRCode{7}:="@"


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
ta_Page{1}:="Maraude"
ta_Page{2}:="Fiche sociale"
ta_Page{3}:="Référents"
ta_Page{4}:="Sanitaire"
ta_Page:=1
C_TEXT:C284(va_QuelDossier)
va_QuelDossier:="MR"

F_LesOrientes(-1)
F_LesOrientes(0)
C_TEXT:C284(vt_TempNOTEMAR; vt_TempNOTEMAR2)

READ WRITE:C146([DePart:1])
FORM SET INPUT:C55([DePart:1]; "DP_Maraude")
va_Titre:="Maraude"

C_TEXT:C284($T_Window_titre)
$T_Window_titre:="Maraude"

C_LONGINT:C283($vl_Fenetre)
$vl_Fenetre:=i_FenêtreNo(800; 660; 4; va_Titre; 1; "Quit_Show")
//$vl_Fenetre:=FEN_OpenFormWindow (->[DePart];"DP_Maraude";Plain form window;$T_Window_titre)  //lpc plein écran 12/10/2018
ADD RECORD:C56([DePart:1])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DePart:1])



<>PR_Maraude:=0
If (vb_Show)
	Général_Show
End if 