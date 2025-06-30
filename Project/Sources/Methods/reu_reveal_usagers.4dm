//%attributes = {}
// Method reu_reveal_usagers masque dans la listbox usager les usagers qui ne sont pas dans la sélection des inscrits 
// 
// #SYNTAX: reu_reveal_usagers)
// #PARAMETERS:
//     None

// #DATE CREATION: 09/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2



C_POINTER:C301($P_LB; $P_Controle)
hm_Get_Pointer_LB_usagers(->$P_LB)
4DLB_Lire_tableau_controle($P_LB; ->$P_Controle)

C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($P_Controle->))
	$P_Controle->{$i}:=lk ligne masquée:K53:31
End for 

// je mets les PK de chaque usager participant
ARRAY LONGINT:C221($rL_ID; 0)
SELECTION TO ARRAY:C260([HeBerge:4]ID:65; $rL_ID)

C_POINTER:C301($P_Usagers_cle; $P_Usagers_nom; $P_Usagers_pk; $P_Permanenciers_nom; $P_Permanenciers_pk_invisible)
Cal_Get_PTR(->$P_Usagers_cle; ->$P_Usagers_nom; ->$P_Usagers_pk; ->$P_Permanenciers_nom; ->$P_Permanenciers_pk_invisible)

For ($i; 1; Size of array:C274($rL_ID))
	// toutes les lignes sont masquées
	C_LONGINT:C283($L_Pos)
	$L_Pos:=Find in array:C230($P_Usagers_pk->; $rL_ID{$i})
	If ($L_Pos>-1)
		$P_Controle->{$L_Pos}:=0
	End if 
End for 



