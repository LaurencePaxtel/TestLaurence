//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Paxtel
// Date et heure : 20/02/23, 11:53:08
// ----------------------------------------------------
// Méthode : _cioSupprFacture
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $id_el : Integer
var $statut_o : Object

var $factureLigne_e : cs:C1710.Factures_LignesEntity

$id_el:=Num:C11(Request:C163("ID de la facture SVP ?"; ""; "Valider"; "Annuler"))

If ($id_el#0)
	$factureLigne_e:=ds:C1482.Factures_Lignes.get($id_el)
	
	If ($factureLigne_e#Null:C1517)
		$statut_o:=$factureLigne_e.drop()
		
		If ($statut_o.success)
			ALERT:C41("L'enregistrement "+String:C10($id_el)+" a bien été supprimé")
		Else 
			ALERT:C41("L'enregistrement "+String:C10($id_el)+" n'a pas pu être supprimé : "+$statut_o.statusText)
		End if 
		
	Else 
		ALERT:C41("L'enregistrement "+String:C10($id_el)+" n'existe pas")
	End if 
	
End if 