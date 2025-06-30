//%attributes = {}
// Method Permanenciers_vers_objet place tous les permanenciers dans un objet 4D 
//  
// #SYNTAX: $O_Permanencier:=Permanenciers_vers_objet 
// #PARAMETERS:
//     $0 Object          : Objet avec les permanenciers

// #DATE CREATION: 05/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2



// Dans cette version on ne met que le nom et la cle primaire

C_OBJECT:C1216($0; $O_Output)

ARRAY LONGINT:C221($rL_PK; 0)
ARRAY TEXT:C222($rT_Permanenciers; 0)

ALL RECORDS:C47([INtervenants:10])
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]ID:16; $rL_PK; *)
SELECTION TO ARRAY:C260([INtervenants:10]IN_NomPrénom:8; $rT_Permanenciers)
REDUCE SELECTION:C351([INtervenants:10]; 0)

OB SET ARRAY:C1227($O_Output; "pk"; $rL_PK)
OB SET ARRAY:C1227($O_Output; "nom"; $rT_Permanenciers)

$0:=$O_Output

// EOM

