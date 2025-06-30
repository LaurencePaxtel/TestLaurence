//%attributes = {}
// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 05/07/18, 17:12:23
// ----------------------------------------------------
// Méthode : Menu_Lance_Process
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($menu; $valeur)
C_BOOLEAN:C305($error)

$menu:=$1
$valeur:=$2

QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]NP_Menu_Libelle:2=$menu)
MultiSoc_Filter(->[NAV_Menus:77])

If (Records in selection:C76([NAV_Menus:77])=1)
	QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=[NAV_Menus:77]ID:1; *)
	QUERY:C277([NAV_Sous_Menus:78];  & ; [NAV_Sous_Menus:78]NS_Menu_Texte:4=$valeur)
	
	MultiSoc_Filter(->[NAV_Sous_Menus:78])
	
	If (Records in selection:C76([NAV_Sous_Menus:78])#1)
		$error:=True:C214
	Else 
		
		If ([NAV_Sous_Menus:78]NS_Methode_Lancement:9#"")
			EXECUTE METHOD:C1007([NAV_Sous_Menus:78]NS_Methode_Lancement:9; *)
		Else 
			ALERT:C41("Erreur de paramétrage. Veuillez contacter l'administrateur")
		End if 
		
	End if 
	
End if 