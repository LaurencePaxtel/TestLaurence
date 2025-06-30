//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_MailReportEnvoyer
//{
//{          Lundi 3 mai 2010 à 14:35:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)

C_TEXT:C284($vt_M_MailBody)
C_LONGINT:C283($vl_SMTP_ID)
C_BOOLEAN:C305($vb_EnvoyeOK; $vb_OK)

$vt_M_MailBody:=_O_Mac to ISO:C519(<>vt_M_MailBody)
<>vt_M_MailErreur:=""

Case of 
	: (Not:C34(F_MailErreur("SMTP_New"; SMTP_New($vl_SMTP_ID))))
	: (Not:C34(F_MailErreur("SMTP_Host"; SMTP_Host($vl_SMTP_ID; <>vt_M_SMTP_Host))))
	: (Not:C34(F_MailErreur("SMTP_From"; SMTP_From($vl_SMTP_ID; <>vt_M_MailFrom))))
	: (Not:C34(F_MailErreur("SMTP_To"; SMTP_To($vl_SMTP_ID; <>vt_M_MailToListe))))
	: (Not:C34(F_MailErreur("SMTP_Subject"; SMTP_Subject($vl_SMTP_ID; _O_Mac to ISO:C519(<>vt_M_MailObjet)))))
	: (Not:C34(F_MailErreur("SMTP_Body"; SMTP_Body($vl_SMTP_ID; $vt_M_MailBody))))
	: (Not:C34(F_MailErreur("SMTP_Send"; SMTP_Send($vl_SMTP_ID))))
	Else 
		$vb_EnvoyeOK:=True:C214  // Message composé et envoyé avec succès
End case 

If ($vl_SMTP_ID#0)  // Si un message a été créé en mémoire, nous devons l'effacer maintenant
	$vb_OK:=F_MailErreur("SMTP_Clear"; SMTP_Clear($vl_SMTP_ID))
End if 

If ($vb_EnvoyeOK)
	<>vt_M_MailBody:=Replace string:C233(<>vt_M_MailBody; Char:C90(10); "")
	$vb_OK:=F_MailReport_Message(False:C215; "OK"; "Envoi mail "+"effectué"; "Liste des personnes en fin d'hébergement"+<>va_CR+<>vt_M_MailBody)
Else 
	$vb_OK:=F_MailReport_Message(False:C215; "NON"; "Envoi mail : "+"l'envoi a échoué"; "Liste des personnes en fin d'hébergement"+<>va_CR+"ERREURS"+<>va_CR+<>vt_M_MailErreur)
End if 