TRACE:C157
// methode chart

//C_LONGINT($vl_Event)
//Case of 
//: ($vl_Event=On Load)
//$Affichage:=0  //0=Cacher 1= Montrer
//  //NECESSAIRE POUR AFFICHER UNE ZONE VIERGE À L'ÉCRAN POUR UN NOUVEAU GRAPHE
//Ô14500;105Ô (vl_LeGraphe;0;0;100;0)  //Paysage, pas d'alerte, type par défaut, pas sauver)

//Ô14500;24Ô (vl_LeGraphe;1;$Affichage)  //Cacher les menus
//Ô14500;24Ô (vl_LeGraphe;2;$Affichage)  //Cacher les outils legraphiques
//Ô14500;24Ô (vl_LeGraphe;3;$Affichage)  //Cacher les outils de tracé
//Ô14500;24Ô (vl_LeGraphe;6;$Affichage)  //Cacher les ascenseurs
//Ô14500;24Ô (vl_LeGraphe;9;$Affichage)  //Cacher les règles

//Ô14500;25Ô (vl_LeGraphe;0;1)  //Non saisissable, Bouton si zone trop petite    


//: ($vl_Event=On Resize)
//  //NOTE : C'est le seul endroit pour obtenir la taille correcte de la zone de 
//  //graphe
//  //Ne surtout pas mettre cela après la construction du graphe    
//OBJECT GET COORDINATES(*;"ZoneGraphe";GrapheGauche;GrapheHaut;GrapheDroite;GrapheBas)  //NOTE : ch_LIRE LIMITES ne marche pas bien
//GrapheGauche:=GrapheGauche+10  //On laisse une marge de manœuvre de 10 pixels
//GrapheDroite:=GrapheDroite-10
//GrapheHaut:=GrapheHaut+10
//GrapheBas:=GrapheBas-10
//GrapheLargeur:=GrapheDroite-GrapheGauche
//GrapheHauteur:=GrapheBas-GrapheHaut
//End case 