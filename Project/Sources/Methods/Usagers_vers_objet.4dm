//%attributes = {}
// Method Usagers_vers_objet place tous les usagers dans un objet 4D
// 
// #SYNTAX: $O_Usagers:=Usagers_vers_objet 
// #PARAMETERS:
//     $0 Object          : Objet avec les usagers

// #DATE CREATION: 05/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_OBJECT:C1216($0; $O_Output)

ARRAY LONGINT:C221($rL_PK; 0)
ARRAY TEXT:C222($rT_Usagers; 0)
ARRAY TEXT:C222($rT_Cle; 0)

ALL RECORDS:C47([HeBerge:4])
MultiSoc_Filter(->[HeBerge:4])
SELECTION TO ARRAY:C260([HeBerge:4]ID:65; $rL_PK; *)
SELECTION TO ARRAY:C260([HeBerge:4]HB_Nom:3; $rT_Usagers; *)
SELECTION TO ARRAY:C260([HeBerge:4]HB_Clé:2; $rT_Cle)
REDUCE SELECTION:C351([HeBerge:4]; 0)

OB SET ARRAY:C1227($O_Output; "pk"; $rL_PK)
OB SET ARRAY:C1227($O_Output; "nom"; $rT_Usagers)
OB SET ARRAY:C1227($O_Output; "cle"; $rT_Cle)

$0:=$O_Output