//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 27/09/2020, 08:01:28
// ----------------------------------------------------
// Method: LB_Generate_Menu_Fields
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284($prefixe; $the_nom_champs; $appel_methode_Virtuel)
C_LONGINT:C283($num_table; $ref; $champs; $longueur_prefixe; $type; $longueur; $pos)
C_BOOLEAN:C305($index; $unique; $invisible)
C_POINTER:C301($file_ptr; $ptr_champ)

ARRAY TEXT:C222(TE_recherche_champ_masque; 0)  // Update
ARRAY TEXT:C222($TA_nom_champs; 0)
ARRAY TEXT:C222($Champs_fiche; 0)
ARRAY TEXT:C222($UID_Champs_fiche; 0)

ARRAY LONGINT:C221($TE_num_table; 0)
ARRAY LONGINT:C221($TE_num_champ; 0)

$file_ptr:=$1

$prefixe:=File_abrev+"_"

$num_table:=Table:C252($file_ptr)
$champs:=Get last field number:C255($num_table)
$longueur_prefixe:=Length:C16($prefixe)

For ($num_champ; 1; $champs)
	
	If (Is field number valid:C1000($num_table; $num_champ))
		$ptr_champ:=Field:C253($num_table; $num_champ)
		GET FIELD PROPERTIES:C258($ptr_champ; $type; $longueur; $index; $unique; $invisible)
		
		$the_nom_champs:=UTL_Champ_Get_Titre($num_table; $num_champ)
		
		If ($invisible=False:C215)
			
			If (Type:C295($ptr_champ->)#Est un BLOB:K8:12)
				APPEND TO ARRAY:C911($TA_nom_champs; $the_nom_champs)
				APPEND TO ARRAY:C911($TE_num_table; $num_table)
				APPEND TO ARRAY:C911($TE_num_champ; $num_champ)
			End if 
			
		End if 
		
	End if 
	
End for 

Case of 
	: ($num_table=Table:C252(->[HeberGement:5]))
		APPEND TO ARRAY:C911($TA_nom_champs; UTL_Champ_Get_Titre(Table:C252(->[HeBerge:4]); Field:C253(->[HeBerge:4]HB_Telephone:66)))
		APPEND TO ARRAY:C911($TE_num_table; Table:C252(->[HeBerge:4]))
		APPEND TO ARRAY:C911($TE_num_champ; Field:C253(->[HeBerge:4]HB_Telephone:66))
		
		APPEND TO ARRAY:C911($TA_nom_champs; UTL_Champ_Get_Titre(Table:C252(->[HeBerge:4]); Field:C253(->[HeBerge:4]HB_FAC_Mode_Facturation:80)))
		APPEND TO ARRAY:C911($TE_num_table; Table:C252(->[HeBerge:4]))
		APPEND TO ARRAY:C911($TE_num_champ; Field:C253(->[HeBerge:4]HB_FAC_Mode_Facturation:80))
		
		APPEND TO ARRAY:C911($TA_nom_champs; UTL_Champ_Get_Titre(Table:C252(->[Participations:116]); Field:C253(->[Participations:116]PAR_Montant_Participation:18)))
		//AJOUTER À TABLEAU($TA_nom_champs; UTL_Champ_Get_Titre(Table(->[Participations]); Champ(->[ParticipationsWebBudget]totalParticipation)))
		APPEND TO ARRAY:C911($TE_num_table; Table:C252(->[Participations:116]))
		APPEND TO ARRAY:C911($TE_num_champ; Field:C253(->[Participations:116]PAR_Montant_Participation:18))
		//AJOUTER À TABLEAU($TE_num_champ; Champ(->[ParticipationsWebBudget]totalParticipation))
		
		// Modifié par : Scanu Rémy (04/11/2022)
		// Ajout des champs [LesCentres]LC_Tarif, [LesCentres]LC_Tarif_2, [LesCentres]LC_Tarif_3
		APPEND TO ARRAY:C911($TA_nom_champs; UTL_Champ_Get_Titre(Table:C252(->[LesCentres:9]); Field:C253(->[LesCentres:9]LC_Tarif:69)))
		APPEND TO ARRAY:C911($TE_num_table; Table:C252(->[LesCentres:9]))
		APPEND TO ARRAY:C911($TE_num_champ; Field:C253(->[LesCentres:9]LC_Tarif:69))
		
		APPEND TO ARRAY:C911($TA_nom_champs; UTL_Champ_Get_Titre(Table:C252(->[LesCentres:9]); Field:C253(->[LesCentres:9]LC_Tarif_2:74)))
		APPEND TO ARRAY:C911($TE_num_table; Table:C252(->[LesCentres:9]))
		APPEND TO ARRAY:C911($TE_num_champ; Field:C253(->[LesCentres:9]LC_Tarif_2:74))
		
		APPEND TO ARRAY:C911($TA_nom_champs; UTL_Champ_Get_Titre(Table:C252(->[LesCentres:9]); Field:C253(->[LesCentres:9]LC_Tarif_3:78)))
		APPEND TO ARRAY:C911($TE_num_table; Table:C252(->[LesCentres:9]))
		APPEND TO ARRAY:C911($TE_num_champ; Field:C253(->[LesCentres:9]LC_Tarif_3:78))
End case 

SORT ARRAY:C229($TA_nom_champs; $TE_num_table; $TE_num_champ; >)
$appel_methode_Virtuel:="LB_Get_Virtuel(\""

For ($i; 1; Size of array:C274($TA_nom_champs))
	
	If (($TE_num_table{$i}#-99) & ($TE_num_champ{$i}#-99))
		APPEND MENU ITEM:C411(ref_menu; $TA_nom_champs{$i})
		$ref:=($TE_num_table{$i}*10000)+$TE_num_champ{$i}
		
		SET MENU ITEM PARAMETER:C1004(ref_menu; -1; en_tete+String:C10($ref))
	Else 
		APPEND MENU ITEM:C411(ref_menu; $TA_nom_champs{$i})
		$pos:=Find in array:C230($Champs_fiche; $TA_nom_champs{$i})
		
		If ($pos>0)
			$appel:=en_tete+$appel_methode_Virtuel+$TA_nom_champs{$i}+"\";\""+$UID_Champs_fiche{$pos}+"\")"
			SET MENU ITEM PARAMETER:C1004(ref_menu; -1; $appel)
		End if 
		
	End if 
	
End for 