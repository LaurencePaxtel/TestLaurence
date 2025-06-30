//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 08/12/18, 22:03:11
// ----------------------------------------------------
// Méthode : Web_Get_Record_Data
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Pointer
var $2 : Text
var $3 : Text
var $4 : Boolean

var $data_label; $JSON; $JSONB_t; $libelle_id : Text
var $continu; $manual : Boolean
var $table : Pointer
var $O_Output; $O_Data : Object
var $collection_c; $collectionB_c : Collection
var $id : Variant

var $centre_e : cs:C1710.LesCentresEntity

var champRef_p : Pointer

$table:=$1
$data_label:=$2

$O_Output:=New object:C1471
$continu:=True:C214

$libelle_id:="id"

If (Count parameters:C259>2)
	
	If ($3#"")
		$libelle_id:=$3
	End if 
	
End if 

If (Count parameters:C259>3)
	$manual:=$4
End if 

$JSON:=Selection to JSON:C1234($table->; SelectionJson_template($table))
EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]"+$libelle_id)

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $data_label; Est un objet:K8:27)

If ($libelle_id="UUID")
	$id:=OB Get:C1224($O_Data; "id"; Est un texte:K8:3)
Else 
	$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))
End if 

READ ONLY:C145($table->)

QUERY:C277($table->; champRef_p->=$id)

If (Records in selection:C76($table->)=1)
	
	If ($table=->[EquipementBien:125])
		RELATE ONE SELECTION:C349([EquipementBien:125]; [Equipement:107])
		$table:=->[Equipement:107]
	End if 
	
	If (Not:C34($manual))
		SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
		$JSON:=Selection to JSON:C1234($table->; SelectionJson_template($table))
	Else 
		$JSON:="["
		
		$o_data_record:=Web_UTL_Record_To_JSON($table)
		$JSON:=$JSON+JSON Stringify:C1217($o_data_record)
		
		Web_Get_Record_Custom($table; ->$JSON)
		$JSON:=$JSON+"]"
		
		If ($table=->[Equipement:107])
			$JSONB_t:=Selection to JSON:C1234($table->; SelectionJson_template(->[EquipementBien:125]))
			
			$collection_c:=JSON Parse:C1218($JSON)
			$collectionB_c:=JSON Parse:C1218($JSONB_t)
			
			$collectionB_c[0].biennom:=""
			$centre_e:=ds:C1482.LesCentres.get([EquipementBien:125]bienID:3)
			
			If ($centre_e#Null:C1517)
				$collectionB_c[0].biennom:=$centre_e.LC_Nom
			End if 
			
			$collectionB_c[0].dateinstallation:=String:C10($collectionB_c[0].dateinstallation)
			$collection_c[0]:=outilsObjectMerge($collection_c[0]; $collectionB_c[0])
			$JSON:=JSON Stringify:C1217($collection_c)
		End if 
		
	End if 
	
Else 
	$continu:=False:C215
End if 

WEB SEND TEXT:C677($JSON)