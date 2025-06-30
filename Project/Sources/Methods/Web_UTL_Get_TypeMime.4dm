//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 20-01-19, 03:10:37
// ----------------------------------------------------
// Method: Web_UTL_Get_TypeMime
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($extension; $1; $result; $0)

$extension:=$1

Case of 
	: ($extension="@pdf")
		$result:="application/pdf"
		
	: ($extension="@doc")
		$result:="application/msword"
		
	: ($extension="@docx")
		$result:="application/vnd.openxmlformats-officedocument.wordprocessingml.document"
		
	: ($extension="@xls")
		$result:="application/vnd.ms-excel"
		
	: ($extension="@xlsx")
		$result:="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
		
	: ($extension="@csv")
		$result:="text/csv"
		
	: ($extension="@zip")
		$result:="application/zip"
		
	: ($extension="@png")
		$result:="image/png"
		
	: ($extension="@jpeg")
		$result:="image/jpeg"
		
	: ($extension="@jpg")
		$result:="image/jpeg"
		
	: ($extension="@txt")
		$result:="text/plain"
		
	Else 
		$result:="application/pdf"
End case 

$0:=$result