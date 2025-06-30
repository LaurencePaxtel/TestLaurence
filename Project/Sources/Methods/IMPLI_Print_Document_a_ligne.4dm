//%attributes = {}
C_POINTER:C301($ptr_fichier; $1; $ptr_fichier_ligne; $2)
C_TEXT:C284($nom_formulaire; $3)
C_LONGINT:C283($Nb_entete; $4; $NB_Pied; $5; $Nbre_page; $page_courante; $hauteur_page; $largeur_page; $hauteur_de_la_ligne)
C_BOOLEAN:C305($Utilisation_nb_page_total; $6; $0)

$ptr_fichier:=$1
$ptr_fichier_ligne:=$2
$nom_formulaire:=$3
$Nb_entete:=$4
$NB_Pied:=$5
$Utilisation_nb_page_total:=$6

If (Count parameters:C259>=7)
	$para_imp:=$7
Else 
	$para_imp:=True:C214
End if 

$taille_entete_long:=0
$taille_entete_short:=0

$taille_pied_long:=0
$taille_pied_short:=0

$page_courante:=0
Section:=""

$Nbre_page:=1

//Détermination des hauteurs des différentes sections
taille_taquet:=0
taille_taquet_base:=0
If ($para_imp)
	
	_O_PAGE SETUP:C299($ptr_fichier->; $nom_formulaire)
	PRINT SETTINGS:C106
Else 
	//UTILISER PARAMETRES IMPRESSION($ptr_fichier->;$nom_formulaire)
End if 
If (ok=1)
	$0:=True:C214
	GET PRINTABLE AREA:C703($hauteur_page; $largeur_page)
	Mode_impression:="Mesure"
	
	Section:="Pied"
	taquet:=Pied de page formulaire:K43:2
	$taille_bas_de_page:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$taille_bas_de_page:=taille_taquet
	$taille_bas_de_page_base:=taille_taquet_base
	
	
	Section:="Cumul long"
	taquet:=Rupture formulaire0:K43:14
	$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$taille_pied_long:=taille_taquet
	$taille_pied_long_base:=taille_taquet_base
	
	
	Section:="Cumul Court"
	taquet:=Rupture formulaire1:K43:15
	$taille_pied_short:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$taille_pied_short:=taille_taquet
	$taille_pied_short_base:=taille_taquet_base
	
	Section:="Entete courte"
	taquet:=Corps formulaire:K43:1
	$hauteur_ligne_base:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$hauteur_ligne_base:=taille_taquet
	$hauteur_ligne_base_base:=taille_taquet_base
	
	Section:="Entete courte"
	taquet:=Entête formulaire1:K43:4
	$taille_entete_short:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$taille_entete_short:=taille_taquet
	$taille_entete_short_base:=taille_taquet_base
	
	//Mode_impression:="Mesure"
	Section:="Entete Grande"
	taquet:=Entête formulaire:K43:3
	$taille_entete_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$taille_entete_long:=taille_taquet
	$taille_entete_long_base:=taille_taquet_base
	
	$taille_entete_short:=$taille_entete_short-$taille_entete_long_base
	$hauteur_ligne_base:=$hauteur_ligne_base-$taille_entete_short_base
	$taille_pied_short:=$taille_pied_short-$hauteur_ligne_base_base
	$taille_pied_long:=$taille_pied_long-$taille_pied_short_base
	$taille_bas_de_page:=$taille_bas_de_page-$taille_pied_long_base
	$Taille_petit_bas:=$taille_pied_short+$taille_bas_de_page
	$Taille_grand_bas:=$taille_pied_short+$taille_pied_long+$taille_bas_de_page
	
	ARRAY LONGINT:C221($hauteur_ligne; Records in selection:C76($ptr_fichier_ligne->))
	FIRST RECORD:C50($ptr_fichier_ligne->)
	For ($i; 1; Size of array:C274($hauteur_ligne))
		Section:="Corps"
		taquet:=Corps formulaire:K43:1
		$hauteur_ligne{$i}:=Print form:C5($ptr_fichier->; $nom_formulaire; Corps formulaire:K43:1)
		$hauteur_ligne{$i}:=taille_taquet-$taille_entete_short_base
		NEXT RECORD:C51($ptr_fichier_ligne->)
	End for 
	
	$Hauteur_deja_imp:=0
	//Calcul du nombre de pages et des lignes à imprimer
	ARRAY TEXT:C222($ligne; 0)
	APPEND TO ARRAY:C911($ligne; "Entete Grande")
	$Hauteur_deja_imp:=$Hauteur_deja_imp+$taille_entete_long
	For ($i; 1; Size of array:C274($hauteur_ligne))
		$espace_restant:=$hauteur_page-$Hauteur_deja_imp
		Case of 
			: ($espace_restant<($hauteur_ligne{$i}+$Taille_petit_bas))  //on ne peut plus rajouter de ligne
				APPEND TO ARRAY:C911($ligne; "Cumul Court")
				$Hauteur_deja_imp:=$Hauteur_deja_imp+$taille_pied_short
				
				$reste:=$espace_restant-$Taille_petit_bas
				While ($reste>1)  //on doit rajouter des pixels blancs de décalage
					Case of 
						: ($reste>50)
							APPEND TO ARRAY:C911($ligne; "Pixel50")
							$reste:=$reste-50
						: ($reste>20)
							APPEND TO ARRAY:C911($ligne; "Pixel20")
							$reste:=$reste-20
						: ($reste>10)
							APPEND TO ARRAY:C911($ligne; "Pixel10")
							$reste:=$reste-10
						: ($reste>5)
							APPEND TO ARRAY:C911($ligne; "Pixel5")
							$reste:=$reste-5
						: ($reste>2)
							APPEND TO ARRAY:C911($ligne; "Pixel2")
							$reste:=$reste-2
						: ($reste>1)
							APPEND TO ARRAY:C911($ligne; "Pixel1")
							$reste:=$reste-1
					End case 
				End while 
				
				APPEND TO ARRAY:C911($ligne; "Pied")
				
				$Nbre_page:=$Nbre_page+1
				
				APPEND TO ARRAY:C911($ligne; "Entete courte")
				$Hauteur_deja_imp:=$taille_entete_short
				APPEND TO ARRAY:C911($ligne; "Corps")
				$Hauteur_deja_imp:=$Hauteur_deja_imp+$hauteur_ligne{$i}
				
			Else 
				APPEND TO ARRAY:C911($ligne; "Corps")
				$Hauteur_deja_imp:=$Hauteur_deja_imp+$hauteur_ligne{$i}
		End case 
		
		If ($i=Size of array:C274($hauteur_ligne))  //c'est la fin on doit imprimer le pied
			$espace_restant:=$hauteur_page-$Hauteur_deja_imp
			If ($espace_restant<$Taille_grand_bas)
				APPEND TO ARRAY:C911($ligne; "Cumul Court")
				$Hauteur_deja_imp:=$Hauteur_deja_imp+$taille_pied_short
				
				$reste:=$espace_restant-$Taille_petit_bas
				While ($reste>1)  //on doit rajouter des pixels blancs de décalage
					Case of 
						: ($reste>50)
							APPEND TO ARRAY:C911($ligne; "Pixel50")
							$reste:=$reste-50
						: ($reste>20)
							APPEND TO ARRAY:C911($ligne; "Pixel20")
							$reste:=$reste-20
						: ($reste>10)
							APPEND TO ARRAY:C911($ligne; "Pixel10")
							$reste:=$reste-10
						: ($reste>5)
							APPEND TO ARRAY:C911($ligne; "Pixel5")
							$reste:=$reste-5
						: ($reste>2)
							APPEND TO ARRAY:C911($ligne; "Pixel2")
							$reste:=$reste-2
						: ($reste>1)
							APPEND TO ARRAY:C911($ligne; "Pixel1")
							$reste:=$reste-1
					End case 
				End while 
				
				APPEND TO ARRAY:C911($ligne; "Pied")
				$Nbre_page:=$Nbre_page+1
				
				
				APPEND TO ARRAY:C911($ligne; "Entete courte")
				$Hauteur_deja_imp:=$taille_entete_short
				APPEND TO ARRAY:C911($ligne; "Cumul Court vide")
				$Hauteur_deja_imp:=$Hauteur_deja_imp+$taille_pied_short
				APPEND TO ARRAY:C911($ligne; "Cumul long")
				$Hauteur_deja_imp:=$Hauteur_deja_imp+$taille_pied_long
				$espace_restant:=$hauteur_page-$Hauteur_deja_imp
				$reste:=$espace_restant-$taille_bas_de_page
				While ($reste>1)  //on doit rajouter des pixels blancs de décalage
					Case of 
						: ($reste>50)
							APPEND TO ARRAY:C911($ligne; "Pixel50")
							$reste:=$reste-50
						: ($reste>20)
							APPEND TO ARRAY:C911($ligne; "Pixel20")
							$reste:=$reste-20
						: ($reste>10)
							APPEND TO ARRAY:C911($ligne; "Pixel10")
							$reste:=$reste-10
						: ($reste>5)
							APPEND TO ARRAY:C911($ligne; "Pixel5")
							$reste:=$reste-5
						: ($reste>2)
							APPEND TO ARRAY:C911($ligne; "Pixel2")
							$reste:=$reste-2
						: ($reste>1)
							APPEND TO ARRAY:C911($ligne; "Pixel1")
							$reste:=$reste-1
					End case 
				End while 
				APPEND TO ARRAY:C911($ligne; "Pied")
			Else 
				APPEND TO ARRAY:C911($ligne; "Cumul Court vide")
				$Hauteur_deja_imp:=$Hauteur_deja_imp+$taille_pied_short
				
				APPEND TO ARRAY:C911($ligne; "Cumul long")
				$Hauteur_deja_imp:=$Hauteur_deja_imp+$taille_pied_long
				$espace_restant:=$hauteur_page-$Hauteur_deja_imp
				$reste:=$espace_restant-$taille_bas_de_page
				
				While ($reste>1)  //on doit rajouter des pixels blancs de décalage
					Case of 
						: ($reste>50)
							APPEND TO ARRAY:C911($ligne; "Pixel50")
							$reste:=$reste-50
						: ($reste>20)
							APPEND TO ARRAY:C911($ligne; "Pixel20")
							$reste:=$reste-20
						: ($reste>10)
							APPEND TO ARRAY:C911($ligne; "Pixel10")
							$reste:=$reste-10
						: ($reste>5)
							APPEND TO ARRAY:C911($ligne; "Pixel5")
							$reste:=$reste-5
						: ($reste>2)
							APPEND TO ARRAY:C911($ligne; "Pixel2")
							$reste:=$reste-2
						: ($reste>1)
							APPEND TO ARRAY:C911($ligne; "Pixel1")
							$reste:=$reste-1
					End case 
				End while 
				APPEND TO ARRAY:C911($ligne; "Pied")
			End if 
			
		End if 
	End for 
	
	//PARAMETRES IMPRESSION
	
	Nbre_page:=$Nbre_page
	//Impression proprement dit
	FIRST RECORD:C50($ptr_fichier_ligne->)
	numero_page_courante:=1
	Mode_impression:="Impression"
	ON ERR CALL:C155("IMPLI_Erreur")
	nb_ligne:=Size of array:C274($ligne)
	For ($k; 1; nb_ligne)
		Section:=$ligne{$k}
		Case of 
			: (Section="Entete Grande")
				The_page:=String:C10(numero_page_courante)+" / "+String:C10(Nbre_page)
				numero_page_courante:=numero_page_courante+1
				$hauteur_de_la_ligne:=Print form:C5($ptr_fichier->; $nom_formulaire; Entête formulaire:K43:3)
				
			: (Section="Entete courte")
				The_page:=String:C10(numero_page_courante)+" / "+String:C10(Nbre_page)
				numero_page_courante:=numero_page_courante+1
				$hauteur_de_la_ligne:=Print form:C5($ptr_fichier->; $nom_formulaire; Entête formulaire1:K43:4)
				
			: (Section="Corps")
				$hauteur_de_la_ligne:=Print form:C5($ptr_fichier->; $nom_formulaire; Corps formulaire:K43:1)
				NEXT RECORD:C51($ptr_fichier_ligne->)
				
			: (Section="Cumul Court@")
				$hauteur_de_la_ligne:=Print form:C5($ptr_fichier->; $nom_formulaire; Rupture formulaire1:K43:15)
				
			: (Section="Cumul long")
				$hauteur_de_la_ligne:=Print form:C5($ptr_fichier->; $nom_formulaire; Rupture formulaire0:K43:14)
				
			: (Section="Pied")
				//The_page:=Chaine(numero_page_courante)+" / "+Chaine(Nbre_page)
				$hauteur_de_la_ligne:=Print form:C5($ptr_fichier->; $nom_formulaire; Pied de page formulaire:K43:2)
				//numero_page_courante:=numero_page_courante+1
				
				
			: (Section="Pixel1")
				$hauteur_de_la_ligne:=Print form:C5([Structures:79]; "Pixel"; Entête formulaire:K43:3)
				
			: (Section="Pixel2")
				$hauteur_de_la_ligne:=Print form:C5([Structures:79]; "Pixel"; Entête formulaire1:K43:4)
				
			: (Section="Pixel5")
				$hauteur_de_la_ligne:=Print form:C5([Structures:79]; "Pixel"; Entête formulaire2:K43:5)
				
			: (Section="Pixel10")
				$hauteur_de_la_ligne:=Print form:C5([Structures:79]; "Pixel"; Entête formulaire3:K43:6)
				
			: (Section="Pixel20")
				$hauteur_de_la_ligne:=Print form:C5([Structures:79]; "Pixel"; Entête formulaire4:K43:7)
				
			: (Section="Pixel50")
				$hauteur_de_la_ligne:=Print form:C5([Structures:79]; "Pixel"; Entête formulaire5:K43:8)
				
		End case 
	End for 
	ON ERR CALL:C155("")
	PAGE BREAK:C6
Else 
	$0:=False:C215
End if 