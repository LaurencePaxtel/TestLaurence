//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 03/09/21, 16:04:58
// ----------------------------------------------------
// Méthode : outilsManageFacture
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Variant
var $1 : Integer
var $2 : Variant  // Mise à jour éventuel du solde due pour les factures suivantes lors d'un réglement OU Entity d'une facture chez qui on souhaite avoir toutes les factures suivantes du même type et pour la même personne
var $3 : Variant  // Recherche dans FAC_Destinataire_ID au lieu de FAC_Locataire_ID OU EntitySelection des factures suivantes d'une facture sur lequel on fait un règlement
var $4 : Boolean

var $i_el : Integer
var $modifEnCascade_b; $majSoldeDu_b; $web_b : Boolean

var $facture_e : cs:C1710.FacturesEntity
var $facture_es; $factureB_es; $factureC_es : cs:C1710.FacturesSelection

Case of 
	: ($1=0)  // Obtenir le solde antérieur (Solde dû de la facture précédente)
		
		$0:=ds:C1482.Factures.get([Factures:86]ID:1).FAC_Solde_Anterieur_cal
	: ($1=1)  // Création d'une facture location (web)
		// not use
	: ($1=10)  // Création d'une facture participation/hébergement (4D)
		// not use
	: ($1=2)  // Modification d'une facture temporaire (web)
		// not use
		
	: ($1=3)  // Mise en place d'un réglement sur une facture (web)
		// not use
		$modifEnCascade_b:=True:C214
	: ($1=4)  // Ajout / Modification d'une ligne dans une facture (web)
		
		If (ds:C1482.Factures.get([Factures:86]ID:1).FAC_Solde_Du_cal<=0)
			[Factures:86]FAC_Statut:16:="Réglée"
		End if 
		
		If ([Factures:86]FAC_Type_Piece:40="location") | ([Factures:86]FAC_Type_Piece:40="mixte")
			$modifEnCascade_b:=True:C214
		End if 
		
	: ($1=30)  // Mise en place d'un réglement sur une facture (4D)
		$facture_es:=Create entity selection:C1512([Factures:86])
		$modifEnCascade_b:=True:C214
	: ($1=100)  // Recherche des factures suivantes (4D)
		$facture_es:=ds:C1482.Factures.newSelection()
		$factureB_es:=ds:C1482.Factures.query("FAC_Type_Piece = :1 AND FAC_Destinataire_ID = :2"; $2.FAC_Type_Piece; $2.FAC_Destinataire_ID)
		
		For ($i_el; $2.FAC_Annee; Year of:C25(Current date:C33))
			
			If ($i_el=$2.FAC_Annee)  // C'est la première fois qu'on passe
				
				If ($2.FAC_Mois<12)
					$factureC_es:=$factureB_es.query("FAC_Annee = :1 AND FAC_Mois > :2"; $i_el; $2.FAC_Mois)
					$facture_es:=$facture_es.or($factureC_es)
				End if 
				
			Else 
				$factureC_es:=$factureB_es.query("FAC_Annee > :1"; $2.FAC_Annee)
				$facture_es:=$facture_es.or($factureC_es)
				
				$i_el:=Year of:C25(Current date:C33)
			End if 
			
		End for 
		
		$0:=$facture_es
	: ($1=1000)  // Modif des factures suivantes
		// not use
		
End case 

$web_b:=(($1=1) | ($1=2) | ($1=3) | ($1=4))

If ($modifEnCascade_b=True:C214)
	
	If (Count parameters:C259=1)
		$majSoldeDu_b:=True:C214
	Else 
		$majSoldeDu_b:=$2
	End if 
	
End if 

Case of 
	: ($web_b=True:C214) & ($modifEnCascade_b=True:C214)
		
		// On recherche les factures suivantes
		If ($1#4) & (Count parameters:C259=3)  // Facture sur 4D
			$facture_es:=ds:C1482.Factures.query("FAC_Destinataire_ID is :1 AND FAC_Periode_Du > :2 AND FAC_Periode_Du # :3"; [Factures:86]FAC_Destinataire_ID:11; [Factures:86]FAC_Periode_Au:52; !00-00-00!).orderBy("FAC_Periode_Du asc")
		Else   // Facture sur le web
			$facture_es:=ds:C1482.Factures.query("FAC_Locataire_ID is :1 AND FAC_Periode_Du > :2 AND FAC_Periode_Du # :3"; [Factures:86]FAC_Locataire_ID:29; [Factures:86]FAC_Periode_Au:52; !00-00-00!).orderBy("FAC_Periode_Du asc")
		End if 
		
		
	: ($web_b=False:C215) & ($modifEnCascade_b=True:C214)
		$facture_es:=$facture_es.orderBy("FAC_Annee asc, FAC_Mois asc")
		
		
		For each ($facture_e; $facture_es)
			$facture_e.reload()
			
			$factureB_es:=outilsManageFacture(100; $facture_e)
			$factureB_es:=$factureB_es.orderBy("FAC_Annee asc, FAC_Mois asc")
			
			// Modifié par : Scanu Rémy (23/08/2023)
			// On ne reprenait pas le dernier solde antérieur
			$factureB_es.refresh()
		End for each 
		
End case 