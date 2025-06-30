//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 13/06/2020, 10:48:02
// ----------------------------------------------------
// Method: Web_Get_Record_Custom
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($table; $1)
C_POINTER:C301($json; $2)

$table:=$1
$json:=$2

Case of 
	: ($table=->[Equipement:107])
		
		C_TEXT:C284($json_custom)
		C_REAL:C285($stk; $stk_reserve; $stk_dispo; $stk_sortant)
		
		READ ONLY:C145([Stock:113])
		
		QUERY:C277([Stock:113]; [Stock:113]STK_EQU_ID:3=[Equipement:107]ID:1)
		MultiSoc_Filter(->[Stock:113])
		
		$stk:=0
		$stk_reserve:=0
		$stk_dispo:=0
		$stk_sortant:=0
		
		If (Records in selection:C76([Stock:113])=1)
			$stk:=[Stock:113]STK_Stock:4
			$stk_reserve:=[Stock:113]STK_Stock_Reserve:6
			$stk_dispo:=[Stock:113]STK_Stock_Disponible:5
			$stk_sortant:=[Stock:113]STK_Stock_Sortant:8
		End if 
		
		$json_custom:=$json_custom+",\"stk_stock\":"+"\""+String:C10($stk)+"\""
		$json_custom:=$json_custom+",\"stk_stock_reserve\":"+"\""+String:C10($stk_reserve)+"\""
		$json_custom:=$json_custom+",\"stk_stock_disponible\":"+"\""+String:C10($stk_dispo)+"\""
		$json_custom:=$json_custom+",\"stk_stock_sortant\":"+"\""+String:C10($stk_sortant)+"\""
		$json_custom:=$json_custom+"}"
		
		$json->:=Replace string:C233($json->; "}"; $json_custom)
		
	: ($table=->[Piece_LK_Equipement:115])
		
		C_TEXT:C284($json_custom)
		
		READ ONLY:C145([Equipement:107])
		READ ONLY:C145([Pieces:106])
		READ ONLY:C145([LesCentres:9])
		
		QUERY:C277([Equipement:107]; [Equipement:107]ID:1=[Piece_LK_Equipement:115]PLE_EQU_ID:4)
		MultiSoc_Filter(->[Equipement:107])
		
		QUERY:C277([Pieces:106]; [Pieces:106]ID:1=[Piece_LK_Equipement:115]PLE_Piece_ID:3)
		MultiSoc_Filter(->[Pieces:106])
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Pieces:106]PIE_Origine_ID:3)
		MultiSoc_Filter(->[LesCentres:9])
		
		QUERY:C277([Immeuble:105]; [Immeuble:105]ID:1=[LesCentres:9]LC_Immeuble_ID:84)
		MultiSoc_Filter(->[Immeuble:105])
		
		$json_custom:=$json_custom+",\"equ_nom\":"+"\""+[Equipement:107]EQU_Nom:4+"\""
		$json_custom:=$json_custom+",\"equ_type\":"+"\""+[Equipement:107]EQU_Type:5+"\""
		$json_custom:=$json_custom+",\"lk_equ_piece_nom\":"+"\""+[Pieces:106]PIE_Nom:4+"\""
		$json_custom:=$json_custom+",\"lk_equ_bien_nom\":"+"\""+[LesCentres:9]LC_GL_Nom_Suite:63+"\""
		$json_custom:=$json_custom+",\"lk_equ_imeuble_nom\":"+"\""+[Immeuble:105]IMM_Nom:3+"\""
		$json_custom:=$json_custom+",\"lk_equ_bien_id\":"+"\""+String:C10([LesCentres:9]ID:60)+"\""
		$json_custom:=$json_custom+",\"lk_equ_imeuble_id\":"+"\""+String:C10([Immeuble:105]ID:1)+"\""
		$json_custom:=$json_custom+"}"
		
		$json->:=Replace string:C233($json->; "}"; $json_custom)
		
	: ($table=->[Sinistres:89])
		
		C_TEXT:C284($json_custom)
		
		READ ONLY:C145([Immeuble:105])
		READ ONLY:C145([LesCentres:9])
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Sinistres:89]SIN_Origine_ID:12)
		MultiSoc_Filter(->[LesCentres:9])
		
		QUERY:C277([Immeuble:105]; [Immeuble:105]ID:1=[LesCentres:9]LC_Immeuble_ID:84)
		MultiSoc_Filter(->[Immeuble:105])
		
		If ((Records in selection:C76([Immeuble:105])=1) & (Records in selection:C76([LesCentres:9])=1))
			
			$json_custom:=$json_custom+",\"lk_imeuble_nom\":"+"\""+[Immeuble:105]IMM_Nom:3+"\""
			$json_custom:=$json_custom+",\"lk_bien_nom\":"+"\""+[LesCentres:9]LC_GL_Nom_Suite:63+"\""
			$json_custom:=$json_custom+",\"lk_imeuble_id\":"+"\""+String:C10([Immeuble:105]ID:1)+"\""
			$json_custom:=$json_custom+",\"lk_bien_id\":"+"\""+String:C10([LesCentres:9]ID:60)+"\""
			$json_custom:=$json_custom+"}"
			$json->:=Replace string:C233($json->; "}"; $json_custom)
			
		End if 
		
		
	: ($table=->[Charges:92])
		
		C_TEXT:C284($json_custom)
		
		READ ONLY:C145([Immeuble:105])
		READ ONLY:C145([LesCentres:9])
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Charges:92]CHA_Origine_ID:6)
		MultiSoc_Filter(->[LesCentres:9])
		
		QUERY:C277([Immeuble:105]; [Immeuble:105]ID:1=[LesCentres:9]LC_Immeuble_ID:84)
		MultiSoc_Filter(->[Immeuble:105])
		
		If ((Records in selection:C76([Immeuble:105])=1) & (Records in selection:C76([LesCentres:9])=1))
			
			$json_custom:=$json_custom+",\"lk_imeuble_nom\":"+"\""+[Immeuble:105]IMM_Nom:3+"\""
			$json_custom:=$json_custom+",\"lk_bien_nom\":"+"\""+[LesCentres:9]LC_GL_Nom_Suite:63+"\""
			$json_custom:=$json_custom+",\"lk_imeuble_id\":"+"\""+String:C10([Immeuble:105]ID:1)+"\""
			$json_custom:=$json_custom+",\"lk_bien_id\":"+"\""+String:C10([LesCentres:9]ID:60)+"\""
			$json_custom:=$json_custom+"}"
			$json->:=Replace string:C233($json->; "}"; $json_custom)
			
		End if 
		
End case 