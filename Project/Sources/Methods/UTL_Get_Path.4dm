//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 24/04/20, 08:57:39
// ----------------------------------------------------
// Method: UTL_Get_Path
// Description
// Cette méthode permet de retourner le chemin correcte
// d'une application ou d'un dossier
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($type; $path)
C_LONGINT:C283($i)
C_BOOLEAN:C305($continu)

$type:=$1
$continu:=True:C214

Case of 
	: ($type="Applications")
		
		While ($continu)
			$i:=$i+1
			
			Case of 
				: ($i=1)
					$path:=System folder:C487(Applications ou Program Files:K41:17)
				: ($i=2)
					$path:="C:\\Program Files (x86)\\"
				: ($i=3)
					$path:="C:\\Program Files\\"
				: ($i=4)
					$path:="C:\\Programmes (x86)\\"
				: ($i=5)
					$path:="C:\\Programmes\\"
				Else 
					$continu:=False:C215
			End case 
			
			If (Test path name:C476($path)=Est un dossier:K24:2)
				$continu:=False:C215
			End if 
			
		End while 
		
	: ($type="PDFCreator")
		
		While ($continu)
			$i:=$i+1
			
			Case of 
				: ($i=1)
					$path:=System folder:C487(Applications ou Program Files:K41:17)
				: ($i=2)
					$path:="C:\\Program Files (x86)\\"
				: ($i=3)
					$path:="C:\\Program Files\\"
				: ($i=4)
					$path:="C:\\Programmes (x86)\\"
				: ($i=5)
					$path:="C:\\Programmes\\"
				Else 
					$continu:=False:C215
					
					$path:=""
			End case 
			
			If ($continu)
				$path:=$path+"PDFCreator\\"+"PDFCreator.exe"
				
				If (Test path name:C476($path)=Est un document:K24:1)
					$continu:=False:C215
				End if 
				
			End if 
			
		End while 
		
End case 

$0:=$path