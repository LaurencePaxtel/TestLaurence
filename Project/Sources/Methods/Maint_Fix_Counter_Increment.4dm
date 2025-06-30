//%attributes = {}
// ----------------------------------------------------
// Développeur(OS) : Kevin HASSAL
// Date et heure : 30/08/18, 05:55:31
// ----------------------------------------------------
// Méthode : Maint_Fix_Counter_Increment
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Pointer

var $id_max; $check_id : Integer
var $table : Pointer

var champRef_p : Pointer

$table:=$1
EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]ID")

ALL RECORDS:C47($table->)

ORDER BY:C49($table->; champRef_p->; >)
LAST RECORD:C200($table->)

$id_max:=champRef_p->
$check_id:=Get database parameter:C643($table->; Numéro automatique table:K37:31)

SET DATABASE PARAMETER:C642($table->; Numéro automatique table:K37:31; $id_max)