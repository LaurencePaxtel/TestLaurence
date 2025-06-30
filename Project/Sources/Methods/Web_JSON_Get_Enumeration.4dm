//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : kevin HASSAL
// Date et heure : 10/11/18, 17:25:54
// ----------------------------------------------------
// Méthode : Web_JSON_Get_Enumeration
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)

C_TEXT:C284($nom_enum; $titre)
C_LONGINT:C283($i; $index_el)
C_COLLECTION:C1488($values_c)

ARRAY TEXT:C222($tb_values; 0)

$nom_enum:=$1
$titre:=$2

Web_Champs_Ecran_Saisie(30108; $2)

If (WEB_CHAMP_Titre#"")
	$titre:=WEB_CHAMP_Titre
End if 

$values_c:=UTL_Web_Get_Enumeration_Values($nom_enum)
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_values)
End if 

//===============================================//
// User Plateforme
//===============================================//
$i:=Size of array:C274($tb_values)

// Modifié par : Scanu Rémy (14/02/2023)
If ($i>0)
	
	Repeat 
		
		If ($tb_values{$i}#(Substring:C12(va_UserPlateforme; 1; 4)+"@"))
			//SUPPRIMER DANS TABLEAU($tb_values; $i; 1)
		End if 
		
		$i:=$i-1
	Until ($i<1)
	
End if 

If (Count parameters:C259=3)
	$values_c:=New collection:C1472
	
	ARRAY TO COLLECTION:C1563($values_c; $tb_values)
	$values_c:=$values_c.map("outilsCollectionValueByPlatform"; New collection:C1472(Substring:C12(va_UserPlateforme; 1; 4)))
	
	$values_c:=$values_c.distinct()
	$index_el:=$values_c.indexOf("valueToDelete")
	
	If ($index_el>=0)
		$values_c.remove($index_el)
	End if 
	
	COLLECTION TO ARRAY:C1562($values_c; $tb_values)
End if 

//===============================================//
// Construction de l'objet JSON
//===============================================//
SORT ARRAY:C229($tb_values; >)

$size:=Size of array:C274($tb_values)
ARRAY OBJECT:C1221($tb_intervenant; $size)

For ($i; 1; $size)
	OB SET:C1220($tb_intervenant{$i}; "id"; Generate UUID:C1066)
	OB SET:C1220($tb_intervenant{$i}; "value"; $tb_values{$i})
End for 

$object:=New object:C1471("title"; $titre; "type"; "radio"; "value"; $titre)
OB SET ARRAY:C1227($object; "list"; $tb_intervenant)

$JSON:=JSON Stringify:C1217($object)
WEB SEND TEXT:C677($JSON)