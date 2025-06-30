//%attributes = {}
// Method LBaR_Hide masque les lignes selon le contenu saisi et trouvé 
//  
// #SYNTAX: LBaR_Hide
// #PARAMETERS:
//     None

// #DATE CREATION: 27/10/2015  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:
// La méthode est privée et non partagée
// #HEADER VERSION: 2


C_TEXT:C284($T_String)
$T_String:=Get edited text:C655

C_POINTER:C301($P_LB)
hm_Get_Pointer_LB_usagers(->$P_LB)

ARRAY TEXT:C222($rT_Col_names; 0)
ARRAY TEXT:C222($rT_Header_names; 0)
ARRAY POINTER:C280($rP_Col_var; 0)
ARRAY POINTER:C280($rP_Header_var; 0)
ARRAY BOOLEAN:C223($rB_Col_visibles; 0)
ARRAY POINTER:C280($rP_Style; 0)
LISTBOX GET ARRAYS:C832($P_LB->; $rT_Col_names; $rT_Header_names; $rP_Col_var; $rP_Header_var; $rB_Col_visibles; $rP_Style)

C_LONGINT:C283($L_Count_col; $L_Count_rows)
$L_Count_col:=LISTBOX Get number of columns:C831($P_LB->)
$L_Count_rows:=LISTBOX Get number of rows:C915($P_LB->)

C_POINTER:C301($P_Hidden)
$P_Hidden:=$rP_Style{4}  // le tableau associé pour cacher, désactiver les lignes

// Le tableau $rT_Filter_column est le tableau qui contient les colonnes exclue de la recheche
// Il est passé de la base hôte par la méthode partagée : LBaR_SearchPicker_Exclude
ARRAY TEXT:C222($rT_Filter_column; 0)
COPY ARRAY:C226(rT_Filter_column; $rT_Filter_column)


C_LONGINT:C283($L_Ligne)
If (Length:C16($T_String)=0) | (Character code:C91(Keystroke:C390)=Touche retour arrière:K12:29)
	
	// On affiche toutes les lignes
	For ($L_Ligne; 1; $L_Count_rows)
		$P_Hidden->{$L_Ligne}:=0  //lk row is hidden
	End for 
End if 

If (Length:C16($T_String)>0)
	
	C_TEXT:C284($T_Col_name)
	C_POINTER:C301($P_Col)
	C_TEXT:C284($T_Source; $T_New)
	C_BOOLEAN:C305($B)
	C_LONGINT:C283($L_LaColonne)
	For ($L_Ligne; 1; $L_Count_rows)
		
		If ($P_Hidden->{$L_Ligne}#lk ligne masquée:K53:31)
			
			$B:=False:C215
			$L_LaColonne:=0
			Repeat 
				
				// Je boucle sur chaque colonne
				// si une colonne contient la chaine on sort de la boucle
				
				$L_LaColonne:=$L_LaColonne+1
				$T_Col_name:=$rT_Col_names{$L_LaColonne}
				If (Find in array:C230($rT_Filter_column; $T_Col_name)>-1)  // si la colonne est inclue dans le filtre
					
					$P_Col:=OBJECT Get pointer:C1124(Objet nommé:K67:5; $T_Col_name)
					
					$T_Source:=String:C10($P_Col->{$L_Ligne})
					$T_New:=Replace string:C233($T_Source; $T_String; "")
					$B:=(Length:C16($T_New)#Length:C16($T_Source))
				End if 
				
			Until (($L_LaColonne=$L_Count_col) | $B)
			
			C_LONGINT:C283($L_Hidden)
			If ($B)
				$L_Hidden:=0
			Else 
				$L_Hidden:=lk ligne masquée:K53:31
			End if 
			$P_Hidden->{$L_Ligne}:=$L_Hidden
		End if 
	End for 
	
	
End if 

// EOM
