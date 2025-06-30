//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CodeCentre  
//{          
//{          Lundi 6 octobre 200! à 18:58:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_POINTER:C301($1)
C_POINTER:C301($2)
var $3 : Integer

var $codeCentre_i : Integer

If (Session:C1714.storage#Null:C1517)
	$codeCentre_i:=Session:C1714.storage.societe.codeCentre
Else 
	$codeCentre_i:=Storage:C1525.societeDetail.codeCentre
End if 

If (Count parameters:C259=3)
	$codeCentre_i:=$3
End if 

$1->:=($codeCentre_i*1000000)+1
$2->:=($codeCentre_i*1000000)+999999

