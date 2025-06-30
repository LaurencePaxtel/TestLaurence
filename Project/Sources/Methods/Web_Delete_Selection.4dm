//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 27/10/2020, 08:58:52
// ----------------------------------------------------
// Method: Web_Delete_Selection
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Pointer

var $Status; $ids : Text
var $total_after; $total_before; $i_el : Integer
var $continu : Boolean
var $O_Output; $O_Data; $table_o : Object
var $table; $table_lignes; $field_lk : Pointer

var champRef_p : Pointer

ARRAY TEXT:C222($tb_ids; 0)
ARRAY LONGINT:C221($tableau_ai; 0)

$table:=$1

If (Count parameters:C259>1)
	$table_lignes:=$2
	$field_lk:=$3
End if 

$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data
$ids:=OB Get:C1224($O_Data; "ids"; Est un texte:K8:3)

EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]id")
READ WRITE:C146($table->)

If (Count parameters:C259>1)
	READ WRITE:C146($table_lignes->)
End if 

UTL_Cut_Text(->$ids; ->$tb_ids; ";")

ARRAY LONGINT:C221($tb_ids_num; Size of array:C274($tb_ids))

For ($j; 1; Size of array:C274($tb_ids))
	$tb_ids_num{$j}:=Num:C11($tb_ids{$j})
End for 

START TRANSACTION:C239

If (Size of array:C274($tb_ids_num)>0)
	QUERY WITH ARRAY:C644(champRef_p->; $tb_ids_num)
	MultiSoc_Filter($table)
	
	Case of 
		: ($table=->[Factures:86])
			$total_before:=Records in selection:C76([Factures:86])
			
			If (Session:C1714.storage.intervenant.Login#"*Administrateur") & (Session:C1714.storage.intervenant.Login#"Admin@")
				QUERY SELECTION:C341([Factures:86]; [Factures:86]FAC_No_Piece:2="")
			End if 
			
			$total_after:=Records in selection:C76([Factures:86])
			
			If ($total_before#$total_after)
				
				// On regarde si la sélection ne contient que des factures définitives
				If ($total_before>0) & ($total_after=0)
					$status:="-2"
				End if 
				
			End if 
			
	End case 
	
	If ($continu)
		
		If ($table=->[Factures:86])
			SELECTION TO ARRAY:C260([Factures:86]ID:1; $tableau_ai)
		End if 
		
		DELETE SELECTION:C66($table->)
		USE SET:C118("LockedSet")
		
		If (Records in set:C195("LockedSet")>0)
			$continu:=False:C215
		End if 
		
		If (Count parameters:C259>1)
			QUERY WITH ARRAY:C644($field_lk->; $tb_ids_num)
			MultiSoc_Filter($table_lignes)
			
			DELETE SELECTION:C66($table_lignes->)
			USE SET:C118("LockedSet")
			
			If (Records in set:C195("LockedSet")>0)
				$continu:=False:C215
			End if 
			
		End if 
		
	End if 
	
Else 
	$continu:=False:C215
End if 

If ($continu)
	VALIDATE TRANSACTION:C240
	
	// Modifié par : Scanu Rémy (02/09/2021)
	// A la suppression d'une facture, on doit supprimer les réglements liés
	If ($table=->[Factures:86])
		READ WRITE:C146([Reglements:93])
		
		For ($i_el; 1; Size of array:C274($tableau_ai))
			$table_o:=ds:C1482.Reglements.query("REG_Origine_IDS = :1"; "@"+String:C10($tableau_ai{$i_el})+"@")
			
			If ($table_o.length>0)  // On trouve des réglements qui sont en rapport avec une des factures que l'utilisateur à supprimer
				
				For each ($enregistrement_o; $table_o)
					
					If (Position:C15(";"; $enregistrement_o.REG_Origine_IDS)>0)  // Réglement qui à régler plusieurs factures
						
						If (Position:C15(String:C10($tableau_ai{$i_el})+";"; $enregistrement_o.REG_Origine_IDS)>0)
							$enregistrement_o.REG_Origine_IDS:=Replace string:C233($enregistrement_o.REG_Origine_IDS; String:C10($tableau_ai{$i_el})+";"; "")
						Else 
							$enregistrement_o.REG_Origine_IDS:=Replace string:C233($enregistrement_o.REG_Origine_IDS; String:C10($tableau_ai{$i_el}); "")
						End if 
						
						If ($enregistrement_o.REG_Origine_IDS="")
							$enregistrement_o.drop()
						Else 
							$enregistrement_o.save()
						End if 
						
					Else   // Réglement qui ne règle qu'une facture
						$enregistrement_o.drop()
					End if 
					
				End for each 
				
			End if 
			
		End for 
		
	End if 
	
Else 
	CANCEL TRANSACTION:C241
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status)

$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)