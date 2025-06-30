
FORM GOTO PAGE:C247(2)

ARRAY TEXT:C222(tabCatégories; 2)  // Création d'un tableau pour l'axe des X
tabCatégories{1}:="Lits distribués"
tabCatégories{2}:="Lits non occupés"

ARRAY DATE:C224(tabSéries; 1)  // Création d'un tableau pour l'axe des X
tabSéries{1}:=vd_Date1

ARRAY LONGINT:C221(tabValeurs; 2)  // Création d'un tableau pour l'axe des Z 
tabValeurs{1}:=vl_TOC_Hébergés
tabValeurs{2}:=vl_TOC_Reste


TRACE:C157
// methode chart

//vl_Graphe2:=Ô14500;10Ô 
//$ii:=Ô14500;27Ô (vl_Graphe2;6;2;tabCatégories;tabSéries;tabValeurs)
//i_image:=Ô14500;9Ô (vl_Graphe2;-1)
//Ô14500;11Ô (vl_Graphe2)
