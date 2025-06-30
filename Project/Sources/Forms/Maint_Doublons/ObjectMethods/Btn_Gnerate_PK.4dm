// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 27/08/18, 17:05:11
// ----------------------------------------------------
// Méthode : Maint_Doublons.Btn_Gnerate_PK
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_LONGINT:C283($i; $compteur; $fiches_traitees; $total; $id_previous; $fiches_modifiees)

$compteur:=0
$fiches_traitees:=0
$fiches_modifiees:=0

UTL_Fenetre(500; 250; 0; "Correction des doublons encours...")

For ($i; 1; Size of array:C274(tb_tables))
	
	$table:=tb_tables{$i}
	$primary_key:=tb_champ_uid{$i}
	
	GOTO XY:C161(2; 2)
	MESSAGE:C88("Table "+tb_table_name{$i})
	
	If (tb_doublons_exist{$i}=True:C214)
		
		READ WRITE:C146($table->)
		
		QUERY WITH ARRAY:C644($primary_key->; tab_primary_key)
		ORDER BY:C49($table->; $primary_key->; >)
		
		$total:=Records in selection:C76($table->)
		
		$compteur:=0
		$id_previous:=0
		
		While (Not:C34(End selection:C36($table->)))
			
			$fiches_traitees:=$fiches_traitees+1
			
			GOTO XY:C161(2; 2)
			MESSAGE:C88("Table "+tb_table_name{$i})
			GOTO XY:C161(2; 3)
			MESSAGE:C88("Total : "+String:C10($total))
			GOTO XY:C161(2; 4)
			MESSAGE:C88("Traitement des fiches : "+String:C10($fiches_traitees))
			GOTO XY:C161(2; 5)
			MESSAGE:C88("Progression : "+String:C10(Round:C94(($fiches_traitees*100)/Records in selection:C76($table->); 0))+"%")
			
			If ($primary_key->=$id_previous)
				
				Case of 
					: (tb_method_spec{$i}="Uut_Numerote")
						$compteur:=Uut_Numerote($table)
						
					Else 
						$compteur:=$compteur+1
				End case 
				
				$id_previous:=$primary_key->
				
				tb_field_save{$i}->:=$primary_key->
				$primary_key->:=$compteur
				SAVE RECORD:C53($table->)
				
				$fiches_modifiees:=$fiches_modifiees+1
				
			Else 
				$id_previous:=$primary_key->
			End if 
			
			NEXT RECORD:C51($table->)
		End while 
		
	End if 
	
	Maint_Fix_Counter_Increment($table)
	
End for 

//Maint_Detect_Doublons 

CLOSE WINDOW:C154

ALERT:C41("Opération effectuée avec succès."+String:C10($fiches_traitees)+" fiches traitées."+String:C10($fiches_modifiees)+" fiches modifiées.")