//%attributes = {}
C_TEXT:C284($vt_Texte)
$vt_Texte:=""
C_LONGINT:C283($ii)

For ($ii; 1; Get last field number:C255(->[HeberGement:5]))
	$vt_Texte:=$vt_Texte+<>va_CR+Field name:C257(Table:C252(->[HeberGement:5]); $ii)
End for 
SET TEXT TO PASTEBOARD:C523($vt_Texte)