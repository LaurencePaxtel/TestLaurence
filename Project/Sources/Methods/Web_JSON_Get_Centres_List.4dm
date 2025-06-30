//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 31/10/18, 01:49:38
// ----------------------------------------------------
// Méthode : Web_JSON_Get_Centres_List
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)
C_VARIANT:C1683($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_OBJECT:C1216($0)

C_TEXT:C284($typeListe_t; $titrePopup_t; $json_t)
C_LONGINT:C283($i_el; $strNum_el)
C_BOOLEAN:C305($prestation_b; $plateformeMulti_b)
C_OBJECT:C1216($retour_o)
C_COLLECTION:C1488($centre_c)

ARRAY OBJECT:C1221($centre_ao; 0)

var $hebergement_e : cs:C1710.HeberGementEntity
var $centre_es : cs:C1710.LesCentresSelection

$typeListe_t:="checkbox"
$titrePopup_t:="Les centres"

// Modifié par : Scanu Rémy (12/04/2024)
$strNum_el:=30108

// La requête provient de la fiche d'un hébergement
If (String:C10(w_visiteur.Referer)="@action=usager-fiche@")
	$hebergement_e:=ds:C1482.HeberGement.get(Num:C11(w_visiteur.RefererValue[1]))
	
	If ($hebergement_e#Null:C1517)
		
		If ($hebergement_e.HG_Nuit=True:C214)
			$strNum_el:=30112
		End if 
		
	End if 
	
End if 

Web_Champs_Ecran_Saisie($strNum_el; "Centre d'hébergement")

If (WEB_CHAMP_Titre#"")
	$titrePopup_t:=WEB_CHAMP_Titre
End if 

If (Count parameters:C259>0)
	$typeListe_t:=$1
End if 

If (Count parameters:C259>1)
	
	If (Value type:C1509($2)=Est un objet:K8:27)
		$prestation_b:=Bool:C1537($2.prestation)
		
		$plateforme_t:=String:C10($2.plateforme)
		$plateformeMulti_b:=Bool:C1537($2.plateformeMulti)
		
		If ($2.titrePopup#Null:C1517)
			$titrePopup_t:=String:C10($2.titrePopup)
		End if 
		
	Else 
		$prestation_b:=$2
	End if 
	
End if 

If (Count parameters:C259>2)
	$plateforme_t:=$3
End if 

If (Count parameters:C259>3)
	$titrePopup_t:=$4
End if 

ALL RECORDS:C47([LesCentres:9])
MultiSoc_Filter(->[LesCentres:9])

// Modifié par : Scanu Rémy (10/08/2021)
// La requête provient de la fiche d'un hébergement
If (String:C10(w_visiteur.Referer)="@action=usager-fiche@")
	$hebergement_e:=ds:C1482.HeberGement.get(Num:C11(w_visiteur.RefererValue[1]))
	
	If ($hebergement_e#Null:C1517)
		$centre_es:=ds:C1482.LesCentres.query("LC_Nom = :1"; $hebergement_e.HG_CentreNom)
		
		If ($centre_es.length=1)
			QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Prestation:55=$centre_es[0].LC_Prestation)
		End if 
		
		// Modifié par : Scanu Rémy (24/05/2024)
		QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Fermé:53=False:C215)
	Else 
		$i_el:=w_visiteur.RefererParam.indexOf("type")
		
		If ($i_el>0)
			QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Prestation:55=Not:C34(w_visiteur.RefererValue[$i_el]="hebergement"))
		End if 
		
	End if 
	
Else 
	
	If ($prestation_b)
		QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Prestation:55=True:C214)
		
		// Modifié par : Scanu Rémy (21/08/2023)
		QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Fermé:53=False:C215)
	End if 
	
	
	QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Plateforme:56=(Substring:C12($plateforme_t; 1; 4)+"@"))
	
	
End if 

ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
ARRAY OBJECT:C1221($centre_ao; Records in selection:C76([LesCentres:9]))

For ($i_el; 1; Records in selection:C76([LesCentres:9]))
	// Modifié par : Scanu Rémy (20/03/2024)
	// Inutile de faire cela...
/*
LIEN RETOUR([LesCentres]LC_RéférenceID)  // on a une sélection de centrelit
MultiSoc_Filter(->[CentresLits])
*/
	
	OB SET:C1220($centre_ao{$i_el}; "id"; [LesCentres:9]LC_RéférenceID:1)
	OB SET:C1220($centre_ao{$i_el}; "value"; [LesCentres:9]LC_Nom:4)
	OB SET:C1220($centre_ao{$i_el}; "categorie"; [LesCentres:9]LC_Categorie:101)
	OB SET:C1220($centre_ao{$i_el}; "prestation"; [LesCentres:9]LC_Prestation:55)
	NEXT RECORD:C51([LesCentres:9])
End for 

// Modifié par : Scanu Rémy (18/07/2023)
// Ajout d'un filtre par plateforme multi
If ($plateformeMulti_b=True:C214)
	$centre_c:=New collection:C1472
	
	ARRAY TO COLLECTION:C1563($centre_c; $centre_ao)
	
	$centre_c:=$centre_c.map("outilsCollectionValueByPlatform"; userPlateForme_c)
	$centre_c:=$centre_c.query("value # :1"; "valueToDelete")
	
	COLLECTION TO ARRAY:C1562($centre_c; $centre_ao)
End if 

$retour_o:=New object:C1471("title"; $titrePopup_t; "type"; $typeListe_t; "value"; "centres")
OB SET ARRAY:C1227($retour_o; "list"; $centre_ao)

$json_t:=JSON Stringify:C1217($retour_o; *)
WEB SEND TEXT:C677($json_t)

return $retour_o