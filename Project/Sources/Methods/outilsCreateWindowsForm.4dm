//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 31/03/20, 18:24:39
// ----------------------------------------------------
// Méthode : outilsCreateWindowsForm
// Description
// 
//
// Paramètres
// $1 = Nom du formulaire
// $2 = Espace en pixel entre le haut/bas de l'écran et le formulaire [numérique ou texte ou objet]
// $3 = Entity Selection [optionnel]
// $4 = Pointeur de la Table OU Objet pour définir paramètre d'entrée et de sortie [optionnel]
// $5 = Objet de paramètre pour les formulaires entrée et sortie [optionnel]
// $6 = Pointeur de la référence de la fenêtre (créer juste la fenêtre ne fait pas apparaître le formulaire appelé) [optionnel]
// ----------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_OBJECT:C1216($3)
C_VARIANT:C1683($4)
C_OBJECT:C1216($5)
C_POINTER:C301($6)

C_TEXT:C284($formSortie_t; $formEntree_t; $formSortieClose_t; $formEntreeClose_t; $titre_t)
C_LONGINT:C283($hauteur_el; $largeur_el; $menu_el; $largeurForm_el; $hauteurForm_el; $moitie_el; $refFen_el; $processFen_el; $gauche_el; $haut_el; $droite_el; $bas_el; $gaucheCalcul_el; $droiteCalcul_el)
C_BOOLEAN:C305($param4isObject_b; $largeurFixe_b; $hauteurFixe_b; $useFormTable_b; $addNewRecord_b; $useSubForm_b; $useExternalWindows_b)
C_POINTER:C301($table_p)

$hauteur_el:=Screen height:C188(*)
$largeur_el:=Screen width:C187(*)

$menu_el:=Menu bar height:C440

If (Count parameters:C259>=4)
	$param4isObject_b:=(Value type:C1509($4)=Est un objet:K8:27)
	
	If ($param4isObject_b=True:C214)
		$addNewRecord_b:=Bool:C1537($4.addNewRecord)
	End if 
	
End if 

If (Count parameters:C259<4) | ($param4isObject_b=True:C214)
	
	If ($param4isObject_b=True:C214)
		$useFormTable_b:=Bool:C1537($4.useFormTable)
		$useSubForm_b:=Bool:C1537($4.useSubForm)
		$useExternalWindows_b:=Bool:C1537($4.useExternalWindows)
	End if 
	
	If ($useFormTable_b=True:C214)
		$table_p:=Formula from string:C1601("->["+$4.table+"]").call()
		FORM GET PROPERTIES:C674($table_p->; $1; $largeurForm_el; $hauteurForm_el; $nbPage_el; $largeurFixe_b; $hauteurFixe_b; $titre_t)
	Else 
		FORM GET PROPERTIES:C674($1; $largeurForm_el; $hauteurForm_el; $nbPage_el; $largeurFixe_b; $hauteurFixe_b; $titre_t)
	End if 
	
Else 
	FORM GET PROPERTIES:C674($4->; $1; $largeurForm_el; $hauteurForm_el; $nbPage_el; $largeurFixe_b; $hauteurFixe_b; $titre_t)
End if 

If ($useExternalWindows_b=True:C214)
	$refFen_el:=$4.refExternalWindows
Else 
	$moitie_el:=$largeurForm_el/2
	
	// Modifié par : Scanu Rémy (18/11/2021)
	// Résolution bug fenêtre maximiser en premier plan
	GET WINDOW RECT:C443($gauche_el; $haut_el; $droite_el; $bas_el; Frontmost window:C447)
	
	If ($gauche_el=0) & ($droite_el=$largeur_el)  // La fenêtre en premier plan prend toute la largeur de l'écran de l'ordinateur
		MINIMIZE WINDOW:C454(Frontmost window:C447)
	End if 
	
	Case of 
		: (Value type:C1509($2->)=Est un objet:K8:27)
			$refFen_el:=Open window:C153(($largeur_el/2)-$moitie_el; $menu_el+Num:C11($2->ecartHautEcran); ($largeur_el/2)+$moitie_el; $hauteur_el-Num:C11($2->ecartBasEcran); Fenêtre standard:K34:13; ""; "outilsCloseWindows")
		: (Value type:C1509($2->)=Est un entier long:K8:6)
			$refFen_el:=Open window:C153(($largeur_el/2)-$moitie_el; $menu_el+$2->; ($largeur_el/2)+$moitie_el; $hauteur_el-$2->; Fenêtre standard:K34:13; ""; "outilsCloseWindows")
		: (Value type:C1509($2->)=Est un texte:K8:3)
			
			Case of 
				: ($2->="left")
					
					If ($largeurForm_el>$largeur_el)
						$refFen_el:=Open window:C153(10; $menu_el+40; $largeur_el-10; $menu_el+$hauteurForm_el+40; Fenêtre standard:K34:13; ""; "outilsCloseWindows")
					Else 
						$refFen_el:=Open window:C153(10; $menu_el+40; $largeurForm_el-10; $menu_el+$hauteurForm_el+40; Fenêtre standard:K34:13; ""; "outilsCloseWindows")
					End if 
					
				: ($2->="right")
					
					If ($largeurForm_el>$largeur_el)
						$refFen_el:=Open window:C153(10; $menu_el+40; $largeur_el-10; $menu_el+$hauteurForm_el+40; Fenêtre standard:K34:13; ""; "outilsCloseWindows")
					Else 
						$refFen_el:=Open window:C153($largeur_el-$largeurForm_el-10; $menu_el+40; $largeur_el-10; $menu_el+$hauteurForm_el+40; Fenêtre standard:K34:13; ""; "outilsCloseWindows")
					End if 
					
				: ($2->="centerModal")
					$refFen_el:=Open window:C153(($largeur_el/2)-$moitie_el; (($hauteur_el/2)-10)-($hauteurForm_el/2); ($largeur_el/2)+$moitie_el; (($hauteur_el/2)-10)+($hauteurForm_el/2); Form dialogue modal:K39:7; ""; "outilsCloseWindows")
				: ($2->="center")
					$gaucheCalcul_el:=($largeur_el/2)-$moitie_el
					
					If ($gaucheCalcul_el<0)  // La Fenêtre va être plus large que la largeur de l'écran...
						$droiteCalcul_el:=$largeur_el-Abs:C99($gaucheCalcul_el)
					Else 
						$droiteCalcul_el:=($largeur_el/2)+$moitie_el
					End if 
					
					$refFen_el:=Open window:C153(Abs:C99($gaucheCalcul_el); (($hauteur_el/2)-10)-($hauteurForm_el/2); $droiteCalcul_el; (($hauteur_el/2)-10)+($hauteurForm_el/2); Fenêtre standard:K34:13; ""; "outilsCloseWindows")
				: ($2->="fullWidth")
					$refFen_el:=Open window:C153(0; $menu_el; $largeur_el; $hauteur_el-$menu_el; Fenêtre standard:K34:13; ""; "outilsCloseWindows")
			End case 
			
	End case 
	
End if 

If (Count parameters:C259>=3)
	
	If (String:C10($3.titreFenetre)#"")
		SET WINDOW TITLE:C213($3.titreFenetre; $refFen_el)
	End if 
	
End if 

$processFen_el:=Window process:C446($refFen_el)
BRING TO FRONT:C326($processFen_el)

If ($useFormTable_b=True:C214) & ($addNewRecord_b=True:C214)
	READ WRITE:C146($table_p->)
	CREATE RECORD:C68($table_p->)
End if 

Case of 
	: (Count parameters:C259=6)
		$6->:=$refFen_el
	: (Count parameters:C259=2)
		DIALOG:C40($1)
	: ($3=Null:C1517)
		DIALOG:C40($4->; $1)
	: (Count parameters:C259=3)
		DIALOG:C40($1; $3)
	: (Count parameters:C259=4) & (Value type:C1509($4)=Est un objet:K8:27)
		
		If ($4.entree#Null:C1517)
			$formEntree_t:=$4.entree
			$formSortie_t:=$4.sortie
			
			$formEntreeClose_t:=$4.entreeClose
			$formSortieClose_t:=$4.sortieClose
		End if 
		
		If (Is nil pointer:C315($table_p)=True:C214) & (String:C10($4.table)#"")
			$table_p:=Formula from string:C1601("->["+$4.table+"]").call()
		End if 
		
	: (Count parameters:C259=4)
		DIALOG:C40($4->; $1; $3)
	: (Count parameters:C259=5)
		$formEntree_t:=$5.entree
		$formSortie_t:=$5.sortie
		
		$formEntreeClose_t:=$5.entreeClose
		$formSortieClose_t:=$5.sortieClose
		$table_p:=$4
End case 

If (Count parameters:C259<6)
	
	If ($formEntree_t#"") | ($useSubForm_b=True:C214)
		
		If ($formEntree_t#"")
			FORM SET OUTPUT:C54($table_p->; $formSortie_t)
			FORM SET INPUT:C55($table_p->; $formEntree_t)
		End if 
		
		If ($param4isObject_b)
			
			Case of 
				: ($useSubForm_b=True:C214)
					// Modifié par : Scanu Rémy (20/04/2023)
					// On rajoute la propriété de la largeur du formulaire pour déterminer si on doit faire apparaître la barre de défilement horizontale
					$3.largeurForm:=$largeurForm_el
					DIALOG:C40("FormSubForm"; $3)
				: ($useFormTable_b=True:C214)
					DIALOG:C40($table_p->; $1; $3)
				Else 
					DIALOG:C40($1; $3)
			End case 
			
		Else 
			DIALOG:C40($4->; $1; $3)
		End if 
		
	End if 
	
	CLOSE WINDOW:C154($refFen_el)
	
	If ($formEntree_t#"")
		FORM SET INPUT:C55($table_p->; $formEntreeClose_t)
		FORM SET OUTPUT:C54($table_p->; $formSortieClose_t)
	End if 
	
	If ($gauche_el=0) & ($droite_el=$largeur_el)  // La fenêtre en premier plan prend toute la largeur de l'écran de l'ordinateur
		MAXIMIZE WINDOW:C453(Frontmost window:C447)
	End if 
	
End if 

If ($useFormTable_b=True:C214) & ($addNewRecord_b=True:C214) & (OK=1)
	SAVE RECORD:C53($table_p->)
End if 