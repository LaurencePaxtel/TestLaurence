//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/11/18, 14:07:33
// ----------------------------------------------------
// Méthode : Web_AGL_Json_To_Record
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Pointer
var $2 : Pointer
var $3 : Pointer

var $champ_name; $json_data_text; $value : Text
var $i; $table_number; $pos : Integer
var $B_16R4; $continue; $update : Boolean
var $table; $json_data; $tb_restricted : Pointer
var $property_c : Collection

var champRef_p : Pointer

$table:=$1
$json_data:=$2
$tb_restricted:=$3
$continue:=True:C214
$json_data_text:=JSON Stringify:C1217($json_data->)

ASSERT:C1129(Is table number valid:C999(Table:C252($table)); "la table n'existe pas")

$B_16R4:=(Num:C11(Application version:C493)>=1640)
$table_number:=Table:C252($table)

For ($i; 1; Get last field number:C255($table))
	$continue:=True:C214
	
	If (Is field number valid:C1000($table_number; $i))
		
		Case of 
			: (Type:C295((Field:C253($table_number; $i))->)=Est une image:K8:10) & ($B_16R4=False:C215)
				$champ_name:=FieldName_to_property(Field:C253($table_number; $i))
			: (Type:C295((Field:C253($table_number; $i))->)=Est un BLOB:K8:12)
				$champ_name:=FieldName_to_property(Field:C253($table_number; $i))
			Else 
				$champ_name:=FieldName_to_property(Field:C253($table_number; $i))
		End case 
		
		$pos:=Find in array:C230($tb_restricted->; $champ_name)
		
		If ($pos>=0)
			CLEAR VARIABLE:C89($continue)
		End if 
		
		If ($continue)
			// Modifié par : Scanu Rémy (28/07/2022)
			// Amélioration du process, car il était trop permissif, si 2 champs contenaient la même chose, exemple lc_type_gestion et lc_type, s'il n'y avait que lc_type_gestion de soumis dans le formulaire, lc_type était aussi pris en compte
			//$pos:=Position($champ_name; $json_data_text)
			$property_c:=OB Keys:C1719($json_data->)
			
			If ($property_c.indexOf($champ_name)#-1)
				EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]"+$champ_name)
				
				$update:=True:C214
				$value:=OB Get:C1224($json_data->; $champ_name; Est un texte:K8:3)
				
				Case of 
					: (Type:C295((Field:C253($table_number; $i))->)=Est un entier long:K8:6)
						champRef_p->:=Num:C11($value)
					: (Type:C295((Field:C253($table_number; $i))->)=Est un numérique:K8:4)
						$value:=Replace string:C233($value; "."; ",")
						champRef_p->:=Num:C11($value)
					: (Type:C295((Field:C253($table_number; $i))->)=_o_Est un float:K8:26)
						$value:=Replace string:C233($value; "."; ",")
						champRef_p->:=Num:C11($value)
					: (Type:C295((Field:C253($table_number; $i))->)=Est un entier:K8:5)
						champRef_p->:=Num:C11($value)
					: (Type:C295((Field:C253($table_number; $i))->)=Est un entier 64 bits:K8:25)
						champRef_p->:=Num:C11($value)
					: (Type:C295((Field:C253($table_number; $i))->)=Est un booléen:K8:9)
						
						If (($value="Vrai") | ($value="True"))
							champRef_p->:=True:C214
						Else 
							champRef_p->:=False:C215
						End if 
						
					: (Type:C295((Field:C253($table_number; $i))->)=Est une date:K8:7)
						
						If ($value#"00/00/00") & (Date:C102($value)=!00-00-00!)
							$value:=Substring:C12($value; 7; 4)+"/"+Substring:C12($value; 4; 2)+"/"+Substring:C12($value; 1; 2)
						End if 
						
						champRef_p->:=Date:C102($value)
					: (Type:C295((Field:C253($table_number; $i))->)=Est une heure:K8:8)
						champRef_p->:=Time:C179($value)
					: (Type:C295((Field:C253($table_number; $i))->)=Est un BLOB:K8:12)
					Else 
						champRef_p->:=$value
				End case 
				
			End if 
			
		End if 
		
	End if 
	
End for 