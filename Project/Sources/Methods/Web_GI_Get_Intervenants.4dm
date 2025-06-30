//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 13/06/2020, 15:13:33
// ----------------------------------------------------
// Method: Web_GI_Get_Intervenants
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($JSON; $search_nom; $setected)
C_LONGINT:C283($i; $count; $id_selected)
C_OBJECT:C1216($O_Data)

ARRAY TEXT:C222($tb_usr_nomprenom; 0)
ARRAY TEXT:C222($tb_usr_societe; 0)

ARRAY LONGINT:C221($tb_usr_ids; 0)
ARRAY BOOLEAN:C223($tb_usr_selected; 0)

READ ONLY:C145([GI_Intervenants:110])
READ ONLY:C145([GI_LK_Intervenants:112])

ALL RECORDS:C47([GI_Intervenants:110])
MultiSoc_Filter(->[GI_Intervenants:110])

$O_Data:=Web_AGL_Get_Post_Json_Data

$search_nom:=OB Get:C1224($O_Data; "search_nom"; Est un texte:K8:3)
$id_selected:=Num:C11(OB Get:C1224($O_Data; "id_selected"; Est un texte:K8:3))

QUERY SELECTION:C341([GI_Intervenants:110]; [GI_Intervenants:110]GII_NomPrenom:6#"")

If ($search_nom#"")
	QUERY SELECTION:C341([GI_Intervenants:110]; [GI_Intervenants:110]GII_NomPrenom:6="@"+$search_nom+"@")
End if 

ORDER BY:C49([GI_Intervenants:110]; [GI_Intervenants:110]GII_NomPrenom:6; >)

If (Records in selection:C76([GI_Intervenants:110])<20)
	$count:=Records in selection:C76([GI_Intervenants:110])
Else 
	$count:=20
End if 

//==========================================//
// Intervenants : Tous
//==========================================//
While (Not:C34(End selection:C36([GI_Intervenants:110])))
	QUERY:C277([GI_LK_Intervenants:112]; [GI_LK_Intervenants:112]GLK_Intervention_ID:3=$id_selected; *)
	QUERY:C277([GI_LK_Intervenants:112];  & ; [GI_LK_Intervenants:112]GLK_Intervenant_ID:4=[GI_Intervenants:110]ID:1)
	
	MultiSoc_Filter(->[GI_LK_Intervenants:112])
	
	APPEND TO ARRAY:C911($tb_usr_ids; [GI_Intervenants:110]ID:1)
	APPEND TO ARRAY:C911($tb_usr_nomprenom; [GI_Intervenants:110]GII_NomPrenom:6)
	APPEND TO ARRAY:C911($tb_usr_societe; [GI_Intervenants:110]GII_Societe:5)
	
	If (Records in selection:C76([GI_LK_Intervenants:112])=0)
		APPEND TO ARRAY:C911($tb_usr_selected; False:C215)
		
		$i:=$i+1
	Else 
		APPEND TO ARRAY:C911($tb_usr_selected; True:C214)
	End if 
	
	If ($i=$count)
		LAST RECORD:C200([GI_Intervenants:110])
	End if 
	
	NEXT RECORD:C51([GI_Intervenants:110])
End while 

//==========================================//
// Intervenants : Participants
//==========================================//
QUERY:C277([GI_LK_Intervenants:112]; [GI_LK_Intervenants:112]GLK_Intervention_ID:3=$id_selected)
MultiSoc_Filter(->[GI_LK_Intervenants:112])

While (Not:C34(End selection:C36([GI_LK_Intervenants:112])))
	QUERY:C277([GI_Intervenants:110]; [GI_Intervenants:110]ID:1=[GI_LK_Intervenants:112]GLK_Intervention_ID:3)
	
	APPEND TO ARRAY:C911($tb_usr_ids; [GI_LK_Intervenants:112]GLK_Intervenant_ID:4)
	APPEND TO ARRAY:C911($tb_usr_nomprenom; [GI_Intervenants:110]GII_NomPrenom:6)
	APPEND TO ARRAY:C911($tb_usr_societe; [GI_Intervenants:110]GII_Societe:5)
	APPEND TO ARRAY:C911($tb_usr_selected; True:C214)
	
	NEXT RECORD:C51([GI_LK_Intervenants:112])
End while 

//==========================================//
ARRAY OBJECT:C1221($tb_object; Size of array:C274($tb_usr_ids))

For ($i; 1; Size of array:C274($tb_usr_ids))
	
	If ($tb_usr_selected{$i})
		$setected:="selected"
	End if 
	
	OB SET:C1220($tb_object{$i}; "userid"; String:C10($tb_usr_ids{$i}); "user_nom_prenom"; $tb_usr_nomprenom{$i}; "usr_societe"; $tb_usr_societe{$i}; "status"; $setected)
	CLEAR VARIABLE:C89($setected)
End for 

$JSON:=JSON Stringify array:C1228($tb_object)
WEB SEND TEXT:C677($JSON)