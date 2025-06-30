//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 16:15:04
// ----------------------------------------------------
// Method: WebAGL_Print_Piece_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_BOOLEAN:C305($6)
C_BOOLEAN:C305($7)  // [Optionnel]
C_BOOLEAN:C305($8)  // [Optionnel]
C_BOOLEAN:C305($9)  // [Optionnel]

C_POINTER:C301($ptr_fichier; $ptr_fichier_ligne)
C_TEXT:C284($nom_formulaire; The_page; The_Page_Total)
C_LONGINT:C283($taille; $taille_entete; $taille_entete_long; $taille_pied_long; $taille_pied_short; $Nb_entete; $NB_Pied; $Nbre_page; \
$hauteur_page; $largeur_page; $cpt; $reste; $nul; $hauteur_entete_1; $hauteur_entete_2; $hauteur_entete_grande; $hauteur_pied; $pos_taquet_Entete1; $pos_taquet_entete2; $pos_corps_base; \
$pos_corps_base; $pos_taquet_rupture3; $pos_taquet_rupture2; $pos_taquet_rupture1; $pos_taquet_rupture0; $pos_taquet_pied; $hauteur_rupture3; $hauteur_rupture2; $hauteur_rupture1; $hauteur_rupture0; $hauteur_disponible; $vlprintedheight)
C_BOOLEAN:C305($Utilisation_nb_page_total; $option_orientation; $vb_Impression_lignes; $para_imp; $ouvrirTacheImpression_b)

C_LONGINT:C283(Thepage)

ARRAY LONGINT:C221($hauteur_ligne; 0)

$ptr_fichier:=$1
$ptr_fichier_ligne:=$2
$nom_formulaire:=$3
$Nb_entete:=$4
$NB_Pied:=$5
$Utilisation_nb_page_total:=$6

$vb_Impression_page:=(Table:C252($ptr_fichier)=Table:C252(->[Factures:86])) & ($nom_formulaire="Print")
$vb_Impression_lignes:=((Table:C252($ptr_fichier_ligne)=Table:C252(->[Factures_Lignes:87])) & ($vb_Impression_page=False:C215))

// OD 20201120 passer par un "imprimer sélection sur $ptr_fichier_ligne et plus par une gestion calcyulée des lignes)
// du coup, déplacement des formulaires de la table [factures] vers la table [Factures_Lignes]
// au passage, modif du format de LetterUS en A4
If (Count parameters:C259>6)
	$para_imp:=$7
Else 
	$para_imp:=True:C214
End if 

If (Count parameters:C259>7)
	$option_orientation:=$8
End if 

If (Count parameters:C259>8)
	$ouvrirTacheImpression_b:=$9
Else 
	$ouvrirTacheImpression_b:=True:C214
End if 


Section:=""
The_page:="1"
The_Page_Total:=""

val_filer:=10
Thepage:=1

//----------------------------------------------------------------------------------------
//         Calcul de la hauteur des sections (premier passage sans impression             
//         La fonction ne pas valider qui stop l'impression                               
//         Empeche imprimer ligne de retourner la hauteur Imprimée.                       
//         Idem pour la fonction lire hauteur imprimee                                   
//----------------------------------------------------------------------------------------
taille_taquet:=0
taille_taquet_base:=0

If ($para_imp) & ($ouvrirTacheImpression_b=True:C214)
	
	If ($vb_Impression_lignes)
		_O_PAGE SETUP:C299($ptr_fichier_ligne->; $nom_formulaire)
	Else 
		_O_PAGE SETUP:C299($ptr_fichier->; $nom_formulaire)
	End if 
	
	PRINT SETTINGS:C106
End if 

If (ok=1)
	
	If ($option_orientation)
		SET PRINT OPTION:C733(Option orientation:K47:2; 2)
	End if 
	
	COPY NAMED SELECTION:C331($ptr_fichier_ligne->; "$sel_lignes")
	
	Case of 
		: ($vb_Impression_lignes)  // On démonte tout, OD 20201120
			Mode_impression:=""
			
			FORM SET OUTPUT:C54($ptr_fichier_ligne->; $nom_formulaire)
			PRINT SELECTION:C60($ptr_fichier_ligne->; *)
		: ($vb_Impression_page)
			Mode_impression:=""
			
			FORM SET OUTPUT:C54($ptr_fichier->; $nom_formulaire)
			PRINT RECORD:C71($ptr_fichier->; *)
		Else 
			
			If ($ouvrirTacheImpression_b=True:C214)
				OPEN PRINTING JOB:C995
			End if 
			
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
			
			Section:="corps_de_base"  // Pas de traitement
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
			
			FIRST RECORD:C50($ptr_fichier_ligne->)
			
			While (Not:C34(End selection:C36($ptr_fichier_ligne->)))
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
				
				NEXT RECORD:C51($ptr_fichier_ligne->)
			End while 
			
			//----------------------------------------------------------------------------------------//
			//                               Impression proprement dit                                //
			//----------------------------------------------------------------------------------------//
			//APPELER SUR ERREUR("IMPLI_Erreur")
			Mode_impression:="Impression"
			
			$hauteur_disponible:=$hauteur_page-($hauteur_pied+$hauteur_rupture3)
			$reste:=$hauteur_disponible
			
			// Impression de l'entete initial
			Section:="Entete"
			taquet:=Entête formulaire:K43:3
			
			$taille_entete_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
			$reste:=$hauteur_disponible-Get printed height:C702
			
			ok:=1
			
			// Impression des lignes
			USE NAMED SELECTION:C332("$sel_lignes")
			FIRST RECORD:C50($ptr_fichier_ligne->)
			
			For ($i; 1; Size of array:C274($hauteur_ligne))
				
				If (ok=1)  // Si la hauteur de la ligne dépasse la hauteur disponible
					The_Page_Total:=String:C10(String:C10(Printing page:C275)+"/"+String:C10($Nbre_page))
					
					If ($hauteur_ligne{$i}>$reste)
						Section:="Rupture3"
						taquet:=Rupture formulaire3:K43:17
						
						$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
						
						// Calcul du filer
						val_filer:=$hauteur_page-Get printed height:C702-$hauteur_pied
						
						If (val_filer#0)
							Section:="Rupture1"
							taquet:=Rupture formulaire1:K43:15
							
							$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
							$reste:=$hauteur_disponible-Get printed height:C702
						End if 
						
						Section:="Pied"
						taquet:=Pied de page formulaire:K43:2
						
						$taille:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
						PAGE BREAK:C6
						
						Thepage:=Thepage+1
						The_page:=String:C10(Thepage)
						
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
					
					NEXT RECORD:C51($ptr_fichier_ligne->)
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
					
					// Calcul du filer
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
					While ($reste>0)
						Section:="Rupture1"
						taquet:=Rupture formulaire1:K43:15
						
						$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
						$vlprintedheight:=Get printed height:C702
						$reste:=$reste-$vlprintedheight
						
						If ($vlprintedheight=0)
							CLEAR VARIABLE:C89($reste)
						End if 
						
					End while 
					
					Section:="Rupture1"
					taquet:=Rupture formulaire1:K43:15
					
					$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
					$reste:=$hauteur_disponible-Get printed height:C702
					
					Section:="Rupture1"
					taquet:=Rupture formulaire1:K43:15
					
					$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
					$reste:=$hauteur_disponible-Get printed height:C702
					//==================================//
					
					Section:="Pied"
					taquet:=Pied de page formulaire:K43:2
					
					$taille:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
					PAGE BREAK:C6
					
					Thepage:=Thepage+1
					The_page:=String:C10(Thepage)
					The_Page_Total:=String:C10(String:C10(Printing page:C275)+"/"+String:C10($Nbre_page))
					
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
					$vlprintedheight:=Get printed height:C702
					$reste:=$reste-$vlprintedheight
					
					If ($vlprintedheight=0)
						CLEAR VARIABLE:C89($reste)
					End if 
					
				End while 
				
				Section:="Rupture1"
				taquet:=Rupture formulaire1:K43:15
				
				$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
				$reste:=$hauteur_disponible-Get printed height:C702
				
				Section:="Rupture1"
				taquet:=Rupture formulaire1:K43:15
				
				$taille_pied_long:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
				$reste:=$hauteur_disponible-Get printed height:C702
				//==================================//
				
				// Impression du logo de bas de page
				Section:="Pied"
				taquet:=Pied de page formulaire:K43:2
				
				$taille:=Print form:C5($ptr_fichier->; $nom_formulaire; taquet)
				$reste:=$hauteur_disponible-Get printed height:C702
			End if 
			
			If ($ouvrirTacheImpression_b=True:C214)
				CLOSE PRINTING JOB:C996
			End if 
			
	End case 
	
	$0:=True:C214
	
	USE NAMED SELECTION:C332("$sel_lignes")
	CLEAR NAMED SELECTION:C333("$sel_lignes")
End if 