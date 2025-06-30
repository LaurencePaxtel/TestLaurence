//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 10/06/2020, 09:03:03
// ----------------------------------------------------
// Method: Web_GI_Save_PEQU
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($table)
C_TEXT:C284($libelle; $Status)
C_OBJECT:C1216($O_Output; $O_Data)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id; $id_table_origine; $id_previous; $num_table)

var champID_p : Pointer

$table:=->[Piece_LK_Equipement:115]
$num_table:=Table:C252($table)
$libelle:="data"
$id_table_origine:=Table:C252(->[LesCentres:9])
$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $libelle; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))
EXECUTE FORMULA:C63("champID_p:=->["+Table name:C256($table)+"]id")

READ WRITE:C146($table->)

If ($id#0)
	QUERY:C277($table->; champID_p->=$id)
	
	If (Records in selection:C76($table->)=1)
		
		If (Locked:C147($table->))
			$continu:=False:C215
		End if 
		
	Else 
		$continu:=False:C215
	End if 
	
Else 
	CREATE RECORD:C68($table->)
	MultiSoc_Init_Structure($table)
	$id:=champID_p->
End if 

If ($continu)
	
	$id_previous:=[Piece_LK_Equipement:115]ID:1
	$quantite_previous:=[Piece_LK_Equipement:115]PLE_Quantite:5
	
	ARRAY TEXT:C222($tb_restricted; 0)
	APPEND TO ARRAY:C911($tb_restricted; "id")
	
	Web_AGL_Json_To_Record($table; ->$O_Data; ->$tb_restricted)
	
	SAVE RECORD:C53($table->)
	
	//===================================================================//
	// Mise à jour du stock : Annulation du mouvement stock précédent en cas de modification du logement
	//===================================================================//
	If (($id_previous#0) & ($id_previous#[Piece_LK_Equipement:115]PLE_Piece_ID:3))
		QUERY:C277([Pieces:106]; [Pieces:106]ID:1=$id_previous)
		MultiSoc_Filter(->[Pieces:106])
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Pieces:106]PIE_Origine_ID:3)
		MultiSoc_Filter(->[LesCentres:9])
		
		READ WRITE:C146([Stock_Mouvements:114])
		
		QUERY:C277([Stock_Mouvements:114]; [Stock_Mouvements:114]STKM_Ligne_ID:5=$id_previous; *)
		QUERY:C277([Stock_Mouvements:114];  & ; [Stock_Mouvements:114]STKM_Origine_Table_No:14=$num_table)
		
		If (Records in selection:C76([Stock_Mouvements:114])=1)
			DELETE RECORD:C58([Stock_Mouvements:114])
		End if 
		
		READ ONLY:C145([Stock_Mouvements:114])
	End if 
	
	//===================================================================//
	// Mise à jour du stock
	//===================================================================//
	If ([Piece_LK_Equipement:115]PLE_Piece_ID:3>0)
		QUERY:C277([Pieces:106]; [Pieces:106]ID:1=[Piece_LK_Equipement:115]PLE_Piece_ID:3)
		MultiSoc_Filter(->[Pieces:106])
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Pieces:106]PIE_Origine_ID:3)
		MultiSoc_Filter(->[LesCentres:9])
		
		STK_Stock_MAJ([Piece_LK_Equipement:115]ID:1; [Piece_LK_Equipement:115]PLE_EQU_ID:4; [Piece_LK_Equipement:115]PLE_Piece_ID:3; "sortie"; [Piece_LK_Equipement:115]PLE_Quantite:5; True:C214; "Installation de l'équipement"; [LesCentres:9]LC_GL_Nom_Suite:63+" - "+[Pieces:106]PIE_Nom:4; ""; ->[Piece_LK_Equipement:115])
	End if 
	
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status)
$T_Json:=JSON Stringify:C1217($O_Output)

WEB SEND TEXT:C677($T_Json)