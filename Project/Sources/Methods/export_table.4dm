//%attributes = {}
C_BOOLEAN:C305($b_valeur)
$vlTable:=$1
$ptr_table:=Table:C252($1)
$nb_champ:=Get last field number:C255($vlTable)

$nom_table:=Table name:C256($vlTable)
$nom_fich:=$nom_table+".txt"

C_TIME:C306($h_RefDoc)
$h_RefDoc:=Create document:C266($nom_fich)
i_Message("Export "+String:C10($vlTable)+" "+$nom_table)

USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15

$texte:=""
For ($vlChamp; 1; $nb_champ)
	If ($texte="")
		$texte:=Field name:C257($vlTable; $vlChamp)
	Else 
		$texte:=$texte+Char:C90(Tabulation:K15:37)+Field name:C257($vlTable; $vlChamp)
	End if 
	
End for 
SEND PACKET:C103($h_RefDoc; $texte+Char:C90(Retour chariot:K15:38))


ALL RECORDS:C47($ptr_table->)
//FIRST RECORD($ptr_table->)
$nb_enreg:=Records in selection:C76($ptr_table->)
For ($v_enreg; 1; $nb_enreg)
	$texte:=""
	
	If (Mod:C98($v_enreg; 500)=0)
		i_MessageSeul("Export "+String:C10($vlTable)+" "+$nom_table+" "+String:C10($v_enreg)+" / "+String:C10($nb_enreg))
	End if 
	
	For ($vlChamp; 1; $nb_champ)
		GET FIELD PROPERTIES:C258($vlTable; $vlChamp; vType; vLong; vIndex; vUnique; vInvisible)
		$ChampPtr:=Field:C253($vlTable; $vlChamp)
		Case of 
				
			: (vType=Est un BLOB:K8:12)
				
			: (vType=Est un booléen:K8:9)
				$b_valeur:=$ChampPtr->
				If ($b_valeur)
					$texte:=$texte+"vrai"
				Else 
					$texte:=$texte+"faux"
				End if 
			: (vType=Est un entier:K8:5)
				$texte:=$texte+String:C10($ChampPtr->)
			: (vType=Est un entier long:K8:6)
				$texte:=$texte+String:C10($ChampPtr->)
			: (vType=Est un numérique:K8:4)
				$texte:=$texte+String:C10($ChampPtr->)
			: (vType=Est une date:K8:7)
				$texte:=$texte+String:C10($ChampPtr->)
			: (vType=Est une heure:K8:8)
				$texte:=$texte+String:C10($ChampPtr->)
				
			: (vType=Est un champ alpha:K8:1)
				$valeur:=$ChampPtr->
				$valeur:=Replace string:C233($valeur; Char:C90(10); "")
				$valeur:=Replace string:C233($valeur; Char:C90(13); " ")
				$valeur:=Replace string:C233($valeur; Char:C90(Tabulation:K15:37); " ")
				$texte:=$texte+$valeur
			: (vType=Est un texte:K8:3)
				$valeur:=$ChampPtr->
				$valeur:=Replace string:C233($valeur; Char:C90(10); "")
				$valeur:=Replace string:C233($valeur; Char:C90(13); " ")
				$valeur:=Replace string:C233($valeur; Char:C90(Tabulation:K15:37); " ")
				$texte:=$texte+$valeur
				
			: (vType=Est une image:K8:10)
				//on ne fait rien
				
			: (vType=Est une sous table:K8:11)
				//on ne fait rien
			Else 
				
		End case 
		$texte:=$texte+Char:C90(Tabulation:K15:37)
		
	End for 
	$texte:=F_MacOuWindow($texte)
	SEND PACKET:C103($h_RefDoc; $texte+Char:C90(Retour chariot:K15:38))
	
	NEXT RECORD:C51($ptr_table->)
End for 

CLOSE DOCUMENT:C267($h_RefDoc)
USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15

CLOSE WINDOW:C154