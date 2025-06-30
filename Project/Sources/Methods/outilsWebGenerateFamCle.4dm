//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 01/06/22, 16:59:14
// ----------------------------------------------------
// Méthode : outilsWebGenerateFamCle
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $retour_o : Object

$retour_o:=New object:C1471("etat"; True:C214; "HG_FamCle"; "")

READ WRITE:C146([HeberGement:5])
QUERY:C277([HeberGement:5]; [HeberGement:5]ID:168=Num:C11(w_visiteur.hebergementID))

If (Records in selection:C76([HeberGement:5])=0)
	CREATE RECORD:C68([HeberGement:5])
	[HeberGement:5]HG_HB_ID:19:=Num:C11(w_visiteur.hebergeID)
End if 

[HeberGement:5]HG_FamClé:104:=""
[HeberGement:5]HG_FamChef:103:=True:C214

Web_P_HG_FamilleChef(1)

$retour_o.HG_FamCle:=[HeberGement:5]HG_FamClé:104
UNLOAD RECORD:C212([HeberGement:5])

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))