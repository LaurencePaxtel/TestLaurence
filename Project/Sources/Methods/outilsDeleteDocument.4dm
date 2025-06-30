//%attributes = {}
// ----------------------------------------------------
// User name (OS): Administrator
// Date and time: 24/02/21, 18:31:14
// ----------------------------------------------------
// Method: outilsDeleteDocument
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($0)  // Booléen qui indique si le document a bien été supprimer
C_TEXT:C284($1)  // Chemin du document à supprimer
C_BOOLEAN:C305($2)  // Booléen qui indique si on veut supprimer le document sur le serveur

C_LONGINT:C283($refProc_el)
C_OBJECT:C1216(gestionProcess_o)

gestionProcess_o:=New object:C1471("finProc"; False:C215; "arFinProc"; False:C215)

Case of 
	: (Application type:C494=4D Server:K5:6)
		DELETE DOCUMENT:C159($1)
		
		gestionProcess_o.docSuppr:=(OK=1)
		gestionProcess_o.finProc:=True:C214
		
		Repeat 
			DELAY PROCESS:C323(Current process:C322; 120)
		Until (gestionProcess_o.arFinProc)
		
	: ($2=True:C214) & (Application type:C494=4D mode distant:K5:5)
		$refProc_el:=Execute on server:C373("outilsDeleteDocument"; 0; "Suppression du document "+outilsExtractFileNameToPath($1; True:C214); $1; False:C215)
		
		Repeat 
			DELAY PROCESS:C323(Current process:C322; 120)
			GET PROCESS VARIABLE:C371($refProc_el; gestionProcess_o; gestionProcess_o)
		Until (gestionProcess_o.finProc)
		
		gestionProcess_o.arFinProc:=True:C214
		SET PROCESS VARIABLE:C370($refProc_el; gestionProcess_o; OB Copy:C1225(gestionProcess_o))
		
		$0:=Bool:C1537(gestionProcess_o.docSuppr)
	Else 
		DELETE DOCUMENT:C159($1)
		$0:=(OK=1)
End case 