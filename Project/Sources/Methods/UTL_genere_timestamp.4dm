//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 24/10/18, 06:55:00
// ----------------------------------------------------
// Méthode : UTL_genere_timestamp
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($0)
C_DATE:C307($1)
C_TIME:C306($2)

C_LONGINT:C283($heure_en_seconde; $jours_en_seconde)
C_DATE:C307($date_ref)
C_TIME:C306($heure_ref)

Case of 
	: (Count parameters:C259=0)
		$date_ref:=Current date:C33(*)
		$heure_ref:=Current time:C178(*)
	: (Count parameters:C259=1)
		$date_ref:=$1
		$heure_ref:=Current time:C178(*)
	: (Count parameters:C259=2)
		$date_ref:=$1
		$heure_ref:=$2
End case 

$date_reference:=Add to date:C393(!00-00-00!; 2003; 1; 1)

$heure_en_seconde:=$heure_ref+0
$jours_en_seconde:=($date_ref-$date_reference)*86400

$0:=$jours_en_seconde+$heure_en_seconde