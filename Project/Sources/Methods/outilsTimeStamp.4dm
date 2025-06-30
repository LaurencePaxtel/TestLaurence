//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 15/12/21, 14:54:54
// ----------------------------------------------------
// Méthode : outilsTimeStamp
// Description
// Retrouver le timestamp depuis le 01/01/1970
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($0)  // Timestamp
C_DATE:C307($1)  // Date [optionnel]
C_TIME:C306($2)  // Heure [optionnel]

C_DATE:C307($date_d)
C_LONGINT:C283($heure_el; $nbJourSec_el)

If (Count parameters:C259=2)
	ASSERT:C1129($1#!00-00-00!; "Le type de $1 n'est pas une date")
	
	$date_d:=$1
	$heure_el:=$2+0
Else 
	$date_d:=Current date:C33
	$heure_el:=Current time:C178+0
End if 

$nbJourSec_el:=Int:C8(($date_d-!1970-01-01!)*86400)

$0:=$nbJourSec_el+$heure_el-outilsTimeStampJetLag