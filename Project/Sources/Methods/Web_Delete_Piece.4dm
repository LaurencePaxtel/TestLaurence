//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02/12/19, 08:37:58
// ----------------------------------------------------
// Method: Web_Piece_Delete
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Pointer
var $2 : Text

var $libelle; $Status : Text
var $id : Integer
var $continu : Boolean
var $table : Pointer
var $O_Output; $O_Data : Object

var $stop_b : Boolean
var $montant_r : Real
var $table_o; $enregistrement_o; $autreTable_o; $autreEnregistrement_o; $statut_o : Object
var $collection_c : Collection

var champRef_p : Pointer

$table:=$1
$libelle:=$2
$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $libelle; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]id")
READ WRITE:C146($table->)

If ($id#0)
	QUERY:C277($table->; champRef_p->=$id)
	
	If (Records in selection:C76($table->)=1)
		
		If (Locked:C147($table->))
			$continu:=False:C215
		End if 
		
	Else 
		$continu:=False:C215
	End if 
	
Else 
	$continu:=False:C215
End if 

If ($continu)
	
	Case of 
		: ($table=->[Factures:86])
			READ WRITE:C146([Factures_Lignes:87])
			
			QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
			MultiSoc_Filter(->[Factures_Lignes:87])
			
			If ([Factures:86]FAC_Type:21="Définitive")
				$status:="Failed"
			Else 
				DELETE RECORD:C58($table->)
				DELETE SELECTION:C66([Factures_Lignes:87])
			End if 
			
		: ($table=->[Reglements:93])
			// Modifié par : Scanu Rémy (05/07/2022)
			READ WRITE:C146([Factures:86])
			START TRANSACTION:C239
			
			$ds_o:=ds:C1482
			$ds_o.startTransaction()
			
			//===============================================//
			// IMPUTATION FACTURES : ANNULATION
			//===============================================//
			$table_o:=Create entity selection:C1512([Reglements:93])
			$enregistrement_o:=$table_o.first()
			
			UNLOAD RECORD:C212([Reglements:93])
			
			$collection_c:=Split string:C1554($enregistrement_o.REG_Origine_IDS; ";")
			outilsManageCollection(1; ->$collection_c)
			
			$montant_r:=$enregistrement_o.REG_Montant
			$autreTable_o:=ds:C1482.Factures.query("ID in :1"; $collection_c).orderBy("FAC_Annee desc, FAC_Mois desc")
			
			For each ($autreEnregistrement_o; $autreTable_o)
				
				If ($montant_r>0)
					
					If ($montant_r>=$autreEnregistrement_o.FAC_Solde_Regle)
						$montant_r:=$montant_r-$autreEnregistrement_o.FAC_Solde_Regle
						$autreEnregistrement_o.FAC_Solde_Regle:=0
					Else 
						$autreEnregistrement_o.FAC_Solde_Regle:=$autreEnregistrement_o.FAC_Solde_Regle-$montant_r
						CLEAR VARIABLE:C89($montant_r)
					End if 
					
					$autreEnregistrement_o.FAC_Statut:=""
					$autreEnregistrement_o.FAC_Regle:=False:C215
					
					$autreEnregistrement_o.save()
					
					
					Case of 
						: ($autreEnregistrement_o.FAC_Solde_Du_cal<=0)  //  réglé
							[Factures:86]FAC_Regle_Status_Color:44:=0x0044FC7B
						: (($autreEnregistrement_o.FAC_Solde_Du_cal>0) & ([Factures:86]FAC_Solde_Regle:26#[Factures:86]FAC_Montant_TTC:8)) & ([Factures:86]FAC_Solde_Regle:26>0)  // réglé partiellement
							[Factures:86]FAC_Regle_Status_Color:44:=0x00FCB944
						Else   // non réglé 
							[Factures:86]FAC_Regle_Status_Color:44:=0x00FC5944
					End case 
					
					SAVE RECORD:C53([Factures:86])
					UNLOAD RECORD:C212([Factures:86])
				End if 
				
			End for each 
			
			$enregistrement_o.reload()
			
			$statut_o:=$enregistrement_o.drop()
			$stop_b:=($statut_o.success=False:C215)
			
			If ($stop_b=True:C214)
				$status:="RecordLocked"
				
				CANCEL TRANSACTION:C241
				$ds_o.cancelTransaction()
			Else 
				VALIDATE TRANSACTION:C240
				$ds_o.validateTransaction()
			End if 
			
		Else 
			DELETE RECORD:C58($table->)
	End case 
	
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status)

$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)