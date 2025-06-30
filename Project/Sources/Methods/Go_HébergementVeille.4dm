//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementVeille
//{
//{          Mercredi 23 mars 2001 à 16:43
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($T_Window_titre)
C_LONGINT:C283($vl_Fenetre)
C_BOOLEAN:C305($B_Dummy)

C_TEXT:C284(va_NrPerma; va_Perimetre115; va_VeilleExpStatLib; va_Titre; va_Réservation; va_Emplacement; va_DossierSIAO; va_AutSol; va_TransFrom)
C_LONGINT:C283(vl_ii; vl_jj; vl_Der_HB; vl_RecCléID; vl_NombreNR; vL_NbFiches; ve_RecAge; ve_RecAgeDebut; ve_RecAgeFin; ve_RecReservation; ve_RecResDer1; ve_RecResDer2; ve_RecResPasDer1; ve_RecResPasDer2; ve_RecRes3; ve_Date_Cas)
C_REAL:C285(vr_TotalDistri)
C_BOOLEAN:C305(vb_Show; vb_OK; vb_RecClé; vb_LaCléEstCryptée)
C_DATE:C307(vd_Der_Date; vd_RecAge; vd_RecAgeDebut; vd_RecAgeFin)

ARRAY TEXT:C222(ta_PlageEnCours; 7)
ARRAY TEXT:C222(ta_DosSIAO_HG; 0)

ARRAY LONGINT:C221(tl_Der_Référence; 0)
ARRAY LONGINT:C221(tl_Der_HB; 0)
ARRAY LONGINT:C221(tl_Der_Nb; 0)
ARRAY LONGINT:C221(tl_DosSIAO_HG; 0)

ARRAY DATE:C224(td_Der_Date; 0)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

// desolé... :o)
ARRAY INTEGER:C220(<>te_FMGrpCK; Size of array:C274(<>ta_FMGrp))

COPY ARRAY:C226(<>ta_FMGrp; <>ta_FMGrpX)
For ($ii; 1; Size of array:C274(<>ta_FMGrpX))
	<>te_FMGrpCK{$ii}:=0
End for 

DébutDécTableCritèreVeille(1)

va_AutSol:=""
va_NrPerma:=""
va_Perimetre115:=""
va_Emplacement:=""
va_DossierSIAO:=""
va_VeilleExpStatLib:=""

vr_TotalDistri:=0
vl_RecCléID:=0
vl_NombreNR:=0
vL_NbFiches:=0
ve_RecAge:=0
ve_RecAgeDebut:=0
ve_RecAgeFin:=0
ve_RecReservation:=0
ve_RecResDer1:=0
ve_RecResDer2:=0
ve_RecResPasDer1:=0
ve_RecResPasDer2:=0
ve_RecRes3:=0
ve_Date_Cas:=0

vd_RecAge:=Current date:C33
vd_RecAgeDebut:=!00-00-00!
vd_RecAgeFin:=!00-00-00!

vb_Show:=False:C215
vb_RecClé:=False:C215
vb_LaCléEstCryptée:=False:C215

P_Profil

//AUTRES CRITERES
DébutDécTableCritèreVeille(2)
P_HébergementVeilleSort(0)
//••• FIN TABLEAU •••

ta_PlageEnCours{1}:="Aujourd'hui"
ta_PlageEnCours{2}:="Semaine en cours"
ta_PlageEnCours{3}:="Quinzaine en cours"
ta_PlageEnCours{4}:="Mois en cours"
ta_PlageEnCours{5}:="Trimestre en cours"
ta_PlageEnCours{6}:="Semestre en cours"
ta_PlageEnCours{7}:="Année en cours"
ta_PlageEnCours:=1
ta_PlageEnCours{0}:=ta_PlageEnCours{ta_PlageEnCours}

$B_Dummy:=F_Report_FullDuplexVAR
$B_Dummy:=F_SIAO_DansHebergement("Declarer")

$T_Window_titre:="Veille"

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergementVeille_b")

$vl_Fenetre:=FEN_OpenFormWindow(->[DiaLogues:3]; "DL_HébergementVeille_b"; Form fenêtre standard:K39:10; $T_Window_titre)  // #20171201-1"
MAXIMIZE WINDOW:C453($vl_Fenetre)

ADD RECORD:C56([DiaLogues:3])
UNLOAD RECORD:C212([DiaLogues:3])

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

POST OUTSIDE CALL:C329(<>PR_HBNotesV)
<>PR_HébergementVeille:=0

If (vb_Show)
	Général_Show
End if 