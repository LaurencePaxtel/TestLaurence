//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 22/09/2020, 09:58:23
// ----------------------------------------------------
// Method: UTL_Champ_Get_Titre
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_TEXT:C284($titre)
C_LONGINT:C283($num_table; $num_field)
C_POINTER:C301($ptr_table)

$num_table:=$1
$num_field:=$2

$ptr_table:=Table:C252($num_table)
$titre:=Field name:C257($num_table; $num_field)

Case of 
	: ($ptr_table=->[HeberGement:5])
		
		If (Application type:C494#4D Server:K5:6)
			
			If (Undefined:C82(<>UTL_tt_Champ_Titre_val))
				ARRAY TEXT:C222(<>UTL_tt_Champ_Titre_val; 0)
				ARRAY INTEGER:C220(<>UTL_tt_Champ_Titre_RubNuméro; 0)
			End if 
			
			If (Size of array:C274(<>UTL_tt_Champ_Titre_val)=0) | (Windows Alt down:C563)
				READ ONLY:C145([LesRubriques:21])
				
				QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8); *)
				QUERY:C277([LesRubriques:21];  & [LesRubriques:21]Ref_Structure:17=<>ref_soc_active)
				
				SELECTION TO ARRAY:C260([LesRubriques:21]RubNomNew:13; <>UTL_tt_Champ_Titre_val; [LesRubriques:21]RubNuméro:4; <>UTL_tt_Champ_Titre_RubNuméro)
			End if 
			
			$vl_ligne:=Find in array:C230(<>UTL_tt_Champ_Titre_RubNuméro; $num_field)
			
			If ($vl_ligne>0)
				
				If (<>UTL_tt_Champ_Titre_val{$vl_ligne}#"")
					$titre:=<>UTL_tt_Champ_Titre_val{$vl_ligne}
				End if 
				
			End if 
			
		Else 
			READ ONLY:C145([LesRubriques:21])
			
			QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8); *)
			QUERY:C277([LesRubriques:21];  & ; [LesRubriques:21]RubNuméro:4=$num_field)
			
			MultiSoc_Filter(->[LesRubriques:21])
			
			If (Records in selection:C76([LesRubriques:21])=1)
				
				If ([LesRubriques:21]RubNomNew:13#"")
					$titre:=[LesRubriques:21]RubNomNew:13
				End if 
				
			End if 
			
		End if 
		
End case 

$0:=$titre