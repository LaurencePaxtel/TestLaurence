//%attributes = {}
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($vl_Position)
C_TEXT:C284($vt_TXT)


$vt_TXT:=$1
//Col 1        
$vl_Position:=Position:C15(<>va_Tab; $vt_TXT)
va_InSiao_Col1:=Substring:C12($vt_TXT; 1; $vl_Position-1)
$vt_TXT:=Substring:C12($vt_TXT; $vl_Position+1)
//Col 2       
$vl_Position:=Position:C15(<>va_Tab; $vt_TXT)
va_InSiao_Col2:=Substring:C12($vt_TXT; 1; $vl_Position-1)
$vt_TXT:=Substring:C12($vt_TXT; $vl_Position+1)
//Col 3       
$vl_Position:=Position:C15(<>va_Tab; $vt_TXT)
va_InSiao_Col3:=Substring:C12($vt_TXT; 1; $vl_Position-1)
$vt_TXT:=Substring:C12($vt_TXT; $vl_Position+1)
//Col 4      
$vl_Position:=Position:C15(<>va_Tab; $vt_TXT)
vt_InSiao_Col4:=Substring:C12($vt_TXT; 1; $vl_Position-1)
$vt_TXT:=Substring:C12($vt_TXT; $vl_Position+1)
If ($2=1)
	//Col 5   
	$vl_Position:=Position:C15(<>va_Tab; $vt_TXT)
	va_InSiao_Col5:=Substring:C12($vt_TXT; 1; $vl_Position-1)
	$vt_TXT:=Substring:C12($vt_TXT; $vl_Position+1)
	//Col 6     
	va_InSiao_Col6:=$vt_TXT
Else 
	va_InSiao_Col5:=$vt_TXT
End if 