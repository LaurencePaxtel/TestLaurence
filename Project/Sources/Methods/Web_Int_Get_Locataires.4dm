//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 23-01-19, 09:44:30
// ----------------------------------------------------
// Method: Web_Int_Get_Locataires
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $data_label; $2; $type; $nom; $prenom; $lien_famille; $telephone; $usager_type; $display_type)
C_DATE:C307($date_naissance)
C_BOOLEAN:C305($query)
C_OBJECT:C1216($O_Data)

$data_label:=$1
$type:=$2
$query:=False:C215

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; $data_label; Est un objet:K8:27)

$nom:=OB Get:C1224($O_Data; "nom"; Est un texte:K8:3)
$prenom:=OB Get:C1224($O_Data; "prenom"; Est un texte:K8:3)
$lien_famille:=OB Get:C1224($O_Data; "lien_famille"; Est un texte:K8:3)
$telephone:=OB Get:C1224($O_Data; "telephone"; Est un texte:K8:3)
$date_naissance:=Date:C102(OB Get:C1224($O_Data; "date_naissance"; Est un texte:K8:3))
$usager_type:=OB Get:C1224($O_Data; "usager_type"; Est un texte:K8:3)
$display_type:=OB Get:C1224($O_Data; "display_type"; Est un texte:K8:3)



READ ONLY:C145([HeBerge:4])


$nom:=$nom+"@"
$prenom:=$prenom+"@"

If ($display_type#"default")
	
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
	
Else 
	
	If ($usager_type="locataire")  //Locataires actifs par défaut
		
		READ ONLY:C145([Locations:84])
		QUERY:C277([Locations:84]; [Locations:84]LOC_Date_Sortie:10>Current date:C33(*))
		MultiSoc_Filter(->[Locations:84])
		
		ARRAY LONGINT:C221($tb_id_tmp; 0)
		SELECTION TO ARRAY:C260([Locations:84]LOC_HB_ID:3; $tb_id_tmp)
		
		QUERY WITH ARRAY:C644([HeBerge:4]ID:65; $tb_id_tmp)
		
	Else 
		ALL RECORDS:C47([HeBerge:4])
	End if 
	
End if 

If ($usager_type="locataire")
	
	QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Locataire:71=True:C214)
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]ID:65; <)
	
	$query:=True:C214
	
End if 

If ($query)
	MultiSoc_Filter(->[HeBerge:4])
End if 
ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Nom:3; >)

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)


If ($type="all")
	$JSON:=Selection to JSON:C1234([HeBerge:4]; SelectionJson_template(->[HeBerge:4]))
Else 
	
	C_LONGINT:C283($count_fiches; $nombre_trouve)
	C_BOOLEAN:C305($locations_encours)
	
	$nombre_trouve:=Records in selection:C76([HeBerge:4])
	$locations_encours:=False:C215
	
	ARRAY OBJECT:C1221($tb_object; $nombre_trouve)
	
	ARRAY LONGINT:C221($tb_id; 0)
	ARRAY LONGINT:C221($tb_hb_referenceID; 0)
	ARRAY TEXT:C222($tb_hb_cle; 0)
	ARRAY TEXT:C222(tb_hb_clefam; 0)
	
	ARRAY TEXT:C222($tb_nom; 0)
	ARRAY TEXT:C222($tb_prenom; 0)
	ARRAY DATE:C224($tb_datenele; 0)
	ARRAY TEXT:C222($tb_type_locataire; 0)
	
	SELECTION TO ARRAY:C260([HeBerge:4]ID:65; $tb_id; [HeBerge:4]HB_ReferenceID:1; $tb_hb_referenceID; [HeBerge:4]HB_Clé:2; $tb_hb_cle; [HeBerge:4]HB_CléFam:47; tb_hb_clefam; [HeBerge:4]HB_Nom:3; $tb_nom; [HeBerge:4]HB_Prénom:4; $tb_prenom; [HeBerge:4]HB_DateNéLe:5; $tb_datenele; [HeBerge:4]HB_Type_Locataire:70; $tb_type_locataire)
	
	SET QUERY DESTINATION:C396(Vers variable:K19:4; $count_fiches)
	For ($i; 1; $nombre_trouve)
		QUERY:C277([Locations:84]; [Locations:84]LOC_Date_Sortie:10>Current date:C33(*); *)
		QUERY:C277([Locations:84];  & ; [Locations:84]LOC_HB_ID:3=$tb_id{$i})
		MultiSoc_Filter(->[Locations:84])
		$locations_encours:=False:C215
		If ($count_fiches>0)
			$locations_encours:=True:C214
		End if 
		OB SET:C1220($tb_object{$i}; "id"; $tb_id{$i}; "hb_cle"; $tb_hb_cle{$i}; "clefamille"; tb_hb_clefam{$i}; "hb_referenceid"; $tb_hb_referenceID{$i}; "locations_encours"; $locations_encours; "hb_nom"; $tb_nom{$i}; "hb_prenom"; $tb_prenom{$i}; "hb_datenele"; $tb_datenele{$i}; "hb_type_locataire"; $tb_type_locataire{$i})
		
	End for 
	SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
	
	$JSON:=JSON Stringify array:C1228($tb_object)
	
End if 



WEB SEND TEXT:C677($JSON)


