//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 26/08/22, 17:09:56
// ----------------------------------------------------
// Méthode : outilsWProWebManageAjax
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $dossierSauvegarde_o; $retour_o : Object
var $file_f : 4D:C1709.File

var $location_e : cs:C1710.LocationsEntity
var $writePro_es : cs:C1710.DOCWPROSelection

$retour_o:=New object:C1471

Case of 
	: (String:C10(w_visiteur.entree)="1")  // Sauvegarde d'un document en rapport avec une location
		$location_e:=ds:C1482.Locations.get(Num:C11(w_visiteur.locationID))
		
		If ($location_e#Null:C1517)
			$dossierSauvegarde_o:=Folder:C1567(fk dossier racine web:K87:15).folder("writePro/"+String:C10(w_visiteur.Ref_Structure)+"/save/"+String:C10(w_visiteur.locationID)+"/"+String:C10($location_e.LOC_HB_ID)+"/"+String:C10(w_visiteur.nomDocument)+"/")
			
			If ($dossierSauvegarde_o.exists=False:C215)
				$dossierSauvegarde_o.create()
			End if 
			
			$file_f:=$dossierSauvegarde_o.file("export4WP.html")
			
			If ($file_f.exists=False:C215)
				$file_f.create()
			End if 
			
			$file_f.setText(String:C10(w_visiteur.contentHtml))
		End if 
		
	: (String:C10(w_visiteur.entree)="2")  // Récupération de tous les documents qui porte un tag en particulier
		outilsOrdaSearchSimple(->[DOCWPRO:121]; ->[DOCWPRO:121]tag:5; "@"+String:C10(w_visiteur.tag)+"@"; ->$writePro_es)
		$retour_o.document:=$writePro_es.toCollection("nom").extract("nom").distinct().orderBy(ck ascending:K85:9)
End case 

outilsObjectDeleteProperty(w_visiteur; "contentHtml"; "tag")
WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))