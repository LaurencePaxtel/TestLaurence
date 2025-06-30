C_LONGINT:C283($hauteur_el; $largeur_el; $menu_el; $largeurForm_el; $hauteurForm_el; $moitie_el; $gaucheCalcul_el; $droiteCalcul_el)

If (Form event code:C388=Sur clic:K2:4)
	$hauteur_el:=Screen height:C188(*)
	$largeur_el:=Screen width:C187(*)
	
	$menu_el:=Menu bar height:C440
	
	FORM GET PROPERTIES:C674([DossierSante:33]; "DE_EcranSaisie"; $largeurForm_el; $hauteurForm_el)
	
	If (ta_Page{ta_Page}#"Entrée & Médicale")  // Entrée & Médicale = Onglet 1
		$largeurForm_el:=790
	End if 
	
	$moitie_el:=$largeurForm_el/2
	
	$gaucheCalcul_el:=($largeur_el/2)-$moitie_el
	
	If ($gaucheCalcul_el<0)  // La Fenêtre va être plus large que la largeur de l'écran...
		$droiteCalcul_el:=$largeur_el-Abs:C99($gaucheCalcul_el)
	Else 
		$droiteCalcul_el:=($largeur_el/2)+$moitie_el
	End if 
	
	//CHANGER COORDONNÉES FENÊTRE(Abs($gaucheCalcul_el);(($hauteur_el/2)-10)-($hauteurForm_el/2);$droiteCalcul_el;(($hauteur_el/2)-10)+($hauteurForm_el/2);Fenêtre formulaire courant)
End if 