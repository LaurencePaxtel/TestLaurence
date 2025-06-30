//%attributes = {}
// ----------------------------------------------------
// Développeur (OS) : Kevin HASSAL
// Date et heure : 31/08/18, 03:13:01
// ----------------------------------------------------
// Méthode : 0_export_table
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_POINTER:C301($table; $1)
C_TEXT:C284($send)
C_LONGINT:C283($i)

$table:=$1

USE CHARACTER SET:C205("windows-1252"; 0)

$cr:=Char:C90(Retour chariot:K15:38)
$sep:=";"
$ref_doc:=Create document:C266(""; "csv")
$send:="Nom"+$cr
$i:=0



UTL_Fenetre(500; 250; 0; "Export encours...")

For ($i; 1; Size of array:C274($table->))
	
	GOTO XY:C161(2; 2)
	MESSAGE:C88(String:C10($i)+"/"+String:C10(Size of array:C274($table->))+" - "+$table->{$i})
	
	$send:=$send+$table->{$i}+$cr
	
End for 


CLOSE WINDOW:C154



SEND PACKET:C103($ref_doc; $send)

CLOSE DOCUMENT:C267($ref_doc)

$excel:=UTL_trouve_excel
$excel:=$excel+" \""+document+"\""
SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "false")
LAUNCH EXTERNAL PROCESS:C811($excel)