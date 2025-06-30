//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/08/22, 17:50:53
// ----------------------------------------------------
// Méthode : outilsWProSendAjax
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $nomFichier_t; $modelePath_t; $content_t; $autreContent_t : Text
var $position_el : Integer
var $document_o; $autreFichier_o; $retour_o : Object

var $dossier_o; $dossierSauvegarde_o : 4D:C1709.Folder
var $fichier4wp_o : 4D:C1709.File  // Fichier 4D write pro
var $fichierHtml_f : 4D:C1709.File  // Fichier 4D write pro au format HTML
var $archive_o : 4D:C1709.ZipArchive  // Objet contenant l'archive decompressé.

var $writePro_es : cs:C1710.DOCWPROSelection
var $fileName_t : Text
$fileName_t:=Generate UUID:C1066+"export4WP"

$retour_o:=New object:C1471("modelePath"; "")
$location_e:=ds:C1482.Locations.get(Num:C11(w_visiteur.locationID))

Case of 
	: (String:C10(w_visiteur.action)="createNewVersion")  // Chargement d'un document 4D Write Pro pour qu'il soit lisible sur le web
		$writePro_es:=ds:C1482.DOCWPRO.query("nom = :1 AND structureRef = :2"; String:C10(w_visiteur.nomDocument); String:C10(w_visiteur.Ref_Structure))
		$writePro_es.refresh()
		
		If ($writePro_es.length=1)
			$document_o:=WP New:C1317($writePro_es.first().fichier)
			outilsWProChargeData(w_visiteur.nomDocument; ->$document_o)
			
			$nomFichier_t:=Replace string:C233($writePro_es.first().nom; "/"; " - ")
			$nomFichier_t:=Replace string:C233($nomFichier_t; "."; "")
			$nomFichier_t:=Replace string:C233($nomFichier_t; " "; "")
			
			$dossier_o:=Folder:C1567(fk dossier racine web:K87:15).folder("writePro/"+Replace string:C233(w_cookie; "."; "")+"/"+$nomFichier_t)
			
			$dossier_o.delete(Supprimer avec contenu:K24:24)  // Si le dossier n'existe pas, la fonction ne fait rien.
			$dossier_o.create()
			
			$dossierSauvegarde_o:=Folder:C1567(fk dossier racine web:K87:15).folder("writePro/"+String:C10(w_visiteur.Ref_Structure)+"/save/")
			
			If ($dossierSauvegarde_o.exists=False:C215)
				$dossierSauvegarde_o.create()
			End if 
			
			$fichier4wp_o:=$dossier_o.file($nomFichier_t+".4WP")
			
			// On change le titre du document dynamiquement (utilisé quand on fait l'export)
			WP SET ATTRIBUTES:C1342($document_o; wk title:K81:79; $fileName_t)
			
			// On calcule les expressions 4D dans le document
			WP FREEZE FORMULAS:C1708($document_o)
			WP EXPORT DOCUMENT:C1337($document_o; $fichier4wp_o.platformPath; wk 4wp:K81:4)
			
			// ----- Changement au format zip + décompression -----
			If ($fichier4wp_o.exists=True:C214)
				$fichier4wp_o:=$fichier4wp_o.rename($fichier4wp_o.name+".zip")
				
				$archive_o:=ZIP Read archive:C1637($fichier4wp_o)  // Décompression de l'archive
				$archive_o.root.copyTo($dossier_o.parent)  // Déplacement de l'archive décompressé.
				
				If ($archive_o.root#Null:C1517)
					// ----- Intégration du code générique dans le code HTML du fichier généré -----
					$fichierHtml_f:=$dossier_o.file($fileName_t+".html")
					$content_t:=$fichierHtml_f.getText("UTF-8"; Document inchangé:K24:18)
					
					$autreFichier_o:=Folder:C1567(fk dossier racine web:K87:15).file("include/writePro/convert4DWriteToHtml.html")
					
					If ($autreFichier_o.exists=True:C214)
						$autreContent_t:=$autreFichier_o.getText("UTF-8"; Document inchangé:K24:18)
						
						// On insère juste avant la balise </body> le contenu du fichier générique
						$position_el:=Position:C15("</body>"; $content_t)
						$content_t:=Insert string:C231($content_t; $autreContent_t; $position_el)
						
						// Et on re-remplace dans le fichier d'origine avec les changements apportés
						$fichierHtml_f.setText($content_t; "UTF-8"; Document inchangé:K24:18)
						$modelePath_t:="/"+Replace string:C233($dossier_o.path+$fileName_t+".html"; Folder:C1567(fk dossier racine web:K87:15).path; "")
					End if 
					
				End if 
				
			End if 
			
		Else 
			$retour_o.notificationError:="Le document "+w_visiteur.nomDocument+" n'a pas pu être trouvé dans la base de donnée, merci de contacter le service informatique."
		End if 
		
	: ($location_e#Null:C1517)  // Gestion des documents Etats des lieux
		$fichier4wp_o:=Folder:C1567(fk dossier racine web:K87:15).file("writePro/"+String:C10(w_visiteur.Ref_Structure)+"/save/"+String:C10(w_visiteur.locationID)+"/"+String:C10($location_e.LOC_HB_ID)+"/"+String:C10(w_visiteur.nomDocument)+"/export4WP.html")
		
		If (w_visiteur.action="checkIfSaveExist")
			$retour_o.exist:=$fichier4wp_o.exists
		End if 
		
		If (w_visiteur.action="loadSaveVersion")
			$modelePath_t:=Substring:C12($fichier4wp_o.path; Position:C15("/writePro/"; $fichier4wp_o.path))
		End if 
		
End case 

OB REMOVE:C1226(w_visiteur; "action")

$retour_o.modelePath:=$modelePath_t
WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))

outilsTableClearRecord(True:C214)