//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 15/03/20, 08:52:04
// ----------------------------------------------------
// Method: MAIL_CSS
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($CSS; $char)

$char:=Char:C90(13)

$CSS:="<style type='text/css'>"+$char

$CSS:=$CSS+"body{"+$char
$CSS:=$CSS+"text-align: left;"+$char
$CSS:=$CSS+"font-family: Segoe UI;"+$char
$CSS:=$CSS+"font-size: 12;"+$char
$CSS:=$CSS+"background-color: #FFFFFF;"+$char
$CSS:=$CSS+"font-weight:normal;"+$char
$CSS:=$CSS+"font-color:#000000;"+$char
$CSS:=$CSS+"}"+$char

$CSS:=$CSS+"table.mail{"+$char
$CSS:=$CSS+"font: 0.8em Arial, Helvetica, sans-serif;"+$char
$CSS:=$CSS+"border-collapse:collapse;"+$char
$CSS:=$CSS+"background:#e8eef7;"+$char
$CSS:=$CSS+"color:#000;margin-left:20px;"+$char
$CSS:=$CSS+"}"+$char

$CSS:=$CSS+"table.mail caption{"+$char
$CSS:=$CSS+"height:102px;"+$char
$CSS:=$CSS+"font-size:000000.1em;"+$char
$CSS:=$CSS+"color:#c6dbff;"+$char
$CSS:=$CSS+"}"+$char

$CSS:=$CSS+".entete_lignes{"+$char
$CSS:=$CSS+"background-color:#000;"+$char
$CSS:=$CSS+"border-color:#fff #fff #435577 #fff;"+$char
$CSS:=$CSS+"border-style: solid;"+$char
$CSS:=$CSS+"border-width: 1px 1px 2px 1px;"+$char
$CSS:=$CSS+"padding: 4px 7px 4px 7px;"+$char
$CSS:=$CSS+"color:#fff;"+$char
$CSS:=$CSS+"font-size:20px;"+$char
$CSS:=$CSS+"}"+$char

$CSS:=$CSS+"table thead tr th{"+$char
$CSS:=$CSS+"background-color:#000;"+$char
$CSS:=$CSS+"border-color:#fff #fff #435577 #fff;"+$char
$CSS:=$CSS+"border-style: solid;"+$char
$CSS:=$CSS+"border-width: 1px 1px 2px 1px;"+$char
$CSS:=$CSS+"padding: 4px 7px 4px 7px;"+$char
$CSS:=$CSS+"color:#fff;"+$char
$CSS:=$CSS+"font-size:20px;"+$char
$CSS:=$CSS+"}"+$char

$CSS:=$CSS+"tbody tr td{"+$char
$CSS:=$CSS+"height:1.7em;"+$char
$CSS:=$CSS+"vertical-align:top;"+$char
$CSS:=$CSS+"padding-left:10px;"+$char
$CSS:=$CSS+"}"+$char

$CSS:=$CSS+"tfoot th, tfoot td{"+$char
$CSS:=$CSS+"height:105px;"+$char
$CSS:=$CSS+"font-weight:bold;"+$char
$CSS:=$CSS+"height:2.0em;"+$char
$CSS:=$CSS+"padding-left:10px;"+$char
$CSS:=$CSS+"vertical-align: top;"+$char
$CSS:=$CSS+"}"+$char

$CSS:=$CSS+"tfoot th{"+$char
$CSS:=$CSS+"height:102px;"+$char
$CSS:=$CSS+"}"+$char

$CSS:=$CSS+"tfoot td{"+$char
$CSS:=$CSS+"height:102px;;"+$char
$CSS:=$CSS+"}"+$char

//*******************//

$CSS:=$CSS+"</style>"+$char+$char

$0:=$CSS