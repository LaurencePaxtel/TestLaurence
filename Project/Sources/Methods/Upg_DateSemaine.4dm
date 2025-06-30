//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DB Solutions
//{
//{          Procédure : Upg_DateSemaine  
//{
//{          Dimanche 17 Novembre 1996 à 15:37:19
//{          Modifiée :
//{          Développement : GUEDJ Phulippe
//{==================================================}

//$1 est égal à une semaine
//$2 est une année
//$0 renvoi la date du premier jour de la semaine

C_DATE:C307($0; $DateRef; $DateTemp)
C_LONGINT:C283($1; $2; $Année)
If (7=8)
	$Année:=$2
	$DateRef:=Date:C102("01/01/"+String:C10($Année))
	$DateTemp:=$DateRef
	
	//calcul du premier lundi
	While (Day number:C114($DateTemp)#2)
		$DateTemp:=$DateTemp+1
	End while 
	
	$0:=$DateTemp+(($1-1)*7)
End if 
//***

$Année:=$2
$DateRef:=Date:C102("01/01/"+String:C10($Année))
$DateTemp:=$DateRef
//Recherche du Dimanche
If (Day number:C114($DateTemp)#1)
	While (Day number:C114($DateTemp)#1)
		$DateTemp:=$DateTemp+1
	End while 
End if 
Case of 
	: ($DateTemp=$DateRef)
	: ($DateTemp>$DateRef)
		$DateTemp:=$DateTemp-1
		While (Day number:C114($DateTemp)#1)
			$DateTemp:=$DateTemp-1
		End while 
End case 

$0:=$DateTemp+(($1)*7)