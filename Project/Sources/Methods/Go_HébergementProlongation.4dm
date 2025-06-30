//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementProlongation
//{
//{          Lundi 2 août 2004 à 18:05
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii)

C_TEXT:C284(va_Titre; va_Réservation; va_Emplacement; va_FinRésa; va_GPClé; va_GPLib; va_CtrLib; va_RésaEffectuée)
C_LONGINT:C283(ve_QuelCas)
C_BOOLEAN:C305(vb_Show)
C_DATE:C307(vd_LastDate; vd_FinRésa)

va_FinRésa:=""
va_CtrLib:=""

va_RH_Typ1:=""
va_RH_Typ2:=""

va_RH_PlateF:=""

vl_RH_RéfID:=0

vb_Show:=False:C215
vb_RH_Médic:=False:C215

vd_LastDate:=!00-00-00!
vd_FinRésa:=!00-00-00!
vb_RecHéb:=False:C215

READ ONLY:C145(*)
SET MENU BAR:C67(1)

SCAN INDEX:C350([HeberGement:5]HG_Date:4; 1; <)
vd_LastDate:=[HeberGement:5]HG_Date:4

P_Tab_PR(0; 0)

//groupes
ARRAY TEXT:C222(<>ta_PRGroupe; 0)
ARRAY INTEGER:C220(<>te_PRGroupe; 0)

//groupes
COPY ARRAY:C226(<>ta_FMGrpX; <>ta_PRGroupe)
ARRAY INTEGER:C220(<>te_PRGroupe; Size of array:C274(<>ta_PRGroupe))

For ($ii; 1; Size of array:C274(<>ta_PRGroupe))
	<>te_PRGroupe{$ii}:=1
End for 

CREATE SET:C116([GrouPe:36]; "E_Groupe")

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergementProlongation")

va_Titre:="Prolongations"
$vl_Fenetre:=i_FenêtreNo(786; 508; 4; va_Titre; 1; "Quit_Show")

ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

P_Tab_PR(0; 0)

<>PR_Prolongation:=0

If (vb_Show)
	Général_Show
End if 