//%attributes = {}
// ----------------------------------------------------
// Développeur (OS) : Kevin HASSAL
// Date et heure : 30/08/18, 04:22:40
// ----------------------------------------------------
// Méthode : MultiSoc_Init_Structure
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Pointer

var $table_p; $refSocActive_p : Pointer
var champRefStrc_p : Pointer
var $Ref_Structure_t : Text

$table_p:=$1

If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
	$Ref_Structure_t:=Session:C1714.storage.intervenant.Ref_Structure
	$refSocActive_p:=->$Ref_Structure_t
Else 
	If (Application type:C494=4D Server:K5:6)
		$refSocActive_p:=->ref_soc_active
	Else 
		$Ref_Structure_t:=Storage:C1525.societeDetail.Ref_Structure
		$refSocActive_p:=->$Ref_Structure_t
	End if 
End if 

EXECUTE FORMULA:C63("champRefStrc_p:=->["+Table name:C256($table_p)+"]Ref_Structure")

If (champRefStrc_p->="")
	champRefStrc_p->:=$refSocActive_p->
End if 