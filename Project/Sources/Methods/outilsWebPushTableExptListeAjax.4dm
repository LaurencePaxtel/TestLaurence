//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : remyscanu
// Date et heure : 09/06/22, 14:28:28
// ----------------------------------------------------
// Méthode : outilsWebPushTableExptListeAjax
// Description
// Permet d'incrémenter le tableau de données envoyé
//
// Paramètres
// ----------------------------------------------------

If (False:C215)  // Historique
	// 06/05/20 remy@connect-io.fr - Création
	// 07/05/20 remy@connect-io.fr - Ajout de la colonne variable Agence
End if 

If (True:C214)  // Déclarations
	C_POINTER:C301($1)  // Pointeur de la collection de données qui va être envoyer
	C_TEXT:C284(${2})  // Nombre de paramètre illimité qui permet d'incrémenter le pointeur ->$1
	
	C_TEXT:C284($parametre_t)
	C_LONGINT:C283($i_el)
	C_VARIANT:C1683($parametre_v)
End if 

If (Bool:C1537(Num:C11(w_visiteur.serverSide))=True:C214)
	$parametre_v:=New object:C1471()
Else 
	$parametre_v:=New collection:C1472()
End if 

For ($i_el; 2; Count parameters:C259)
	$parametre_t:=${$i_el}
	
	If (Bool:C1537(Num:C11(w_visiteur.serverSide))=True:C214)
		$parametre_v["Col"+String:C10($i_el-1)]:=$parametre_t
	Else 
		$parametre_v.push($parametre_t)
	End if 
	
End for 

If (Bool:C1537(Num:C11(w_visiteur.serverSide))=True:C214)
	$parametre_v["DT_RowId"]:=${Count parameters:C259}
End if 

$1->push($parametre_v)