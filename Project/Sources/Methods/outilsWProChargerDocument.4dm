//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 16/11/21, 17:48:20
// ----------------------------------------------------
// Méthode : outilsWProChargerDocument
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)
C_BOOLEAN:C305($2)
C_POINTER:C301($3)
C_TEXT:C284($4)

C_OBJECT:C1216($table_o; $autreTable_o; $enregistrement_o)

ARRAY TEXT:C222($tag_at; 0)

$table_o:=ds:C1482.DOCWPRO.newSelection()

If ($3->=Null:C1517)
	$3->:=New object:C1471
End if 

Case of 
	: ($1="initBibliothequeNumerique")
		outilsOrdaSearchSimple("DOCWPRO"; "structureRef"; <>ref_soc_active; ->$table_o)
	: ($1="rechercheDossierBibliothequeNumerique")
		$3->selectionDocument:=False:C215
		
		$autreTable_o:=ds:C1482.DOCWPRO.query("tag = :1 AND structureRef = :2"; "@"+$4+"@"; <>ref_soc_active)
	: ($1="recherche")
		$table_o:=ds:C1482.DOCWPRO.query("nom = :1 AND structureRef = :2"; "@"+$4+"@"; <>ref_soc_active)
	Else 
		outilsOrdaSearchSimple("DOCWPRO"; "structureRef"; <>ref_soc_active; ->$table_o)
End case 

If ($1="rechercheDossierBibliothequeNumerique")
	
	For each ($enregistrement_o; $autreTable_o)
		JSON PARSE ARRAY:C1219($enregistrement_o.tag; $tag_at)
		
		If (Find in array:C230($tag_at; $4)#-1)
			$table_o.add($enregistrement_o)
		End if 
		
	End for each 
	
End if 

If ($1="initBibliothequeNumerique")
	$3->DOCWPRO:=$table_o
Else 
	$3->DOCWPRO:=$table_o.toCollection("nom").orderBy("nom asc")
End if 