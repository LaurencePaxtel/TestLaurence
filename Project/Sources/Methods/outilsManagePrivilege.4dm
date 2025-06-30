//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 07/02/24, 15:06:47
// ----------------------------------------------------
// Méthode : outilsManagePrivilege
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Variant
var $1 : Integer  // Point d'entrée
var $2 : Text  // Nom du privilège
var $3 : Integer  // ID de l'intervenant

var $privilege_e : cs:C1710.PrivilegeEntity
var $intervenantPrivilege_es : cs:C1710.IntervenantsPrivilegeSelection

Case of 
	: ($1=1)  // Check si l'utilisateur $3 a bien le privilège $2
		$0:=False:C215
		outilsOrdaSearchSimple(->[Privilege:135]; ->[Privilege:135]nom:1; $2; ->$privilege_e; "first")
		
		If ($privilege_e#Null:C1517)
			$intervenantPrivilege_es:=$privilege_e.AllIntervenantPrivilege.query("intervenantID = :1"; $3)
			$0:=($intervenantPrivilege_es.length>0)
		End if 
		
	: ($1=2)  // Retourne tous les privilèges de l'utilisateur $3
		$0:=ds:C1482.IntervenantsPrivilege.query("intervenantID = :1"; $3).OnePrivilege.orderBy("nom asc").toCollection("nom").extract("nom")
End case 