//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : remyscanu
// Date et heure : 10/03/23, 15:38:36
// ----------------------------------------------------
// Méthode : Dupliquer_champ_new_value
// Description
// 
//
// Paramètres
// $1 Pointer : le tableau de préférences
// $2 Pointer : le champ à dupliquer
// $3 Pointer : la variable intermédiaire
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_TEXT:C284($T_field; $T_Name)
C_LONGINT:C283($i)
C_BOOLEAN:C305($B_Duplique)
C_POINTER:C301($P_Array; $P_Field; $P_Output)

ARRAY OBJECT:C1221($rO_Duplique; 0)

$P_Array:=$1
$P_Field:=$2
$P_Output:=$3

COPY ARRAY:C226($P_Array->; $rO_Duplique)
$T_Name:=Field name:C257($P_Field)

Repeat 
	$i:=$i+1
	
	$B_Duplique:=$rO_Duplique{$i}.checked
	$T_field:=$rO_Duplique{$i}.field
Until ($T_field=$T_Name)

If ($B_Duplique)
	
	Case of 
		: (Type:C295($P_Output->)=Est un entier long:K8:6) & (Type:C295($P_Field->)=Est un booléen:K8:9)
			$P_Output->:=Num:C11($P_Field->)
		Else 
			$P_Output->:=$P_Field->
	End case 
	
Else 
	CLEAR VARIABLE:C89($P_Output->)
End if 