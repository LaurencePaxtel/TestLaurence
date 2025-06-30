//%attributes = {}
// Method LB_Get_Colonne  
// Pointeur sur la colonne qui a  été cliquée

C_POINTER:C301($1)

C_POINTER:C301($P_varCol)
C_LONGINT:C283($L_colonne; $L_ligne)
LISTBOX GET CELL POSITION:C971(*; OBJECT Get name:C1087; $L_colonne; $L_ligne; $P_varCol)

$1->:=$P_varCol