//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 28/01/20, 20:15:54
// ----------------------------------------------------
// Method: REG_Get_Liste
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $i_el : Integer
var $displayAll_b : Boolean

var txt_filtre_numero; txt_filtre_nom : Text
var txt_filtre_montant : Real

var $reglement_es; $reglementB_es : cs:C1710.ReglementsSelection

// Modifié par : Scanu Rémy (23/02/2022)
If (Value type:C1509(tb_fac_choix)#Est une variable indéfinie:K8:13)
	$reglement_es:=ds:C1482.Reglements.newSelection()
	
	For ($i_el; 1; Size of array:C274(tb_fac_choix))
		
		If (tb_fac_choix{$i_el}=True:C214)
			$reglementB_es:=ds:C1482.Reglements.query("REG_Origine_IDS = :1"; "@"+String:C10(tb_fac_id{$i_el})+"@")
			
			If ($reglementB_es.length>0)
				$reglement_es:=$reglement_es.or($reglementB_es)
			End if 
			
			If ($displayAll_b=False:C215)
				$displayAll_b:=True:C214
			End if 
			
		End if 
		
	End for 
	
End if 

If (Not:C34($displayAll_b)=True:C214)  // Aucune facture de sélectionnée, on pré-selectionne tout
	$reglement_es:=ds:C1482.Reglements.all()
End if 

$reglement_es:=$reglement_es.query("REG_Date_Piece >= :1 AND REG_Date_Piece <= :2 AND REG_Destinataire_Nom = :3 AND REG_Libelle = :4 AND REG_No_Piece = :5 AND REG_Bien_ID = :6"; \
Form:C1466.dateDu; Form:C1466.dateAu; "@"+txt_filtre_nom+"@"; "@"+txt_filtre_designation+"@"; "@"+txt_filtre_numero+"@"; 0)

If (txt_filtre_montant>0)
	$reglement_es:=$reglement_es.query("REG_Montant = :1"; txt_filtre_montant)
End if 

outilsOrdaSearchByRefStctre(->$reglement_es)

USE ENTITY SELECTION:C1513($reglement_es)
LOAD RECORD:C52([Reglements:93])

OBJECT SET ENTERABLE:C238(*; "@"; True:C214)
OBJECT SET ENABLED:C1123(*; "@"; True:C214)

txt_titre_fenetre_regl:="Liste des règlements : "+String:C10(Records in selection:C76([Reglements:93]))