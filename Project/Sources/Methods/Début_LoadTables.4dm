//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Dev
// Date et heure : 28/05/21, 15:09:13
// ----------------------------------------------------
// Méthode : Début_LoadTables
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text
var $2 : Pointer

var $TT_RéférenceID : Text

Début_LienTable($1; ->$TT_RéférenceID)

QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=$TT_RéférenceID)
MultiSoc_Filter(->[TAbles:12])

SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; $2->)
SORT ARRAY:C229($2->; >)

Web_Genere_Variable_Process($2)

storageEnumerationInit($1; $2)