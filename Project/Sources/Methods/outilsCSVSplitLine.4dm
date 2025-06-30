//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 07/11/23, 17:59:26
// ----------------------------------------------------
// Méthode : outilsCSVSplitLine
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_OBJECT:C1216($1)
C_POINTER:C301($2)

C_TEXT:C284($encoding; $file_path; $Delimiter; $csv; $CurrentTest_text)
C_LONGINT:C283($r; $c; $i)
C_BOOLEAN:C305($SkipErrors_bool)
C_POINTER:C301($aMatrix_text_ptr)
C_OBJECT:C1216($params)

// 1st dimension is the field (ready for ARRAY TO SELECTION)
// 2nd dimension is the row
ARRAY TEXT:C222($values; 0; 0)

ARRAY LONGINT:C221($pos; 0)
ARRAY LONGINT:C221($len; 0)

ASSERT:C1129(Count parameters:C259>1)
ASSERT:C1129(Not:C34(Is nil pointer:C315($2)))

ASSERT:C1129(Type:C295($2->)=Est un tableau 2D:K8:24)
ASSERT:C1129(Type:C295($2->{0})=Est un tableau texte:K8:16)

$params:=$1
$aMatrix_text_ptr:=$2

$encoding:=OB Get:C1224($params; "encoding"; Est un texte:K8:3)
$file_path:=OB Get:C1224($params; "in"; Est un texte:K8:3)
$Delimiter:=OB Get:C1224($params; "delimiter"; Est un texte:K8:3)
$SkipErrors_bool:=OB Get:C1224($params; "skip_errors"; Est un booléen:K8:9)

If ($Delimiter="")
	$Delimiter:=","
End if 

ASSERT:C1129(($Delimiter=",") | ($Delimiter=";"))

If ($encoding="")
	$encoding:="utf-8"
End if 

ASSERT:C1129(Test path name:C476($file_path)=Est un document:K24:1)
$csv:=Document to text:C1236($file_path; $encoding; Document avec CRLF:K24:20)

$r:=1
$c:=1
$i:=1

Repeat 
	$CurrentTest_text:=Substring:C12($csv; $i; 50)
	$gotValue:=False:C215
	
	If (Match regex:C1019("\""; $csv; $i; *))  //quoted value
		$j:=$i+1
		
		While (Match regex:C1019("((?:\"\")|[^\"])"; $csv; $j; $pos; $len; *))  // scan "" or non-quote
			$test:=Substring:C12($csv; $pos{1}; $len{1})
			$j:=$pos{1}+$len{1}
		End while 
		
		If (Match regex:C1019("\""; $csv; $j; *))
			$value:=Replace string:C233(Substring:C12($csv; $i+1; $j-$i-1); "\"\""; "\""; *)
			$gotValue:=True:C214
		End if 
		
		$i:=$j+1
		
	Else 
		
		If (Match regex:C1019("([^"+$Delimiter+"\\r\\n]*)"; $csv; $i; $pos; $len; *))  //read to a quote or end of line
			$value:=Substring:C12($csv; $pos{1}; $len{1})
			$i:=$pos{1}+$len{1}
			$gotValue:=True:C214
		End if 
		
	End if 
	
	If ($gotValue)
		
		If ($c>Size of array:C274($values))  // put value in array
			INSERT IN ARRAY:C227($values; $c)
		End if 
		
		ARRAY TEXT:C222($values{$c}; $r)
		$values{$c}{$r}:=$value
		
		Case of 
			: (Match regex:C1019($Delimiter; $csv; $i; *))
				$i:=$i+1  // skip the quote
				$c:=$c+1  // goto next column
				
				If (Match regex:C1019("$"; $csv; $i; *))
					//last column of last element is empty
					If ($c>Size of array:C274($values))
						INSERT IN ARRAY:C227($values; $c)
					End if 
					ARRAY TEXT:C222($values{$c}; $r)
					$values{$c}{$r}:=""
				End if 
				
			: (Match regex:C1019("(\\r\\n)"; $csv; $i; $pos; $len; *))
				$i:=$pos{1}+$len{1}  // skip the line delimiter
				$r:=$r+1  // goto next row
				$c:=1  // reset column counter
			: ($SkipErrors_bool) & (Match regex:C1019("(\\r\\n)"; $csv; $i; $pos; $len))  // Skip to end of line if a column contains incorrectly escaped double-quotes
				$i:=$pos{1}+$len{1}  //skip the line delimiter
				$r:=$r+1  // goto next row
				$c:=1  // reset column counter
			Else 
				$i:=Length:C16($csv)+1  // EXIT
		End case 
		
	End if 
	
	outilsCleanVariable(->$CurrentTest_text)
Until (Match regex:C1019("$"; $csv; $i; *))  //EOF (with or without line delimiter)

COPY ARRAY:C226($values; $aMatrix_text_ptr->)