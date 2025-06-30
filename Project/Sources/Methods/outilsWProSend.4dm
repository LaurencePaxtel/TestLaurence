//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 18/04/23, 18:51:03
// ----------------------------------------------------
// Méthode : outilsWProSend
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text
var $2 : Integer  // Nombre de document à imprimer
var $3 : Text  // Nom du document PDF
var $4 : Collection  // Ajout d'un ou plusieurs documents 4D Write Pro à la suite de l'impression du premier
var $5 : Boolean  // Indique si on est dans un contexte 4D [Optionnel]

var $writePro_t : Text
var $print1Document_b; $contexte4D_b : Boolean
var $document_o; $documentB_o : Object
var $writePro_c : Collection
var $Ref_Structure_t : Text
var $heberge_e : cs:C1710.HeBergeEntity
var $writePro_es : cs:C1710.DOCWPROSelection

$writePro_c:=New collection:C1472
$print1Document_b:=($2=1)

If (Count parameters:C259>=4)
	$writePro_c:=$4.copy()
End if 

If (Count parameters:C259=5)
	$contexte4D_b:=$5
End if 

If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
	$Ref_Structure_t:=Session:C1714.storage.intervenant.Ref_Structure
Else 
	$Ref_Structure_t:=Storage:C1525.societeDetail.Ref_Structure
End if 

$writePro_es:=ds:C1482.DOCWPRO.query("nom = :1 AND structureRef = :2"; $1; $Ref_Structure_t)
$writePro_es.refresh()

If ($writePro_es.length=1)
	$document_o:=WP New:C1317($writePro_es.first().fichier)
	outilsWProChargeData($1; ->$document_o; True:C214)
	WP SET DATA CONTEXT:C1786($document_o; wpVar_o)
	// On calcule les expressions 4D dans le document
	ST FREEZE EXPRESSIONS:C1282($document_o)
	
	For each ($writePro_t; $writePro_c)
		$writePro_es:=ds:C1482.DOCWPRO.query("nom = :1 AND structureRef = :2"; $writePro_t; $Ref_Structure_t)
		$documentB_o:=$writePro_es.first().fichier
		
		Case of 
			: ($writePro_t="Situation comptable")  // On demande à incorporer le situation comptable à un autre document
				
				If ($contexte4D_b=True:C214)
					outilsOrdaSearchSimple(->[HeBerge:4]; ->[HeBerge:4]HB_ReferenceID:1; [Factures:86]FAC_Origine_ID:37; ->$heberge_e; "first")
					
					// Génération de la liste des factures et règlements pour chaque hébergé
					liste_c:=$heberge_e.getSituationComptableList()
					
					// Génération du document PDF
					QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=$heberge_e.ID)
					SOC_Get_Config(1)
				End if 
				
		End case 
		
		outilsWProChargeData($writePro_t; ->$documentB_o; True:C214)
		
		WP INSERT BREAK:C1413($document_o; wk page break:K81:188; wk append:K81:179)
		WP INSERT DOCUMENT:C1411($document_o; $documentB_o; wk append:K81:179)
		
		// On calcule les expressions 4D dans le document
		ST FREEZE EXPRESSIONS:C1282($document_o)
	End for each 
	
	outilsWProImprimer($print1Document_b; "simple"; ""; $document_o; Null:C1517; $print1Document_b)
Else 
	ALERT:C41("Le document "+$1+" n'a pas pu être trouvé dans la base de donnée, merci de contacter le service informatique.")
End if 

outilsTableClearRecord(True:C214)