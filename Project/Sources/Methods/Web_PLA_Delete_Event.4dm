//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02/04/20, 08:51:14
// ----------------------------------------------------
// Method: Web_PLA_Delete_Event
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($table; $1)
C_TEXT:C284($data_label; $2; $T_JSON; $Status)
C_OBJECT:C1216($O_Output; $O_Data)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id; $eve_id_origine)
C_DATE:C307($eve_date_du)

var champID_p : Pointer

$table:=$1
$data_label:=$2
$O_Output:=New object:C1471
$continu:=True:C214
$status:="Failed"

EXECUTE FORMULA:C63("champID_p:=->["+Table name:C256($table)+"]id")

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; $data_label; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))
$recurring:=OB Get:C1224($O_Data; "recurring"; Est un texte:K8:3)

If ($id#0)
	
	If ($recurring="check")
		
		READ ONLY:C145([Events:103])
		READ ONLY:C145([Events_Details:104])
		
		QUERY:C277([Events:103]; [Events:103]ID:1=$id)
		MultiSoc_Filter(->[Events:103])
		
		$eve_id_origine:=[Events:103]EVE_ID_Origine:17
		$eve_date_du:=[Events:103]EVE_Date_Du:5
		
		If ($eve_id_origine#0)
			QUERY:C277([Events:103]; [Events:103]EVE_ID_Origine:17=$eve_id_origine; *)
			QUERY:C277([Events:103];  & ; [Events:103]EVE_Date_Du:5>$eve_date_du)
			MultiSoc_Filter(->[Events:103])
		Else 
			REDUCE SELECTION:C351([Events:103]; 0)
		End if 
		
		If (Records in selection:C76([Events:103])>0)
			$status:="-1"
			$continu:=False:C215
		End if 
		
	End if 
	
	If ($continu)
		
		//=================================//
		//  Suppression de l'événement courant
		//=================================//
		READ WRITE:C146([Events:103])
		READ WRITE:C146([Events_Details:104])
		
		QUERY:C277($table->; champID_p->=$id)
		
		$eve_id_origine:=[Events:103]EVE_ID_Origine:17
		$eve_date_du:=[Events:103]EVE_Date_Du:5
		
		QUERY:C277([Events_Details:104]; [Events_Details:104]EVD_Event_ID:3=[Events:103]ID:1)
		
		If (Records in selection:C76($table->)=1)
			DELETE RECORD:C58($table->)
			DELETE SELECTION:C66([Events_Details:104])
			$status:="success"
		Else 
			$continu:=False:C215
		End if 
		
		//=================================//
		//  Suppression des événements récurrents
		//=================================//
		
		If ($continu)
			If ($recurring="true")
				READ ONLY:C145([Events:103])
				READ ONLY:C145([Events_Details:104])
				
				QUERY:C277([Events:103]; [Events:103]EVE_ID_Origine:17=$eve_id_origine; *)
				QUERY:C277([Events:103];  & ; [Events:103]EVE_Date_Du:5>$eve_date_du)
				MultiSoc_Filter(->[Events:103])
				
				ARRAY LONGINT:C221($tb_ids; 0)
				SELECTION TO ARRAY:C260([Events:103]ID:1; $tb_ids)
				
				READ WRITE:C146([Events:103])
				READ WRITE:C146([Events_Details:104])
				
				QUERY WITH ARRAY:C644([Events:103]ID:1; $tb_ids)
				MultiSoc_Filter(->[Events:103])
				QUERY WITH ARRAY:C644([Events_Details:104]EVD_Event_ID:3; $tb_ids)
				MultiSoc_Filter(->[Events:103])
				
				DELETE SELECTION:C66([Events:103])
				DELETE SELECTION:C66([Events_Details:104])
			End if 
		End if 
		
	End if 
	
Else 
	$continu:=False:C215
End if 

OB SET:C1220($O_Output; "Status"; $status)
$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)
