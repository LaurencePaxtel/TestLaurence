//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 17/04/23, 14:55:48
// ----------------------------------------------------
// Méthode : outilsWebManageAccounting
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $compteComptableAutre_b : Boolean
var $retour_o : Object

var $societe_e : cs:C1710.SOcieteEntity

$retour_o:=New object:C1471

Case of 
	: (String:C10(w_visiteur.charge)#"")
		outilsOrdaSearchSimple(->[SOciete:18]; ->[SOciete:18]Ref_Structure:97; w_visiteur.Ref_Structure; ->$societe_e; "first")
		
		If ($societe_e#Null:C1517)
			$compteComptableAutre_b:=(w_visiteur.charge#"eau") & (w_visiteur.charge#"electricite") & (w_visiteur.charge#"gaz") & (w_visiteur.charge#"internet") & (w_visiteur.charge#"telephone")
			
			Case of 
				: ($societe_e.comptabilite=Null:C1517)
					$retour_o.notificationError:="Merci de paramétrer dans 4D les compte comptables de la société "+$societe_e.SO_Libel00
				: ($societe_e.comptabilite.location=Null:C1517)
					$retour_o.notificationError:="Merci de paramétrer dans 4D les compte comptables « location » de la société "+$societe_e.SO_Libel00
				: ($compteComptableAutre_b=True:C214)
					$retour_o.compteComptable:=$societe_e.comptabilite.location.autre
				: (Num:C11($societe_e.comptabilite.location[Lowercase:C14(w_visiteur.charge)])=0)
					$retour_o.notificationError:="Merci de paramétrer dans 4D le compte comptable « location », celui qui s'appelle « "+Choose:C955($compteComptableAutre_b; "Autres"; w_visiteur.charge)+" » de la société "+\
						$societe_e.SO_Libel00
				Else 
					$retour_o.compteComptable:=$societe_e.comptabilite.location[Lowercase:C14(w_visiteur.charge)]
			End case 
			
		End if 
		
End case 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))