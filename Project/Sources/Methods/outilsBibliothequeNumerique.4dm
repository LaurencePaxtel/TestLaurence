//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Administrator
// Date et heure : 27/02/21, 01:14:50
// ----------------------------------------------------
// Méthode : outilsBibliothequeNumerique
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_OBJECT:C1216($info_o; $position_o)

$info_o:=New object:C1471("formName"; "FormBibliothequeNumerique")
outilsWProChargerDocument("initBibliothequeNumerique"; False:C215; ->$info_o)
//$position_t:="center"
//outilsCreateWindowsForm("FormBibliothequeNumerique"; ->$position_t; $info_o)

$position_o:=New object:C1471("ecartHautEcran"; 30; "ecartBasEcran"; 100)
outilsCreateWindowsForm("FormBibliothequeNumerique"; ->$position_o; \
$info_o; New object:C1471("useSubForm"; True:C214))