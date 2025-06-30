TableChamps(5; <>ta_vDSLibel)

// #BS Migration v15 30/05/16
// Remplacement de la commande obsolète
// _o_ARRAY TO STRING LIST par xliff_ARRAY_TO_XLIFF

// Modifié par : Scanu Rémy (25/01/2023)
//xliff_ARRAY_TO_XLIFF_(-><>ta_RubNomNew; (<>vlSTR+<>ta_vDSLibel))
outilsCreateXliffFile((<>vlSTR+<>ta_vDSLibel); -><>ta_RubNomNew)

//====================================================//
// Modified by: Kevin HASSAL (12/10/2020)
//  Gestion Multi-Sociétés : Gestion des fichiers XLIFF par structure
//====================================================//

// Modifié par : Scanu Rémy (25/01/2023)
//xliff_ARRAY_TO_XLIFF_(-><>ta_RubNomNew; ((<>vlSTR+<>ta_vDSLibel)*1000)+<>ID_Societe_Active)
outilsCreateXliffFile(((<>vlSTR+<>ta_vDSLibel)*1000)+<>ID_Societe_Active; -><>ta_RubNomNew)