//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DB Solutions
//{
//{          Procédure : Upg_NumSemaine  
//{
//{          Dimanche 17 Novembre 1996 à 15:34:33
//{          Modifiée :
//{          Développement : GUEDJ Phulippe
//{==================================================}

//$1 est égal à une date
//$0 renvoi le numéro de la semaine

C_DATE:C307($1; $DateRef; $DateTemp)
C_LONGINT:C283($Année; $NbJours; $Sem1; $0)
C_REAL:C285($Sem)

$Année:=Year of:C25($1)
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

$NbJours:=($1-$DateTemp)  //+1


If ($NbJours<7)
	$NbJours:=7
End if 
$Sem:=$NbJours/7
$Sem1:=Int:C8($Sem)
If (Dec:C9($Sem)>0)
	$Sem1:=$Sem1+1
End if 
If ($Sem1=53)
	$Sem1:=1
End if 
$0:=$Sem1


