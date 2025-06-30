//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 31/08/18, 03:24:34
// ----------------------------------------------------
// Méthode : UTL_trouve_excel
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($excel)
C_LONGINT:C283($propriete)

_O_PLATFORM PROPERTIES:C365($propriete)

If ($propriete=Mac OS:K25:2)  //sous Mac OS
	
	Case of 
		: ((Test path name:C476("Applications:Microsoft Office 2011:Microsoft Excel.app"))>=0)
			$excel:="open -a /Applications/Microsoft\\ Office\\ 2011/Microsoft\\ Excel.app"
		: ((Test path name:C476("Applications:Microsoft Office 2008:Microsoft Excel.app"))>=0)
			$excel:="open -a /Applications/Microsoft\\ Office\\ 2008/Microsoft\\ Excel.app"
		: ((Test path name:C476("Applications:Microsoft Office 2004:Microsoft Excel"))>=0)
			$excel:="open -a /Applications/Microsoft\\ Office\\ 2004/Microsoft\\ Excel"
	End case 
	
Else   //on est sur PC
	
	Case of 
		: ((Test path name:C476("C:\\Program Files\\Microsoft Office\\Office\\Excel.EXE"))>0)
			$excel:="C:\\Program Files\\Microsoft Office\\Office\\Excel.EXE"
		: ((Test path name:C476("C:\\Program Files\\Microsoft Office\\Office\\Excel.EXE"))>0)
			$excel:="C:\\Program Files\\Microsoft Office\\Office\\Excel.EXE"
		: ((Test path name:C476("C:\\Program Files\\Microsoft Office\\Office15\\Excel.EXE"))>0)
			$excel:="C:\\Program Files\\Microsoft Office\\Office15\\Excel.EXE"
		: ((Test path name:C476("C:\\Program Files\\Microsoft Office\\Office14\\Excel.EXE"))>0)
			$excel:="C:\\Program Files\\Microsoft Office\\Office14\\Excel.EXE"
		: ((Test path name:C476("C:\\Program Files (x86)\\Microsoft Office\\Office14\\Excel.EXE"))>0)
			$excel:="C:\\Program Files (x86)\\Microsoft Office\\Office14\\Excel.EXE"
		: ((Test path name:C476("C:\\Program Files\\Microsoft Office\\Office13\\Excel.EXE"))>0)
			$excel:="C:\\Program Files\\Microsoft Office\\Office13\\Excel.EXE"
		: ((Test path name:C476("C:\\Program Files\\Microsoft Office\\Office12\\Excel.EXE"))>0)
			$excel:="C:\\Program Files\\Microsoft Office\\Office12\\Excel.EXE"
		: ((Test path name:C476("C:\\Program Files\\Microsoft Office\\Office11\\Excel.EXE"))>0)
			$excel:="C:\\Program Files\\Microsoft Office\\Office11\\Excel.EXE"
		: ((Test path name:C476("C:\\Program Files\\Microsoft Office\\Office10\\Excel.EXE"))>0)
			$excel:="C:\\Program Files\\Microsoft Office\\Office10\\Excel.EXE"
		: ((Test path name:C476("C:\\APPS\\Microsoft Office\\OFFICE11\\Excel.EXE"))>0)
			$excel:="C:\\apps\\Microsoft Office\\Office11\\Excel.EXE"
		: ((Test path name:C476("C:\\Program Files (x86)\\Microsoft Office\\Office12\\Excel.EXE"))>0)
			$excel:="C:\\Program Files (x86)\\Microsoft Office\\Office12\\Excel.EXE"
		: ((Test path name:C476("C:\\Program Files\\Microsoft Office\\Office16\\EXCEL.EXE"))>0)
			$excel:="C:\\Program Files\\Microsoft Office\\Office16\\EXCEL.EXE"
	End case 
	
End if 

$0:=$excel