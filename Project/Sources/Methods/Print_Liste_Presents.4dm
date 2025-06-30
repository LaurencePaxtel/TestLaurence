//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 13/03/20, 08:20:28
// ----------------------------------------------------
// Method: Print_Liste_Presents
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($ptr_fichier; $1)
C_TEXT:C284($2; $nom_formulaire; The_page; The_Page_Total)
C_LONGINT:C283($Nb_entete; $3; $NB_Pied; $4; $Nbre_page; $page_courante; $hauteur_page; $largeur_page; Thepage)
C_BOOLEAN:C305($Utilisation_nb_page_total; $5; $0)

$ptr_fichier:=$1
$nom_formulaire:=$2
$Nb_entete:=$3
$NB_Pied:=$4
$Utilisation_nb_page_total:=$5

If (Count parameters:C259>5)
	$para_imp:=$6
Else 
	$para_imp:=True:C214
End if 

$taille_entete_long:=0
$taille_entete_short:=0

$taille_pied_long:=0
$taille_pied_short:=0

$page_courante:=0
Section:=""

val_filer:=10
Thepage:=1
The_page:=String:C10(Thepage)
The_Page_Total:=""
$Nbre_page:=0

//----------------------------------------------------------------------------------------
//         Calcul de la hauteur des sections (premier passage sans impression             
//         La fonction ne pas valider qui stop l'impression                               
//         Empeche imprimer ligne de retourner la hauteur Imprimée.                       
//         Idem pour la fonction lire hauteur imprimee                                   
//----------------------------------------------------------------------------------------


taille_taquet:=0
taille_taquet_base:=0


If ($para_imp)
	_O_PAGE SETUP:C299($ptr_fichier->; $nom_formulaire)
	PRINT SETTINGS:C106
End if 

If (ok=1)
	$0:=True:C214
	
	OPEN PRINTING JOB:C995
	
	
	GET PRINTABLE AREA:C703($hauteur_page; $largeur_page)
	Mode_impression:="Mesure"
	
	Section:="Entete"
	taquet:=Entête formulaire:K43:3
	$nul:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$taille_entete:=taille_taquet_base
	
	Section:="Entete1"
	taquet:=Entête formulaire1:K43:4
	$nul:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$pos_taquet_Entete1:=taille_taquet_base
	
	Section:="Entete2"
	taquet:=Entête formulaire2:K43:5
	$nul:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$pos_taquet_entete2:=taille_taquet_base
	
	Section:="corps_de_base"  //Pas de traitement
	taquet:=Corps formulaire:K43:1
	$nul:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$pos_corps_base:=taille_taquet_base
	
	
	Section:="Rupture3"
	taquet:=Rupture formulaire3:K43:17
	$nul:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$pos_taquet_rupture3:=taille_taquet_base
	
	Section:="Rupture2"
	taquet:=Rupture formulaire2:K43:16
	$nul:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$pos_taquet_rupture2:=taille_taquet_base
	
	Section:="Rupture1"
	taquet:=Rupture formulaire1:K43:15
	$nul:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$pos_taquet_rupture1:=taille_taquet_base
	
	Section:="Rupture0"
	taquet:=Rupture formulaire0:K43:14
	$nul:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$pos_taquet_rupture0:=taille_taquet_base
	
	Section:="Pied"
	taquet:=Pied de page formulaire:K43:2
	$nul:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$pos_taquet_pied:=taille_taquet_base
	
	//-------------------------------------//
	// Calculs des hauteurs des sections   //
	//-------------------------------------//
	
	// Calcul des hauteurs des entêtes
	$hauteur_entete_grande:=$taille_entete
	$hauteur_entete_1:=$pos_taquet_entete1-$taille_entete
	$hauteur_entete_2:=$pos_taquet_entete2-$pos_taquet_entete1
	$hauteur_pied:=$pos_taquet_pied-$pos_taquet_rupture0
	
	// Calcul des hauteurs des ruptures
	$hauteur_rupture3:=$pos_taquet_rupture3-$pos_corps_base
	$hauteur_rupture2:=$pos_taquet_rupture2-$pos_taquet_rupture3
	$hauteur_rupture1:=$pos_taquet_rupture1-$pos_taquet_rupture2
	$hauteur_rupture0:=$pos_taquet_rupture0-$pos_taquet_rupture1
	
	// ---------------------------------------------------------------------//
	//              Calcul de la hauteur des lignes à imprimer              //
	//----------------------------------------------------------------------//
	
	$hauteur_disponible:=$hauteur_page-($hauteur_pied+$hauteur_rupture3)
	
	$Hauteur_deja_imprime:=$hauteur_entete_grande
	$Hauteur_deja_imprime:=$Hauteur_deja_imprime+$hauteur_entete_2
	
	$espace_restant:=$hauteur_disponible-$Hauteur_deja_imprime
	$Nbre_page:=1
	
	ARRAY LONGINT:C221($hauteur_ligne; 0)
	
	
	
	$cpt:=0
	
	For ($lp_i; 1; lp_total_rows)
		
		$cpt:=1
		
		Section:="Corps"
		taquet:=Corps formulaire:K43:1
		$nul:=Print form:C5($ptr_fichier->; $nom_formulaire; Corps formulaire:K43:1)
		APPEND TO ARRAY:C911($hauteur_ligne; taille_taquet_base-$pos_taquet_entete2)
		
		$Hauteur_deja_imprime:=$Hauteur_deja_imprime+(taille_taquet_base-$pos_taquet_entete2)
		$espace_restant:=$hauteur_disponible-$Hauteur_deja_imprime
		
		If ($cpt>1)
			$hauteur_ligne_imprime:=(taille_taquet_base-$pos_taquet_entete2)-$hauteur_ligne{$cpt-1}
		Else 
			$hauteur_ligne_imprime:=(taille_taquet_base-$pos_taquet_entete2)
		End if 
		
		
		If ($espace_restant<$hauteur_ligne_imprime)
			$Nbre_page:=$Nbre_page+1
			$Hauteur_deja_imprime:=$hauteur_entete_1
			$Hauteur_deja_imprime:=$Hauteur_deja_imprime+$hauteur_entete_2
		End if 
		
	End for 
	
	
	
	//----------------------------------------------------------------------------------------//
	//                               Impression proprement dit                                //
	//----------------------------------------------------------------------------------------//
	//APPELER SUR ERREUR("IMPLI_Erreur")
	Mode_impression:="Impression"
	
	$hauteur_disponible:=$hauteur_page-($hauteur_pied+$hauteur_rupture3)
	$reste:=$hauteur_disponible
	
	//Impression de l'entete initial
	
	The_Page_Total:=String:C10(String:C10(Printing page:C275)+"/"+String:C10($Nbre_page))
	
	Section:="Entete"
	taquet:=Entête formulaire:K43:3
	$taille_entete_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
	$reste:=$hauteur_disponible-Get printed height:C702
	
	ok:=1
	
	
	$print_latest_rupture_3:=False:C215
	
	For ($i; 1; lp_total_rows)
		If (ok=1)
			
			// Si la hauteur de la ligne dépasse la hauteur disponible
			
			txt_dimanche:=""
			txt_lundi:=""
			txt_mardi:=""
			txt_mercredi:=""
			txt_jeudi:=""
			txt_vendredi:=""
			txt_samedi:=""
			
			If ($i<=Size of array:C274(tb_lp_dimanche))
				txt_dimanche:=tb_lp_dimanche{$i}
			End if 
			If ($i<=Size of array:C274(tb_lp_lundi))
				txt_lundi:=tb_lp_lundi{$i}
			End if 
			If ($i<=Size of array:C274(tb_lp_mardi))
				txt_mardi:=tb_lp_mardi{$i}
			End if 
			If ($i<=Size of array:C274(tb_lp_mercredi))
				txt_mercredi:=tb_lp_mercredi{$i}
			End if 
			If ($i<=Size of array:C274(tb_lp_jeudi))
				txt_jeudi:=tb_lp_jeudi{$i}
			End if 
			If ($i<=Size of array:C274(tb_lp_vendredi))
				txt_vendredi:=tb_lp_vendredi{$i}
			End if 
			If ($i<=Size of array:C274(tb_lp_samedi))
				txt_samedi:=tb_lp_samedi{$i}
			End if 
			
			
			
			The_Page_Total:=String:C10(String:C10(Printing page:C275)+"/"+String:C10($Nbre_page))
			
			
			If ($hauteur_ligne{$i}>$reste)
				
				Section:="Rupture3"
				taquet:=Rupture formulaire3:K43:17
				$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
				
				//  //calcul du filer
				//val_filer:=$hauteur_page-Get printed height-$hauteur_pied
				//If (val_filer#0)
				//Section:="Rupture1"
				//taquet:=Form break1
				//$taille_pied_long:=Print form($ptr_fichier->;$nom_formulaire;taquet)
				//$reste:=$hauteur_disponible-Get printed height
				//End if 
				
				//==================================//
				// Added by: Kevin HASSAL (09/03/2020)
				//==================================//
				$reste:=$hauteur_disponible-Get printed height:C702
				
				While ($reste>0)
					Section:="Rupture1"
					taquet:=Rupture formulaire1:K43:15
					$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
					$reste:=$hauteur_disponible-Get printed height:C702
				End while 
				
				//==================================//
				
				
				Section:="Pied"
				taquet:=Pied de page formulaire:K43:2
				$taille:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
				
				//PAGE BREAK
				
				Thepage:=Thepage+1
				The_page:=String:C10(Thepage)
				The_Page_Total:=String:C10(String:C10(Thepage)+"/"+String:C10($Nbre_page))
				
				Section:="Entete1"
				taquet:=Entête formulaire1:K43:4
				$h_ligne:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
				
				Section:="Entete2"
				taquet:=Entête formulaire2:K43:5
				$h_ligne:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
				
			End if 
			
			Section:="Corps"
			taquet:=Corps formulaire:K43:1
			$h_ligne:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
			
			$reste:=$hauteur_disponible-Get printed height:C702
			
		Else 
			$i:=Size of array:C274($hauteur_ligne)+1
		End if 
	End for 
	
	
	If (ok=1)
		
		The_Page_Total:=String:C10(String:C10(Printing page:C275)+"/"+String:C10($Nbre_page))
		
		Section:="Rupture3"
		taquet:=Rupture formulaire3:K43:17
		$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
		$reste:=$hauteur_disponible-Get printed height:C702
		
		If (($hauteur_rupture2+$hauteur_rupture0+$hauteur_pied)>$reste)
			
			//calcul du filer
			val_filer:=$hauteur_page-Get printed height:C702-$hauteur_pied
			If (val_filer#0)
				Section:="Rupture1"
				taquet:=Rupture formulaire1:K43:15
				$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
				$reste:=$hauteur_disponible-Get printed height:C702
			End if 
			
			//==================================//
			// Added by: Kevin HASSAL (09/03/2020)
			//==================================//
			$reste:=$hauteur_disponible-Get printed height:C702
			While ($reste>0)
				Section:="Rupture1"
				taquet:=Rupture formulaire1:K43:15
				$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
				$reste:=$hauteur_disponible-Get printed height:C702
			End while 
			
			//==================================//
			
			
			Section:="Pied"
			taquet:=Pied de page formulaire:K43:2
			$taille:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
			
			PAGE BREAK:C6
			
			Thepage:=Thepage+1
			The_page:=String:C10(Thepage)
			The_Page_Total:=String:C10(String:C10(Thepage)+"/"+String:C10($Nbre_page))
			
			Section:="Entete1"
			taquet:=Entête formulaire1:K43:4
			$h_ligne:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
			
		End if 
		
		// Impression des totaux
		Section:="Rupture2"
		taquet:=Rupture formulaire2:K43:16
		$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
		$reste:=$hauteur_disponible-Get printed height:C702
		
		// Valeur du dernier filer
		val_filer:=$hauteur_page-Get printed height:C702-($hauteur_pied+$hauteur_rupture0)
		If (val_filer#0)
			Section:="Rupture1"
			taquet:=Rupture formulaire1:K43:15
			$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
			$reste:=$hauteur_disponible-Get printed height:C702
		End if 
		
		//Impression de la mention obligatoire
		Section:="Rupture0"
		taquet:=Rupture formulaire0:K43:14
		$taille_pied_short:=Print form:C5($ptr_fichier->; $nom_formulaire; Rupture formulaire0:K43:14)
		$reste:=$hauteur_disponible-Get printed height:C702
		
		//==================================//
		// Added by: Kevin HASSAL (09/03/2020)
		//==================================//
		While ($reste>0)
			Section:="Rupture1"
			taquet:=Rupture formulaire1:K43:15
			$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
			$reste:=$hauteur_disponible-Get printed height:C702
			$reste:=$hauteur_disponible-Get printed height:C702
		End while 
		
		
		//==================================//
		
		//Impression du logo de bas de page
		Section:="Pied"
		taquet:=Pied de page formulaire:K43:2
		$taille:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
		$reste:=$hauteur_disponible-Get printed height:C702
		
	End if 
	
	
	CLOSE PRINTING JOB:C996
	
Else 
	$0:=False:C215
End if 

