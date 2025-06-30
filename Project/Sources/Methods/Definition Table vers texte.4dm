//%attributes = {}
// Method Definition Table vers texte exporte sur le bureau les tables et les champs de l'application 
// Fichier 1 : [STRUCTURE]Liste des tables.txt
// Fichier 2 : [STRUCTURE]Liste des tables et des champs.txt

// #SYNTAX: Definition Table vers texte 
// #PARAMETERS:
//     None 

// #DATE CREATION: 17/07/2015  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:
// Une erreur est générée si la table n'a pas de table
// #HEADER VERSION: 2


C_LONGINT:C283($L_Count_table)
$L_Count_table:=0

C_LONGINT:C283($i)
For ($i; 1; Get last table number:C254)
	If (Is table number valid:C999($i))
		$L_Count_table:=$L_Count_table+1
	End if 
End for 

ASSERT:C1129($L_Count_table>0; "Pas de table")

For ($i; 1; 2)
	
	C_TEXT:C284($T_Table)
	CLEAR VARIABLE:C89($T_Table)
	
	C_TEXT:C284($T_Titel)
	C_LONGINT:C283($L_Table; $L_Field)
	If ($i=1)
		
		For ($L_Table; 1; $L_Count_table)
			
			If (Is table number valid:C999($L_Table))
				$T_Table:=$T_Table+"["+Table name:C256($L_Table)+"]"+"\r"
			End if 
		End for 
		
		$T_Titel:="Liste des tables.txt"
	Else 
		
		
		For ($L_Table; 1; $L_Count_table)
			
			If (Is table number valid:C999($L_Table))
				$T_Table:=$T_Table+"["+Table name:C256($L_Table)+"]"+"\r"
				
				C_LONGINT:C283($L_Count_field)
				$L_Count_field:=Get last field number:C255($L_Table)
				
				For ($L_Field; 1; $L_Count_field)
					
					If (Is field number valid:C1000($L_Table; $L_Field))
						
						$T_Table:=$T_Table+"     ["+Table name:C256($L_Table)+"]"+Field name:C257($L_Table; $L_Field)+"\r"
						
					End if 
				End for 
			End if 
		End for 
		
		$T_Titel:="Liste des tables et des champs.txt"
	End if 
	
	C_TEXT:C284($T_DB_Name)
	$T_DB_Name:=Replace string:C233(Structure file:C489(*); Get 4D folder:C485(Dossier base:K5:14; *); "")
	
	C_TEXT:C284($T_Path)
	$T_Path:=System folder:C487(Bureau:K41:16)+"["+$T_DB_Name+"]"+$T_Titel
	
	C_TIME:C306($H_Doc)
	$H_Doc:=Create document:C266($T_Path)
	If (OK=1)
		
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		SEND PACKET:C103($H_Doc; $T_Table)
		CLOSE DOCUMENT:C267($H_Doc)
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		
		BEEP:C151
	End if 
	
End for 

// EOM
