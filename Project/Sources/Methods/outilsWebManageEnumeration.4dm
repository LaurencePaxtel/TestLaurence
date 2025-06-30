//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 10/07/24, 16:04:27
// ----------------------------------------------------
// Méthode : outilsWebManageEnumeration
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $retour_o : Object

$retour_o:=New object:C1471("success"; True:C214)

Case of 
	: (String:C10(w_visiteur.action)="getEnumeration")  // Exemple enumerationLib = "FM Distri5"
		$typesTables_es:=ds:C1482.TypesTables.query("TT_Libellé = :1"; String:C10(w_visiteur.enumerationLib))
		$tables_es:=outilsOrdaSearch($typesTables_es; "TT_RéférenceID"; "TAbles"; "TB_TT_ID")
		
		$retour_o.data:=$tables_es.query("Ref_Structure = :1"; String:C10(w_visiteur.refStructure)).toCollection("TB_Texte").extract("TB_Texte").distinct().orderBy(ck ascending:K85:9)
		
		If (String:C10(w_visiteur.typeReturn)#"")
			
			Case of 
				: (String:C10(w_visiteur.typeReturn)="text")
					$retour_o.data:=$retour_o.data.map("outilsCollectionValueToString")
				: (String:C10(w_visiteur.typeReturn)="numeric")
					$retour_o.data:=$retour_o.data.map("outilsCollectionValueToNum")
				: (String:C10(w_visiteur.typeReturn)="date")
					$retour_o.data:=$retour_o.data.map("outilsCollectionValueToDate")
			End case 
			
		End if 
		
End case 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))