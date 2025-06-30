//%attributes = {}
// Method Replace_compiler_directives replaces deprecated compiler directives 
// C_INTEGER,
// _o_C_INTEGER
// C_STRING
// _o_C_STRING
// ARRAY STRING
// _o_ARRAY STRING
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


ARRAY TEXT:C222($rT_Old_Directive; 3)
ARRAY TEXT:C222($rT_New_Directive; Size of array:C274($rT_Old_Directive))

// added 02/08/2016
$rT_Old_Directive{1}:=Command name:C538(293)+"\\(\\d{1,3};"  // c_string
$rT_Old_Directive{2}:=Command name:C538(282)+"\\("  // c_integer
$rT_Old_Directive{3}:=Command name:C538(218)+"\\(\\d{1,3};"  // array string

$rT_New_Directive{1}:=Command name:C538(284)+"("
$rT_New_Directive{2}:=Command name:C538(283)+"("
$rT_New_Directive{3}:=Command name:C538(222)+"("


C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($rT_Paths))
	
	// for each method
	
	C_BOOLEAN:C305($B_Modified)
	$B_Modified:=False:C215
	
	C_LONGINT:C283($j)
	For ($j; 1; Size of array:C274($rT_Old_Directive))
		
		// for each directive
		
		C_LONGINT:C283($L_Start)
		$L_Start:=1
		Repeat 
			// for each found
			
			ARRAY LONGINT:C221($rL_Pos; 0)
			ARRAY LONGINT:C221($rL_Length; 0)
			
			C_BOOLEAN:C305($B_Match)
			$B_Match:=Match regex:C1019($rT_Old_Directive{$j}; $rT_Code{$i}; $L_Start; $rL_Pos; $rL_Length)
			If ($B_Match)
				
				$B_Modified:=True:C214
				
				$L_Start:=$rL_Pos{0}+$rL_Length{0}
				
				C_TEXT:C284($T_Old)
				$T_Old:=Substring:C12($rT_Code{$i}; $rL_Pos{0}; $rL_Length{0})
				$rT_Code{$i}:=Replace string:C233($rT_Code{$i}; $T_Old; $rT_New_Directive{$j})
				
			End if 
		Until ($B_Match=False:C215)
	End for 
	
	If ($B_Modified)
		METHOD SET CODE:C1194($rT_Paths{$i}; $rT_Code{$i})
	End if 
End for 

ALERT:C41("job done in "+String:C10((Milliseconds:C459-$L_Milli)*0.001)+" seconds")

// EOM

