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

READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
ALL RECORDS:C47([Messagerie:34])
MultiSoc_Filter(->[Messagerie:34])
ORDER BY:C49([Messagerie:34]; [Messagerie:34]MS_Date:2; <; *)
ORDER BY:C49([Messagerie:34]; [Messagerie:34]MS_Heure:3; <)

If (7=7)
	FORM SET INPUT:C55([Messagerie:34]; "MS_EcranSaisie")
	FORM SET OUTPUT:C54([Messagerie:34]; "MS_EcranListe")
	$vl_Fenetre:=i_FenêtreNo(475; 448; 4; "Messagerie : "+String:C10(Records in selection:C76([Messagerie:34])); 4; "Quit_Simple")
	MODIFY SELECTION:C204([Messagerie:34]; *)
Else 
	READ WRITE:C146([DiaLogues:3])
	FORM SET INPUT:C55([DiaLogues:3]; "DL_Messagerie")
	$vl_Fenetre:=i_FenêtreNo(475; 448; 4; "Messagerie"; 4; "Quit_Simple")
	ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
	
	READ ONLY:C145([DiaLogues:3])
End if 
CLOSE WINDOW:C154($vl_Fenetre)
<>PR_Messagerie2:=0
If (vb_Show)
	Général_Show
End if 