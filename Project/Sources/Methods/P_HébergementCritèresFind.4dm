//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementCritèresFind  
//{
//{          Lundi 26 juillet 2004 à 11:03:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)  // Table
C_POINTER:C301($2)  // Champ
C_POINTER:C301($3)  // Tableau : libellé
C_POINTER:C301($4)  // Tableau : Cas

C_LONGINT:C283($i; $j)
C_BOOLEAN:C305($vbOK)

If (Size of array:C274($3->)>0)
	
	If (Records in selection:C76($1->)>0)
		
		For ($i; 1; Size of array:C274($3->))
			$j:=$j+$4->{$i}
		End for 
		
		If ($j>0) & ($j<Size of array:C274($3->))  // Il y au moins un label de sélectionner
			
			For ($i; 1; Size of array:C274($3->))
				
				If ($4->{$i}=1)  // Le label a été sélectionnée
					
					If ($vbOK)  // Il y a déjà un label de traiter
						
						// Modifié par : Scanu Rémy - remy@connect-io.fr (13/04/2022) et Re-modifié par Scanu Rémy (10/08/2022)
						Case of 
							: ($3->{$i}="(Sans valeur)")
								QUERY SELECTION:C341($1->;  | ; $2->=""; *)
							: (Value type:C1509($2->)=Est un booléen:K8:9)
								
								If ($3->{$i}="Oui") | ($3->{$i}="Vrai")
									QUERY SELECTION:C341($1->;  | ; $2->=True:C214; *)
								Else 
									QUERY SELECTION:C341($1->;  | ; $2->=False:C215; *)
								End if 
								
							Else 
								QUERY SELECTION:C341($1->;  | ; $2->=$3->{$i}; *)
						End case 
						
					Else   // Premier label de traiter
						
						// Modifié par : Scanu Rémy (10/08/2022)
						Case of 
							: ($3->{$i}="(Sans valeur)")
								QUERY SELECTION:C341($1->; $2->=""; *)
							: (Value type:C1509($2->)=Est un booléen:K8:9)
								
								If ($3->{$i}="Oui") | ($3->{$i}="Vrai")
									QUERY SELECTION:C341($1->; $2->=True:C214; *)
								Else 
									QUERY SELECTION:C341($1->; $2->=False:C215; *)
								End if 
								
							Else 
								QUERY SELECTION:C341($1->; $2->=$3->{$i}; *)
						End case 
						
					End if 
					
					$vbOK:=True:C214
				End if 
				
			End for 
			
			QUERY SELECTION:C341($1->)
		End if 
		
	End if 
	
End if 