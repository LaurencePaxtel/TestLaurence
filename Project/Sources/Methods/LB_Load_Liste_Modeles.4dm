//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 24/09/2020, 17:08:05
// ----------------------------------------------------
// Method: LB_Load_Liste_Modèles
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BLOB:C604($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($Ref_user)
C_TEXT:C284($ref_soc_active)

C_BLOB:C604($blob)

ARRAY TEXT:C222($Liste_formulaire; 0)
ARRAY TEXT:C222($Liste_ref_formulaire; 0)
ARRAY TEXT:C222($Liste_type_formulaire; 0)

$Ref_user:=$1
$ref_soc_active:=$2

// Modifié par : Scanu Rémy - remy@connect-io.fr (12/07/2021)
// Ajout des modèles entreprise
QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=$Ref_user; *)
QUERY:C277([Preferences:81];  | ; [Preferences:81]PREF_UID_user:7="")

QUERY SELECTION:C341([Preferences:81]; [Preferences:81]PREF_Type:2="Modèle de liste")

MultiSoc_Filter(->[Preferences:81])

If (Records in selection:C76([Preferences:81])#0)
	
	For ($i; 1; Records in selection:C76([Preferences:81]))
		APPEND TO ARRAY:C911($Liste_formulaire; [Preferences:81]PREF_Info_plus_2:24)
		APPEND TO ARRAY:C911($Liste_ref_formulaire; String:C10([Preferences:81]UID:1))
		APPEND TO ARRAY:C911($Liste_type_formulaire; "USR")
		
		NEXT RECORD:C51([Preferences:81])
	End for 
	
End if 

// Modèle par défaut
QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=""; *)
QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="Modèle par défaut")

MultiSoc_Filter(->[Preferences:81])

If (Records in selection:C76([Preferences:81])#0)
	
	For ($i; 1; Records in selection:C76([Preferences:81]))
		APPEND TO ARRAY:C911($Liste_formulaire; [Preferences:81]PREF_Info_plus_2:24)
		APPEND TO ARRAY:C911($Liste_ref_formulaire; [Preferences:81]UID:1)
		
		If ([Preferences:81]Ref_Structure:10#"")
			APPEND TO ARRAY:C911($Liste_type_formulaire; "ENT")
		Else 
			APPEND TO ARRAY:C911($Liste_type_formulaire; "GEN")
		End if 
		
		NEXT RECORD:C51([Preferences:81])
	End for 
	
End if 

SORT ARRAY:C229($Liste_formulaire; $Liste_ref_formulaire; $Liste_type_formulaire; >)

APPEND TO ARRAY:C911($Liste_formulaire; "Modèle par défaut")
APPEND TO ARRAY:C911($Liste_ref_formulaire; "defaut")
APPEND TO ARRAY:C911($Liste_type_formulaire; "defaut")

QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=$Ref_user; *)
QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="Modele_liste_selected")

MultiSoc_Filter(->[Preferences:81])

If (Records in selection:C76([Preferences:81])=1)
	$liste:=Find in array:C230($Liste_formulaire; [Preferences:81]PREF_Info_plus_2:24)
	
	If ($liste>0)
		$Liste_formulaire:=$liste
	Else 
		
		If (Size of array:C274($Liste_formulaire)>0)
			$Liste_formulaire:=1
		End if 
		
	End if 
	
Else 
	
	If (Size of array:C274($Liste_formulaire)>0)
		$Liste_formulaire:=1
	End if 
	
End if 

VARIABLE TO BLOB:C532($Liste_formulaire; $blob)
VARIABLE TO BLOB:C532($Liste_ref_formulaire; $blob; *)
VARIABLE TO BLOB:C532($Liste_type_formulaire; $blob; *)

$selected:=$Liste_formulaire
VARIABLE TO BLOB:C532($selected; $blob; *)

$0:=$blob