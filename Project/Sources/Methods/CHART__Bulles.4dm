//%attributes = {}
//TRACE
// methode chart

//CHART__Bulles
//MÉTHODE APPELÉE LORS DE L'AFFICHAGE DES INFOS BULLES
//ON LA DÉTOURNÉ POUR METTRE EN VALEUR LA SÉRIE SOUS LA SOURIS
//MAIS AUSSI POUR FIXER LE POINT DE VUE DES GRAPHES
//NOTE : Le nom de la méthode doit être COURT (bug 4D)

//C_LONGINT($1;$2;$3;$4)
//C_LONGINT($SourisX;$SourisY;$SourisBouton)
//C_LONGINT($PositionFocus)


//  //CHART__Bulles
//  //MÉTHODE APPELÉE LORS DE L'AFFICHAGE DES INFOS BULLES
//  //ON LA DÉTOURNÉ POUR METTRE EN VALEUR LA SÉRIE SOUS LA SOURIS
//  //MAIS AUSSI POUR FIXER LE POINT DE VUE DES GRAPHES
//  //NOTE : Le nom de la méthode doit être COURT (bug 4D)

//C_LONGINT($1;$2;$3;$4)
//C_LONGINT($SourisX;$SourisY;$SourisBouton)
//C_LONGINT($PositionFocus)

//Case of 
//: (Caps lock down)  //Signal qu'on veut modifier la perspective du graphe avec la souris
//GET MOUSE($SourisX;$SourisY;$SourisBouton)

//$SourisX:=$SourisX-GrapheGauche  //Position relative de la souris par rapport à la zone chart
//$SourisY:=$SourisY-GrapheHaut

//If ($SourisX<0)
//$SourisX:=0
//End if 

//If ($SourisX>GrapheLargeur)
//$SourisX:=GrapheLargeur
//End if 

//If ($SourisY<0)
//$SourisY:=0
//End if 

//If ($SourisY>GrapheHauteur)
//$SourisY:=GrapheHauteur
//End if 

//If (NumeroChamp2<0)  //Graphe 2D ou camemberts

//If (b3DouCamembert=1)  //Camemberts
//Ô14500;98Ô (LeGraphe;IdGraphe;Elevation;$SourisX/10)  //Avant de sortir le secteur sur lequel se trouve la souris

//ARRAY INTEGER($TabOptions;1)
//If (Not(Shift down))
//Rotation:=((360*$SourisY)/GrapheHauteur)%360  //Angle de départ du camembert donné par la position verticale de la souris
//End if 
//$TabOptions{1}:=Rotation
//Ô14500;87Ô (LeGraphe;IdGraphe;$TabOptions)

//Else   //Graphe 2D normal

//If (Not(Macintosh option down))  //On va ajouter du relief au graphe 2D          
//Rotation:=($SourisX-(GrapheLargeur/2))/4
//Elevation:=($SourisY-(GrapheHauteur/2))/4
//Ô14500;47Ô (LeGraphe;IdGraphe;Rotation;Elevation)

//Else   //pour jouer avec les trames et les traits        
//Ô14500;35Ô (LeGraphe;IdGraphe;8;100;($SourisY/5)%36;Ô14500;80Ô (Teinte+1);($SourisX/10)%32)  //8 = Ordonnées -1 = même trame
//Ô14500;36Ô (LeGraphe;IdGraphe;8;100;($SourisY/5)%36;-1)  //8 = Ordonnées -1 = même trame
//End if 
//End if 

//Else   //2 champs ont été choisis

//If ((bCumul=1) | (b3DouCamembert=0))  //Graphe 2D et demi
//Rotation:=($SourisX-(GrapheLargeur/2))/4
//Elevation:=($SourisY-(GrapheHauteur/2))/4
//Ô14500;47Ô (LeGraphe;IdGraphe;Rotation;Elevation)

//Else   //Véritable Graphe 3D
//Rotation:=90-((90*$SourisX)/GrapheLargeur)
//Elevation:=(90*$SourisY)/GrapheHauteur
//Ô14500;49Ô (LeGraphe;IdGraphe;Rotation;Elevation)
//End if 

//End if 

//Else   //Caps lock n'est pas enfoncée, mise en exergue de la série survolée par la souris

//If (NumeroChamp2<0)  //Graphe 2D
//If (b3DouCamembert=1)  //Camemberts

//If ($3#0)  //On est bien sur une série
//Ô14500;98Ô (LeGraphe;IdGraphe;0;0)  //On remet en place tous les secteurs    
//Elevation:=$3
//Ô14500;98Ô (LeGraphe;IdGraphe;Elevation;25)  //Avant de sortir le secteur sur lequel se trouve la souris

//If (NombreOrdonnees=1)
//$PositionFocus:=0
//Else 
//$PositionFocus:=((200*($3-1))/(NombreOrdonnees-1))-100
//End if 

//CHART_DegradeLuminosite (Teinte;$PositionFocus)
//End if 

//Else   //Graphe 2D

//End if 

//Else   //Graphe 3D

//If ($4#0)  //La souris est bien positionnée sur une série
//If (NombreOrdonnees=1)
//$PositionFocus:=0
//Else 
//$PositionFocus:=((200*($4-1))/(NombreOrdonnees-1))-100
//End if 

//CHART_DegradeLuminosite (Teinte;$PositionFocus)
//End if 

//End if 
//End case 