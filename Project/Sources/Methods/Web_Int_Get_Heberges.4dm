//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 21:24:00
// ----------------------------------------------------
// Méthode : Web_Int_Get_Heberges
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_DATE:C307($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_TEXT:C284($6)
C_TEXT:C284($7)

C_TEXT:C284($nom; $prenom; $lien_famille; $telephone; $type; $filtre)
C_LONGINT:C283($count_fiches; $nombre_trouve)
C_BOOLEAN:C305($query; $noteSP_b)
C_DATE:C307($date_naissance)

var $heberge_e : cs:C1710.HeBergeEntity

ARRAY TEXT:C222($tb_hb_cle; 0)
ARRAY TEXT:C222(tb_hb_clefam; 0)

ARRAY LONGINT:C221($tb_id; 0)
ARRAY LONGINT:C221($tb_hb_referenceID; 0)

READ ONLY:C145([HeBerge:4])

$nom:=$1
$prenom:=$2
$date_naissance:=$3
$lien_famille:=$4
$telephone:=$5
$type:=$6

If (Count parameters:C259>6)
	$filtre:=$7
End if 

If ($nom#"")
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Nom:3=$nom+"@")
	$query:=True:C214
End if 

If ($prenom#"")
	
	If ($query)
		QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Prénom:4=$prenom+"@")
	Else 
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Prénom:4=$prenom+"@")
		
		$query:=True:C214
	End if 
	
End if 

If ($date_naissance#!00-00-00!)
	
	If ($query)
		QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_DateNéLe:5=$date_naissance)
	Else 
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_DateNéLe:5=$date_naissance)
		
		$query:=True:C214
	End if 
	
End if 

If ($telephone#"")
	
	If ($query)
		QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Telephone:66=$telephone)
	Else 
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Telephone:66=$telephone)
	End if 
	
End if 

If ($lien_famille#"")
	CREATE SET:C116([HeBerge:4]; "$avantRecherche")
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FamClé:104=$lien_famille)
	RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
	
	CREATE SET:C116([HeBerge:4]; "$apresRecherche")
	
	If ($query)
		INTERSECTION:C121("$avantRecherche"; "$apresRecherche"; "$apresRecherche")
		USE SET:C118("$apresRecherche")
	Else 
		$query:=True:C214
	End if 
	
	CLEAR SET:C117("$avantRecherche")
	CLEAR SET:C117("$apresRecherche")
End if 

If ($query)
	MultiSoc_Filter(->[HeBerge:4])
End if 

ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)

SET DATABASE PARAMETER:C642(Dates inside objects:K37:73; String type without time zone:K37:86)

If ($type="all")
	$JSON:=Selection to JSON:C1234([HeBerge:4]; SelectionJson_template(->[HeBerge:4]))
Else 
	$nombre_trouve:=Records in selection:C76([HeBerge:4])
	
	ARRAY OBJECT:C1221($compte_hebergement; $nombre_trouve)
	SELECTION TO ARRAY:C260([HeBerge:4]ID:65; $tb_id; [HeBerge:4]HB_ReferenceID:1; $tb_hb_referenceID; [HeBerge:4]HB_Clé:2; $tb_hb_cle; [HeBerge:4]HB_CléFam:47; tb_hb_clefam)
	
	For ($i; 1; $nombre_trouve)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$tb_hb_referenceID{$i})
		
		If ($filtre#"")
			
			Case of 
				: ($filtre="jour")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215)
				: ($filtre="nuit")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=True:C214)
				Else 
					// rien
			End case 
			
		End if 
		
		MultiSoc_Filter(->[HeberGement:5])
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
		
		$heberge_e:=ds:C1482.HeBerge.get($tb_id{$i})
		
		If ($heberge_e.HB_Cas1=True:C214) | ($heberge_e.HB_Cas2=True:C214) | ($heberge_e.HB_Cas3=True:C214) | ($heberge_e.HB_Cas4=True:C214) | \
			($heberge_e.HB_Cas5=True:C214) | ($heberge_e.HB_Cas6=True:C214) | ($heberge_e.HB_Cas7=True:C214) | ($heberge_e.HB_Cas8=True:C214) | \
			($heberge_e.HB_Cas9=True:C214) | ($heberge_e.HB_Cas10=True:C214)
			$noteSP_b:=True:C214
		End if 
		
		$count_fiches:=Records in selection:C76([HeberGement:5])
		OB SET:C1220($compte_hebergement{$i}; "id"; $tb_id{$i}; \
			"hb_cle"; $tb_hb_cle{$i}; \
			"clefamille"; [HeberGement:5]HG_FamClé:104; \
			"hb_referenceid"; $tb_hb_referenceID{$i}; \
			"count_fiches"; $count_fiches; \
			"noteSP"; $noteSP_b; \
			"isFamChief"; False:C215)
		
		CLEAR VARIABLE:C89($noteSP_b)
	End for 
	
	$JSON:=JSON Stringify array:C1228($compte_hebergement)
End if 

WEB SEND TEXT:C677($JSON)