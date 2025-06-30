//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Messagerie
//{
//{          Mercredi 19 juin 2001 à 14:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)

C_TEXT:C284(va_GroupeMes; vaTitreMes)
C_LONGINT:C283($vl_Fenetre)
C_BOOLEAN:C305(vb_Show)
C_DATE:C307(vd_DateMess)

va_GroupeMes:=$1
vb_Show:=False:C215

READ ONLY:C145(*)
SET MENU BAR:C67(1)

If (va_GroupeMes=<>va_Messagerie115)
	vaTitreMes:="Transmissions "
Else 
	vaTitreMes:="Transmissions "+va_GroupeMes
End if 

If (vb_Show)
	Général_Hide
End if 

QUERY:C277([Messagerie:34]; [Messagerie:34]MS_Groupe:5=$1; *)
QUERY:C277([Messagerie:34];  & ; [Messagerie:34]MS_Catégorie:6="")
MultiSoc_Filter(->[Messagerie:34])

ORDER BY:C49([Messagerie:34]; [Messagerie:34]MS_Date:2; <; *)
ORDER BY:C49([Messagerie:34]; [Messagerie:34]MS_Heure:3; <)

FORM SET INPUT:C55([Messagerie:34]; "MS_EcranSaisie")
FORM SET OUTPUT:C54([Messagerie:34]; "MS_EcranListe")

If (7=8)  //10/5/2010
	$vl_Fenetre:=i_FenêtreNo(670; 600; 4; vaTitreMes+" : "+String:C10(Records in selection:C76([Messagerie:34])); 4; "Quit_Simple")
Else 
	$vl_Fenetre:=i_FenêtreNo(670; 600; 4; vaTitreMes+" : "+String:C10(Records in selection:C76([Messagerie:34])); 14; "Quit_Simple")
End if 

MODIFY SELECTION:C204([Messagerie:34]; *)
CLOSE WINDOW:C154($vl_Fenetre)

Case of 
	: ($1=<>va_MessagerieSté)
		<>PR_MessagerieSté:=0
	: ($1=<>va_Messagerie115)
		<>PR_Messagerie115:=0
	Else 
		<>PR_Messagerie:=0
End case 

If (vb_Show)
	Général_Show
End if 