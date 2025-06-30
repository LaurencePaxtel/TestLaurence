//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_MailErreur
//{
//{          Lundi 3 mai 2010 à 14:35:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=True:C214
C_TEXT:C284($1)  //Quelle commande
C_LONGINT:C283($2)  //Quelle erreur
If ($2#0)
	<>vt_M_MailErreur:=<>vt_M_MailErreur+(<>va_CR*Num:C11(<>vt_M_MailErreur>""))+$1+" (erreur "+String:C10($2)+") : "+IT_ErrorText($2)
	$0:=False:C215
End if 