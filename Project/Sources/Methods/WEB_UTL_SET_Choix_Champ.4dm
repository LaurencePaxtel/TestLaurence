//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 14-12-18, 17:37:29
// ----------------------------------------------------
// Method: WEB_UTL_SET_Choix_Champ
// Description
// 
// 
// Exemples : 
// 
// WEB_UTL_SET_CHOIX_CHAMP (->[Pays];->[Pays]PAY_Pays;"1";vrai)
// WEB_UTL_SET_CHOIX_CHAMP (->[Pays];->[Pays]PAY_Pays;"1|3|10";vrai)
// WEB_UTL_SET_CHOIX_CHAMP (->[Pays];->[Pays]PAY_Pays;"Canada")
// WEB_UTL_SET_CHOIX_CHAMP (->[Pays];->[Pays]PAY_Pays;"Canada|France")
// 
// WEB_UTL_SET_CHOIX_CHAMP (->[Pays];->[Pays]PAY_Pays;"NUM|UID";"2")
// Paramètres
// @POINTEUR la table
// @POINTEUR le champ de recherche
// @TEXTE le choix ... si multiple on utlise le supparateur |
// @BOOL  indéfini:choix par valeur, vrai:choix par clé , faux:remplacer les clés par les valeurs

// ----------------------------------------------------
var $0 : Text
var $1 : Pointer
var $2 : Pointer
var $3 : Text
var $4 : Text
var $5 : Text
var $6 : Text

var $keyDef; $choixSer; $html : Text
var $found; $key : Integer
var $table; $champAffich : Pointer

var champRef_p : Pointer

ARRAY TEXT:C222($TB_labels; 0)
ARRAY TEXT:C222($TB_valeurs; 0)
ARRAY TEXT:C222($TB_choix; 0)

ARRAY LONGINT:C221($TBEL_valeurs; 0)

$table:=$1
$champAffich:=$2
$keyDef:=$3
$choixSer:=$4

If ($choixSer="")
	$choixSer:="-1"
End if 

Case of 
	: ($keyDef="")
		$key:=2
	: ($keyDef="NUM")
		$key:=1
	: ($keyDef="UID")
		$key:=1
End case 

$nameTable:=Table name:C256($table)
EXECUTE FORMULA:C63("champRef_p:=->["+$nameTable+"]ID")

If (Count parameters:C259=5)
	USE NAMED SELECTION:C332($5)
	CLEAR NAMED SELECTION:C333($5)
	
	FIRST RECORD:C50($table->)
Else 
	ORDER BY:C49($table->; $champAffich->; >)
End if 

If ($keyDef="")
	DISTINCT VALUES:C339($champAffich->; $TB_labels)
	DISTINCT VALUES:C339($champAffich->; $TB_valeurs)
Else 
	SELECTION TO ARRAY:C260($champAffich->; $TB_labels)
	
/*
Si (Type valeur(champRef_p->)=Est un entier long)
SÉLECTION VERS TABLEAU(champRef_p->; $TBEL_valeurs)
	
Boucle ($i; 1; Taille tableau($TBEL_valeurs))
AJOUTER À TABLEAU($TBEL_valeurs; Chaîne($TBEL_valeurs))
Fin de boucle 
	
Sinon 
SÉLECTION VERS TABLEAU(champRef_p->; $TBEL_valeurs)
Fin de si 
*/
	SELECTION TO ARRAY:C260(champRef_p->; $TBEL_valeurs)
	
End if 

SORT ARRAY:C229($TB_labels; $TB_valeurs; >)
UTL_Decoupe_texte(->$choixSer; ->$TB_choix; "|")

For ($i; 1; Size of array:C274($TB_valeurs))
	$html:=$html+String:C10($TB_valeurs{$i})
	
	If ($key=2)
		$html:=$html+"_"+String:C10($TB_valeurs{$i})
		$found:=Find in array:C230($TB_choix; String:C10($TB_labels{$i}))
	Else 
		$html:=$html+"_"+String:C10($TB_labels{$i})
		$found:=Find in array:C230($TB_choix; String:C10($TB_valeurs{$i}))
	End if 
	
	If ($found#-1)
		$html:=$html+"_s"
	End if 
	
	If ($i<Size of array:C274($TB_valeurs))
		$html:=$html+"|"
	End if 
	
End for 

If (Count parameters:C259=6)
	$0:=$6+"|"+$html
Else 
	$0:=$html
End if 