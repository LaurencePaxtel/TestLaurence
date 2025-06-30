//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : F_MailTauxEnvoyer
//{          Mardi 26 octobre 2010 à 16:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
$0:=False:C215
C_LONGINT:C283($vl_SMTP_ID)
C_BOOLEAN:C305($vb_EnvoyeOK; $vb_OK)
<>vt_M_MailErreur:=""
C_TEXT:C284($vt_M_MailToListe)
C_TEXT:C284($vt_M_MailObjet)
C_TEXT:C284($vt_M_MailBody)
$vt_M_MailBody:=$1


$vt_M_MailObjet:="Taux d'occupation"
$vt_M_MailToListe:="fpc@paxtel.fr"
$vt_M_MailToListe:="taux@paxtel.fr"

$vb_EnvoyeOK:=False:C215  //Indicateur précisant s'il est applicable à toutes les commandes
Case of 
		
	: (Not:C34(F_MailErreur("SMTP_New"; SMTP_New($vl_SMTP_ID))))
		
	: (Not:C34(F_MailErreur("SMTP_Host"; SMTP_Host($vl_SMTP_ID; <>vt_M_SMTP_Host))))
		
	: (Not:C34(F_MailErreur("SMTP_From"; SMTP_From($vl_SMTP_ID; <>vt_M_MailFrom))))
		
	: (Not:C34(F_MailErreur("SMTP_To"; SMTP_To($vl_SMTP_ID; $vt_M_MailToListe))))
		
	: (Not:C34(F_MailErreur("SMTP_Subject"; SMTP_Subject($vl_SMTP_ID; _O_Mac to ISO:C519($vt_M_MailObjet)))))
		
	: (Not:C34(F_MailErreur("SMTP_Body"; SMTP_Body($vl_SMTP_ID; $vt_M_MailBody))))
		
	: (Not:C34(F_MailErreur("SMTP_Send"; SMTP_Send($vl_SMTP_ID))))
		
	Else 
		$vb_EnvoyeOK:=True:C214  //Message composé et envoyé avec succès
		
End case 

If ($vl_SMTP_ID#0)  //Si un message a été créé en mémoire, nous devons l'effacer maintenant
	$vb_OK:=F_MailErreur("SMTP_Clear"; SMTP_Clear($vl_SMTP_ID))
End if 