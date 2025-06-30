//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-11-18, 21:42:07
// ----------------------------------------------------
// Method: Web_Int_Get_Heberge
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $Status; $T_JSON : Text
var $continu : Boolean
var $O_Output; $O_Data : Object


ARRAY OBJECT:C1221($json_ao; 0)

READ ONLY:C145([HeBerge:4])
READ WRITE:C146([Adresses:53])

$O_Output:=New object:C1471
$continu:=True:C214
$status:="success"

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; "heberge"; Est un objet:K8:27)

$hg_hb_id:=OB Get:C1224($O_Data; "hg_hb_id"; Est un texte:K8:3)

If ($hg_hb_id#"")
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=Num:C11($hg_hb_id))
	MultiSoc_Filter(->[HeBerge:4])
	
	If (Records in selection:C76([HeBerge:4])=1)
		// Modifié par : Scanu Rémy (30/08/2023)
		// Ajout de l'adresse
		UTL_Adresse_Gere(->[HeBerge:4]ID:65; ->[HeBerge:4])
		SAVE RECORD:C53([Adresses:53])
		
		SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
		$T_JSON:=Selection to JSON:C1234([HeBerge:4]; SelectionJson_template(->[HeBerge:4]))
		
		JSON PARSE ARRAY:C1219($T_JSON; $json_ao)
		
		$json_ao{1}.hb_datenele:=String:C10(Date:C102($json_ao{1}.hb_datenele))
		
		$json_ao{1}.adresse1:=[Adresses:53]AD_Adresse1:16
		$json_ao{1}.adresse2:=[Adresses:53]AD_Adresse2:17
		$json_ao{1}.adresse3:=[Adresses:53]AD_Adresse3:18
		
		$json_ao{1}.codePostal:=[Adresses:53]AD_Code_postal:19
		$json_ao{1}.ville:=[Adresses:53]AD_Ville:20
		
		$T_JSON:=JSON Stringify array:C1228($json_ao)
		
		// Modifié par : Scanu Rémy (20/02/2023)
/*$O_Output:=JSON Parse($T_JSON)
JOINTURE([HeBerge]; [Note])
		
$note_es:=Créer Entity Selection([Note])*/
	Else 
		$continu:=False:C215
		$status:="failed"
	End if 
	
Else 
	$continu:=False:C215
	$status:="failed"
End if 

If ($continu=False:C215)
	OB SET:C1220($O_Output; "Status"; $status)
	$T_Json:=JSON Stringify:C1217($O_Output)
End if 

WEB SEND TEXT:C677($T_Json)