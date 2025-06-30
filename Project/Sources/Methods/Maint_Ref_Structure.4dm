//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 30/08/18, 04:35:22
// ----------------------------------------------------
// Méthode : Maint_Ref_Structure
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Pointer

var $refSocActive_t : Text
var $stop_b : Boolean
var $table_p : Pointer

var champRef_p : Pointer

$table_p:=$1

If (MultiSoc_Is_Table_Multi($table_p)=False:C215)
	$refSocActive_t:=<>ref_soc_active
	
	READ WRITE:C146($table_p->)
	ALL RECORDS:C47($table_p->)
	
	// Modifié par : Scanu Rémy (22/07/2022) et Re-modifié par Scanu Rémy (20/12/2022)
	// Ajout cas particulier pour la table PAGEWEB || Finalement on part sur une méthode plus générique
	$stop_b:=(outilsTableCheckIfFieldExist($table_p; "structureRef")=False:C215) & (outilsTableCheckIfFieldExist($table_p; "Ref_Structure")=False:C215)
	
	Case of 
		: ($stop_b=True:C214)
		: (outilsTableCheckIfFieldExist($table_p; "structureRef")=True:C214)
			EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table_p)+"]structureRef")
		Else 
			EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table_p)+"]Ref_Structure")
	End case 
	
	If ($stop_b=False:C215)
		
		// Modifié par : Scanu Rémy (05/05/2023)
		QUERY:C277($table_p->; champRef_p->=""; *)
		QUERY:C277($table_p->;  | ; champRef_p->="TMP")
		
		UTL_Fenetre(500; 250; 0; "Traitement en cours...")
		
		While (Not:C34(End selection:C36($table_p->)))
			
			If (Mod:C98(Selected record number:C246($table_p->); 100)=0)
				MESSAGE:C88(Table name:C256($table_p)+" "+String:C10(Selected record number:C246($table_p->))+" / "+String:C10(Records in selection:C76($table_p->)))
			End if 
			
			champRef_p->:=$refSocActive_t
			
			SAVE RECORD:C53($table_p->)
			NEXT RECORD:C51($table_p->)
		End while 
		
	End if 
	
	CLOSE WINDOW:C154
End if 