//%attributes = {}
//TRACE
// methode chart

//C_LONGINT($1)  //LA ZONE GRAPHE
//C_POINTER($2)  //L'ID DU GRAPHE
//C_LONGINT($3)  //TYPE DE GRAPHE
//C_LONGINT($4)  //LA RECHERCHE
//C_BLOB(Blob)
//C_TEXT($vt_Debut)

//Ô14500;4Ô ($1)  //Nouveau graphe
//Ô14500;105Ô ($1;0;0;100;0)  //Paysage, pas d'alerte, type par défaut, pas sauver)
//Ô14500;107Ô ($1;Screen width;Screen height)  //Pour pouvoir ajouter des droites, rectangles à la main sinon erreur 'Hors zone'
//Ô14500;24Ô ($1;1;1)  //Montrer les menus (pour accéder aux options spécifiques du graphe)
//Ô14500;24Ô ($1;2;0)  //Cacher les outils legraphiques
//Ô14500;24Ô ($1;3;0)  //Cacher les outils de tracé
//Ô14500;24Ô ($1;6;0)  //Cacher les ascenseurs
//Ô14500;24Ô ($1;9;0)  //Cacher les règles

//  //NOTE : ch_LIMITES ZONE ne donne que la taille de la zone définie en structure 
//  //donc inutile après un redimensionnement selon la taille de l'écran
//  //Remplacé par un LIRE RECT dans le cyle de redimensionnement du formulaire
//Ô14500;25Ô ($1;1;1)  //Zone saisissable et affichée dans un bouton si zone trop petite

//  //Choix des couleurs qui seront celles par défaut si l'utilisateur ajoute un objet
//  //à la main au graphe
//Ô14500;74Ô ($1;-2;3;Ô14500;80Ô (Light grey+1))  //-2 = Valeur par défaut 3=trame pleine (choix entre 1 et 36)
//Ô14500;72Ô ($1;-2;3;Ô14500;80Ô (Blue+1))

//ARRAY TEXT($ta_AbscissesLibellés;0)
//ARRAY LONGINT($tl_Valeurs;0)
//ARRAY REAL($tl_Pourcentages;0)

//ARRAY TEXT($ta_OrdonnéesTotal;1)

//QUERY([PresentationData];[PresentationData]PN_Date=vd_Date1)
//ORDER BY([PresentationData];[PresentationData]PN_Libelle;>)
//Case of 
//: ($4=1)
//SELECTION TO ARRAY([PresentationData]PN_Libelle;$ta_AbscissesLibellés;[PresentationData]PN_Heberges;$tl_Valeurs;[PresentationData]PN_HebergesPC;$tl_Pourcentages)
//: ($4=2)
//SELECTION TO ARRAY([PresentationData]PN_Libelle;$ta_AbscissesLibellés;[PresentationData]PN_HebergesJour;$tl_Valeurs;[PresentationData]PN_HebergesJourPC;$tl_Pourcentages)
//: ($4=3)
//SELECTION TO ARRAY([PresentationData]PN_Libelle;$ta_AbscissesLibellés;[PresentationData]PN_NonSatisfait;$tl_Valeurs;[PresentationData]PN_NonSatisfaitPC;$tl_Pourcentages)
//End case 
//$ta_OrdonnéesTotal{1}:="TOTAL "

//  //* CONSTRUCTION DU GRAPHE PAR 4D
//  //NOTE : Ce qui suit est destiné à exploiter un bug de 4D pour bénéficier de la 
//  //méhode associée aux infos bulles pour les graphes surfaciques.
//  //Ces graphes n'ont pas d'info-bulles mais on fait d'abord un graphique en 
//  //colonnes, puis on change le type de graphe. Les infos bulles sont alors toujours
//  //appelées et on peut ainsi faire varier la perspective avec la souris
//$2->:=Ô14500;27Ô ($1;2;1;$ta_AbscissesLibellés;$ta_OrdonnéesTotal;$tl_Valeurs)  //4D Chart va enfin travailler…

//Ô14500;39Ô ($1;$2->;0;0;-1;-1;0;0;0)

//  //NOTE : On a mis deux tirets consécutifs dans le nom de la méthode  CHART__Bulles
//  //afin de pouvoir détecter cet appel spécial dans Insider.
//  //ch_FIXER INFOBULLES ($1;$2->;7;1;1;2;"";"";"CHART__Bulles")  `NOTE : Le nom de l

//  //Teinte:=102
//  //Rotation:=45
//  //Elevation:=45


//Ô14500;93Ô ($1;$2->;$3)  //On remet le type de graphe réel en gardant les infos bulles
//vl_CHART_Teinte:=102  //102
//  //* RÉGLAGE DES COULEURS DU GRAPHE
//  //C'EST LA PARTIE ARTISTIQUE QUE 4D EST INCAPABLE DE RÉALISER
//  //Graphe 2D -> La couleur est choisie dans la palette 4D
//Ô14500;36Ô ($1;$2->;1;3;3;Ô14500;80Ô (White+1))  //Socle ou fond pour la 2D 1= Paroi Dernier 3= Trame pleine
//Ô14500;35Ô ($1;$2->;1;2;3;Ô14500;80Ô (White+1))  //Rectangle de tracé 2D
//Ô14500;35Ô ($1;$2->;6;2;3;Ô14500;80Ô (243))  //Lignes frontières des Z 6 = Grille 3= Trame pleine (grille pour la 2D)
//Ô14500;36Ô ($1;$2->;8;100;-1;Ô14500;80Ô (vl_CHART_Teinte))  //8 = Ordonnées -1 = même trame
//Ô14500;47Ô ($1;$2->;vl_CHART_Rotation;vl_CHART_Elevation)

//vl_CHART_NbOrdonnées:=Size of array($ta_AbscissesLibellés)  //Eh oui !
//CHART_DegradeLuminosite ($1;$2->;vl_CHART_Teinte;vl_CHART_Luminosite)

//Ô14500;98Ô ($1;$2->;vl_CHART_Elevation;25)  //Extraction du secteur ayant le focus

//ARRAY INTEGER($TabOptions;1)
//$TabOptions{1}:=vl_CHART_Rotation
//Ô14500;87Ô ($1;$2->;$TabOptions)


//  //Cas des camemberts
//Ô14500;109Ô ($1;$2->;1;5;0;"")  //Manuel PDF pg 135, on affiche les valeurs et pourcentages en haut (CAMEMBERT)

//If (<>vb_CestUnMac)
//$vt_Debut:=Séparateur dossier
//Else 
//$vt_Debut:=<>vt_DossierApplication
//End if 

//Case of 
//: ($4=1)
//<>vi_Graphe1:=Ô14500;9Ô ($1;-1)
//PICTURE TO BLOB(<>vi_Graphe1;Blob;"JPEG")
//If (7=8)
//BLOB TO DOCUMENT($vt_Debut+"DossierWeb"+Séparateur dossier+"image1.jpg";Blob)
//End if 
//: ($4=2)
//<>vi_Graphe2:=Ô14500;9Ô ($1;-1)
//PICTURE TO BLOB(<>vi_Graphe2;Blob;"JPEG")
//If (7=8)
//BLOB TO DOCUMENT($vt_Debut+"DossierWeb"+Séparateur dossier+"image2.jpg";Blob)
//End if 
//: ($4=3)
//<>vi_Graphe3:=Ô14500;9Ô ($1;-1)
//PICTURE TO BLOB(<>vi_Graphe3;Blob;"JPEG")
//If (7=8)
//BLOB TO DOCUMENT($vt_Debut+"DossierWeb"+Séparateur dossier+"image3.jpg";Blob)
//End if 
//End case 

//Ô14500;75Ô ($1;-1;0)  //Aucun objet sélectionné

