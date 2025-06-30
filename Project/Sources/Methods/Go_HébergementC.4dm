//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementC (ercher)  
//{
//{          Lundi 28 Juillet 1997 à 17:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)

C_TEXT:C284($T_Window_titre)
C_BOOLEAN:C305($vb_OK)

C_TEXT:C284(va_JourNuit; va_HGRNom; va_HGRPré; va_GPClé; va_Transfert_HBAlors; va_Transfert_Centre; va_NNN; va_FrappeClavier; va_IDT_CléFam; vt_AccesDossierSIAO_HG)
C_LONGINT:C283(vL_Nb_HB_F; vL_Nb_HG_F; vl_SourisX; vl_SourisY; vl_SourisBt; ve_NbSP; vl_NbHGi; vl_AccesDossierSIAO_HG; wSansFiltre)
C_BOOLEAN:C305(vb_Show; vb_DoubleClic; vb_PasseR)
C_DATE:C307(vd_HGRNé)

// Modifié par : Scanu Rémy (05/08/2022)
C_LONGINT:C283(ve_Cdr1T; ve_Cdr1L; ve_Cdr1B; ve_Cdr1R; ve_Cdr2T; ve_Cdr2L; ve_Cdr2B; ve_Cdr2R; ve_Cdr3T; ve_Cdr3L; ve_Cdr3B; ve_Cdr3R; \
ve_Cdr4T; ve_Cdr4L; ve_Cdr4B; ve_Cdr4R; ve_Cdr5T; ve_Cdr5L; ve_Cdr5B; ve_Cdr5R)

SET MENU BAR:C67(1)

vb_Show:=False:C215

If (vb_Show)
	Général_Hide
End if 

vb_DoubleClic:=$1
vb_PasseR:=False:C215

// Modifié par : Scanu Rémy (05/08/2022)
va_JourNuit:=$2
va_FormatFrom:=$3

va_HGRNom:=""
va_HGRPré:=""
va_NNN:=""
va_FrappeClavier:=""
va_IDT_CléFam:=""
va_Rép2:=""
va_Gpe:=""

vd_HGRNé:=!00-00-00!

vL_Nb_HB_F:=0
vL_Nb_HG_F:=0
vl_SourisX:=0
vl_SourisY:=0
vl_SourisBt:=0

//Liste des demandeurs      
ve_Cdr1L:=11
ve_Cdr1T:=290
ve_Cdr1R:=991
ve_Cdr1B:=461

//Liste des situations
ve_Cdr2L:=6
ve_Cdr2T:=257
ve_Cdr2R:=764
ve_Cdr2B:=325

//Liste des situations Page 2
ve_Cdr5L:=6
ve_Cdr5T:=264
ve_Cdr5R:=764
ve_Cdr5B:=502

//Liste des Groupes
ve_Cdr3L:=6
ve_Cdr3T:=285
ve_Cdr3R:=267
ve_Cdr3B:=502

//Liste des Membres
ve_Cdr4L:=10
ve_Cdr4T:=863
ve_Cdr4R:=444
ve_Cdr4B:=993

READ ONLY:C145(*)


wSansFiltre:=0

F_LesOrientes(-1)
F_LesOrientes(0)

$vb_OK:=F_SIAO_DansHebergement("Declarer")

P_HébergementProfil("J"; "")

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergementGpe")

$T_Window_titre:="Recherche des personnes"

$vl_Fenetre:=FEN_OpenFormWindow(->[DiaLogues:3]; "DL_HébergementGpe"; Form fenêtre standard:K39:10; $T_Window_titre)  // lpc 14/12/2017 plein ecran
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_HébergementC:=0

If (vb_Show)
	Général_Show
End if 

POST OUTSIDE CALL:C329(<>PR_Genéral)