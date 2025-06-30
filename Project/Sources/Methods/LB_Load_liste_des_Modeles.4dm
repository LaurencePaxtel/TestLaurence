//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 23/09/2020, 17:04:44
// ----------------------------------------------------
// Method: LB_Load_liste_des_Modeles
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($offset; $value)
C_BLOB:C604($blob)

ARRAY TEXT:C222(Liste_formulaire; 0)
ARRAY TEXT:C222(Liste_ref_formulaire; 0)
ARRAY TEXT:C222(Liste_type_formulaire; 0)

$blob:=LB_Load_Liste_Modeles(<>Ref_User_actif; <>ref_soc_active)

BLOB TO VARIABLE:C533($blob; Liste_formulaire; $offset)
BLOB TO VARIABLE:C533($blob; Liste_ref_formulaire; $offset)
BLOB TO VARIABLE:C533($blob; Liste_type_formulaire; $offset)
BLOB TO VARIABLE:C533($blob; $value; $offset)

Liste_formulaire:=$value