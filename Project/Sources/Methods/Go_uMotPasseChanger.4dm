//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uMotPasseChanger
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_Fenetre)

C_TEXT:C284(va_MPmot1; va_MPmot2; va_MPmotOld)
C_BOOLEAN:C305(vb_OKMP)

va_Titre:="Modification du mot de passe"

If (<>vb_T_MPMasquePlus)  //6/4/2011
	$vl_Fenetre:=i_FenêtreNo(466; 307; 16; va_Titre; 3; "Quit_Simple")
	
	DIALOG:C40([DiaLogues:3]; "DL_ChangerMtPasseLG")
	CLOSE WINDOW:C154($vl_Fenetre)
Else 
	$vl_Fenetre:=i_FenêtreNo(466; 212; 16; va_Titre; 3; "Quit_Simple")
	
	DIALOG:C40([DiaLogues:3]; "DL_ChangerMtPasse")
	CLOSE WINDOW:C154($vl_Fenetre)
End if 