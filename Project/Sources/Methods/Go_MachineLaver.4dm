//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_MachineLaver
//{
//{          Lundi 10 janvier 2011 à 17:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_Fenetre)
C_BOOLEAN:C305($vb_OK)

C_TEXT:C284(va_Titre; va_UnLib45; va_NNN; va_FrappeClavier; va_IDT_CléFam; va_IDT_LienFam; va_IDT_Typ1; va_IDT_Clé; va_IDT_Nom; va_IDT_Pré; \
va_Plage_1; va_Plage_2; va_Plage_3; va_Plage_4; va_Plage_5; va_Plage_6; va_MachineLib; va_MachineLibAbrev; va_Semaine)
C_LONGINT:C283(veD1; veD2; veD3; veD4; veD5; veD6; veD7; vl_UneRéfID; vL_NbFiches; vl_Sel_CleUnique; vL_Nb_HG_F; vl_NbHGi; vL_Nb_SI_F; \
vl_NbHGs; ve_NbSP; vl_CleUnique_ID; vL_Nb_HB_F; vL_Nb_HG_F; vl_RéfU_HBB; ve_IDT_Age; ve_IDT_PCAge; x_IDTG_1; x_IDTG_2; vl_MachineLe_ID; \
b_Sel_H_1_1; b_Sel_H_1_2; b_Sel_H_1_3; b_Sel_H_1_4; b_Sel_H_1_5; b_Sel_H_1_6; b_Sel_H_1_7; b_Sel_H_2_1; b_Sel_H_2_2; b_Sel_H_2_3; \
b_Sel_H_2_4; b_Sel_H_2_5; b_Sel_H_2_6; b_Sel_H_2_7; b_Sel_H_3_1; b_Sel_H_3_2; b_Sel_H_3_3; b_Sel_H_3_4; b_Sel_H_3_5; b_Sel_H_3_6; \
b_Sel_H_3_7; b_Sel_H_4_1; b_Sel_H_4_2; b_Sel_H_4_3; b_Sel_H_4_4; b_Sel_H_4_5; b_Sel_H_4_6; b_Sel_H_4_7; b_Sel_H_5_1; b_Sel_H_5_2; \
b_Sel_H_5_3; b_Sel_H_5_4; b_Sel_H_5_5; b_Sel_H_5_6; b_Sel_H_5_7; b_Sel_H_6_1; b_Sel_H_6_2; b_Sel_H_6_3; b_Sel_H_6_4; b_Sel_H_6_5; \
b_Sel_H_6_6; b_Sel_H_6_7)
C_BOOLEAN:C305(vb_OK; vb_Sel_CleUnique)
C_DATE:C307(vd_DateJour; vd_DateRef; vd_IDT_NéLe; vdD1; vdD2; vdD3; vdD4; vdD5; vdD6; vdD7)
C_TIME:C306(vh_PlageD_1; vh_PlageF_1; vh_PlageD_2; vh_PlageF_2; vh_PlageD_3; vh_PlageF_3; vh_PlageD_4; vh_PlageF_4; vh_PlageD_5; \
vh_PlageF_5; vh_PlageD_6; vh_PlageF_6)
C_POINTER:C301(vp_UnPointeur)

va_NNN:=""
va_FrappeClavier:=""
va_IDT_CléFam:=""
va_IDT_LienFam:=""
va_IDT_Typ1:=""
va_IDT_Clé:=""
va_IDT_Nom:=""
va_IDT_Pré:=""

// LesJours de la semaine
va_Plage_1:=""
va_Plage_2:=""
va_Plage_3:=""
va_Plage_4:=""
va_Plage_5:=""
va_Plage_6:=""

va_MachineLib:=""
va_MachineLibAbrev:=""

vL_Nb_HB_F:=0
vL_Nb_HG_F:=0
ve_IDT_Age:=0
ve_IDT_PCAge:=0
x_IDTG_1:=0
x_IDTG_2:=0
vl_MachineLe_ID:=0

vd_IDT_NéLe:=!00-00-00!
vd_DateRef:=!00-00-00!
vd_DateJour:=Current date:C33(*)

SET MENU BAR:C67(1)
READ ONLY:C145(*)

$vb_OK:=F_Planning_OP(0; 0)
$vb_OK:=F_Planning_OP(1; 0)

//Semaine en cours
Uut_Tab_AnnSem(vd_DateJour)

te_Année:=Find in array:C230(te_Année; Year of:C25(vd_DateJour))
te_Année{0}:=te_Année

$vb_OK:=F_Planning_OB(0; 0)
$vb_OK:=F_Planning_OB(2; 0)

READ WRITE:C146([DiaLogues:3])

FORM SET INPUT:C55([DiaLogues:3]; "DL_MachineLaver")
$vl_Fenetre:=i_FenêtreNo(876; 608; 4; "Planning"; 1; "Quit_Simple")

ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_MachineLaver:=0