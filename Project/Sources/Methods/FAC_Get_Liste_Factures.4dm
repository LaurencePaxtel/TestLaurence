//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02/01/20, 13:51:50
// ----------------------------------------------------
// Method: FAC_Get_Liste_Factures
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $destinataire_t : Text
var $destinataireID_el; $index_el : Integer
var $table_o; $autreTable_o; $facture_o; $element_o : Object
var $liste_c; $facture_c; $reglement_c : Collection

var txt_mois_facture; txt_filtre_numero : Text
var var_total_tarif_ttc; var_total_reglements; var_total_solde_du : Real

ARRAY LONGINT:C221($factureID_ai; 0)

ARRAY TEXT:C222(tb_fac_libelle; 0)
ARRAY TEXT:C222(tb_fac_destinataire; 0)

// Modifié par : Scanu Rémy - remy@connect-io.fr (21/04/2021)
ARRAY TEXT:C222(tb_fac_usager; 0)
ARRAY TEXT:C222(tb_fac_mode_envoie; 0)

ARRAY TEXT:C222(tb_fac_type_piece; 0)
ARRAY TEXT:C222(tb_fac_numero_piece; 0)

// Modifié par : Scanu Rémy - remy@connect-io.fr (01/07/2021)
ARRAY TEXT:C222(tb_fac_numero_si_avoir; 0)

ARRAY LONGINT:C221(tb_fac_id; 0)
ARRAY LONGINT:C221(tb_fac_destinataire_id; 0)

ARRAY LONGINT:C221(tb_fac_mois; 0)
ARRAY LONGINT:C221(tb_fac_annee; 0)
ARRAY LONGINT:C221(tb_fac_color; 0)
ARRAY TEXT:C222(tb_fac_color_text; 0)

ARRAY REAL:C219(tb_fac_debit; 0)
ARRAY REAL:C219(tb_fac_credit; 0)

ARRAY DATE:C224(tb_fac_date; 0)

var $facture_e : cs:C1710.FacturesEntity
var $facture_es : cs:C1710.FacturesSelection

var $heberge_es : cs:C1710.HeBergeSelection

var $reglement_e : cs:C1710.ReglementsEntity
var $reglement_es : cs:C1710.ReglementsSelection

READ ONLY:C145([Factures:86])

$liste_c:=New collection:C1472
$facture_c:=New collection:C1472
$reglement_c:=New collection:C1472

If (Num:C11(Form:C1466.appel)=3)  // Si on provient de la liste Facture (HB ou P) on affiche directement les factures qu'on vient de générer
	
	If ([Factures:86]FAC_Type_Piece:40="HG")
		Form:C1466.appel:=1
	Else 
		Form:C1466.appel:=2
	End if 
	
Else 
	
	If (Num:C11(Form:C1466.appel)=1)
		QUERY:C277([Factures:86]; [Factures:86]FAC_Type_Piece:40="HG"; *)
	Else 
		QUERY:C277([Factures:86]; [Factures:86]FAC_Type_Piece:40="P"; *)
	End if 
	
	QUERY:C277([Factures:86];  & ; [Factures:86]FAC_Date_Piece:3>=txt_filtre_date1; *)
	QUERY:C277([Factures:86];  & ; [Factures:86]FAC_Date_Piece:3<=txt_filtre_date2; *)
	QUERY:C277([Factures:86];  & ; [Factures:86]FAC_Destinataire_Nom:13="@"+txt_filtre_nom+"@"; *)
	QUERY:C277([Factures:86];  & ; [Factures:86]FAC_Libelle:42="@"+txt_filtre_designation+"@"; *)
	QUERY:C277([Factures:86];  & ; [Factures:86]FAC_Mois_Annee:48="@"+txt_mois_facture+"@"; *)
	QUERY:C277([Factures:86];  & ; [Factures:86]FAC_No_Piece:2="@"+txt_filtre_numero+"@")
	
	If (Chk_tous=False:C215)
		QUERY SELECTION:C341([Factures:86]; [Factures:86]FAC_Regle:41=Chk_regle)
	End if 
	
	If (Chk_factures_seule=True:C214)
		QUERY SELECTION:C341([Factures:86]; [Factures:86]FAC_Montant_TTC:8>0)
	End if 
	
	If (Chk_avoirs_seule=True:C214)
		QUERY SELECTION:C341([Factures:86]; [Factures:86]FAC_Montant_TTC:8<0)
	End if 
	
End if 

$table_o:=Create entity selection:C1512([Factures:86])
$autreTable_o:=outilsOrdaSearch($table_o; "FAC_Origine_ID"; "HeBerge"; "HB_ReferenceID")

$autreTable_o:=$autreTable_o.query("HB_Nom = :1 OR HB_Prénom = :1"; "@"+txt_filtre_usager+"@")
$autreTable_o:=outilsOrdaSearch($autreTable_o; "HB_ReferenceID"; "Factures"; "FAC_Origine_ID")

$table_o:=$table_o.and($autreTable_o)

USE ENTITY SELECTION:C1513($table_o)
LOAD RECORD:C52([Factures:86])

MultiSoc_Filter(->[Factures:86])

// Modifié par : Scanu Rémy - remy@connect-io.fr (26/04/2023) et Re-modifié par : Scanu Rémy (24/08/2023)
//TRIER([Factures]; [Factures]FAC_Destinataire_Nom; >; [Factures]FAC_Date_Piece; >; [Factures]FAC_No_Piece; >)
ORDER BY:C49([Factures:86]; [Factures:86]FAC_Destinataire_Nom:13; >; [Factures:86]FAC_Annee:34; >; [Factures:86]FAC_Mois:33; >)

OBJECT SET ENTERABLE:C238(*; "@"; True:C214)
OBJECT SET ENABLED:C1123(*; "@"; True:C214)

SELECTION TO ARRAY:C260([Factures:86]ID:1; $factureID_ai)
ARRAY TO COLLECTION:C1563($liste_c; $factureID_ai; "factureID")

If (Chk_factures_seule=False:C215)  // Si on ne sélectionne pas la boite à cocher pour avoir uniquement les factures
	$facture_c:=$liste_c.copy()
	
	For each ($facture_o; $facture_c)
		$index_el:=$liste_c.indices("factureID = :1"; $facture_o.factureID)[0]
		$reglement_es:=ds:C1482.Reglements.query("REG_Origine_IDS = :1"; "@"+String:C10($facture_o.factureID)+"@").orderBy("REG_Date_Piece asc")
		
		For each ($reglement_e; $reglement_es)
			
			If ($reglement_c.indexOf($reglement_e.ID)=-1)
				$reglement_c.push($reglement_e.ID)
				$liste_c.insert($index_el+1; New object:C1471("reglement"; $reglement_e))
			End if 
			
		End for each 
		
		If (Chk_reglements_seule=True:C214)
			$liste_c.remove($index_el)
		End if 
		
	End for each 
	
End if 

For each ($element_o; $liste_c)
	
	If ($element_o.factureID#Null:C1517)  // C'est une facture
		$facture_e:=ds:C1482.Factures.get($element_o.factureID)
		$heberge_es:=ds:C1482.HeBerge.query("HB_ReferenceID is :1"; $facture_e.FAC_Origine_ID)
		
		$destinataire_t:=$facture_e.FAC_Destinataire_Nom
		$destinataireID_el:=$facture_e.FAC_Destinataire_ID
		
		APPEND TO ARRAY:C911(tb_fac_id; $facture_e.ID)
		
		APPEND TO ARRAY:C911(tb_fac_date; $facture_e.FAC_Date_Piece)
		APPEND TO ARRAY:C911(tb_fac_mois; $facture_e.FAC_Mois)
		APPEND TO ARRAY:C911(tb_fac_annee; $facture_e.FAC_Annee)
		
		APPEND TO ARRAY:C911(tb_fac_type_piece; Choose:C955($facture_e.FAC_Avoir_ID>0; "Avoir"; "Facture"))
		APPEND TO ARRAY:C911(tb_fac_numero_piece; $facture_e.FAC_No_Piece)
		
		APPEND TO ARRAY:C911(tb_fac_color; $facture_e.FAC_Regle_Status_Color)
		APPEND TO ARRAY:C911(tb_fac_color_text; "")
		APPEND TO ARRAY:C911(tb_fac_libelle; Choose:C955($facture_e.FAC_Avoir_ID>0; Replace string:C233($facture_e.FAC_No_Piece; SO_Avoir_Prefixe; "FAC"); $facture_e.FAC_Mois_Annee))
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (01/07/2021)
		If ($facture_e.FAC_Avoir_ID>0)  // Il s'agit d'un avoir
			$facture_es:=ds:C1482.Factures.query("ID is :1"; $facture_e.FAC_Avoir_ID)
			
			If ($facture_es.length>0)
				APPEND TO ARRAY:C911(tb_fac_numero_si_avoir; $facture_es[0].FAC_No_Piece)
			Else 
				APPEND TO ARRAY:C911(tb_fac_numero_si_avoir; "")
			End if 
			
		Else 
			APPEND TO ARRAY:C911(tb_fac_numero_si_avoir; "")
		End if 
		
		APPEND TO ARRAY:C911(tb_fac_debit; Choose:C955($facture_e.FAC_Avoir_ID>0; 0; $facture_e.FAC_Montant_TTC))
		APPEND TO ARRAY:C911(tb_fac_credit; Choose:C955($facture_e.FAC_Avoir_ID>0; $facture_e.FAC_Montant_TTC; 0))
		
		APPEND TO ARRAY:C911(tb_fac_mode_envoie; $facture_e.FAC_Mode_Envoie)
	Else   // C'est un réglement
		APPEND TO ARRAY:C911(tb_fac_id; $element_o.reglement.ID)
		
		APPEND TO ARRAY:C911(tb_fac_date; $element_o.reglement.REG_Date_Piece)
		APPEND TO ARRAY:C911(tb_fac_mois; 0)
		APPEND TO ARRAY:C911(tb_fac_annee; 0)
		
		APPEND TO ARRAY:C911(tb_fac_type_piece; "Règlement")
		APPEND TO ARRAY:C911(tb_fac_numero_piece; $element_o.reglement.REG_No_Piece)
		
		APPEND TO ARRAY:C911(tb_fac_color; 16777215)
		APPEND TO ARRAY:C911(tb_fac_color_text; "")
		APPEND TO ARRAY:C911(tb_fac_libelle; $element_o.reglement.REG_Mode_Reglement)
		
		APPEND TO ARRAY:C911(tb_fac_numero_si_avoir; "")
		
		APPEND TO ARRAY:C911(tb_fac_debit; 0)
		APPEND TO ARRAY:C911(tb_fac_credit; $element_o.reglement.REG_Montant)
		
		APPEND TO ARRAY:C911(tb_fac_mode_envoie; "")
		
		If (Chk_reglements_seule=True:C214)
			$facture_c:=Split string:C1554($element_o.reglement.REG_Origine_IDS; ";")
			
			$facture_es:=ds:C1482.Factures.query("ID in :1"; $facture_c).orderBy("FAC_Annee asc, FAC_Mois asc")
			$facture_e:=$facture_es.first()
			
			$destinataire_t:=$facture_e.FAC_Destinataire_Nom
			$destinataireID_el:=$facture_e.FAC_Destinataire_ID
			
			$heberge_es:=ds:C1482.HeBerge.query("HB_ReferenceID is :1"; $facture_e.FAC_Origine_ID)
		End if 
		
	End if 
	
	APPEND TO ARRAY:C911(tb_fac_destinataire; $destinataire_t)
	APPEND TO ARRAY:C911(tb_fac_destinataire_id; $destinataireID_el)
	
	If ($heberge_es.length>0)
		APPEND TO ARRAY:C911(tb_fac_usager; $heberge_es[0].HB_Nom+" "+$heberge_es[0].HB_Prénom)
	Else 
		APPEND TO ARRAY:C911(tb_fac_usager; "")
	End if 
	
End for each 

// Modifié par : Scanu Rémy (11/10/2023)
// Reset de la colonne pour sélectionner un élément dans la liste
If (Value type:C1509(tb_fac_choix)#Est une variable indéfinie:K8:13) & (Value type:C1509(tb_fac_regle_color)#Est une variable indéfinie:K8:13)
	outilsCleanVariable(->tb_fac_choix; ->tb_fac_regle_color)
End if 

ARRAY BOOLEAN:C223(tb_fac_choix; Size of array:C274(tb_fac_id))
ARRAY TEXT:C222(tb_fac_regle_color; Size of array:C274(tb_fac_id))

var_total_tarif_ttc:=Sum:C1(tb_fac_debit)
var_total_reglements:=Sum:C1(tb_fac_credit)

// Modifié par : Scanu Rémy (05/07/2022) et Re-modifié par Scanu Rémy (19/04/2023)
var_total_solde_du:=var_total_tarif_ttc-var_total_reglements

txt_titre_fenetre_facl:="Liste des factures : "+String:C10(Records in selection:C76([Factures:86]))
UNLOAD RECORD:C212([Factures:86])