//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_EnCoursMono
//{
//{          Lundi 14 décembre 2009 à 14:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
$0:=False:C215
C_LONGINT:C283($1)

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)

Case of 
	: ($1=1)
		//Si le report en mono est en cours : faire patienter
		$vb_OK:=False:C215
		$vb_OK:=(<>vl_TypeApplication=_o_4D Interpreted Desktop:K5:3)
		$vb_OK:=$vb_OK | (<>vl_TypeApplication=4D Desktop:K5:4)
		$vb_OK:=$vb_OK | (<>vl_TypeApplication=4D Volume Desktop:K5:2)
		$vb_OK:=$vb_OK | (<>vl_TypeApplication=4D mode local:K5:1)
		If ($vb_OK)
			$vb_OKreport:=False:C215
			If (vb_ReportAuto)
				If (PR_ReportServeur>0)
					$0:=True:C214
				End if 
			End if 
		End if 
		
	: ($1=2)
/*
i_Message("Veuillez patienter jusqu'à la fermeture du report !")
vb_ReportAuto:=Faux
$ii:=Statut du process(<>PR_ReportServeur)
Si ($ii=Endormi)
RÉACTIVER PROCESS(<>PR_ReportServeur)
Fin de si 
Repeter 
vb_ReportAuto:=Faux
APPELER 4D
APPELER 4D
Jusque (<>PR_ReportServeur=0)
FERMER FENÊTRE
$0:=Vrai
*/
End case 