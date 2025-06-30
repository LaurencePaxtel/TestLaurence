//%attributes = {}
// Method w_Get_hebergement_detail retourne un Objet de la fiche hebergement ID
// 
// #SYNTAX: $T_JSON:=w_Get_hebergement_detail(cle) 
// #PARAMETERS:
//     $0 Text            : Fiche au format JSON
//     $1 Long            : ID de l'hebergement

// #DATE CREATION: 13/08/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2



// les boutons du formulaire ecran saisie B :
//     - SP
//     - AF
//     - Action
//     - Note
// vont tous chercher dans la table [HeBerge]


C_OBJECT:C1216($0; $O_Output)
$O_Output:=JSON Parse:C1218("{}")  // starting from 16R3 use Create object


C_LONGINT:C283($1; $L_ID)
$L_ID:=$1

SET QUERY LIMIT:C395(1)
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=$L_ID)
SET QUERY LIMIT:C395(0)

RELATE ONE:C42([HeberGement:5]HG_HB_ID:19)  // va chercher l'hebergé

C_OBJECT:C1216($O_Liste)
$O_Liste:=w_Get_PopupsToObject

C_OBJECT:C1216($O_Hebergement)
$O_Hebergement:=4DREC_Record_to_Object(->[HeberGement:5])

C_OBJECT:C1216($O_Heberge)
$O_Heberge:=4DREC_Record_to_Object(->[HeBerge:4])

OB SET:C1220($O_Output; "hebergement"; $O_Hebergement)
OB SET:C1220($O_Output; "heberge"; $O_Heberge)
OB SET:C1220($O_Output; "popups"; $O_Liste)

$0:=$O_Output

// EOM
