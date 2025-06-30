//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Développeur (OS) : Kevin HASSAL
// Date et heure : 30/08/18, 03:50:46
// ----------------------------------------------------
// Méthode : MultiSoc_Filter
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Pointer

var $multisocTableCheck_b : Boolean
var $table_p; $refSocActive_p : Pointer
var champRefStrc_p : Pointer
var $Ref_Structure_t : Text

$table_p:=$1
$multisocTableCheck_b:=True:C214

If (Count parameters:C259>1)
	$multisocTableCheck_b:=$2
End if 

If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
	$Ref_Structure_t:=Session:C1714.storage.intervenant.Ref_Structure
Else 
	$Ref_Structure_t:=Storage:C1525.societeDetail.Ref_Structure
End if 

$refSocActive_p:=->$Ref_Structure_t

If (Not:C34(MultiSoc_Is_Table_Multi($table_p; $multisocTableCheck_b)))
	
	If (Not:C34(Undefined:C82($refSocActive_p->)))
		
		Case of 
			: (String:C10($refSocActive_p->)#"")
				EXECUTE FORMULA:C63("champRefStrc_p:=->["+Table name:C256($table_p)+"]Ref_Structure")
				QUERY SELECTION:C341($table_p->; champRefStrc_p->=$refSocActive_p->)
			: (Application type:C494#4D Server:K5:6)
				ASSERT:C1129(False:C215; "Erreur MS1.Veuillez contacter le service informatique, référence structure : "+String:C10($refSocActive_p->))
				TRACE:C157
		End case 
		
	Else 
		//ALERTE("Erreur MS2.Veuillez contacter le service informatique.")
	End if 
	
End if 