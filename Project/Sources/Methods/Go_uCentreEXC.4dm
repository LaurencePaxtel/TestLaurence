//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uCentreEXC
//{
//{          Mercredi 5 mai 2004 à 11:19:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 


C_LONGINT:C283(vl_TT; vl_NT)

C_TEXT:C284(va_CCE_Nom)
va_CCE_Nom:=""

ARRAY INTEGER:C220(te_CCE_Check; 0)

ARRAY BOOLEAN:C223(tb_CCE_Check; 0)
ARRAY LONGINT:C221(tl_CCE_Réf; 0)
ARRAY TEXT:C222(ta_CCE_Lieu; 0)
ARRAY TEXT:C222(ta_CCE_Nom; 0)
ARRAY TEXT:C222(ta_CCE_Ville; 0)

C_TIME:C306(vh_CentreEXChD)
C_TIME:C306(vh_CentreEXChF)
vh_CentreEXChD:=<>vh_CentreEXChD
vh_CentreEXChF:=<>vh_CentreEXChF
ALL RECORDS:C47([LesCentres:9])
MultiSoc_Filter(->[LesCentres:9])
ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tl_CCE_Réf; [LesCentres:9]LC_Excuse:49; tb_CCE_Check; [LesCentres:9]LC_Lieu:5; ta_CCE_Lieu; [LesCentres:9]LC_Nom:4; ta_CCE_Nom; [LesCentres:9]LC_Ville:28; ta_CCE_Ville)
vl_TT:=Size of array:C274(tl_CCE_Réf)
ARRAY INTEGER:C220(te_CCE_Check; vl_TT)
vl_NT:=0
For ($ii; 1; vl_TT)
	te_CCE_Check{$ii}:=Num:C11(tb_CCE_Check{$ii}=True:C214)
	vl_NT:=vl_NT+te_CCE_Check{$ii}
End for 
va_CCE_Nom:=String:C10(vl_TT)+" dont : "+String:C10(vl_NT)+" sélectionné(s)"
va_Titre:="Paramétrage des centres"
$vl_Fenetre:=i_FenêtreNo(633; 508; 16; va_Titre; 1; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_CentreEXC")
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_CentreEXC:=0
If (vb_Show)
	Général_Show
End if 