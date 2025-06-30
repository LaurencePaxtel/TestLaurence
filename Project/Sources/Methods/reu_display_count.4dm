//%attributes = {}
// Method hm_display_count affiche le nombre d'usagers dans la lb et le nombre de lignes cachées 
// 
// #SYNTAX: hm_display_count
// #PARAMETERS:
//     None

// #DATE CREATION: 06/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_POINTER:C301($P_LB)
hm_Get_Pointer_LB_usagers(->$P_LB)

ARRAY TEXT:C222($rT_Col_names; 0)
ARRAY TEXT:C222($rT_Header_names; 0)
ARRAY POINTER:C280($rP_Col_var; 0)
ARRAY POINTER:C280($rP_Header_var; 0)
ARRAY BOOLEAN:C223($rB_Col_visibles; 0)
ARRAY POINTER:C280($rP_Style; 0)
LISTBOX GET ARRAYS:C832($P_LB->; $rT_Col_names; $rT_Header_names; $rP_Col_var; $rP_Header_var; $rB_Col_visibles; $rP_Style)

C_POINTER:C301($P_Hidden)
$P_Hidden:=$rP_Style{4}  // le tableau associé pour cacher

C_LONGINT:C283($L_Count_hidden; $L_Count_rows)
$L_Count_hidden:=Count in array:C907($P_Hidden->; lk ligne masquée:K53:31)
$L_Count_rows:=Size of array:C274($P_Hidden->)

C_POINTER:C301($P_Count)
$P_Count:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "count_usager")
$P_Count->:=String:C10($L_Count_rows-$L_Count_hidden)+" usagers / "+String:C10($L_Count_rows)
