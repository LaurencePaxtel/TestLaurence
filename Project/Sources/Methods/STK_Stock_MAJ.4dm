//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 07/06/2020, 12:50:36
// ----------------------------------------------------
// Method: STK_Stock_MAJ
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $id_ligne; $2; $id_equ; $3; $stkm_id; $num_table)
C_TEXT:C284($4; $stkm_nature)
C_REAL:C285($stkm_quantite; $5)
C_BOOLEAN:C305($6; $stkm_auto; $continu)
C_TEXT:C284($7; $stkm_motif; $8; $stkm_emplacement; $9; $stkm_description)
C_POINTER:C301($ptr_table; $10)

$id_ligne:=$1
$id_equ:=$2
$id_piece:=$3
$stkm_nature:=$4
$stkm_quantite:=$5
$stkm_auto:=$6
$stkm_motif:=$7
$stkm_emplacement:=$8
$stkm_description:=$9
$ptr_table:=$10

$continu:=True:C214
$num_table:=Table:C252($ptr_table)

START TRANSACTION:C239

Case of 
	: (($stkm_nature="entree") | ($stkm_nature="entrée"))
		$stkm_nature:="entrée"
	: ($stkm_nature="sortie")
		$stkm_quantite:=$stkm_quantite*-1
	: ($stkm_nature="reservation")
End case 

//-----------------------------------------------------------//
// Mouvement du stock
//-----------------------------------------------------------//
READ WRITE:C146([Stock_Mouvements:114])

If ($id_ligne#0)
	QUERY:C277([Stock_Mouvements:114]; [Stock_Mouvements:114]STKM_Ligne_ID:5=$id_ligne; *)
	QUERY:C277([Stock_Mouvements:114];  & ; [Stock_Mouvements:114]STKM_Origine_Table_No:14=$num_table)
	
	If (Records in selection:C76([Stock_Mouvements:114])=1)
		
		If (Locked:C147([Stock_Mouvements:114]))
			$continu:=False:C215
		End if 
		
	Else 
		CREATE RECORD:C68([Stock_Mouvements:114])
		MultiSoc_Init_Structure(->[Stock_Mouvements:114])
		[Stock_Mouvements:114]STKM_EQU_ID:3:=$id_equ
		[Stock_Mouvements:114]STKM_Ligne_ID:5:=$id_ligne
		[Stock_Mouvements:114]STKM_Origine_Table_No:14:=$num_table
		$stkm_id:=[Stock_Mouvements:114]ID:1
	End if 
	
Else 
	CREATE RECORD:C68([Stock_Mouvements:114])
	MultiSoc_Init_Structure(->[Stock_Mouvements:114])
	
	[Stock_Mouvements:114]STKM_EQU_ID:3:=$id_equ
	[Stock_Mouvements:114]STKM_Ligne_ID:5:=$id_ligne
	[Stock_Mouvements:114]STKM_Piece_ID:4:=$id_piece
	[Stock_Mouvements:114]STKM_Origine_Table_No:14:=$num_table
	
	$stkm_id:=[Stock_Mouvements:114]ID:1
End if 

If ($continu)
	[Stock_Mouvements:114]STKM_EQU_ID:3:=$id_equ
	
	[Stock_Mouvements:114]STKM_Date:7:=Current date:C33
	[Stock_Mouvements:114]STKM_Heure:8:=Current time:C178
	
	[Stock_Mouvements:114]STKM_Auto:12:=$stkm_auto
	[Stock_Mouvements:114]STKM_Motif:11:=$stkm_motif
	[Stock_Mouvements:114]STKM_Emplacement:13:=$stkm_emplacement
	[Stock_Mouvements:114]STKM_Description:10:=$stkm_description
	[Stock_Mouvements:114]STKM_Nature:9:=$stkm_nature
	[Stock_Mouvements:114]STKM_Quantite:6:=$stkm_quantite
	
	SAVE RECORD:C53([Stock_Mouvements:114])
	UNLOAD RECORD:C212([Stock_Mouvements:114])
	
	//-----------------------------------------------------------//
	// Stock MAJ
	//-----------------------------------------------------------//
	READ ONLY:C145([Stock_Mouvements:114])
	
	QUERY:C277([Stock_Mouvements:114]; [Stock_Mouvements:114]STKM_EQU_ID:3=$id_equ)
	MultiSoc_Filter(->[Stock_Mouvements:114])
	
	READ WRITE:C146([Stock:113])
	
	QUERY:C277([Stock:113]; [Stock:113]STK_EQU_ID:3=$id_equ)
	MultiSoc_Filter(->[Stock:113])
	
	Case of 
		: (Records in selection:C76([Stock:113])=1)
			
			If (Locked:C147([Stock:113]))
				$continu:=False:C215
			End if 
			
		: (Records in selection:C76([Stock:113])=0)
			CREATE RECORD:C68([Stock:113])
			MultiSoc_Init_Structure(->[Stock:113])
			
			[Stock:113]STK_EQU_ID:3:=$id_equ
		Else 
			DELETE SELECTION:C66([Stock:113])
			
			CREATE RECORD:C68([Stock:113])
			MultiSoc_Init_Structure(->[Stock:113])
			
			[Stock:113]STK_EQU_ID:3:=$id_equ
	End case 
	
	[Stock:113]STK_Stock:4:=Sum:C1([Stock_Mouvements:114]STKM_Quantite:6)
	[Stock:113]STK_Stock_Reserve:6:=0
	[Stock:113]STK_Stock_Disponible:5:=[Stock:113]STK_Stock:4-[Stock:113]STK_Stock_Reserve:6
	
	QUERY SELECTION:C341([Stock_Mouvements:114]; [Stock_Mouvements:114]STKM_Quantite:6<0)
	[Stock:113]STK_Stock_Sortant:8:=Sum:C1([Stock_Mouvements:114]STKM_Quantite:6)*-1
	
	SAVE RECORD:C53([Stock:113])
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