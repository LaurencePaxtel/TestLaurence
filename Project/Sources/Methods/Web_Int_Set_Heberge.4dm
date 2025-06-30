//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/11/18, 08:55:54
// ----------------------------------------------------
// Méthode : Web_Int_Set_Heberge
// Description
// 
//
// Paramètres
// ----------------------------------------------------

var $1 : Text

var $type; $T_Message; $Status; $hb_nom; $hb_prenom; $hb_cle; $hb_nom; $hb_prenom; $hb_telephone : Text
var $continu; $vb_OK; $update_b : Boolean
var $hb_dateneledate; $hb_datenele : Date
var $O_Output; $O_Data; $statut_o : Object

var $heberge_e : cs:C1710.HeBergeEntity

var $hebergement_e : cs:C1710.HeberGementEntity
var $hebergement_es : cs:C1710.HeberGementSelection

ARRAY TEXT:C222($tb_restricted; 0)

$type:=$1
$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; "heberge"; Est un objet:K8:27)

$hg_hb_id:=OB Get:C1224($O_Data; "hg_hb_id"; Est un texte:K8:3)

APPEND TO ARRAY:C911($tb_restricted; "id")
APPEND TO ARRAY:C911($tb_restricted; "hg_hb_id")

READ WRITE:C146([HeBerge:4])

If ($hg_hb_id#"")
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=Num:C11($hg_hb_id))
	
	If (Records in selection:C76([HeBerge:4])=1)
		
		If (Locked:C147([HeBerge:4]))
			$continu:=False:C215
		End if 
		
	Else 
		$continu:=False:C215
	End if 
	
Else 
	$hb_nom:=OB Get:C1224($O_Data; "hb_nom"; Est un texte:K8:3)
	$hb_prenom:=OB Get:C1224($O_Data; "hb_prenom"; Est un texte:K8:3)
	$hb_dateneledate:=Date:C102(OB Get:C1224($O_Data; "hb_datenele"; Est un texte:K8:3))
	
	$hb_nom:=Uppercase:C13($hb_nom)
	$hb_prenom:=Uppercase:C13($hb_prenom)
	$hb_cle:=Uut_HébergéClé(->$hb_nom; ->$hb_prenom; ->$hb_dateneledate)
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$hb_cle)
	MultiSoc_Filter(->[HeBerge:4])
	
	If (Records in selection:C76([HeBerge:4])=0)
		CREATE RECORD:C68([HeBerge:4])
		
		MultiSoc_Init_Structure(->[HeBerge:4])
		[HeBerge:4]HB_ReferenceID:1:=[HeberGement:5]HG_HB_ID:19
	Else 
		$continu:=False:C215
		$T_Message:="La clé '"+$hb_cle+"' existe déjà !"
	End if 
	
End if 

If ($continu)
	
	Case of 
		: ($type="coordonnees")
			UTL_Adresse_Gere(->[HeBerge:4]ID:65; ->[HeBerge:4])
			[Adresses:53]AD_Adresse1:16:=OB Get:C1224($O_Data; "adresse1"; Est un texte:K8:3)
			[Adresses:53]AD_Adresse2:17:=OB Get:C1224($O_Data; "adresse2"; Est un texte:K8:3)
			[Adresses:53]AD_Adresse3:18:=OB Get:C1224($O_Data; "adresse3"; Est un texte:K8:3)
			[Adresses:53]AD_Code_postal:19:=OB Get:C1224($O_Data; "codePostal"; Est un texte:K8:3)
			[Adresses:53]AD_Ville:20:=OB Get:C1224($O_Data; "ville"; Est un texte:K8:3)
			
			// Modifié par : Scanu Rémy (10/04/2024)
			// Ajout possibilité de modifier nom, prénom et date naissance de l'hébergé
			If ($O_Data.nom#Null:C1517)
				[HeBerge:4]HB_Nom:3:=Uppercase:C13(OB Get:C1224($O_Data; "nom"; Est un texte:K8:3))
			End if 
			
			If ($O_Data.prenom#Null:C1517)
				[HeBerge:4]HB_Prénom:4:=Uppercase:C13(OB Get:C1224($O_Data; "prenom"; Est un texte:K8:3))
			End if 
			
			If ($O_Data.dateNaissance#Null:C1517)
				[HeBerge:4]HB_DateNéLe:5:=Date:C102(OB Get:C1224($O_Data; "dateNaissance"; Est un texte:K8:3))
			End if 
			
			$hb_cle:=Uut_HébergéClé(->[HeBerge:4]HB_Nom:3; ->[HeBerge:4]HB_Prénom:4; ->[HeBerge:4]HB_DateNéLe:5)
			$update_b:=($hb_cle#[HeBerge:4]HB_Clé:2)
			
			If ($update_b=True:C214)
				outilsOrdaSearchSimple(->[HeBerge:4]; ->[HeBerge:4]HB_Clé:2; $hb_cle; ->$heberge_e; "first")
				$continu:=($heberge_e=Null:C1517)
				
				If ($continu=False:C215)
					OB SET:C1220($O_Output; "notificationError"; "Cette personne existe déjà, veuillez demander à votre administrateur de faire une fusion")
				End if 
				
				[HeBerge:4]HB_Clé:2:=$hb_cle
			End if 
			
			// Modifié par : Scanu Rémy (24/05/2024)
			[HeBerge:4]HB_PièceNéOu:57:=OB Get:C1224($O_Data; "lieuNaissance"; Est un texte:K8:3)
			[HeBerge:4]HB_PièceNationalité:58:=OB Get:C1224($O_Data; "nationalite"; Est un texte:K8:3)
			[HeBerge:4]HB_PièceCNI:59:=OB Get:C1224($O_Data; "numCNI"; Est un texte:K8:3)
			[HeBerge:4]HB_PiècePasseport:60:=OB Get:C1224($O_Data; "numPassport"; Est un texte:K8:3)
			
			[HeBerge:4]HB_Email:68:=OB Get:C1224($O_Data; "email"; Est un texte:K8:3)
			[HeBerge:4]HB_Telephone:66:=OB Get:C1224($O_Data; "telephone"; Est un texte:K8:3)
			SAVE RECORD:C53([Adresses:53])
		: ($type="notes")
			
			$vb_OK:=Web_User_Check_Privilege("Notes modife")
			
			[HeBerge:4]Notes:6:=OB Get:C1224($O_Data; "note_1"; Est un texte:K8:3)
			[HeBerge:4]HB_Notes2:50:=OB Get:C1224($O_Data; "note_2"; Est un texte:K8:3)
			[HeBerge:4]HB_Notes3:54:=OB Get:C1224($O_Data; "note_3"; Est un texte:K8:3)
			[HeBerge:4]HB_notes4:64:=OB Get:C1224($O_Data; "note_4"; Est un texte:K8:3)
			[HeBerge:4]HB_NotesTrans:53:=OB Get:C1224($O_Data; "note_5"; Est un texte:K8:3)
			
			If ($vb_OK)
				[HeBerge:4]HB_Maraude:41:=OB Get:C1224($O_Data; "note_6"; Est un texte:K8:3)
				[HeBerge:4]HB_Maraude2:51:=OB Get:C1224($O_Data; "note_7"; Est un texte:K8:3)
				[HeBerge:4]HB_Note_FVV:69:=OB Get:C1224($O_Data; "note_8"; Est un texte:K8:3)
			End if 
			
		: ($type="sp") | ($type="actions") | ($type="af") | ($type="usager")
			Web_AGL_Json_To_Record(->[HeBerge:4]; ->$O_Data; ->$tb_restricted)
			
		: ($type="add")
			APPEND TO ARRAY:C911($tb_restricted; "hb_cle")
			APPEND TO ARRAY:C911($tb_restricted; "hb_nom")
			APPEND TO ARRAY:C911($tb_restricted; "hb_prenom")
			APPEND TO ARRAY:C911($tb_restricted; "hb_telephone")
			
			$hb_nom:=OB Get:C1224($O_Data; "hb_nom"; Est un texte:K8:3)
			$hb_prenom:=OB Get:C1224($O_Data; "hb_prenom"; Est un texte:K8:3)
			$hb_telephone:=OB Get:C1224($O_Data; "hb_telephone"; Est un texte:K8:3)
			$hb_datenele:=Date:C102(OB Get:C1224($O_Data; "hb_datenele"; Est un texte:K8:3))
			
			[HeBerge:4]HB_Nom:3:=Uppercase:C13($hb_nom)
			[HeBerge:4]HB_Prénom:4:=Uppercase:C13($hb_prenom)
			[HeBerge:4]HB_Clé:2:=Uut_HébergéClé(->[HeBerge:4]HB_Nom:3; ->[HeBerge:4]HB_Prénom:4; ->$hb_datenele)
			[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
			[HeBerge:4]HB_FicheCrééele:46:=Current date:C33(*)
			
			// Modifié par : Scanu Rémy (06/02/2024)
			// Ajout téléphone
			[HeBerge:4]HB_Telephone:66:=$hb_telephone
			
			Web_AGL_Json_To_Record(->[HeBerge:4]; ->$O_Data; ->$tb_restricted)
	End case 
	
	If ($continu)
		SAVE RECORD:C53([HeBerge:4])
		
		If ($update_b=True:C214)
			outilsOrdaSearchSimple(->[HeberGement:5]; ->[HeberGement:5]HG_HB_ID:19; [HeBerge:4]HB_ReferenceID:1; ->$hebergement_es)
			
			For each ($hebergement_e; $hebergement_es)
				$hebergement_e.HG_Nom:=[HeBerge:4]HB_Nom:3
				$hebergement_e.HG_Prénom:=[HeBerge:4]HB_Prénom:4
				$hebergement_e.HG_DateNéLe:=[HeBerge:4]HB_DateNéLe:5
				
				$statut_o:=$hebergement_e.save()
			End for each 
			
		End if 
		
	End if 
	
	$status:="Success"
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status; "message"; $T_Message)
$T_Json:=JSON Stringify:C1217($O_Output)

WEB SEND TEXT:C677($T_Json)