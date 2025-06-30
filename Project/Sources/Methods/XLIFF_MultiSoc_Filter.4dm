//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 12/10/2020, 17:04:48
// ----------------------------------------------------
// Method: XLIFF_MultiSoc_Filter
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($path)

$path:=Get 4D folder:C485(Dossier Resources courant:K5:16)
$path:=$path+"fr.lproj"+Séparateur dossier:K24:12

DOCUMENT LIST:C474($path; $tb_files)

For ($i; 1; Size of array:C274($tb_files))
	
	If (Length:C16($tb_files{$i})>12)
		TRACE:C157
		
		$string:=Replace string:C233($tb_files{$i}; "STR"; "")
		$string:=Replace string:C233($string; ".xlf"; "")
		
		$number:=(Num:C11($string)/100)-<>ID_Societe_Active
		
		$file_name:="STR"+String:C10($number)+".xlf"
		
		COPY DOCUMENT:C541($path+$tb_files{$i}; $path+$file_name; *)
		
	End if 
	
End for 

