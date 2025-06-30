//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_VoirStatutSP
//{
//{          Mercredi 10 Août 2001 à 20:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_LONGINT:C283($vl_Fenetre)

READ ONLY:C145([HeBerge:4])

QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$1)
MultiSoc_Filter(->[HeBerge:4])

If (Records in selection:C76([HeBerge:4])=1)
	FORM SET INPUT:C55([HeBerge:4]; "HB_NotesVoirSP")
	$vl_Fenetre:=i_FenêtreNo(440; 494; 16; "Notes SP"; 3; "Quit_Simple")
	
	MODIFY SELECTION:C204([HeBerge:4])
	CLOSE WINDOW:C154($vl_Fenetre)
End if 