//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplexChemein
//{
//{          Vendrdi 24 octobre 2008 à 16:11
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_BOOLEAN:C305($1)
C_BOOLEAN:C305($vb_OK)


//Tester l'éxistance du répertoire
$vb_OK:=(<>vt_T_CheminRép>"")
If ($vb_OK)
	$vb_OK:=F_Répertoire(<>vt_T_CheminRép)
End if 
If ($vb_OK=False:C215)
	$vb_OK:=F_Report_FullDuplexMessage2($1; "Transfert NO"; "Report Transfert non effectué"; "Veuillez vérifier le chemin d'accès du répertoire de transfert !")
	If ($1)
	Else 
		ALERT:C41("Veuillez vérifier le chemin d'accès du répertoire de transfert !")
	End if 
End if 