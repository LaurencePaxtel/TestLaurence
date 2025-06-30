//%attributes = {}
// Method Replace_compiler_directives replaces deprecated inactive button 

//
// #SYNTAX: Replace compiler directives 
// #PARAMETERS:
//     none

// #DATE CREATION: 02/02/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 08/02/2016
// #NOTE: This methods runs on 4D v13 and later
// 
// #HEADER VERSION: 2

// If you find this code useful, so send a mail!

C_LONGINT:C283($L_Milli)
$L_Milli:=Milliseconds:C459

ARRAY TEXT:C222($rT_Paths; 0)
METHOD GET PATHS:C1163(Chemin tous les objets:K72:16; $rT_Paths)

ARRAY TEXT:C222($rT_Code; 0)
METHOD GET CODE:C1190($rT_Paths; $rT_Code)

$T_This_path:=METHOD Get path:C1164(Chemin méthode projet:K72:1; Current method name:C684)
$L_Pos:=Find in array:C230($rT_Paths; $T_This_path)
DELETE FROM ARRAY:C228($rT_Paths; $L_Pos)
DELETE FROM ARRAY:C228($rT_Code; $L_Pos)


ARRAY TEXT:C222($rT_Old_Command; 2)
ARRAY TEXT:C222($rT_New_Command; Size of array:C274($rT_Old_Command))

// respecter cet ordre !
$rT_Old_Command{1}:=Command name:C538(193)+"\\(.*\\)"
$rT_Old_Command{2}:=Command name:C538(192)+"\\(.*\\)"

$rT_New_Command{1}:=Command name:C538(1123)+"("  // OBJECT SET ENABLED + TRUE N° 214
$rT_New_Command{2}:=Command name:C538(1123)+"("  // OBJECT SET ENABLED + FALSE N° 215

C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($rT_Paths))
	
	// for each method
	
	C_BOOLEAN:C305($B_Modified)
	$B_Modified:=False:C215
	
	C_LONGINT:C283($j)
	For ($j; 1; Size of array:C274($rT_Old_Command))
		
		// for each directive
		
		C_LONGINT:C283($L_Start)
		$L_Start:=1
		Repeat 
			// for each found
			
			ARRAY LONGINT:C221($rL_Pos; 0)
			ARRAY LONGINT:C221($rL_Length; 0)
			
			C_BOOLEAN:C305($B_Match)
			$B_Match:=Match regex:C1019($rT_Old_Command{$j}; $rT_Code{$i}; $L_Start; $rL_Pos; $rL_Length)
			If ($B_Match)
				
				$B_Modified:=True:C214
				
				$L_Start:=$rL_Pos{0}+$rL_Length{0}
				
				C_TEXT:C284($T_Old)
				$T_Old:=Substring:C12($rT_Code{$i}; $rL_Pos{0}; $rL_Length{0})
				
				C_LONGINT:C283($L_Long; $L_Pos)
				$L_Long:=Length:C16($T_Old)
				$L_Pos:=Position:C15("("; $T_Old)
				
				C_TEXT:C284($T_Nom_Var_bouton; $T_Remplacement)
				$T_Nom_Var_bouton:=Substring:C12($T_Old; $L_Pos+1; $L_Long-$L_Pos-1)  // Nom de la variable ou du pointeur
				$T_Remplacement:=$rT_New_Command{$j}+$T_Nom_Var_bouton+";"+Choose:C955($j=1; Command name:C538(215); Command name:C538(214))+")"
				
				$rT_Code{$i}:=Replace string:C233($rT_Code{$i}; $T_Old; $T_Remplacement)
			End if 
		Until ($B_Match=False:C215)
	End for 
	
	If ($B_Modified)
		METHOD SET CODE:C1194($rT_Paths{$i}; $rT_Code{$i})
	End if 
End for 

ALERT:C41("job done in "+String:C10((Milliseconds:C459-$L_Milli)*0.001)+" seconds")

// EOM

