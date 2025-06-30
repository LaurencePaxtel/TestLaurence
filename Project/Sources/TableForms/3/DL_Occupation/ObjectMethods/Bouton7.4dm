

ARRAY TEXT:C222(ta_Catégories_11; 4)  // Création d'un tableau pour l'axe des X
ta_Catégories_11{1}:="Hommes"
ta_Catégories_11{2}:="Femmes"
ta_Catégories_11{3}:="Mineurs"
ta_Catégories_11{4}:="Lits non distribués"

ARRAY DATE:C224(td_Séries_11; 1)
td_Séries_11{1}:=vd_Date1

ARRAY LONGINT:C221(tl_Valeurs_11; 4)  // Création d'un tableau pour l'axe des Z 
tl_Valeurs_11{1}:=vl_TOC_Hébergés_H
tl_Valeurs_11{2}:=vl_TOC_Hébergés_F
tl_Valeurs_11{3}:=vl_TOC_Hébergés_M
tl_Valeurs_11{4}:=vl_TOC_Reste

TRACE:C157
// methode chart

//vl_GrapheZone_11:=Ô14500;10Ô 

//Ô14500;24Ô (vl_GrapheZone_11;1;0)
//Ô14500;24Ô (vl_GrapheZone_11;2;0)
//Ô14500;24Ô (vl_GrapheZone_11;3;0)
//Ô14500;24Ô (vl_GrapheZone_11;9;0)

//Ô14500;105Ô (vl_GrapheZone_11;-1;1;-1;-1)
//vl_GrapheID_11:=Ô14500;27Ô (vl_GrapheZone_11;6;2;ta_Catégories_11;td_Séries_11;tl_Valeurs_11)

//  //Légende
//Ô14500;38Ô (vl_GrapheZone_11;vl_GrapheID_11;1;0;0;8;0;0;0)

//  //Définir la position de la légende (en bas, horizontale)
//Ô14500;39Ô (vl_GrapheZone_11;vl_GrapheID_11;1;0;0;0;8;0;0)



//Ô14500;36Ô (vl_GrapheZone_11;vl_GrapheID_11;8;100;3;Ô14500;80Ô (7))  //Bleu  
//Ô14500;36Ô (vl_GrapheZone_11;vl_GrapheID_11;8;200;3;Ô14500;80Ô (5))
//Ô14500;36Ô (vl_GrapheZone_11;vl_GrapheID_11;8;300;3;Ô14500;80Ô (2))  //Jaune
//Ô14500;36Ô (vl_GrapheZone_11;vl_GrapheID_11;8;400;3;Ô14500;80Ô (10))  //Vert


//Ô14500;37Ô (vl_GrapheZone_11;vl_GrapheID_11;2;0;Ô14500;85Ô ("ARIAL");14;1;-1)

//  //Titre
//vl_GrapheTitre_11:=Ô14500;58Ô (vl_GrapheZone_11;1;1;210;3;"Répartition par Etat civil")
//Ô14500;70Ô (vl_GrapheZone_11;vl_GrapheTitre_11;Ô14500;85Ô ("ARIAL");18;1;Ô14500;80Ô (16);1)

//Ô14500;12Ô (vl_GrapheZone_11;1;vl_Gauche;vl_Haut;vl_Droite;vl_Bas)

//  //Centrer le graphe
//Ô14500;68Ô (vl_GrapheZone_11;vl_GrapheID_11;vl_Gauche2;vl_Haut2;vl_Droite2;vl_Bas2)

//vl_GraphePosition_11:=((vl_Droite-vl_Gauche)-(vl_Droite2-vl_Gauche2))/2
//Ô14500;76Ô (vl_GrapheZone_11;vl_GrapheID_11;vl_GraphePosition_11;vl_Haut2)

//  //Centrer le titre
//Ô14500;68Ô (vl_GrapheZone_11;vl_GrapheTitre_11;vl_Gauche2;vl_Haut2;vl_Droite2;vl_Bas2)
//vl_GraphePosition_11:=((vl_Droite-vl_Gauche)-(vl_Droite2-vl_Gauche2))/2
//Ô14500;76Ô (vl_GrapheZone_11;vl_GrapheTitre_11;vl_GraphePosition_11;vl_Haut2)

//  //Centrer le graphe de 9 points vers le bas
//Ô14500;68Ô (vl_GrapheZone_11;vl_GrapheID_11;vl_Gauche;vl_Haut;vl_Droite;vl_Bas)
//Ô14500;76Ô (vl_GrapheZone_11;vl_GrapheID_11;vl_Gauche;vl_Haut+9)


//i_image:=Ô14500;9Ô (vl_GrapheZone_11;-1)

//<>vi_Limage:=i_image

//Ô14500;11Ô (vl_GrapheZone_11)

//FORM GOTO PAGE(2)