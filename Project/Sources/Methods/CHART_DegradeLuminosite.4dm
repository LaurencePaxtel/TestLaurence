//%attributes = {}
//TRACE
// methode chart


//CHART_DegradeLuminosite Voir aussi CHART_DegradeArcEnCiel
//Colorie les NombreOrdonnees par un arc en ciel de luminosité $3
//Écrit à wakayama le samedi 17 mars 2001
//La luminosité n'est pas utile ici, le thermomètre servira à choisir une série
//dite 'pivot' à mettre en valeur dans le graphe. Les autres séries seront pâles
//On fera descendre la luminosité de 80 à 0 pour la faire remonter ensuite.
//La position sur le thermomètre indique la position de la série à souligner.

//Dans le cas d'un arc en ciel, la série à mettre en valeur verra sa teinte 
//saturée


//C_LONGINT($1)  //LE GRAPHE
//C_LONGINT($2)  //LE GRAPHE
//C_LONGINT($3)  //Index entre 1 et 256 de la couleur dans la palette 4D
//C_LONGINT($4)  //Position du focus entre -100 et 100 qui définit le pivot

//C_LONGINT($i;$PositionSpectre;$CodeCouleur;$CodeCouleurPrecedent;$LumiMaxi;$OrdonneePivot;$CouleurTeinte;$CouleurPivot;$CouleurTrait;$CouleurFilDeFer)
//C_LONGINT($ProportionRouge;$ProportionVert;$ProportionBleu;$PositionSpectre)

//If ((vl_CHART_NbOrdonnées#0) & ($3#(Black+1)))  //Noir = convention couleur 4D
//$CouleurFilDeFer:=Ô14500;80Ô (Dark grey+1)
//$CouleurTeinte:=Ô14500;80Ô ($3)
//$CodeCouleurPrecedent:=$CouleurTeinte

//$LumiMaxi:=80  //Essayez des valeurs entre 50 et 100
//$OrdonneePivot:=(($4+100)*(vl_CHART_NbOrdonnées-1)/200)+1  //Pivot situé entre 1 et NombreOrdonnees

//If ($3=(White+1))  //Convention arc en ciel, le pivot sera mis en valeur par la teinte saturée
//$PositionSpectre:=360*($OrdonneePivot-1)/vl_CHART_NbOrdonnées
//CHARTCOLOR_FixerRVB (->vl_CHART_ProportionRouge;->vl_CHART_ProportionVert;->vl_CHART_ProportionBleu;$PositionSpectre)
//$CouleurPivot:=Ô14500;78Ô (vl_CHART_ProportionRouge;vl_CHART_ProportionVert;vl_CHART_ProportionBleu)
//Else 
//$CouleurPivot:=$CouleurTeinte
//End if 

//$CouleurTrait:=$CouleurTeinte  //Teinte d'origine sans luminosité
//Ô14500;79Ô ($CouleurTeinte;$ProportionRouge;$ProportionVert;$ProportionBleu)  //Composantes de la teinte en RVB

//  //Première boucle décroissante de luminosité entre $LumiMaxi et 0 (pour $i=
//  //$OrdonneePivot)
//  //Pour assombrir le côté droit de la série, on utilise la couleur utilisé pour la 
//  //série précèdente qui est plus sombre
//For ($i;$OrdonneePivot;1;-1)  //Boucle décroissante pour avoir le côté droit plus sombre

//If ($3=(White+1))  //Convention pour un graphe arc en ciel
//$PositionSpectre:=360*($i-1)/vl_CHART_NbOrdonnées  //La teinte varie comme un arc en ciel
//CHARTCOLOR_FixerRVB (->vl_CHART_ProportionRouge;->vl_CHART_ProportionVert;->vl_CHART_ProportionBleu;$PositionSpectre)
//$Luminosite:=Luminosite
//Else   //Cas normal
//vl_CHART_ProportionRouge:=$ProportionRouge
//vl_CHART_ProportionVert:=$ProportionVert
//vl_CHART_ProportionBleu:=$ProportionBleu

//If ($OrdonneePivot=1)
//$Luminosite:=0
//Else 
//$Luminosite:=($LumiMaxi*($OrdonneePivot-$i))/($OrdonneePivot-1)
//End if 
//End if 

//CHART_COL_FixerLuminosite (->vl_CHART_ProportionRouge;->vl_CHART_ProportionVert;->vl_CHART_ProportionBleu;$Luminosite)
//$CodeCouleur:=Ô14500;78Ô (vl_CHART_ProportionRouge;vl_CHART_ProportionVert;vl_CHART_ProportionBleu)

//Case of 
//: (Shift down)  //Faces cachées
//Ô14500;36Ô ($1;$2;8;$i*100;1;$CodeCouleur)  //8 = Ordonnées 1 = transparent        
//Ô14500;35Ô ($1;$2;8;$i*100;1;$CodeCouleur)  //8 = Ordonnées 1 = transparent

//: (Macintosh option down)  //Fil de fer
//$CouleurTrait:=$CouleurFilDeFer
//Ô14500;36Ô ($1;$2;8;$i*100;1;$CodeCouleur)  //8 = Ordonnées 1 = transparent
//Ô14500;35Ô ($1;$2;8;$i*100;3;$CouleurTrait)  //8 = Ordonnées  3 = Trame pleine   

//Else   //Cas normal
//Ô14500;36Ô ($1;$2;8;$i*100;3;$CodeCouleur)  //8 = Ordonnées 3 = Trame pleine
//Ô14500;35Ô ($1;$2;8;$i*100;3;$CouleurTrait)  //8 = Ordonnées 3 = Trame pleine
//If ($3#(White+1))  //On va colorier la face droite des barres en un peu plus sombre
//Ô14500;36Ô ($1;$2;8;($i*100)+3;3;$CodeCouleurPrecedent)  //8 = Ordonnées 3 = Trame pleine  3=face droite 
//End if 
//End case 

//$CodeCouleurPrecedent:=$CodeCouleur
//End for 


//For ($i;$OrdonneePivot;vl_CHART_NbOrdonnées)  //NOTE: $OrdonneePivot est redessiné mais sert à initialiser $CodeCouleurPrecedent

//If ($3=(White+1))  //Convention arc en ciel
//$PositionSpectre:=360*($i-1)/vl_CHART_NbOrdonnées  //La teinte varie comme un arc en ciel
//CHARTCOLOR_FixerRVB (->vl_CHART_ProportionRouge;->vl_CHART_ProportionVert;->vl_CHART_ProportionBleu;$PositionSpectre)
//$Luminosite:=Luminosite

//Else 
//vl_CHART_ProportionRouge:=$ProportionRouge
//vl_CHART_ProportionVert:=$ProportionVert
//vl_CHART_ProportionBleu:=$ProportionBleu

//If ($OrdonneePivot=vl_CHART_NbOrdonnées)
//$Luminosite:=0
//Else 
//$Luminosite:=($LumiMaxi*($i-$OrdonneePivot))/(vl_CHART_NbOrdonnées-$OrdonneePivot)
//End if 
//End if 

//CHART_COL_FixerLuminosite (->vl_CHART_ProportionRouge;->vl_CHART_ProportionVert;->vl_CHART_ProportionBleu;$Luminosite)
//$CodeCouleur:=Ô14500;78Ô (vl_CHART_ProportionRouge;vl_CHART_ProportionVert;vl_CHART_ProportionBleu)

//Case of 
//: (Shift down)  //Faces cachées
//Ô14500;36Ô ($1;$2;8;$i*100;1;$CodeCouleur)  //8 = Ordonnées 1 = transparent
//Ô14500;35Ô ($1;$2;8;$i*100;1;$CodeCouleur)  //8 = Ordonnées 1 = transparent

//: (Macintosh option down)  //Fil de fer
//$CouleurTrait:=$CouleurFilDeFer
//Ô14500;36Ô ($1;$2;8;$i*100;1;$CodeCouleur)  //8 = Ordonnées 1 = transparent
//Ô14500;35Ô ($1;$2;8;$i*100;3;$CouleurTrait)  //8 = Ordonnées 3 = Trame pleine 

//Else   //Cas normal
//Ô14500;36Ô ($1;$2;8;$i*100;3;$CodeCouleur)  //8 = Ordonnées 3 = Trame pleine
//Ô14500;35Ô ($1;$2;8;$i*100;3;$CouleurTrait)  //8 = Ordonnées 3 = Trame pleine
//If ($3#(White+1))  //On va colorier la face droite des barres en un peu plus sombre
//Ô14500;36Ô ($1;$2;8;($i*100)+3;3;$CodeCouleurPrecedent)  //8 = Ordonnées 3 = Trame pleine  3=face droite
//End if 
//End case 

//$CodeCouleurPrecedent:=$CodeCouleur
//End for 

//  //MISE EN EXERGUE DE LA SÉRIE PIVOT AYANT LE FOCUS

//  //La série pivot aura un trait blanc et la teinte d'origine
//Ô14500;36Ô ($1;$2;8;$OrdonneePivot*100;3;$CouleurPivot)  //8 = Ordonnées 3 = trame pleine
//Ô14500;35Ô ($1;$2;8;$OrdonneePivot*100;3;Ô14500;80Ô (White+1))  //8 = Ordonnées 3 = trame pleine

//  //On va assombrir la face droite des colonnes (marche aussi pour les arc en ciel
//Ô14500;79Ô ($CouleurPivot;vl_CHART_ProportionRouge;vl_CHART_ProportionVert;vl_CHART_ProportionBleu)  //Composantes de la teinte en RVB
//CHART_COL_FixerLuminosite (->vl_CHART_ProportionRouge;->vl_CHART_ProportionVert;->vl_CHART_ProportionBleu;-15)  //On assombrit le côté droit de la série pivot de 15%

//$CodeCouleurPrecedent:=Ô14500;78Ô (vl_CHART_ProportionRouge;vl_CHART_ProportionVert;vl_CHART_ProportionBleu)
//Ô14500;36Ô ($1;$2;8;($OrdonneePivot*100)+3;3;$CodeCouleurPrecedent)  //8 = Ordonnées 3 = Trame pleine 3=face droite
//End if 