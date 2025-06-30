//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_DossierPsycho  
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


SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_passe1)
C_BOOLEAN:C305(vb_TuQuitte)
C_LONGINT:C283(vL_Nb_HB_F)
C_LONGINT:C283(vL_Nb_HG_F)
C_TEXT:C284(va_Nb_HG_F)

C_LONGINT:C283(vl_RéfU_HB)
C_LONGINT:C283(vl_RéfU_HG)
vL_Nb_HB_F:=0
vL_Nb_HG_F:=0

vb_passe1:=False:C215

vl_RéfU_HB:=0
vl_RéfU_HG:=0
ve_NbMar:=0
C_TEXT:C284(va_Rép)
C_TEXT:C284(va_Rép2)
va_Rép:=""
va_Rép2:=""
C_BOOLEAN:C305(vb_MRferme)

C_TEXT:C284(vt_Txti1; vt_Txti2; vt_Txti3; vt_Txti4; vt_Txti5)
vt_Txti1:=""
vt_Txti2:=""
vt_Txti3:=""
vt_Txti4:=""
vt_Txti5:=""

V_HG_Dec(0)
V_HG_Dec(1)

If (F_VariablesTransite(0; 1; False:C215))
End if 
If (F_VariablesTransite(1; 1; False:C215))
End if 
C_TEXT:C284(va_HGRPré)
C_DATE:C307(va_HGRNé)
va_HGRPré:=""
va_HGRNé:=!00-00-00!
vb_TuQuitte:=False:C215
C_LONGINT:C283(vL_RéfHBOld)
C_LONGINT:C283(vL_RéfHBNew)
C_TEXT:C284(vt_Texte)
C_TEXT:C284(va_MRsexe)

C_TEXT:C284(va_QuelDossier)
va_QuelDossier:="Dy"

C_TEXT:C284($T_Window_titre)
$T_Window_titre:="Dossier psycho-social) //lpc plein écran 12/10/2018"

F_LesOrientes(-1)
F_LesOrientes(0)


READ WRITE:C146([DePart:1])
FORM SET INPUT:C55([DePart:1]; "DP_DosPsycho")
va_Titre:="Dossier psycho-social"
//$vl_Fenetre:=i_FenêtreNo (786;508;4;va_Titre;1;"Quit_Show")
$vl_Fenetre:=FEN_OpenFormWindow(->[DePart:1]; "DP_DosPsycho"; Form fenêtre standard:K39:10; $T_Window_titre)  //lpc plein écran 12/10/2018
ADD RECORD:C56([DePart:1])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DePart:1])


<>PR_DoP:=0
If (vb_Show)
	Général_Show
End if 