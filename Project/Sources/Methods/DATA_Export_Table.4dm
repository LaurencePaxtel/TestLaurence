//%attributes = {}
//{==================================================}
//{          Méthode : DATA_Export_Table
//{          Mardi 29/11/2019 à 12:40
//{          Modifiée :
//{          Développeur : Kevin HASSAL
//{==================================================}

//C_TIME($1)
//C_POINTER($2)
//C_LONGINT($ii;$long;$index)
//C_TEXT($data)
//C_BOOLEAN($index;$unique;$invis)

//For ($ii;1;Get last field number($2))


//GET FIELD PROPERTIES(Table($2);$ii;$type;$long;$index;$unique;$invis)
//$OK:=Vrai

//Case of 
//: ($type=Is alpha field)
//$data:=Field(Table($2);$ii)->
//: ($type=Is text)
//$data:=Field(Table($2);$ii)->
//$data:=Replace string($data;"?";"-")
//$data:=Replace string($data;Char(13);"?")
//: ($type=Is float)
//$data:=String(Field(Table($2);$ii)->)
//: ($type=Is integer)
//$data:=String(Field(Table($2);$ii)->)
//: ($type=Is longint)
//$data:=String(Field(Table($2);$ii)->)
//: ($type=Is date)
//$data:=String(Field(Table($2);$ii)->;Blank if null date)
//: ($type=Is time)
//$data:=String(Field(Table($2);$ii)->;HH MM SS)
//: ($type=Is boolean)
//$data:=("O"*Num(Field(Table($2);$ii)->))
//$data:=$data+("N"*Num(Field(Table($2);$ii)->=False))
//: ($type=Is picture)
//$data:=""
//: ($type=Is subtable)
//$data:=""
//: ($type=Is BLOB)
//$data:=""
//Else 
//  ///SET CHANNEL(
//End case 


//If ($ii=1)
//SEND PACKET($1;$data)
//Else 
//SEND PACKET($1;";"+$data)
//End if 


//End for 

//SEND PACKET($1;Char(13))
