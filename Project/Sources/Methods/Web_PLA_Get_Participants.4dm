//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 29/03/20, 11:30:54
// ----------------------------------------------------
// Method: Web_PLA_Get_Participants
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($JSON; $search_nom; $setected)
C_LONGINT:C283($i; $count; $id_selected)
C_OBJECT:C1216($O_Data)

ARRAY TEXT:C222($tb_usr_cle; 0)
ARRAY LONGINT:C221($tb_usr_ids; 0)
ARRAY BOOLEAN:C223($tb_usr_selected; 0)

READ ONLY:C145([INtervenants:10])
READ ONLY:C145([Events_Details:104])

ALL RECORDS:C47([INtervenants:10])
MultiSoc_Filter(->[INtervenants:10])

$O_Data:=Web_AGL_Get_Post_Json_Data

$search_nom:=OB Get:C1224($O_Data; "search_nom"; Est un texte:K8:3)
$id_selected:=Num:C11(OB Get:C1224($O_Data; "id_selected"; Est un texte:K8:3))

QUERY SELECTION:C341([INtervenants:10]; [INtervenants:10]IN_NomPrénom:8#"")

If ($search_nom#"")
	QUERY SELECTION:C341([INtervenants:10]; [INtervenants:10]IN_NomPrénom:8="@"+$search_nom+"@")
End if 

ORDER BY:C49([INtervenants:10]; [INtervenants:10]IN_NomPrénom:8; >)

If (Records in selection:C76([INtervenants:10])<20)
	$count:=Records in selection:C76([INtervenants:10])
Else 
	$count:=20
End if 

//==========================================//
// Héberges
//==========================================//
While (Not:C34(End selection:C36([INtervenants:10])))
	QUERY:C277([Events_Details:104]; [Events_Details:104]EVD_Event_ID:3=$id_selected; *)
	QUERY:C277([Events_Details:104];  & ; [Events_Details:104]EVD_User_ID:4=[INtervenants:10]ID:16)
	MultiSoc_Filter(->[Events_Details:104])
	
	APPEND TO ARRAY:C911($tb_usr_ids; [INtervenants:10]ID:16)
	APPEND TO ARRAY:C911($tb_usr_cle; [INtervenants:10]IN_NomPrénom:8)
	
	If (Records in selection:C76([Events_Details:104])=0)
		APPEND TO ARRAY:C911($tb_usr_selected; False:C215)
		$i:=$i+1
	Else 
		APPEND TO ARRAY:C911($tb_usr_selected; True:C214)
	End if 
	
	If ($i=$count)
		LAST RECORD:C200([INtervenants:10])
	End if 
	
	NEXT RECORD:C51([INtervenants:10])
End while 

//==========================================//
// Participants
//==========================================//
QUERY:C277([Events_Details:104]; [Events_Details:104]EVD_Event_ID:3=$id_selected)
MultiSoc_Filter(->[Events_Details:104])

While (Not:C34(End selection:C36([Events_Details:104])))
	QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=[Events_Details:104]EVD_User_ID:4)
	
	APPEND TO ARRAY:C911($tb_usr_ids; [Events_Details:104]EVD_User_ID:4)
	APPEND TO ARRAY:C911($tb_usr_cle; [INtervenants:10]IN_NomPrénom:8)
	APPEND TO ARRAY:C911($tb_usr_selected; True:C214)
	
	NEXT RECORD:C51([Events_Details:104])
End while 

//==========================================//
ARRAY OBJECT:C1221($tb_object; Size of array:C274($tb_usr_ids))

For ($i; 1; Size of array:C274($tb_usr_ids))
	
	If ($tb_usr_selected{$i})
		$setected:="selected"
	End if 
	
	OB SET:C1220($tb_object{$i}; "userid"; String:C10($tb_usr_ids{$i}); "user_nom_prenom"; $tb_usr_cle{$i}; "status"; $setected)
	CLEAR VARIABLE:C89($setected)
End for 

$JSON:=JSON Stringify array:C1228($tb_object)
WEB SEND TEXT:C677($JSON)