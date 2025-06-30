//%attributes = {}
/*------------------------------------------------------------------------------
Methode projet : storageEnumerationInit

Chargement du storage et Session.storage depuis un tableau d'énumérations.

$1 : nom de l'énumération
$2 : pointeur de tableau avec la liste des enumérations
$3 : la valeur sélectionné.

Historique
17/10/23 gregory@connect-io.fr - Création
------------------------------------------------------------------------------*/

#DECLARE($nom_t : Text; $liste_p : Pointer)
var $enumeration_es : cs:C1710.TypesTablesSelection
var $enumeration_e : cs:C1710.TypesTablesEntity
var $lesRubriques_es : cs:C1710.LesRubriquesSelection
var $libelle_t : Text
var $enumeration_o : Object

// Recherche du libellé du champ
var $structure_t : Text
If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
	$structure_t:=Session:C1714.storage.intervenant.Ref_Structure
Else 
	$structure_t:=Storage:C1525.societeDetail.Ref_Structure
End if 


$enumeration_o:={}
$enumeration_o.nom:=$nom_t
$enumeration_o.item:=New shared collection:C1527()
ARRAY TO COLLECTION:C1563($enumeration_o.item; $liste_p->)

// On recherche notre enumération.
$enumeration_es:=ds:C1482.TypesTables.query("TT_Libellé = :1 AND HG_Champ_ID # 0"; $nom_t)

If ($enumeration_es.length=1)
	$enumeration_e:=$enumeration_es.first()
	
	// On récupére les informations de la rubriques (libellé,...)
	$lesRubriques_es:=$enumeration_e.lesRubriquess.query("Ref_Structure = :1 AND RubNoSTR = 30108"; $structure_t)
	
	//$lesRubriques_es:=ds.LesRubriques.query("Ref_Structure = :1 AND RubNom = :2 AND RubNoSTR = 30108"; $structure_t; $nom_t)
	If ($lesRubriques_es.length#0)
		$libelle_t:=$lesRubriques_es.first().RubNomNew
	End if 
	
	
	
	$enumeration_o.champNumero:=$enumeration_e.HG_Champ_ID
	$enumeration_o.champNom:=Field name:C257(Table:C252(->[HeberGement:5]); $enumeration_e.HG_Champ_ID)
	$enumeration_o.libelle:=$libelle_t
Else 
	$enumeration_o.libelle:=$nom_t
End if 

If (Session:C1714.storage#Null:C1517)
	// Gestion du storage de la session web
	Use (Session:C1714.storage.enumeration)
		Session:C1714.storage.enumeration.push(OB Copy:C1225($enumeration_o; ck shared:K85:29; Session:C1714.storage.enumeration))
	End use 
Else 
	
	If (Storage:C1525.enumeration=Null:C1517)
		Use (Storage:C1525)
			Storage:C1525.enumeration:=New shared collection:C1527()
		End use 
	End if 
	
	Use (Storage:C1525.enumeration)
		Storage:C1525.enumeration.push(OB Copy:C1225($enumeration_o; ck shared:K85:29; Storage:C1525.enumeration))
	End use 
End if 