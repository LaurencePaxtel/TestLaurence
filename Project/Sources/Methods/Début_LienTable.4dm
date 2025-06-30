//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 20/10/22, 18:06:47
// ----------------------------------------------------
// Méthode : Début_LienTable
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text
C_POINTER:C301($2)

QUERY:C277([TypesTables:11]; [TypesTables:11]TT_Libellé:4=$1)
MultiSoc_Filter(->[TypesTables:11])

If (Records in selection:C76([TypesTables:11])=1)
	$2->:=String:C10([TypesTables:11]TT_RéférenceID:1; "000")+"/1@"
Else 
	$2->:="0"
End if 