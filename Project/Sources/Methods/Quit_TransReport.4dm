//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : Quit_TransReport
//{
//{          Jeudi 4 décembre 2008 à 14:42
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (vb_ReporEnCours)
	ALERT:C41("Tranfert en cours…")
Else 
	CANCEL:C270
End if 