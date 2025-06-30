//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 25/06/2020, 15:22:25
// ----------------------------------------------------
// Method: Go_Participations
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Real
var $message_t : Text
var $erreur_el : Integer
var $position_o : Object

var PAR_HB_ReferenceID : Integer

PAR_HB_ReferenceID:=$1

QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$1)
MultiSoc_Filter(->[HeBerge:4])

If (Records in selection:C76([HeBerge:4])=1)
	$erreur_el:=4DREC_Load_Record(->[HeBerge:4]; ->$message_t)  // #PHONE2017
	
	If ($erreur_el=1)
		$position_o:=New object:C1471("ecartHautEcran"; 30; "ecartBasEcran"; 100)
		outilsCreateWindowsForm("DL_Participations"; ->$position_o; \
			New object:C1471("table"; "DiaLogues"; "formName"; "DL_Participations"; "fullWidth"; True:C214); \
			New object:C1471("table"; "DiaLogues"; "useFormTable"; True:C214; "useSubForm"; True:C214))
		
/*LECTURE ÉCRITURE([DiaLogues])
FORM FIXER ENTRÉE([DiaLogues]; "DL_Reports")
		
va_Titre:="Reports"
		
$vl_Fenetre:=i_FenêtreNo(786; 508; 4; va_Titre; 1; "Quit_Show")
AJOUTER ENREGISTREMENT([DiaLogues])  //lpc 08122017 ascenceur
		
FERMER FENÊTRE*/
		
/*$ref_el:=Créer fenêtre formulaire([DiaLogues]; "DL_Participations"; Form fenêtre standard; Centrée horizontalement; Centrée verticalement)
DIALOGUE([DiaLogues]; "DL_Participations"; Créer objet)*/
	Else 
		ALERT:C41($message_t)
	End if 
	
End if 

<>PR_Participations:=0
UNLOAD RECORD:C212([HeBerge:4])