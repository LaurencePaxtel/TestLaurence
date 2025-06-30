//%attributes = {}
// Method 4DREC_Record_to_Object places the current record into a object 
// 
// #SYNTAX: $O_Record:=4DREC_Record_to_Object(->Table) 
// #PARAMETERS:
//     $0 Object          : Record pushed into an object
//     $1 Pointer         : Pointer on a table

// #DATE CREATION: 15/08/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_OBJECT:C1216($0; $O_Output)
C_POINTER:C301($1; $P_Table)
$P_Table:=$1

$O_Output:=JSON Parse:C1218("{}")  // starting from 16R3 use Create object

C_LONGINT:C283($L_Table)
$L_Table:=Table:C252($P_Table)

C_LONGINT:C283($i)
For ($i; 1; Get last field number:C255($L_Table))
	
	If (Is field number valid:C1000($L_Table; $i))
		
		C_POINTER:C301($P_Field)
		$P_Field:=Field:C253($L_Table; $i)
		
		C_LONGINT:C283($L_Type)
		$L_Type:=Type:C295($P_Field->)
		Case of 
			: ($L_Type=Est un BLOB:K8:12)
				// rien
			: ($L_Type=Est une image:K8:10)
				// à partir de 16R4
			Else 
				C_TEXT:C284($T_Property)
				$T_Property:=FieldName_to_property($P_Field)
				
				OB SET:C1220($O_Output; $T_Property; $P_Field->)
		End case 
	End if 
End for 

$0:=$O_Output

// EOM

