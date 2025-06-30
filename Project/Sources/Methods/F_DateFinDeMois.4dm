//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_DateFinDeMois
//{
//{          Lundi 6 septembre 2004 à 14:31
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_DATE:C307($0)
C_DATE:C307($1)
$0:=$1
If ($1>!00-00-00!)
	Repeat 
		$1:=$1+1
	Until (Day of:C23($1)=1)
	$0:=$1-1
End if 
