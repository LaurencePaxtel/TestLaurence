//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : remyscanu
// Date et heure : 22/09/21, 10:36:51
// ----------------------------------------------------
// Méthode : Uut_Numerote
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Integer  // Référence unique de la ressource
var $1 : Pointer  // Nom de la ressource
var $2 : Boolean  // Remise à zéro
var $3 : Object  // Contient les données pour faire des recherches plus approfondies

var $nomRessource_t : Text
var $multiSocTableCheck_b : Boolean
var $referenceUnique_es : cs:C1710.ReferenceUniqueSelection
var $referenceUnique_e : cs:C1710.ReferenceUniqueEntity
var $Ref_Structure_t : Text
$multiSocTableCheck_b:=True:C214

If (Is a variable:C294($1))
	// Modified by: Kevin HASSAL (06/05/2020)
	$multiSocTableCheck_b:=Not:C34($1->="HG@")  // Traitement spécifique pour la numérotation des fiches d'hébergements par structure/mois
	$nomRessource_t:=$1->
Else 
	$nomRessource_t:=Table name:C256($1)
End if 

$referenceUnique_es:=ds:C1482.ReferenceUnique.query("RU_Fichier= :1"; $nomRessource_t)

If (Not:C34($multiSocTableCheck_b))
	Case of 
		: (Application type:C494=4D Server:K5:6) && (String:C10(ref_soc_active)#"")
			$Ref_Structure_t:=ref_soc_active
			
		: (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
			$Ref_Structure_t:=Session:C1714.storage.intervenant.Ref_Structure
		Else 
			$Ref_Structure_t:=Storage:C1525.societeDetail.Ref_Structure
	End case 
	$referenceUnique_es:=$referenceUnique_es.query("Ref_Structure = :1"; $Ref_Structure_t)
End if 

If ($referenceUnique_es.length>=1)
	$referenceUnique_e:=$referenceUnique_es.first()
	
	If (Count parameters:C259=2)
		If ($2=True:C214)
			$referenceUnique_e.RU_Numero:=0
		Else 
			$referenceUnique_e.RU_Numero+=1
		End if 
	Else 
		$referenceUnique_e.RU_Numero+=1
	End if 
	
	$state_o:=$referenceUnique_e.save()
	If ($state_o.success=False:C215)
		TRACE:C157
	End if 
	
Else 
	$referenceUnique_e:=ds:C1482.ReferenceUnique.new()
	
	$referenceUnique_e.Ref_Structure:=$Ref_Structure_t
	
	$referenceUnique_e.RU_Fichier:=$nomRessource_t
	$referenceUnique_e.RU_Numero:=1
	
	$state_o:=$referenceUnique_e.save()
	If ($state_o.success=False:C215)
		TRACE:C157
	End if 
End if 

$0:=$referenceUnique_e.RU_Numero
