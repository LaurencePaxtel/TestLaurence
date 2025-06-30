//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 16/01/19, 11:56:14
// ----------------------------------------------------
// Méthode : outilsCreateXliffFile
// Description
// Génération du fichier xliff
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var $2 : Variant

var $cr_t; $tab_t; $element_t : Text
var $i_el; $process_el; $lengthMax_el; $moduloProgress_el : Integer
var $xliffFile_h : Time
var $collection_c : Collection

var $xliffFile_f : 4D:C1709.File

$collection_c:=New collection:C1472

If (Value type:C1509($2)=Est un pointeur:K8:14)
	ARRAY TO COLLECTION:C1563($collection_c; $2->)
Else 
	$collection_c:=$2.copy()
End if 

If (Application type:C494=4D mode distant:K5:5)  // Si on est sur un 4D distant on éxécute cela sur le serveur
	$process_el:=Execute on server:C373("outilsCreateXliffFile"; 0; "Génération du fichier xliff STR"+String:C10($1); $1; $collection_c)
Else 
	
	If ($collection_c.length>0)
		$xliffFile_f:=Folder:C1567(fk dossier ressources:K87:11).file("fr.lproj/STR"+String:C10($1)+".xlf")
		
		If ($xliffFile_f.exists=True:C214)
			$xliffFile_f.delete()
		End if 
		
		$xliffFile_h:=Create document:C266($xliffFile_f.platformPath)
		
		If (OK=1)
			$cr_t:=Char:C90(Retour chariot:K15:38)
			$tab_t:=Char:C90(Tabulation:K15:37)
			
			$i_el:=1
			
			// Entête du fichier xliff
			SEND PACKET:C103($xliffFile_h; "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+$cr_t)
			SEND PACKET:C103($xliffFile_h; "<!DOCTYPE xliff PUBLIC \"-//XLIFF//DTD XLIFF//FR\""+$cr_t)
			SEND PACKET:C103($xliffFile_h; "\"http://www.oasis-open.org/committees/xliff/documents/xliff.dtd\">"+$cr_t+$cr_t)
			
			SEND PACKET:C103($xliffFile_h; "<xliff version=\"1.0\">"+$cr_t)
			SEND PACKET:C103($xliffFile_h; $tab_t+"<file datatype=\"x-STR#\" original=\"undefined\" source-language=\"fr\" target-language=\"fr\" product-version=\"v19\">"+$cr_t)
			SEND PACKET:C103($xliffFile_h; $tab_t+$tab_t+"<body>"+$cr_t)
			
			$lengthMax_el:=$collection_c.length
			$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
			
			outilsProgressBar(0; "Initialisation"; False:C215)
			
			// Libellé du groupe Chaîne($1)
			SEND PACKET:C103($xliffFile_h; $tab_t+$tab_t+$tab_t+"<group id=\""+String:C10($1)+"\" resname=\"STR# "+String:C10($1)+"\" >"+$cr_t)
			
			For each ($element_t; $collection_c)
				
				If ($i_el%$moduloProgress_el=0)
					outilsProgressBar($i_el/$lengthMax_el; "Génération du fichier xliff \"STR"+String:C10($1)+"\" en cours..."; True:C214)
				End if 
				
				// Libellé du trans-unit de chaque numChaine de Chaîne($1)
				SEND PACKET:C103($xliffFile_h; $tab_t+$tab_t+$tab_t+$tab_t+"<trans-unit id=\""+String:C10($i_el)+"\">"+$cr_t)
				
				// Source du trans-unit
				SEND PACKET:C103($xliffFile_h; $tab_t+$tab_t+$tab_t+$tab_t+$tab_t+"<source>"+$element_t+"</source>"+$cr_t)
				
				// Cible du trans-unit
				SEND PACKET:C103($xliffFile_h; $tab_t+$tab_t+$tab_t+$tab_t+$tab_t+"<target>"+$element_t+"</target>"+$cr_t)
				
				// Fin du trans-unit
				SEND PACKET:C103($xliffFile_h; $tab_t+$tab_t+$tab_t+$tab_t+"</trans-unit>"+$cr_t)
				
				$i_el:=$i_el+1
			End for each 
			
			// Fin du groupe Chaîne($1)
			SEND PACKET:C103($xliffFile_h; $tab_t+$tab_t+$tab_t+"</group>"+$cr_t)
			
			outilsProgressBar(1; "arrêt")
			
			// Bas du fichier xliff
			SEND PACKET:C103($xliffFile_h; $tab_t+$tab_t+"</body>"+$cr_t)
			SEND PACKET:C103($xliffFile_h; $tab_t+"</file>"+$cr_t)
			SEND PACKET:C103($xliffFile_h; "</xliff>")
			
			CLOSE DOCUMENT:C267($xliffFile_h)
		End if 
		
	End if 
	
End if 