//%attributes = {}
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($ii; $vl_Position)
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
If (va_InSiao_Col3="0")
Else 
	$vt_TXT:=Substring:C12($vt_TXT; $vl_Position+1)
	$ii:=0
	
	Case of 
		: ($3=1)
			$ii:=$ii+1
			//Col 4      
			$vl_Position:=Position:C15(<>va_Tab; $vt_TXT)
			vt_InSiao_Col4:=Substring:C12($vt_TXT; 1; $vl_Position-1)
			$vt_TXT:=Substring:C12($vt_TXT; $vl_Position+1)
			va_InSiao_Col5:=$vt_TXT
			tt_InSiao_Valeur{$2}{$ii}:=vt_InSiao_Col4
			
		: ($3=2)
			Repeat 
				$ii:=$ii+1
				$vl_Position:=Position:C15(<>va_Tab; $vt_TXT)
				If ($vl_Position>0)
					tt_InSiao_Valeur{$2}{$ii}:=Substring:C12($vt_TXT; 1; $vl_Position-1)
					$vt_TXT:=Substring:C12($vt_TXT; $vl_Position+1)
				Else 
					tt_InSiao_Valeur{$2}{$ii}:=$vt_TXT
					$vt_TXT:=""
				End if 
			Until ($vt_TXT="")
	End case 
End if 