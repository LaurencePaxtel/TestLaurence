//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 18-01-19, 11:02:55
// ----------------------------------------------------
// Method: UTL_Get_Document_Type
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($name; $1; $extension)

$name:=$1

Case of 
	: ($name="@.pdf@")
		$extension:=".pdf"
		
	: ($name="@.png@")
		$extension:=".png"
		
	: ($name="@.docx@")
		$extension:=".docx"
		
	: ($name="@.doc@")
		$extension:=".doc"
		
	: ($name="@.xlsx@")
		$extension:=".xlsx"
		
	: ($name="@.xls@")
		$extension:=".xls"
		
	: ($name="@.txt@")
		$extension:=".txt"
		
	: ($name="@.png@")
		$extension:=".png"
		
	: ($name="@.jpg@")
		$extension:=".jpg"
		
	: ($name="@.jpeg@")
		$extension:=".jpeg"
		
	: ($name="@.bmp@")
		$extension:=".bmp"
		
	Else 
		$extension:=""
End case 

$0:=$extension