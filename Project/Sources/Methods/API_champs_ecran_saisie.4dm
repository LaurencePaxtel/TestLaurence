//%attributes = {}
// Method API_champs_ecran_saisie retourne un objet avec le libellé du popup 
// qui sélectionne le thème et le selecteur qui permet de chercher dans [LesRubriques]RubNoSTR 
// Voir méthode : Debut_DecVarChampAttribut
//
// #SYNTAX: API_SelecteurChampsObligatoires(->Object) 
// #PARAMETERS: 
// $1 Pointer : Objet avec le libellé et son sélecteur dans [LesRubriques]RubNoSTR

// #DATE CREATION: 12/02/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_LONGINT:C283($0; $L_MyError)
$L_MyError:=1  //OK par defaut

C_TEXT:C284($1; $T_Selecteur)
$T_Selecteur:=$1  // c'est le nom de l'action envoyée par la requête

C_TEXT:C284($2; $T_Param)
$T_Param:=$2

C_POINTER:C301($3; $P_O_User_output)
$P_O_User_output:=$3

C_LONGINT:C283($i; $j)
C_LONGINT:C283($L_Trouve)
ARRAY OBJECT:C1221($rO_Selection; 0)
Case of 
	: ($T_Selecteur="champs_ecran_saisie_selecteur")
		
		C_LONGINT:C283($L_String)
		$L_String:=30100
		
		$L_Trouve:=Size of array:C274(<>ta_vDSLibel)
		If ($L_Trouve<1)
			$L_MyError:=-2
		Else 
			ARRAY OBJECT:C1221($rO_Selection; $L_Trouve)
			
			ARRAY TEXT:C222($rT_Libelle; 0)
			COPY ARRAY:C226(<>ta_vDSLibel; $rT_Libelle)
			
			For ($i; 1; Size of array:C274($rT_Libelle))
				OB SET:C1220($rO_Selection{$i}; $rT_Libelle{$i}; ($L_String+$i))
			End for 
		End if 
		
	: ($T_Selecteur="champs_ecran_saisie")
		
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=Num:C11($T_Param))
		MultiSoc_Filter(->[LesRubriques:21])
		
		$L_Trouve:=Records in selection:C76([LesRubriques:21])
		Case of 
			: ($L_Trouve=0)
				$L_MyError:=-1
			Else 
				
				C_LONGINT:C283($L_Trouve)
				$L_Trouve:=Records in selection:C76([LesRubriques:21])
				ORDER BY:C49([LesRubriques:21]; [LesRubriques:21]RubFichier:3; >)
				
				ARRAY INTEGER:C220($rI_Table; 0)
				ARRAY INTEGER:C220($rI_Field; 0)
				SELECTION TO ARRAY:C260([LesRubriques:21]RubFichier:3; $rI_Table; [LesRubriques:21]RubNuméro:4; $rI_Field)
				
				$T_JSON:=Selection to JSON:C1234([LesRubriques:21]; SelectionJson_template(->[LesRubriques:21]))
				
				JSON PARSE ARRAY:C1219($T_JSON; $rO_Selection)
				
				// Je récupère l'appairage des champs/listes popup
				ARRAY OBJECT:C1221($rO_Paire_champs_listes; 0)
				API_Get_paire_Fields_Listes(->$rO_Paire_champs_listes)
				
				// pour la lisibilité du webmaster
				// j'ajoute le nom de la table
				For ($i; 1; $L_Trouve)
					
					$L_Table:=$rI_Table{$i}
					$L_Field:=$rI_Field{$i}
					
					If (Is table number valid:C999($L_Table))
						
						$T_Nom:=Table name:C256($L_Table)
						$T_Liste:="pas de liste"
						
						C_LONGINT:C283($L_Size_paire; $j)
						$L_Size_paire:=Size of array:C274($rO_Paire_champs_listes)
						$j:=1
						Repeat 
							C_BOOLEAN:C305($B_Stop)
							$B_Stop:=False:C215
							
							// je boucle sur le tableau d'objet pour trouver la liste associée au champ
							C_POINTER:C301($P_Field)
							$P_Field:=OB Get:C1224($rO_Paire_champs_listes{$j}; "field"; Est un pointeur:K8:14)
							If (Is field number valid:C1000($L_Table; $L_Field))
								If ($P_Field=(Field:C253($L_Table; $L_Field)))
									$T_Liste:=OB Get:C1224($rO_Paire_champs_listes{$j}; "liste"; Est un texte:K8:3)
									$B_Stop:=True:C214
								End if 
							End if 
							
							
							
							$j:=$j+1
						Until ($j>$L_Size_paire) | ($B_Stop)
						
					Else 
						$T_Nom:="table invalide"
						$T_Liste:="non applicable"
					End if 
					OB SET:C1220($rO_Selection{$i}; "table"; $T_Nom)
					OB SET:C1220($rO_Selection{$i}; "liste"; $T_Liste)
					
				End for 
				REDUCE SELECTION:C351([LesRubriques:21]; 0)
		End case 
		
	Else 
		$L_MyError:=MAXLONG:K35:2
End case 

Case of 
	: ($L_MyError=-1)
		$T_Message:="Aucun enregistrement avec le sélecteur "+$T_Param
	: ($L_MyError=-2)
		$T_Message:="Le popup <>ta_vDSLibel est vide"
	: ($L_MyError=MAXLONG:K35:2)
		$T_Message:="Mauvais sélecteur"
	Else 
		$T_Message:="OK"
End case 

OB SET:C1220($P_O_User_output->; "message"; $T_Message)
OB SET ARRAY:C1227($P_O_User_output->; "output"; $rO_Selection)

$0:=$L_MyError