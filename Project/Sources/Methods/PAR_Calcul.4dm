//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 25/06/2020, 09:12:55
// ----------------------------------------------------
// Method: PAR_Calcul
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Variant  // Valeur du montant du mois X pour le montant Y
var $2 : Integer  // Numéro du mois

var $va_Libellé : Text
var $vl_Type; $vl_Position1; $vl_Position2; $mois_el; $i_el : Integer
var $variable_c : Collection

var montant1_r; montant2_r; montant3_r; montant4_r; montant5_r; montant6_r; montant7_r; \
montant8_r : Real
var ptrMontantT_p; ptrTaux_p; ptrMontantF_p : Pointer

$vl_Type:=Value type:C1509($1)
$mois_el:=$2

If ($vl_Type=Est un pointeur:K8:14)
	$vl_Type:=Value type:C1509($1->)
End if 

If ($vl_Type=Est un champ alpha:K8:1) | ($vl_Type=Est un texte:K8:3) | ($vl_Type=Est un numérique:K8:4)
	
	If (Value type:C1509($1)=Est un pointeur:K8:14)
		$va_Libellé:=String:C10($1->)
	Else 
		$va_Libellé:=String:C10($1)
	End if 
	
End if 

If ($va_Libellé>"")
	
	// Modifié par : Scanu Rémy (07/04/2023)
	// En mode compilé, on ne peut pas utiliser des variables locales avec la commande EXÉCUTER FORMULE
	$variable_c:=New collection:C1472
	
	For ($i_el; 1; 8)
		$variable_c.push(New object:C1471(\
			"name"; "montant"+String:C10($i_el)+"_r"; "value"; "Num(Form.participation["+String:C10($mois_el-1)+"].PAR_Montant_"+String:C10($i_el)+")"))
	End for 
	
	outilsVariableAffectValueByProg($variable_c)
	
	$vl_Position1:=Position:C15("("; $va_Libellé)
	$vl_Position2:=Position:C15(")"; $va_Libellé)
	
	If ($vl_Position1>0) & ($vl_Position2>0) & ($vl_Position2>$vl_Position1)
		Form:C1466.participation[$mois_el-1].PAR_Taux:=Num:C11(Substring:C12($va_Libellé; $vl_Position1+1; $vl_Position2-$vl_Position1-1))
	End if 
	
	Form:C1466.participation[$mois_el-1].PAR_Montant_Total:=Round:C94(montant1_r+montant2_r+montant3_r+montant4_r+montant5_r+montant6_r+montant7_r+montant8_r; 2)
	Form:C1466.participation[$mois_el-1].PAR_Montant_Participation:=Round:C94(Form:C1466.participation[$mois_el-1].PAR_Montant_Total*Form:C1466.participation[$mois_el-1].PAR_Taux/100; 2)
End if 