//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : remyscanu
// Date et heure : 04/03/24, 14:46:20
// ----------------------------------------------------
// Méthode : REST_variable_extraire
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Boolean
var $1 : Pointer
var $2 : Pointer
var $3 : Pointer
var $4 : Text

var $vt_nomVar; $vt_val : Text
var $vl_type : Integer
var $vb_Point_Decimal : Boolean

$vt_nomVar:=$4

If (Find in array:C230($1->; $vt_nomVar)>0)
	$vt_val:=$2->{Find in array:C230($1->; $vt_nomVar)}
	$0:=True:C214
End if 

$vb_Point_Decimal:=((11/10)=Num:C11("1.1"))
$vl_type:=Type:C295($3->)

Case of 
	: ($vl_type=Est un numérique:K8:4) | ($vl_type=Est un entier:K8:5) | ($vl_type=Est un entier long:K8:6)
		
		If (Not:C34($vb_Point_Decimal))
			$vt_val:=Replace string:C233($vt_val; "."; ",")
		End if 
		
		$3->:=Num:C11($vt_val)
	Else 
		$3->:=$vt_val
End case 