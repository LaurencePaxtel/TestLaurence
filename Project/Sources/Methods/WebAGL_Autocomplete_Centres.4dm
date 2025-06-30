//%attributes = {}
//  // ----------------------------------------------------
//  // User name (OS): Kevin HASSAL
//  // Date and time: 26-12-18, 18:23:08
//  // ----------------------------------------------------
//  // Method: WebAGL_Autocomplete_Centres
//  // Description
//  // 
//  //
//  // Parameters
//  // ----------------------------------------------------

//  // ----------------------------------------------------
//  // User name (OS): Kevin HASSAL
//  // Date and time: 18-12-18, 08:50:32
//  // ----------------------------------------------------
//  // Method: WebAGL_Autocomplete_Data
//  // Description
//  // 
//  //
//  // Parameters
//  // ----------------------------------------------------

//C_POINTER($table;$1;$field_id;$2;$field_value;$3;$field_value_second;$field_id_origin)
//C_TEXT($T_JSON;$T_Message;$Status;$request_term_1;$request_term_2)
//C_OBJECT($O_Output;$O_Data)
//C_BOOLEAN($continu)
//C_LONGINT($id;$size;$i;$id_origin)

//$table:=$1
//$field_id:=$2
//$field_value:=$3
//$field_value_second:=Null
//$field_id_origin:=Null

//If (Count parameters>3)
//C_POINTER($4)
//$field_value_second:=$4
//End if 

//If (Count parameters>4)
//C_POINTER($5)
//$field_id_origin:=$5
//End if 

//$O_Output:=New object
//$continu:=True

//$O_Data:=Web_AGL_Get_Post_Json_Data 

//$request_term_1:=OB Get($O_Data;"data_first";Is text)

//$request_term_2:=OB Get($O_Data;"data_second";Is text)

//$id_origin:=Num(OB Get($O_Data;"id";Is text))

//READ ONLY($table->)

//SET QUERY LIMIT(10)

//If ($request_term_1#"")

//QUERY($table->;$field_value->="@"+$request_term_1+"@";*)

//If ($field_value_second#Null)
//QUERY($table->; & ;$field_value_second->="@"+$request_term_2+"@";*)
//End if 

//QUERY($table->)

//Else 
//QUERY($table->;$field_value->#"")
//End if 

//If ($field_id_origin#Null)
//QUERY SELECTION($table->;$field_id_origin->=$id_origin)
//End if 

//MultiSoc_Filter ($table)

//  //ORDER BY($field_value->;>)

//SET QUERY LIMIT(10)

//$size:=Records in selection($table->)

//ARRAY OBJECT($tb_result;$size)

//ARRAY LONGINT($tb_id;0)
//ARRAY TEXT($tb_value;0)
//ARRAY TEXT($tb_value_second;0)
//ARRAY TEXT($tb_adresse;0)

//READ ONLY([Adresses])

//If ($field_value_second=Null)

//SELECTION TO ARRAY($field_id->;$tb_id;$field_value->;$tb_value)

//For ($i;1;$size)
//OB SET($tb_result{$i};"id";$tb_id{$i};"value";$tb_value{$i})
//APPEND TO ARRAY($tb_adresse;UTL_Get_Adresse
//End for 

//Else 

//SELECTION TO ARRAY($field_id->;$tb_id;$field_value->;$tb_value;$field_value_second->;$tb_value_second)

//For ($i;1;$size)
//OB SET($tb_result{$i};"id";$tb_id{$i};"value";$tb_value{$i}+" "+$tb_value_second{$i})
//End for 

//End if 

//$JSON:=JSON Stringify array($tb_result)

//WEB SEND TEXT($JSON)