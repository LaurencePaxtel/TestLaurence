//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 01/04/20, 08:51:47
// ----------------------------------------------------
// Method: Web_Get_Event
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)

C_TEXT:C284($data_label; $T_JSON; $libelle_id; $mode)
C_LONGINT:C283($id; $j)
C_BOOLEAN:C305($continu; $is_user_granted)
C_POINTER:C301($table)
C_OBJECT:C1216($O_Output; $O_Data)

var champID_p : Pointer

ARRAY OBJECT:C1221($tb_object; 1)
ARRAY OBJECT:C1221($tb_privileges_config; 0)

$table:=$1
$data_label:=$2
$O_Output:=New object:C1471
$continu:=True:C214
$libelle_id:="id"

If (Count parameters:C259>2)
	$libelle_id:=$3
End if 

EXECUTE FORMULA:C63("champID_p:=->["+Table name:C256($table)+"]"+$libelle_id)

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $data_label; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

READ ONLY:C145($table->)
READ ONLY:C145([Events_Details:104])
READ ONLY:C145([HeBerge:4])
READ ONLY:C145([INtervenants:10])

If ($id#0)
	QUERY:C277($table->; champID_p->=$id)
	
	If (Records in selection:C76($table->)=1)
		
		//==========================================//
		// Privilèges 
		//==========================================//
		$mode:="readwrite"
		$is_user_granted:=True:C214
		
		If (w_userUID#[Events:103]EVE_User_ID:9)
			
			//********************************************************//
			// Autorisations
			//********************************************************//
			$is_user_granted:=False:C215
			$mode:="denied"
			
			QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=w_userUID; *)
			QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="planning_web_privileges")
			MultiSoc_Filter(->[Preferences:81])
			
			If (Records in selection:C76([Preferences:81])=1)
				OB GET ARRAY:C1229([Preferences:81]PREF_Object_Value:12; "privileges"; $tb_privileges_config)
				
				For ($j; 1; Size of array:C274($tb_privileges_config))
					
					If ($tb_privileges_config{$j}.id=String:C10([Events:103]EVE_User_ID:9))
						$mode:=$tb_privileges_config{$j}.privilege
						$is_user_granted:=True:C214
						$j:=Size of array:C274($tb_privileges_config)
					End if 
					
				End for 
				
			End if 
			
			//********************************************************//
			// Si je suis participant 
			//********************************************************//
			If (Not:C34($is_user_granted))
				QUERY:C277([Events_Details:104]; [Events_Details:104]EVD_Event_ID:3=[Events:103]ID:1; *)
				QUERY:C277([Events_Details:104];  & ; [Events_Details:104]EVD_User_ID:4=w_userUID)
				MultiSoc_Filter(->[Events_Details:104])
				
				If (Records in selection:C76([Events_Details:104])=1)
					$mode:="readonly"
				End if 
				
			End if 
			//********************************************************//
			
		End if 
		//==========================================//
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Events:103]EVE_HB_ID:14)
		MultiSoc_Filter(->[HeBerge:4])
		
		QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=[Events:103]EVE_User_ID:9)
		MultiSoc_Filter(->[INtervenants:10])
		
		$date_du_iso:=String:C10(Year of:C25([Events:103]EVE_Date_Du:5))+"-"+String:C10(Month of:C24([Events:103]EVE_Date_Du:5); "00")+"-"+String:C10(Day of:C23([Events:103]EVE_Date_Du:5); "00")
		OB SET:C1220($tb_object{1}; \
			"id"; String:C10([Events:103]ID:1); \
			"eve_date_du"; String:C10([Events:103]EVE_Date_Du:5; ISO date:K1:8); \
			"eve_date_au"; String:C10([Events:103]EVE_Date_Au:6; ISO date:K1:8); \
			"eve_heure_du"; String:C10([Events:103]EVE_Heure_Du:7; h mn:K7:2); \
			"eve_heure_au"; String:C10([Events:103]EVE_Heure_Au:8; h mn:K7:2); \
			"eve_titre"; [Events:103]EVE_Titre:3; \
			"eve_type"; [Events:103]EVE_Type:10; \
			"eve_usager_nom"; [HeBerge:4]HB_Clé:2; \
			"eve_hb_id"; [Events:103]EVE_HB_ID:14; \
			"eve_presence"; [Events:103]EVE_Presence:11; \
			"eve_rappel"; [Events:103]EVE_Rappel:12; \
			"eve_recurrence"; [Events:103]EVE_Recurrence:13; \
			"privilege"; $mode; \
			"eve_notes"; [Events:103]EVE_Notes:4; \
			"eve_owner_name"; [INtervenants:10]IN_NomPrénom:8; \
			"eve_date_du_iso"; $date_du_iso)
		
		$T_Json:=JSON Stringify array:C1228($tb_object)
	Else 
		$continu:=False:C215
	End if 
	
Else 
	$continu:=False:C215
End if 

WEB SEND TEXT:C677($T_Json)