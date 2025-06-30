//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : Go_HébergementReport  
//{
//{          Lundi 21 mai 2001 à 18:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii; $vl_Fenetre)

C_TEXT:C284(va_TransFrom; Va_NoUFicR; va_Rép; va_Rép2; va_Réservation)
C_LONGINT:C283(uEmplace; vL_NbFiches; vl_RéfU_HG; vl_Page; vl_RéfU_HBB; vl_IDT_IDHB; vl_IDT_IDHG; vl_NoRéfHG; vl_NoFicheHG; vl_NoRéfHGNb)
C_BOOLEAN:C305(vb_Show; vb_IDT_NUIT; vb_RatrapageSelection)
C_TIME:C306(vh_Clic1)

ARRAY TEXT:C222(ta_xTri; 5)

ARRAY INTEGER:C220(te_xTri; 5)

ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
ARRAY LONGINT:C221(tl_RATTRAPE_Réf_HG; 0)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vb_Show:=False:C215
vb_OK:=F_Report_FullDuplexVAR  //••   `Variables communes au report

uEmplace:=1
vL_NbFiches:=0
vl_RéfU_HG:=0
vl_Page:=0

vh_Clic1:=?00:00:00?

F_VariablesTransite(0; 2; False:C215)
vb_RatrapageSelection:=False:C215

For ($ii; 1; Size of array:C274(ta_xTri))
	te_xTri{$ii}:=0
End for 

ta_xTri{1}:="> Centre"
ta_xTri{2}:="> Code postal"
ta_xTri{3}:="< Date"
ta_xTri{4}:="> Nom"
ta_xTri{5}:="> Numéro de fiche"

ta_xTri:=3
ta_xTri{0}:=ta_xTri{ta_xTri}

vL_NbFiches:=Records in table:C83([HeberGement:5])

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_Reports")

va_Titre:="Reports"

$vl_Fenetre:=i_FenêtreNo(1100; 508; 4; va_Titre; 1; "Quit_Show")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur

CLOSE WINDOW:C154
READ ONLY:C145([DiaLogues:3])

POST OUTSIDE CALL:C329(<>PR_HBNotesV)
<>PR_Repor:=0

If (vb_Show)
	Général_Show
End if 