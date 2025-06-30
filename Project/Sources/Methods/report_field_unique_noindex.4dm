//%attributes = {}
// Method report_field_unique_noindex  
// 
// 
// #SYNTAX: $L_Erreur:=report_field_unique_noindex(param_1;->param_N) 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : 
//     $2 Pointer         : 
//     $3 Date            : 
//     $4 Time            : 
//     $5 BLOB            : 
//     $6 Picture         : 
//     $7 Object          :
//     $8 real            :
//     $9 Boolean         :

// #DATE CREATION: 14/05/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_LONGINT:C283($maxTableNumber_l; $currentTable_l)
C_LONGINT:C283($maxFieldCount_l; $currentField_l)
C_LONGINT:C283($dontCare_l)  // For GET FIELD PROPERTIES values that are not used.
C_BOOLEAN:C305($dontCare_f; $isIndexed_f; $isUnique_f)
C_TEXT:C284($logHeader_t; $logRecord_t; $logfile_t)
C_TEXT:C284($delim_t; $lf_t)
C_TIME:C306($logfile_h)
C_TEXT:C284($tableName_t; $fieldName_t)

$delim_t:=Char:C90(Tabulation:K15:37)
$lf_t:=Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40)

$logHeader_t:="Unique fields without index:"+$lf_t

$logfile_t:=Get 4D folder:C485(Dossier Logs:K5:19)+"UniqueNotIndexed.txt"

$logfile_h:=Create document:C266($logfile_t)

If (OK=1)
	USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
	
	SEND PACKET:C103($logfile_h; $logHeader_t)
	
	$maxTableNumber_l:=Get last table number:C254
	
	For ($currentTable_l; 1; $maxTableNumber_l)
		If (Is table number valid:C999($currentTable_l))
			$maxFieldCount_l:=Get last field number:C255(Table:C252($currentTable_l))
			For ($currentField_l; 1; $maxFieldCount_l)
				If (Is field number valid:C1000($currentTable_l; $currentField_l))
					
					// Note the following line breaks over two lines in text,
					// it is one statement in the method:
					GET FIELD PROPERTIES:C258($currentTable_l; $currentField_l; $dontCare_l; $dontCare_l; $isIndexed_f; $isUnique_f; $dontCare_f)
					
					If (($isUnique_f) & (Not:C34($isIndexed_f)))
						
						$tableName_t:=Table name:C256(Table:C252($currentTable_l))
						$fieldName_t:=Field name:C257(Field:C253($currentTable_l; $currentField_l))
						
						
						$logRecord_t:="["+$tableName_t+"]"+$fieldName_t+$lf_t
						
						SEND PACKET:C103($logfile_h; $logRecord_t)
						
					End if 
				End if 
			End for 
		End if 
	End for 
	USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
	CLOSE DOCUMENT:C267($logfile_h)
	SHOW ON DISK:C922($logfile_t)
End if 


BEEP:C151

