//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : i_NbJoursDateàDate  
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($0)
C_DATE:C307($1)
C_DATE:C307($2)

C_DATE:C307($dt)

If ($1>!00-00-00!) & ($2>!00-00-00!)
	
	If ($2<$1)
		$dt:=$1
		
		$1:=$2
		$2:=$dt
	End if 
	
	$0:=$2-$1+1
	
	If ($0>366)
		ALERT:C41("Vous ne pouvez pas excéder une année !")
	End if 
	
Else 
	ALERT:C41("Vérifiez les dates !")
End if 