//%attributes = {}
// Method FieldToObject returns a property and a value to insert into an object 
// 
// #SYNTAX: FieldToObject(Object;->Field) 
// #PARAMETERS:
//     $1 Object          : object
//     $2 Pointer         : Pointer to a field

// #DATE CREATION: 15/08/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_OBJECT:C1216($1; $O_Object)
$O_Object:=$1

C_POINTER:C301($2; $P_Field)
$P_Field:=$2

OB SET:C1220($O_Object; Lowercase:C14(Field name:C257($P_Field)); $P_Field->)

// EOM



