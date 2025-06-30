//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uTablesHébergés
//{
//{          Lundi 18 juin 2001 à 11:27:55
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
i_Message("Chargement en cours…")
C_LONGINT:C283(vL_Nb_HG_F; $vl_EcranL)
C_BOOLEAN:C305(vb_OK)
vb_OK:=False:C215
C_TEXT:C284(vt_Champs)
vt_Champs:=""
C_LONGINT:C283(ve_Genre; ve_GenreHB)
ve_Genre:=0
ve_GenreHB:=-1
C_LONGINT:C283($ii; $kk)

C_LONGINT:C283(ve_Type)
C_LONGINT:C283(vl_Long)
C_BOOLEAN:C305(vb_Index)

$kk:=Get last field number:C255(->[HeBerge:4])
ARRAY TEXT:C222(ta_Champs; $kk)
ARRAY POINTER:C280(tp_Champs; $kk)
ARRAY INTEGER:C220(te_ChampsType; $kk)
For ($ii; 1; $kk)
	If (Substring:C12(Field name:C257(Table:C252(->[HeBerge:4]); $ii); 1; 3)="HB_")
		ta_Champs{$ii}:=Substring:C12(Field name:C257(Table:C252(->[HeBerge:4]); $ii); 4)
	Else 
		ta_Champs{$ii}:=Field name:C257(Table:C252(->[HeBerge:4]); $ii)
	End if 
	tp_Champs{$ii}:=Field:C253(Table:C252(->[HeBerge:4]); $ii)
	GET FIELD PROPERTIES:C258(tp_Champs{$ii}; ve_Type; vl_Long; vb_Index)
	te_ChampsType{$ii}:=ve_Type
End for 
SORT ARRAY:C229(ta_Champs; tp_Champs; te_ChampsType; >)
CLOSE WINDOW:C154

va_Titre:="Liste des hébergés (Demandeurs) : "
READ ONLY:C145([HeBerge:4])
FORM SET OUTPUT:C54([HeBerge:4]; "V_Développeur")
ALL RECORDS:C47([HeBerge:4])
MultiSoc_Filter(->[HeBerge:4])
vL_Nb_HG_F:=Records in selection:C76([HeBerge:4])
FIRST RECORD:C50([HeBerge:4])
If (<>vl_EcranL>(1148+15))
	$vl_EcranL:=(1148+15)
Else 
	$vl_EcranL:=<>vl_EcranL-10
End if 
$vl_Fenetre:=i_FenêtreNo($vl_EcranL; <>vl_EcranH-60; 8; va_Titre+String:C10(vL_Nb_HG_F); 1; "Quit_Simple")
DISPLAY SELECTION:C59([HeBerge:4]; *)
CLOSE WINDOW:C154($vl_Fenetre)

<>PR_DévTablesHB:=0
If (vb_Show)
	Général_Show
End if 