//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 29/03/20, 08:54:27
// ----------------------------------------------------
// Method: Web_PLA_Save
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)

C_TEXT:C284($libelle; $Status; $eve_participants_ids; $checkboxRappel_t)
C_LONGINT:C283($id; $eve_user_id_selected)
C_BOOLEAN:C305($continu)
C_POINTER:C301($table)
C_OBJECT:C1216($O_Output; $O_Data)

var champID_p : Pointer

ARRAY TEXT:C222($tb_restricted; 0)
ARRAY TEXT:C222($tb_participants_ids; 0)

APPEND TO ARRAY:C911($tb_restricted; "id")
APPEND TO ARRAY:C911($tb_restricted; "eve_user_id")

$table:=$1
$libelle:=$2
$O_Output:=New object:C1471
$continu:=True:C214
$status:="Success"

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $libelle; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))
$eve_user_id_selected:=Num:C11(OB Get:C1224($O_Data; "eve_user_id_selected"; Est un texte:K8:3))

If ($eve_user_id_selected<=0)
	$eve_user_id_selected:=w_userUID
End if 

EXECUTE FORMULA:C63("champID_p:=->["+Table name:C256($table)+"]id")
READ WRITE:C146($table->)

If ($id#0)
	QUERY:C277($table->; champID_p->=$id)
	MultiSoc_Filter($table)
	
	If (Records in selection:C76($table->)=1)
		$continu:=(Not:C34(Locked:C147($table->)))
	Else 
		CLEAR VARIABLE:C89($continu)
	End if 
	
Else 
	READ ONLY:C145([INtervenants:10])
	
	QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=$eve_user_id_selected)
	MultiSoc_Filter(->[INtervenants:10])
	
	CREATE RECORD:C68($table->)
	MultiSoc_Init_Structure($table)
	
	[Events:103]EVE_User_ID:9:=$eve_user_id_selected
	[Events:103]EVE_User_NomPrenom:16:=[INtervenants:10]IN_NomPrénom:8
	$id:=champID_p->
End if 

If ($continu)
	
	// Modifié par : Scanu Rémy (11/09/2022)
	If ($O_Data.eve_rappel#Null:C1517)
		
		// Modifié par : Scanu Rémy (07/02/2023)
		Case of 
			: (Value type:C1509($O_Data.eve_rappel)=Est une collection:K8:32)
				$checkboxRappel_t:=$O_Data.eve_rappel.join(";")
			: (Value type:C1509($O_Data.eve_rappel)=Est un texte:K8:3)
				$checkboxRappel_t:=OB Get:C1224($O_Data; "eve_rappel"; Est un texte:K8:3)
		End case 
		
		[Events:103]EVE_Rappel:12:=Replace string:C233($checkboxRappel_t; ","; ";")
		OB REMOVE:C1226($O_Data; "eve_rappel")
	End if 
	
	Web_AGL_Json_To_Record($table; ->$O_Data; ->$tb_restricted)
	READ ONLY:C145([HeBerge:4])
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Events:103]EVE_HB_ID:14)
	MultiSoc_Filter(->[HeBerge:4])
	
	[Events:103]EVE_HB_NomPrenom:15:=[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4
	SAVE RECORD:C53($table->)
	
	//=======================================//
	// Liste des participants 
	//=======================================//
	$eve_participants_ids:=OB Get:C1224($O_Data; "eve_participants_ids"; Est un texte:K8:3)
	UTL_Cut_Text(->$eve_participants_ids; ->$tb_participants_ids; ",")
	
	READ WRITE:C146([Events_Details:104])
	
	QUERY:C277([Events_Details:104]; [Events_Details:104]EVD_Event_ID:3=[Events:103]ID:1)
	MultiSoc_Filter(->[Events_Details:104])
	
	DELETE SELECTION:C66([Events_Details:104])
	
	For ($i; 1; Size of array:C274($tb_participants_ids))
		QUERY:C277([Events_Details:104]; [Events_Details:104]EVD_User_ID:4=Num:C11($tb_participants_ids{$i}); *)
		QUERY:C277([Events_Details:104];  & ; [Events_Details:104]EVD_Event_ID:3=[Events:103]ID:1)
		
		Case of 
			: (Records in selection:C76([Events_Details:104])=0)
				CREATE RECORD:C68([Events_Details:104])
				MultiSoc_Init_Structure(->[Events_Details:104])
				
				[Events_Details:104]EVD_Event_ID:3:=[Events:103]ID:1
				[Events_Details:104]EVD_User_ID:4:=Num:C11($tb_participants_ids{$i})
				SAVE RECORD:C53([Events_Details:104])
			: (Records in selection:C76([Events_Details:104])=1)
			Else 
				$continu:=False:C215
		End case 
		
	End for 
	
	//=======================================//
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status; "id_event"; String:C10([Events:103]ID:1))

$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)