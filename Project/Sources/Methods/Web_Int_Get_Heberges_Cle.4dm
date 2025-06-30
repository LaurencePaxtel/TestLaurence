//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 22/10/18, 05:09:51
// ----------------------------------------------------
// Méthode : Web_Int_Get_Heberges_Cle
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_TEXT:C284($JSON; $filtre)
C_LONGINT:C283($cle; $nombre_trouve)
C_BOOLEAN:C305($edit_b; $checkbox_b)

var $centre_e : cs:C1710.LesCentresEntity

ARRAY TEXT:C222($tb_prestation; 0)
//TABLEAU TEXTE($tb_orientation; 0)
ARRAY TEXT:C222($tb_plateforme; 0)
ARRAY TEXT:C222($tb_autresolutio; 0)

ARRAY INTEGER:C220($tb_nuitencours; 0)
ARRAY INTEGER:C220($tb_nuittotal; 0)

ARRAY LONGINT:C221($tb_hg_hb_id; 0)
ARRAY LONGINT:C221($tb_hb_referenceID; 0)

ARRAY BOOLEAN:C223($tb_cloturee; 0)

ARRAY DATE:C224($tb_date; 0)

$cle:=$1
$filtre:=$2

READ ONLY:C145([HeberGement:5])
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$cle)

If ($filtre#"")
	
	Case of 
		: ($filtre="jour")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215)
		: ($filtre="nuit")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=True:C214)
	End case 
	
End if 

ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; [HeberGement:5]HG_HeureAppel:5; <)

$nombre_trouve:=Records in selection:C76([HeberGement:5])


If ($nombre_trouve>400)
	$nombre_trouve:=400
End if 

ARRAY OBJECT:C1221($tb_result; $nombre_trouve)

//SÉLECTION VERS TABLEAU([HeberGement]HG_HB_ID; $tb_hb_referenceID; [HeberGement]HG_Date; $tb_date; [HeberGement]HG_Plateforme; $tb_plateforme; \
[HeberGement]HG_CentreNom; $tb_prestation; [HeberGement]HG_Orientation1; $tb_orientation; [HeberGement]HG_NuitenCours; \
$tb_nuitencours; [HeberGement]HG_NuitTOTAL; $tb_nuittotal; [HeberGement]HG_Cloturée; $tb_cloturee; [HeberGement]ID; $tb_hg_hb_id)

SELECTION TO ARRAY:C260([HeberGement:5]HG_HB_ID:19; $tb_hb_referenceID; [HeberGement:5]HG_Date:4; $tb_date; [HeberGement:5]HG_Plateforme:139; $tb_plateforme; \
[HeberGement:5]HG_CentreNom:62; $tb_prestation; [HeberGement:5]HG_AutreSolutio:88; $tb_autresolutio; [HeberGement:5]HG_NuitenCours:92; \
$tb_nuitencours; [HeberGement:5]HG_NuitTOTAL:93; $tb_nuittotal; [HeberGement:5]HG_Cloturée:67; $tb_cloturee; [HeberGement:5]ID:168; $tb_hg_hb_id)



For ($i; 1; $nombre_trouve)
	QUERY:C277([HeberGement:5]; [HeberGement:5]ID:168=$tb_hg_hb_id{$i})
	
	// Modifié par : Scanu Rémy (03/07/2023) et Re-modifié par : Scanu Rémy (15/02/2024)
	// Finalement on affiche les autres fiches hébergements, mais on autorise d'ouvrir uniquement celles liées à la plateforme de l'utilisateur connecté
	// Si c'est une prestation qui est affiché qui a le booléen [LesCentres]LC_Sante = Vrai, mais que l'utilisateur n'appartient pas au groupe Santé il ne peut ni la voir, ni la modifier
	$edit_b:=([HeberGement:5]HG_Plateforme:139=(Substring:C12(w_visiteur.User_Plateforme; 1; 4)+"@"))
	outilsOrdaSearchSimple(->[LesCentres:9]; ->[LesCentres:9]LC_Nom:4; $tb_prestation{$i}; ->$centre_e; "first")
	
	If ($centre_e#Null:C1517)
		
		If ($centre_e.LC_Sante=True:C214)
			$edit_b:=outilsManagePrivilege(1; "Santé"; w_userUID)
			
			If ($edit_b=False:C215)
				$tb_prestation{$i}:="XXX"
			End if 
			
		End if 
		
	End if 
	
	// Modifié par : Scanu Rémy (10/04/2024)
	// Ajout checkbox pour pouvoir éventuellement supprimer une ou plusieurs fiches hébergements
	$checkbox_b:=outilsManagePrivilege(1; "Suppression_fiches_usager"; w_userUID)
	
	If ($checkbox_b=True:C214)
		$checkbox_b:=$edit_b
	End if 
	
	OB SET:C1220($tb_result{$i}; \
		"date"; $tb_date{$i}; \
		"prestation"; $tb_prestation{$i}; \
		"Sortie"; $tb_autresolutio{$i}; \
		"reservation"; String:C10($tb_nuitencours{$i})+"/"+String:C10($tb_nuittotal{$i}); "c"; String:C10($tb_cloturee{$i}); \
		"id"; $tb_hg_hb_id{$i}; \
		"hg_hb_id"; $tb_hb_referenceID{$i}; \
		"plateforme"; $tb_plateforme{$i}; \
		"autresolution"; [HeberGement:5]HG_AutreSolutio:88; \
		"edit"; $edit_b; \
		"checkbox"; $checkbox_b)
End for 

$JSON:=JSON Stringify array:C1228($tb_result)
WEB SEND TEXT:C677($JSON)