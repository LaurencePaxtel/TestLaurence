//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_RéservationDateFin
//{
//{          Lundi 6 septembre 2004 à 10:51:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($0)
C_DATE:C307($1)  //Date de la fiche
C_LONGINT:C283($2)  //Nuit reste

If ($1>!00-00-00!)
	$0:=Add to date:C393($1; 0; 0; $2)
End if 