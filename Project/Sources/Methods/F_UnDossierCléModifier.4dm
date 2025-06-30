//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction :  F_UnDossierCléModifier
//{
//{          Mercredi 18 juillet 2001 à 10:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_LONGINT:C283(vl_IDT_RéfU)
C_TEXT:C284(va_IDT_Nom)
C_TEXT:C284(va_IDT_Pré)
C_DATE:C307(vd_IDT_NéLe)
C_TEXT:C284(va_IDT_Old)
C_TEXT:C284(va_IDT_Clé)
C_LONGINT:C283(vl_IDT_Stat)
C_LONGINT:C283(ve_IDT_Age)
vl_SourisXb:=0
vl_SourisYb:=0
vl_SourisBtb:=0

C_LONGINT:C283($vl_Fenetre)
If (7=8)
	READ WRITE:C146([DiaLogues:3])
	FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergéCléListe")
	$vl_Fenetre:=i_FenêtreNo(352; 362; 5; "Modifier la clé"; 3; "Quit_Simple")
	ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
	CLOSE WINDOW:C154($vl_Fenetre)
	READ ONLY:C145([DiaLogues:3])
End if 


READ WRITE:C146([DePart:1])
FORM SET INPUT:C55([DePart:1]; "DP_HébergéCléListe")
$vl_Fenetre:=i_FenêtreNo(352; 362; 5; "Modifier la clé"; 3; "Quit_Simple")
ADD RECORD:C56([DePart:1])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DePart:1])
$0:=vb_Valider