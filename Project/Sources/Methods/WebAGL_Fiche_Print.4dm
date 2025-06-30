//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 15:07:12
// ----------------------------------------------------
// Method: WebAGL_Fiche_Print
// Description
// Description
// A utiliser pour l'impression des fiches que ça soit les fiches principales 
// (Impression standard) ou les fiches avec des lignes  
//
// Paramètres :    
// 1er Cas c'est  l'impression standard d'une fiches  : 
// Web_AGL_Fiche_Print (pointeur sur la table; Nom du formulaire d'mpression)

// 2eme Cas c'est  l'impression des fiches avec des lignes (factures...etc ): 
// Web_AGL_Fiche_Print (pointeur sur la table; Nom du formulaire d'mpression; pointeur1 ;pointeur2...)
// pointeur1 ;pointeur2 .... sont les pointeurs sur les tables lignes à afficher dans le formulaire d'impression

// NB : 1 :si les lignes de la fiche sont presentées dans le formulaire d'impression
// sous forme d'un " sous fourmulaire " alors on utilise le premier cas ( deux paramétres ) 
// 2 : Etre sur que les selectiones des tables à utiliser dans le formulaire d'impression sont bonnes
// ----------------------------------------------------

C_POINTER:C301($1; $ptr_Table; $ptr_param)
C_TEXT:C284($2; $Print_Form_Name; $AutosaveDirectory; $AutosaveFilename; $file_name_pdf)
C_BLOB:C604($blob)
C_BOOLEAN:C305(sendDoc)
$ptr_Table:=$1
$Print_Form_Name:=$2
ON ERR CALL:C155("Web_Detect_Error")

FORM SET OUTPUT:C54($ptr_Table->; $Print_Form_Name)

If ([Factures:86]FAC_No_Piece:2#"")
	$file_name_pdf:="Facture_"+Replace string:C233([Factures:86]FAC_No_Piece:2; "FAC/"; "")+".pdf"
Else 
	$file_name_pdf:="Facture_provisoire_"+String:C10([Factures:86]ID:1)+".pdf"
End if 

QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=Session:C1714.storage.intervenant.Ref_Structure)
i_entete:=[Structures:79]STRC_Logo:5  //[Structures]STRC_Entete
i_pied:=[Structures:79]STRC_Logo:5  //[Structures]STRC_Pied
//$Chemin_Imp_Tempo:=Get 4D folder(HTML Root folder)+"temp_print\\"+String(UTL_Generate_TimeStamp )+".pdf"


//$Chemin_Imp_Tempo:="C:\\Users\\Kevin HASSAL\\Desktop\\impression\\Test_PDF_"+String(UTL_Generate_TimeStamp )+".pdf"
//$Chemin_Imp_Tempo:="C:\\Users\\Kevin HASSAL\\Documents\\4d print job\\Test_PDF_"+String(UTL_Generate_TimeStamp )+".pdf"

//$Chemin_Imp_Tempo:=Get 4D folder(HTML Root folder)+"print_job"+Folder separator+"Test_PDF_"+String(UTL_Generate_TimeStamp )+".pdf"

//$AutosaveDirectory:="C:\\Users\\Kevin HASSAL\\Documents\\4d print job"
//$AutosaveFilename:="C:\\Users\\Kevin HASSAL\\Documents\\4d print job\\Test_PDF_"+String(UTL_Generate_TimeStamp )+".pdf"


$Chemin_Imp_Tempo:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"print_job"+Séparateur dossier:K24:12+$file_name_pdf

$AutosaveDirectory:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"print_job"
$AutosaveFilename:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"print_job"+Séparateur dossier:K24:12+$file_name_pdf

$AutosaveFilename:=$file_name_pdf


//SET DATABASE PARAMETER(Maximum Web requests size;27)


//SET PRINT OPTION(Destination option;3;$Chemin_Imp_Tempo)
_O_PAGE SETUP:C299($ptr_Table->; $Print_Form_Name)



SET CURRENT PRINTER:C787("Win2PDF")
SET PRINT OPTION:C733(Option destination:K47:7; 2; $Chemin_Imp_Tempo)

//SET PRINT OPTION("PDFOptions:UseAutosave";1)
//SET CURRENT PRINTER(PDFCreator Printer name)



//SET PRINT OPTION("PDFOptions:UseAutosaveDirectory";1)
//SET PRINT OPTION("PDFOptions:AutosaveDirectory";$AutosaveDirectory)
//SET PRINT OPTION("PDFOptions:AutosaveFilename";$AutosaveFilename)
//SET PRINT OPTION(Destination option;3;$Chemin_Imp_Tempo)
//SET PRINT OPTION("PDFOptions:UseAutosave";1)

//SET CURRENT PRINTER(PDFCreator Printer name)
//  //SET PRINT OPTION(Destination option;2;$Chemin_Imp_Tempo)
//SET PRINT OPTION(Destination option;3;$Chemin_Imp_Tempo)
//SET PRINT OPTION("PDFOptions:UseAutosave";1)
//SET PRINT OPTION("PDFOptions:UseAutosaveDirectory";1)
//  //SET PRINT OPTION("PDFOptions:AutosaveDirectory";$AutosaveDirectory)
//SET PRINT OPTION(Destination option;3;$AutosaveDirectory)
//  //SET PRINT OPTION(Destination option;2;$Chemin_Imp_Tempo)




//SET CURRENT PRINTER(PDFCreator Printer name)
//SET PRINT OPTION("PDFOptions:UseAutosave";1)
//SET PRINT OPTION("PDFInfo:Synchronous Mode";1)
//SET PRINT OPTION("PDFInfo:Start";1)

//SET PRINT OPTION(Destination option;3;$Chemin_Imp_Tempo)  // This is now the same piece of code as on Macintosh 
//SET PRINT OPTION("PDFOptions:AutosaveFilename";$Chemin_Imp_Tempo)


// GET PRINT OPTION("PDFInfo:Version";$numVersion)

//SET PRINT OPTION("PDFInfo:Reset standard options";0)



//SET CURRENT PRINTER(PDFCreator Printer name)
//SET PRINT OPTION("PDFOptions:UseAutosave";1)
//SET PRINT OPTION("PDFOptions:UseAutosaveDirectory";1)
//SET PRINT OPTION("PDFOptions:AutosaveDirectory";$AutosaveDirectory)


//  SET PRINT OPTION("PDFOptions:AutosaveFilename";"Test_PDF_"+String(UTL_Generate_TimeStamp )+".pdf")

//SET PRINT OPTION(Destination option;3;$AutosaveFilename)

//OPEN PRINTING JOB


//SET PRINT OPTION(2;2)
//SET PRINT OPTION(12;$Chemin_Imp_Tempo)

If (Count parameters:C259>2)
	If ($Print_Form_Name#"Fiche_impression")
		For ($i; 3; Count parameters:C259)
			EXECUTE FORMULA:C63("$ptr_param:=$"+String:C10($i))
			WebAGL_Print_Piece_Ligne($ptr_Table; $ptr_param; $Print_Form_Name; 3; 1; True:C214; False:C215)
		End for 
	Else 
		PRINT RECORD:C71($ptr_Table->; *)
	End if 
Else 
	PRINT RECORD:C71($ptr_Table->; *)
End if 
//CLOSE PRINTING JOB
// Attente le temps que le serveur crée le PDF
$tempo:=0
Repeat 
	$tempo:=$tempo+1
	DELAY PROCESS:C323(Current process:C322; 30)
Until ((Test path name:C476($Chemin_Imp_Tempo)=1) | ($tempo=60))  // boucle de 30 secondes


ARRAY TEXT:C222(TB_chemin_fichier; 0)

If (sendDoc)
	APPEND TO ARRAY:C911(TB_chemin_fichier; $Chemin_Imp_Tempo)
Else 
	DOCUMENT TO BLOB:C525($Chemin_Imp_Tempo; $blob)
	If (Test path name:C476($Chemin_Imp_Tempo)=1)
		ON ERR CALL:C155("WEB_IO_TRAITEMENT_ERREURS")
		DELETE DOCUMENT:C159($Chemin_Imp_Tempo)
		ON ERR CALL:C155("")
	End if 
	ARRAY TEXT:C222($champ; 0)
	APPEND TO ARRAY:C911($champ; "X-STATUS")
	APPEND TO ARRAY:C911($champ; "Cache-Control")
	APPEND TO ARRAY:C911($champ; "Expires")
	APPEND TO ARRAY:C911($champ; "Content-disposition")
	APPEND TO ARRAY:C911($champ; "Content-type")
	
	ARRAY TEXT:C222($valeur; 0)
	APPEND TO ARRAY:C911($valeur; "200 OK")
	APPEND TO ARRAY:C911($valeur; "private, must-revalidate, max-age=0")
	APPEND TO ARRAY:C911($valeur; "-1")
	APPEND TO ARRAY:C911($valeur; "filename="+$file_name_pdf)
	APPEND TO ARRAY:C911($valeur; "application/pdf")
	
	WEB SET HTTP HEADER:C660($champ; $valeur)
	WEB SEND RAW DATA:C815($blob)
	ABORT:C156
End if 