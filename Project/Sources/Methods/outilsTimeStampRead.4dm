//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 15/12/21, 15:00:18
// ----------------------------------------------------
// Méthode : outilsTimeStampRead
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)  // $0 = [texte]
C_TEXT:C284($1)  // $1 = [texte] info de sortie ("date" ou "heure")
C_LONGINT:C283($2)  // $2 = [entier long] le timestamp

C_LONGINT:C283($tsAvecDecallage_el)

ASSERT:C1129(Count parameters:C259=2; "Il manque un paramêtre à cette méthode.")
ASSERT:C1129(Type:C295($2)=Est un entier long:K8:6; "Le param $1 doit être de type 'entier'.")
ASSERT:C1129(($1="date") | ($1="heure"); "La valeur de $1 est incorrect.")

$tsAvecDecallage_el:=$2+outilsTimeStampJetLag

If ($1="date")
	$0:=String:C10(Int:C8($tsAvecDecallage_el/86400)+!1970-01-01!; Interne date court:K1:7)
Else 
	$0:=String:C10(Time:C179(Mod:C98($tsAvecDecallage_el; 86400)); h mn s:K7:1)
End if 