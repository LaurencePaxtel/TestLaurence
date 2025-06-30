//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 09/06/2020, 11:51:31
// ----------------------------------------------------
// Method: Web_Save_Stock
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($Status)
C_OBJECT:C1216($O_Output; $O_Data)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id; $id_piece; $id_ligne)

$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; "data"; Est un objet:K8:27)

$id_piece:=Num:C11(OB Get:C1224($O_Data; "id_piece"; Est un texte:K8:3))
$id_ligne:=Num:C11(OB Get:C1224($O_Data; "id_ligne"; Est un texte:K8:3))

START TRANSACTION:C239

READ WRITE:C146([Stock_Mouvements:114])

If ($id_ligne#0)
	
	QUERY:C277([Stock_Mouvements:114]; [Stock_Mouvements:114]ID:1=$id_ligne)
	
	If (Records in selection:C76([Stock_Mouvements:114])=1)
		If (Locked:C147([Stock_Mouvements:114]))
			$continu:=False:C215
		End if 
	Else 
		$continu:=False:C215
	End if 
	
Else 
	CREATE RECORD:C68([Stock_Mouvements:114])
	MultiSoc_Init_Structure(->[Stock_Mouvements:114])
	[Stock_Mouvements:114]STKM_EQU_ID:3:=$id_piece
	$id:=[Stock_Mouvements:114]ID:1
End if 

If ($continu)
	
	//-----------------------------------------------------------//
	// Mouvement du stock
	//-----------------------------------------------------------//
	
	ARRAY TEXT:C222($tb_restricted; 0)
	APPEND TO ARRAY:C911($tb_restricted; "id")
	
	Web_AGL_Json_To_Record(->[Stock_Mouvements:114]; ->$O_Data; ->$tb_restricted)
	
	SAVE RECORD:C53([Stock_Mouvements:114])
	UNLOAD RECORD:C212([Stock_Mouvements:114])
	
	//-----------------------------------------------------------//
	// Stock 
	//-----------------------------------------------------------//
	READ ONLY:C145([Stock_Mouvements:114])
	QUERY:C277([Stock_Mouvements:114]; [Stock_Mouvements:114]STKM_EQU_ID:3=$id_piece)
	MultiSoc_Filter(->[Stock_Mouvements:114])
	
	READ WRITE:C146([Stock:113])
	QUERY:C277([Stock:113]; [Stock:113]STK_EQU_ID:3=$id_piece)
	MultiSoc_Filter(->[Stock:113])
	
	Case of 
		: (Records in selection:C76([Stock:113])=1)
			If (Locked:C147([Stock:113]))
				$continu:=False:C215
			End if 
		: (Records in selection:C76([Stock:113])=0)
			CREATE RECORD:C68([Stock:113])
			MultiSoc_Init_Structure(->[Stock:113])
			[Stock:113]STK_EQU_ID:3:=$id_piece
		Else 
			DELETE SELECTION:C66([Stock:113])
			CREATE RECORD:C68([Stock:113])
			MultiSoc_Init_Structure(->[Stock:113])
			[Stock:113]STK_EQU_ID:3:=$id_piece
	End case 
	
	[Stock:113]STK_Stock:4:=Sum:C1([Stock_Mouvements:114]STKM_Quantite:6)
	[Stock:113]STK_Stock_Reserve:6:=0
	[Stock:113]STK_Stock_Disponible:5:=[Stock:113]STK_Stock:4-[Stock:113]STK_Stock_Reserve:6
	SAVE RECORD:C53([Stock:113])
	
Else 
	$continu:=False:C215
End if 

If ($continu)
	VALIDATE TRANSACTION:C240
	$status:="Success"
Else 
	CANCEL TRANSACTION:C241
	$status:="Failed"
End if 

UNLOAD RECORD:C212([Stock:113])
UNLOAD RECORD:C212([Stock_Mouvements:114])
READ ONLY:C145([Stock:113])
READ ONLY:C145([Stock_Mouvements:114])

OB SET:C1220($O_Output; "Status"; $status)
$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)

