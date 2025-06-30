//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 10/03/23, 14:45:06
// ----------------------------------------------------
// Méthode : Dupliquer_hebergement_field
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)

C_TEXT:C284($T_Selecteur; $T_Text_error)
C_LONGINT:C283($L_PK; $i; $L_Table; $L_Max_field; $L_Size; $L_Erreur; $L_column; $L_row)
C_BOOLEAN:C305($B_RO; $B_coche; $save_b)
C_POINTER:C301($P_LB; $P_col_check; $P_col_name; $P_col_num; $P_Tableau_objet)
C_COLLECTION:C1488($duplicateField_c; $collection_c)

ARRAY TEXT:C222($rT_Name; 0)
ARRAY INTEGER:C220($rI_Num; 0)
ARRAY BOOLEAN:C223($rB_Check; 0)
ARRAY OBJECT:C1221($rO_Duplique; 0)

$T_Selecteur:=$1

$P_LB:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "LB")
$P_col_check:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "col_check")
$P_col_name:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "col_name")
$P_col_num:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "col_num")

If (Count parameters:C259=2)
	$P_Tableau_objet:=$2
End if 

$L_PK:=Get_Primary_Key(Table:C252(->[HeberGement:5]))

Case of 
	: ($T_Selecteur="load")  // On relit l'objet ou les champs de la table, on place le tout dans une listbox (1 paramètre)
		Dupliquer_hebergement_field("get"; ->$rO_Duplique)
		
		$L_Table:=Table:C252(->[HeberGement:5])
		$L_Max_field:=Get last field number:C255($L_Table)
		
		If (Size of array:C274($rO_Duplique)=0)
			
			For ($i; 1; $L_Max_field)
				
				If (Is field number valid:C1000($L_Table; $i))
					APPEND TO ARRAY:C911($rB_Check; True:C214)  // vrai pour que la PK le soit
					APPEND TO ARRAY:C911($rT_Name; Field name:C257($L_Table; $i))
					APPEND TO ARRAY:C911($rI_Num; $i)
				End if 
				
			End for 
			
		Else 
			
			If (Size of array:C274($rO_Duplique)<$L_Max_field)
				$save_b:=True:C214
				
				$duplicateField_c:=New collection:C1472
				ARRAY TO COLLECTION:C1563($duplicateField_c; $rO_Duplique)
				
				For ($i; 1; $L_Max_field)
					
					If (Is field number valid:C1000($L_Table; $i))
						$collection_c:=$duplicateField_c.query("field = :1"; Field name:C257($L_Table; $i))
						
						If ($collection_c.length=0)
							$duplicateField_c.push(New object:C1471("field"; Field name:C257($L_Table; $i); "checked"; False:C215; "id"; $i))
						End if 
						
					End if 
					
				End for 
				
				CLEAR VARIABLE:C89($rO_Duplique)
				COLLECTION TO ARRAY:C1562($duplicateField_c; $rO_Duplique)
			End if 
			
			For ($i; 1; Size of array:C274($rO_Duplique))
				APPEND TO ARRAY:C911($rT_Name; OB Get:C1224($rO_Duplique{$i}; "field"; Est un texte:K8:3))
				APPEND TO ARRAY:C911($rB_Check; OB Get:C1224($rO_Duplique{$i}; "checked"; Est un booléen:K8:9))
				APPEND TO ARRAY:C911($rI_Num; OB Get:C1224($rO_Duplique{$i}; "id"; Est un entier long:K8:6))
			End for 
			
		End if 
		
		COPY ARRAY:C226($rB_Check; $P_col_check->)
		COPY ARRAY:C226($rT_Name; $P_col_name->)
		COPY ARRAY:C226($rI_Num; $P_col_num->)
		
		If ($save_b=True:C214)
			Dupliquer_hebergement_field("save")
		End if 
		
	: ($T_Selecteur="save")  // On place les colonnes de la listbox dans un objet (1 paramètre)
		$L_Size:=LISTBOX Get number of rows:C915($P_LB->)
		ARRAY OBJECT:C1221($rO_Duplique; $L_Size)
		
		For ($i; 1; $L_Size)
			OB SET:C1220($rO_Duplique{$i}; "field"; $P_col_name->{$i}; "checked"; $P_col_check->{$i}; "id"; $P_col_num->{$i})
		End for 
		
		Dupliquer_hebergement_field("set"; ->$rO_Duplique)
	: ($T_Selecteur="set") | ($T_Selecteur="get")  // SET : Le contenu de l'objet récupéré de la listbox est stocké dans un enregistrement || GET : Le tableau d'objet dans son enregistrement est placé dans une variable tableau objet
		
		If ([DePart2:76]Reference_ID:4#-2900)
			Dupliquer_hebergement_field("Charger_record")
		End if 
		
		If ($T_Selecteur="set")
			$B_RO:=4DTABLE_MakeRW(->[DePart2:76])
			$L_Erreur:=4DREC_Load_Record(->[DePart2:76]; ->$T_Text_error)
			
			If ($L_Erreur=1)
				COPY ARRAY:C226($P_Tableau_objet->; $rO_Duplique)
				
				OB SET ARRAY:C1227([DePart2:76]Proprietes:2; "duplique"; $rO_Duplique)
				SAVE RECORD:C53([DePart2:76])
				
				UNLOAD RECORD:C212([DePart2:76])
			End if 
			
			4DTABLE_MakeRW_Restore(->[DePart2:76]; $B_RO)
		Else 
			
			If (OB Is defined:C1231([DePart2:76]Proprietes:2; "duplique"))
				OB GET ARRAY:C1229([DePart2:76]Proprietes:2; "duplique"; $rO_Duplique)
			End if 
			
			COPY ARRAY:C226($rO_Duplique; $P_Tableau_objet->)
		End if 
		
	: ($T_Selecteur="Charger_record")
		QUERY:C277([DePart2:76]; [DePart2:76]Reference_ID:4=-2900)
		MultiSoc_Filter(->[DePart2:76])
		
		If (Records in selection:C76([DePart2:76])=0)
			CREATE RECORD:C68([DePart2:76])
			MultiSoc_Init_Structure(->[DePart2:76])
			
			[DePart2:76]Reference_ID:4:=-2900
			[DePart2:76]Label:3:="tous les champs duplicables"
			SAVE RECORD:C53([DePart2:76])
		End if 
		
	: ($T_Selecteur="liberer")
		UNLOAD RECORD:C212([DePart2:76])
	: ($T_Selecteur="reset")  // vider le champ objet
		Dupliquer_hebergement_field("Charger_record")
		
		$B_RO:=4DTABLE_MakeRW(->[DePart2:76])
		$L_Erreur:=4DREC_Load_Record(->[DePart2:76]; ->$T_Text_error)
		
		OB REMOVE:C1226([DePart2:76]Proprietes:2; "duplique")
		SAVE RECORD:C53([DePart2:76])
		UNLOAD RECORD:C212([DePart2:76])
		
		4DTABLE_MakeRW_Restore(->[DePart2:76]; $B_RO)
		Dupliquer_hebergement_field("load")
	: ($T_Selecteur="coche") | ($T_Selecteur="decoche")
		$B_coche:=($T_Selecteur="coche")
		
		For ($i; 1; Size of array:C274($P_LB->))
			
			If ($i#$L_PK)
				$P_col_check->{$i}:=$B_coche
			End if 
			
		End for 
		
	: ($T_Selecteur="check_pk")
		LISTBOX GET CELL POSITION:C971($P_LB->; $L_column; $L_row)
		
		If ($P_col_num->{$L_row}=$L_PK)
			
			If ($P_col_check->{$L_row}=False:C215)
				$P_col_check->{$L_row}:=True:C214
				BEEP:C151
			End if 
			
		End if 
		
End case 