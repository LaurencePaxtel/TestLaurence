//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 15:07:12
// ----------------------------------------------------
// Method: AGL_Fiche_Print
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
C_POINTER:C301($1)
C_TEXT:C284($2)
C_POINTER:C301($3)

C_TEXT:C284($Print_Form_Name; $AutosaveDirectory; $filename; $file_name_pdf; $file_name_ps)
C_LONGINT:C283($n)
C_BOOLEAN:C305($mode_web; $option_orientation; $create_pdf)
C_POINTER:C301($ptr_Table; $ptr_param)
C_BLOB:C604($blob)

ARRAY TEXT:C222($champ; 0)
ARRAY TEXT:C222($valeur; 0)

$ptr_Table:=$1
$Print_Form_Name:=$2
$ptr_param:=$3

$create_pdf:=True:C214

If (Count parameters:C259>3)
	$mode_web:=$4
End if 

If (Count parameters:C259>4)
	$option_orientation:=$5
End if 

ON ERR CALL:C155("Web_Detect_Error")

FORM SET OUTPUT:C54($ptr_Table->; $Print_Form_Name)

SOC_Get_Config

Case of 
	: ($ptr_Table=->[Factures:86])
		
		If ([Factures:86]FAC_Montant_TTC:8>=0)
			
			// Modifié par : Scanu Rémy - remy@connect-io.fr (11/06/2021)
			// J'enlève [Factures]FAC_Destinataire_Nom dans le nom du fichier pdf car il peut avoir des caractères spécieaux type ["é","à"] etc.
			If ([Factures:86]FAC_No_Piece:2#"")
				$filename:="Facture_"+Replace string:C233([Factures:86]FAC_No_Piece:2; SO_Facture_Prefixe+"/"; "")  //+"_"+[Factures]FAC_Destinataire_Nom
			Else 
				$filename:="Facture_provisoire_"+String:C10([Factures:86]ID:1)  //+"_"+[Factures]FAC_Destinataire_Nom
			End if 
			
		Else 
			$filename:="Avoir_"+Replace string:C233([Factures:86]FAC_No_Piece:2; SO_Avoir_Prefixe+"/"; "")+"_"+[Factures:86]FAC_Destinataire_Nom:13
		End if 
		
		// Mode de facturation
		If ([Factures:86]FAC_Type_Facturation:49="Participations")
			$filename:=Replace string:C233($filename; "Facture"; "Participation")
		End if 
		
	: ($ptr_Table=->[Events:103])
		$filename:="Liste des événements"
End case 

$filename:=Replace string:C233($filename; "/"; "")
$filename:=Replace string:C233($filename; " "; "_")

$AutosaveDirectory:=Get 4D folder:C485(Dossier 4D actif:K5:10)+"print_job"+Séparateur dossier:K24:12

If (Not:C34(Test path name:C476($AutosaveDirectory)=Est un dossier:K24:2))
	CREATE FOLDER:C475($AutosaveDirectory)
End if 

_O_PAGE SETUP:C299($ptr_Table->; $Print_Form_Name)

// Modifié par : Scanu Rémy (07/09/2021)
// Remplacement de PDF creator par Microsoft print to PDF
//LISTE IMPRIMANTES($tb_printers_list)
//$pos:=Chercher dans tableau($tb_printers_list;"@PDFCreator@")

//Si ($pos>0)
//$path_pdfcreator:=UTL_Get_Path ("PDFCreator")

//Si (Tester chemin acces($path_pdfcreator)=Est un document)

//Si (Non(Tester chemin acces($AutosaveDirectory)=Est un dossier))
//CRÉER DOSSIER($AutosaveDirectory)
//Fin de si 

//Sinon 
//$txt_alert:="Impossible de localiser PDFCreator pour la génération du fichier PDF"

//$create_pdf:=Faux
//Fin de si 

//Sinon 
//$txt_alert:="Veuillez installer PDFCreator pour la génération du ficher PDF"

//$create_pdf:=Faux
//Fin de si 

If ($create_pdf)
	//FIXER IMPRIMANTE COURANTE($tb_printers_list{$pos})
	SET CURRENT PRINTER:C787(Driver PDF générique:K47:15)
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (11/06/2021)
	// J'imprime directement le fichier PDF au lieu d'utiliser le fichier .ps
	//$file_name_ps:=$AutosaveDirectory+$filename+".ps"
	$file_name_pdf:=$AutosaveDirectory+$filename+".pdf"
	
	SET PRINT OPTION:C733(Option nom document à imprimer:K47:10; $file_name_pdf)
	SET PRINT OPTION:C733(Option destination:K47:7; 2; $file_name_pdf)
	SET PRINT OPTION:C733(_o_Option masquer progression impr:K47:12; 1)
	
	WebAGL_Print_Piece_Ligne($ptr_Table; $ptr_param; $Print_Form_Name; 3; 1; True:C214; False:C215; $option_orientation)
	
	//LANCER PROCESS EXTERNE($path_pdfcreator+" /PrintFile=\""+$file_name_pdf+"\"")
	//LANCER PROCESS EXTERNE("\""+$path_pdfcreator+"\" /IF\""+$file_name_ps+"\" /OF\""+$file_name_pdf+"\"")
	
	While ((Test path name:C476($file_name_pdf)#Est un document:K24:1) & ($n<5))
		IDLE:C311
		
		$n:=$n+1
		DELAY PROCESS:C323(Current process:C322; 60)
	End while 
	
	$0:=$file_name_pdf
End if 

If ($mode_web)
	
	If ($create_pdf)
		DOCUMENT TO BLOB:C525($file_name_pdf; $blob)
		
		If (Test path name:C476($file_name_pdf)=1)
			ON ERR CALL:C155("WEB_IO_TRAITEMENT_ERREURS")
			DELETE DOCUMENT:C159($file_name_pdf)
			DELETE DOCUMENT:C159($file_name_ps)
			ON ERR CALL:C155("")
		End if 
		
		APPEND TO ARRAY:C911($champ; "X-STATUS")
		APPEND TO ARRAY:C911($champ; "Cache-Control")
		APPEND TO ARRAY:C911($champ; "Expires")
		APPEND TO ARRAY:C911($champ; "Content-disposition")
		APPEND TO ARRAY:C911($champ; "Content-type")
		
		APPEND TO ARRAY:C911($valeur; "200 OK")
		APPEND TO ARRAY:C911($valeur; "private, must-revalidate, max-age=0")
		APPEND TO ARRAY:C911($valeur; "-1")
		APPEND TO ARRAY:C911($valeur; "filename="+$filename+".pdf")
		APPEND TO ARRAY:C911($valeur; "application/pdf")
		
		WEB SET HTTP HEADER:C660($champ; $valeur)
		WEB SEND RAW DATA:C815($blob)
		
		ABORT:C156
	Else 
		WEB_message(""; $txt_alert)
	End if 
	
End if 
