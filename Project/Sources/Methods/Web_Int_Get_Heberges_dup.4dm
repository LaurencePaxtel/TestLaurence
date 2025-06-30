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

C_TEXT:C284($1; $nom; $2; $prenom; $4; $lien_famille; $5; $telephone; $6; $type)
C_DATE:C307($3; $date_naissance)
C_BOOLEAN:C305($query)


$nom:=$1
$prenom:=$2
$date_naissance:=$3
$lien_famille:=$4
$telephone:=$5
$type:=$6
$query:=False:C215

READ ONLY:C145([HeBerge:4])

If ($nom#"")
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Nom:3=$nom)
	$query:=True:C214
End if 

If ($prenom#"")
	If ($query)
		QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Prénom:4=$prenom)
	Else 
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Prénom:4=$prenom)
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

If ($lien_famille#"")
	//QUERY SELECTION([HeBerge];[HeBerge]HB_Prénom=$lien_famille)
End if 

If ($telephone#"")
	If ($query)
		QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Prénom:4=$telephone)
	Else 
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Prénom:4=$telephone)
	End if 
End if 

If ($query)
	MultiSoc_Filter(->[HeBerge:4])
End if 

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)


If ($type="aldl")
	$JSON:=Selection to JSON:C1234([HeBerge:4]; SelectionJson_template(->[HeBerge:4]))
Else 
	
	C_LONGINT:C283($count_fiches; $nombre_trouve)
	
	$nombre_trouve:=Records in selection:C76([HeBerge:4])
	
	ARRAY OBJECT:C1221($compte_hebergement; $nombre_trouve)
	
	ARRAY LONGINT:C221($tb_id; 0)
	ARRAY LONGINT:C221($tb_hb_referenceID; 0)
	ARRAY TEXT:C222($tb_hb_cle; 0)
	ARRAY TEXT:C222(tb_hb_clefam; 0)
	
	SELECTION TO ARRAY:C260([HeBerge:4]ID:65; $tb_id; [HeBerge:4]HB_ReferenceID:1; $tb_hb_referenceID; [HeBerge:4]HB_Clé:2; $tb_hb_cle; [HeBerge:4]HB_CléFam:47; tb_hb_clefam)
	
	SET QUERY DESTINATION:C396(Vers variable:K19:4; $count_fiches)
	For ($i; 1; $nombre_trouve)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$tb_hb_referenceID{$i})
		MultiSoc_Filter(->[HeberGement:5])
		OB SET:C1220($compte_hebergement{$i}; "id"; $tb_id{$i}; "hb_cle"; $tb_hb_cle{$i}; "clefamille"; tb_hb_clefam{$i}; "hb_referenceid"; $tb_hb_referenceID{$i}; "count_fiches"; $count_fiches)
	End for 
	SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
	
	$JSON:=JSON Stringify array:C1228($compte_hebergement)
	
End if 

C_OBJECT:C1216($O_Output)
$O_Output:=New object:C1471
OB SET ARRAY:C1227($O_Output; "data"; $compte_hebergement)
$JSON:=JSON Stringify:C1217($O_Output)


//C_OBJECT($O_Output)
//$O_Output:=New object
//OB SET ($O_Output;"data";$JSON)
//$JSON:=JSON Stringify($O_Output)

WEB SEND TEXT:C677($JSON)


