//%attributes = {}

$nombre_table:=Get last table number:C254

For ($i; 1; $nombre_table)
	If ($i#5)
		export_table($i)
	End if 
End for 