//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 12/10/2020, 11:43:05
// ----------------------------------------------------
// Method: XLIFF_Get_Indexed_String
// Description
// Cette méthode à été créee pour régler le bug sur la méthode
// du composant 4D-COMP-STR qui ne supporte pas la gestion multi-sociétés
// xliff_Txt_Get_Indexed_String_
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $group_id; $2; $index)
C_TEXT:C284($file_name; $path)

C_TEXT:C284($reference; $value)
ARRAY TEXT:C222($DOM; 0)

$group_id:=$1
$index:=$2
$file_name:="STR"+String:C10($group_id)+".xlf"
$value:=""
$path:=Get 4D folder:C485(Dossier Resources courant:K5:16)
$path:=$path+"fr.lproj"
$path:=$path+Séparateur dossier:K24:12+$file_name

If (Test path name:C476($path)=Est un document:K24:1)
	
	$reference:=DOM Parse XML source:C719($path)
	
	If (OK=1)
		
		$DOM{0}:=DOM Find XML element:C864($reference; "/xliff/file/body/group/trans-unit["+String:C10($index)+"]/source"; $DOM)
		
		If (OK=1)
			
			If (Size of array:C274($DOM)=1)
				DOM GET XML ELEMENT VALUE:C731($DOM{1}; $value)
			End if 
			
		End if 
		
		DOM CLOSE XML:C722($reference)
	End if 
	
End if 

$0:=$value