//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 14/12/21, 17:33:25
// ----------------------------------------------------
// Méthode : outilsOrdaSearchByRefSt(ru)ct(u)re
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)
C_VARIANT:C1683($2)
C_TEXT:C284($3)
var $Ref_Structure : Text

Case of 
	: (Count parameters:C259=1)
		// <>ref_soc_active devient Session.storage.intervenant.Ref_Structure
		If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
			$Ref_Structure:=Session:C1714.storage.intervenant.Ref_Structure
		Else 
			$Ref_Structure:=Storage:C1525.societeDetail.Ref_Structure
		End if 
		
		$1->:=$1->query("Ref_Structure = :1"; $Ref_Structure)
	: (Count parameters:C259>=2) & (Value type:C1509($2)=Est un texte:K8:3)
		
		If (Count parameters:C259=3)
			$1->:=$1->query($3+" = :1"; $2)
		Else 
			$1->:=$1->query("Ref_Structure = :1"; $2)
		End if 
		
	: (Count parameters:C259>=2) & (Value type:C1509($2)=Est une collection:K8:32)
		
		If (Count parameters:C259=3)
			$1->:=$1->query($3+" in :1"; $2)
		Else 
			$1->:=$1->query("Ref_Structure in :1"; $2)
		End if 
		
End case 