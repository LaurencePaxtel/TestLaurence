//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_DisposLitsFacil
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284(va_DateType)
C_LONGINT:C283(vL_NbFiches; vl_RéfU_HG; vl_Page)
C_TIME:C306(vh_Clic1)
C_DATE:C307(vd_DateEnCours)

vL_NbFiches:=0
vl_RéfU_HG:=0
vh_Clic1:=?00:00:00?

vd_DateEnCours:=!00-00-00!

READ WRITE:C146([DiaLogues:3])
READ ONLY:C145([CentresLits:16])

READ ONLY:C145(*)
SET MENU BAR:C67(1)

Général_Hide

va_Titre:="Situation des centres"
FORM SET INPUT:C55([DiaLogues:3]; "DL_CtrDispoFacil")

$vl_Fenetre:=i_FenêtreNo(810; 520; 4; va_Titre; 1; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3])

CLOSE WINDOW:C154($vl_Fenetre)

<>PR_LitsFacil:=0

READ ONLY:C145([DiaLogues:3])
READ ONLY:C145([CentresLits:16])

Général_Show