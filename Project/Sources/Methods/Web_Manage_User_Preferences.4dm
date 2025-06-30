//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): Scanu Rémy
// Date and time: 22/12/20, 16:59:27
// ----------------------------------------------------
// Method: Web_Manage_User_Preferences
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($intervenantID_t; $action_t; $propriete_t; $valeur_t; $type_t; $userPreferences_t; $pathFileUserPreferences_t; $proprieteObjet_t)
C_LONGINT:C283($i_el; $pos_el)
C_BOOLEAN:C305($stop_b)
C_OBJECT:C1216($userPreferences_o; $proprieteCheck_o; $proprieteToSet_o)
C_COLLECTION:C1488($propriete_c)

$intervenantID_t:=Web_Form_Get_Post_Value("intervenantID")
$action_t:=Web_Form_Get_Post_Value("action")

$propriete_t:=Web_Form_Get_Post_Value("propriete")
$valeur_t:=Web_Form_Get_Post_Value("valeur")

$type_t:=Web_Form_Get_Post_Value("type")

$pathFileUserPreferences_t:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"customContent"+Séparateur dossier:K24:12+$intervenantID_t+Séparateur dossier:K24:12+"userPreferences.json"

If (Test path name:C476($pathFileUserPreferences_t)=Est un document:K24:1)
	$userPreferences_t:=Document to text:C1236($pathFileUserPreferences_t; "UTF-8"; Document inchangé:K24:18)
	$userPreferences_o:=JSON Parse:C1218($userPreferences_t)
	
	Case of 
		: ($action_t="sauvegarder") | ($action_t="supprimer")
			// Si la propriété que je veux modifier n'existe pas, je vais recréer à la volée tout le cheminement possible
			$propriete_c:=Split string:C1554($propriete_t; "."; sk ignorer chaîne vide:K86:1)
			$proprieteCheck_o:=$userPreferences_o
			
			For each ($proprieteObjet_t; $propriete_c) Until ($stop_b=True:C214)
				
				If ($proprieteCheck_o[$proprieteObjet_t]=Null:C1517)
					$proprieteCheck_o[$proprieteObjet_t]:=New object:C1471
				End if 
				
				If (OB Get type:C1230($proprieteCheck_o; $proprieteObjet_t)=Est un objet:K8:27)  // J'incrémente mon objet de la propriété sur lequel je suis en train de boucler
					$proprieteCheck_o:=$proprieteCheck_o[$proprieteObjet_t]
				Else 
					$stop_b:=True:C214
				End if 
				
			End for each 
			
			// Je prends la dernière propriété passée, et je lui affecte la valeur adéquate
			$proprieteToSet_o:=$userPreferences_o
			
			For each ($proprieteObjet_t; $propriete_c)
				
				If ($i_el+1=$propriete_c.length)  // Je booucle jusqu'à la dernière propriété
					
					Case of 
						: ($type_t="collection")
							
							If (Value type:C1509($proprieteToSet_o[$propriete_c[$propriete_c.length-1]])#Est une collection:K8:32)
								$proprieteToSet_o[$propriete_c[$propriete_c.length-1]]:=New collection:C1472
							End if 
							
							$pos_el:=$proprieteToSet_o[$propriete_c[$propriete_c.length-1]].indexOf($valeur_t)
							
							Case of 
								: ($action_t="sauvegarder")
									
									If ($pos_el=-1)
										$proprieteToSet_o[$propriete_c[$propriete_c.length-1]].push($valeur_t)
									End if 
									
								: ($action_t="supprimer")
									
									If ($pos_el#-1)
										$proprieteToSet_o[$propriete_c[$propriete_c.length-1]].remove($pos_el)
									End if 
									
							End case 
							
						: ($action_t="supprimer")
							OB REMOVE:C1226($proprieteToSet_o; $propriete_c[$propriete_c.length-1])
						Else 
							$proprieteToSet_o[$propriete_c[$propriete_c.length-1]]:=$valeur_t
							
							If (Length:C16($valeur_t)>2)
								
								If (Substring:C12($valeur_t; 0; 1)="{") & (Substring:C12($valeur_t; Length:C16($valeur_t); 1)="}")
									$proprieteToSet_o[$propriete_c[$propriete_c.length-1]]:=JSON Parse:C1218($valeur_t)
								End if 
								
							End if 
							
					End case 
					
				Else 
					$proprieteToSet_o:=$proprieteToSet_o[$proprieteObjet_t]
				End if 
				
				$i_el:=$i_el+1
			End for each 
			
			TEXT TO DOCUMENT:C1237($pathFileUserPreferences_t; JSON Stringify:C1217($userPreferences_o); "UTF-8"; Document inchangé:K24:18)
	End case 
	
End if 