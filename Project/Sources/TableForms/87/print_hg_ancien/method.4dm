// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 19:28:12
// ----------------------------------------------------
// Method: [Factures].print
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($largeur; $deplacement; $hauteur)

GES_Imp_Maj_Variables(->[Factures:86])

Case of 
	: (Section="Corps")
		//-----------------------------------------------------------------------------------------------
		//       Redimensionnement automatique du champ titre
		//-----------------------------------------------------------------------------------------------
		$designation:=->[Factures_Lignes:87]FACL_Libelle_2:29
		//$designation->:=Remplacer chaine($designation->;Caractere(Retour à la ligne);" ")
		//$designation->:=Remplacer chaine($designation->;Caractere(Retour chariot);" ")
		C_LONGINT:C283($largeur; $hauteur)
		OBJECT GET COORDINATES:C663($designation->; $g; $h; $d; $b)
		$largeur_actuelle_fixe:=$d-$g  // Calcul de la taille du champ texte libelle
		$haut_prec:=$b-$h
		OBJECT GET BEST SIZE:C717($designation->; $largeur; $hauteur; $largeur_actuelle_fixe)
		$hauteur:=$hauteur
		$deplacement:=$hauteur-$haut_prec
		$position_taquet_corps:=Get print marker:C708(Corps formulaire:K43:1)
		$position_taquet_corps:=$position_taquet_corps+$deplacement
		OBJECT MOVE:C664($designation->; $g; $h; $d; $hauteur+$h; *)
		OBJECT MOVE:C664(*; "Sep_Vertical@"; 0; 0; 0; $deplacement)
		SET PRINT MARKER:C709(Corps formulaire:K43:1; $position_taquet_corps; *)
		taille_taquet_base:=Get print marker:C708(taquet)
		
		//-----------------------------------------------------------------------------------------------
		//       Redimensionnement automatique du champ Libelle
		//-----------------------------------------------------------------------------------------------
		$designation:=->[Factures_Lignes:87]FACL_Libelle:5
		//$designation->:=Remplacer chaine($designation->;Caractere(Retour à la ligne);" ")
		//$designation->:=Remplacer chaine($designation->;Caractere(Retour chariot);" ")
		C_LONGINT:C283($largeur; $hauteur)
		OBJECT GET COORDINATES:C663($designation->; $g; $h; $d; $b)
		$largeur_actuelle_fixe:=$d-$g  // Calcul de la taille du champ texte libelle
		$haut_prec:=$b-$h
		OBJECT GET BEST SIZE:C717($designation->; $largeur; $hauteur; $largeur_actuelle_fixe)
		$hauteur:=$hauteur
		$deplacement:=$hauteur-$haut_prec
		$position_taquet_corps:=Get print marker:C708(Corps formulaire:K43:1)
		$position_taquet_corps:=$position_taquet_corps+$deplacement
		OBJECT MOVE:C664($designation->; $g; $h; $d; $hauteur+$h; *)
		OBJECT MOVE:C664(*; "Sep_Vertical@"; 0; 0; 0; $deplacement)
		SET PRINT MARKER:C709(Corps formulaire:K43:1; $position_taquet_corps; *)
		
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Entete")
		
		taille_taquet_base:=Get print marker:C708(taquet)
		
		taille_taquet_base:=Get print marker:C708(taquet)
		
		
	: (Section="Entete1")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Entete2")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Pied")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Rupture0")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Rupture1")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Rupture2")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Rupture3")
		taille_taquet_base:=Get print marker:C708(taquet)
		
End case 

If (Mode_impression="Mesure")
	taille_taquet:=Get print marker:C708(taquet)
	CANCEL:C270
End if 