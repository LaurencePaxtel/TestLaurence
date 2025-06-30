//%attributes = {}
// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 05/07/18, 16:59:35
// ----------------------------------------------------
// Méthode : Menu_Init
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284(<>Menu_Btn_Social; <>Menu_Btn_CH; <>Menu_Btn_DA; <>Menu_Btn_PAccueil; <>Menu_Btn_Maraude; <>Menu_Btn_AD; <>Menu_Btn_Envoie; <>Menu_Btn_Stats)

<>Menu_Btn_Social:=""
<>Menu_Btn_CH:=""
<>Menu_Btn_DA:=""
<>Menu_Btn_PAccueil:=""
<>Menu_Btn_Maraude:=""
<>Menu_Btn_AD:=""
<>Menu_Btn_Envoie:=""
<>Menu_Btn_Stats:=""

ARRAY TEXT:C222(<>TAB_Menu_Btn_Social; 0)
ARRAY TEXT:C222(<>TAB_Menu_Btn_CH; 0)
ARRAY TEXT:C222(<>TAB_Menu_Btn_DA; 0)
ARRAY TEXT:C222(<>TAB_Menu_Btn_PAccueil; 0)
ARRAY TEXT:C222(<>TAB_Menu_Btn_Maraude; 0)
ARRAY TEXT:C222(<>TAB_Menu_Btn_AD; 0)
ARRAY TEXT:C222(<>TAB_Menu_Btn_Envoie; 0)
ARRAY TEXT:C222(<>TAB_Menu_Btn_Stats; 0)

NAV_Object_Set_Style("GIP_Demande_PopUp"; -><>Menu_Btn_Social)
NAV_Object_Set_Style("GIP_AdUtil_PopUp"; -><>Menu_Btn_CH)
NAV_Object_Set_Style("GIP_AdUtil_PopUp1"; -><>Menu_Btn_DA)
NAV_Object_Set_Style("GIP_AdUtil_PopUp2"; -><>Menu_Btn_PAccueil)
NAV_Object_Set_Style("GIP_AdUtil_PopUp3"; -><>Menu_Btn_Maraude)
NAV_Object_Set_Style("GIP_AdUtil_PopUp4"; -><>Menu_Btn_AD)
NAV_Object_Set_Style("GIP_AdUtil_PopUp5"; -><>Menu_Btn_Envoie)
NAV_Object_Set_Style("GIP_AdUtil_PopUp6"; -><>Menu_Btn_Stats)

READ ONLY:C145([NAV_Menus:77])
READ ONLY:C145([NAV_Sous_Menus:78])

//========================================//
// Bouton Social
//========================================//
QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]NP_Menu_Libelle:2="<>Menu_Btn_Social")
MultiSoc_Filter(->[NAV_Menus:77])

If (Records in selection:C76([NAV_Menus:77])=1)
	
	If ([NAV_Menus:77]NP_Visible:4=True:C214)
		<>Menu_Btn_Social:=[NAV_Menus:77]NP_Menu_Texte:3
		
		QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=[NAV_Menus:77]ID:1; *)
		QUERY:C277([NAV_Sous_Menus:78];  & ; [NAV_Sous_Menus:78]NS_Visible:6=True:C214)
		MultiSoc_Filter(->[NAV_Sous_Menus:78])
		
		ORDER BY:C49([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_Ordre:7; >)
		
		While (Not:C34(End selection:C36([NAV_Sous_Menus:78])))
			APPEND TO ARRAY:C911(<>TAB_Menu_Btn_Social; [NAV_Sous_Menus:78]NS_Menu_Texte:4)
			
			NEXT RECORD:C51([NAV_Sous_Menus:78])
		End while 
		
	Else 
		OBJECT SET VISIBLE:C603(*; "Ligne_Btn_Social"; False:C215)
	End if 
	
End if 

//========================================//
// Centres d'Hébergements
//========================================//
QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]NP_Menu_Libelle:2="<>Menu_Btn_CH")
MultiSoc_Filter(->[NAV_Menus:77])

If (Records in selection:C76([NAV_Menus:77])=1)
	
	If ([NAV_Menus:77]NP_Visible:4=True:C214)
		<>Menu_Btn_CH:=[NAV_Menus:77]NP_Menu_Texte:3
		
		QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=[NAV_Menus:77]ID:1; *)
		QUERY:C277([NAV_Sous_Menus:78];  & ; [NAV_Sous_Menus:78]NS_Visible:6=True:C214)
		MultiSoc_Filter(->[NAV_Sous_Menus:78])
		
		ORDER BY:C49([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_Ordre:7; >)
		
		While (Not:C34(End selection:C36([NAV_Sous_Menus:78])))
			APPEND TO ARRAY:C911(<>TAB_Menu_Btn_CH; [NAV_Sous_Menus:78]NS_Menu_Texte:4)
			
			NEXT RECORD:C51([NAV_Sous_Menus:78])
		End while 
		
	Else 
		OBJECT SET VISIBLE:C603(*; "Ligne_Btn_CH"; False:C215)
	End if 
	
End if 

//========================================//
// Dossiers Actifs
//========================================//
QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]NP_Menu_Libelle:2="<>Menu_Btn_DA")
MultiSoc_Filter(->[NAV_Menus:77])

If (Records in selection:C76([NAV_Menus:77])=1)
	
	If ([NAV_Menus:77]NP_Visible:4=True:C214)
		<>Menu_Btn_DA:=[NAV_Menus:77]NP_Menu_Texte:3
		
		QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=[NAV_Menus:77]ID:1; *)
		QUERY:C277([NAV_Sous_Menus:78];  & ; [NAV_Sous_Menus:78]NS_Visible:6=True:C214)
		MultiSoc_Filter(->[NAV_Sous_Menus:78])
		
		ORDER BY:C49([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_Ordre:7; >)
		
		While (Not:C34(End selection:C36([NAV_Sous_Menus:78])))
			APPEND TO ARRAY:C911(<>TAB_Menu_Btn_DA; [NAV_Sous_Menus:78]NS_Menu_Texte:4)
			
			NEXT RECORD:C51([NAV_Sous_Menus:78])
		End while 
		
	Else 
		OBJECT SET VISIBLE:C603(*; "Ligne_Btn_DA"; False:C215)
	End if 
	
End if 

//========================================//
// P.Accueil
//========================================//
QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]NP_Menu_Libelle:2="<>Menu_Btn_PAccueil")
MultiSoc_Filter(->[NAV_Menus:77])

If (Records in selection:C76([NAV_Menus:77])=1)
	
	If ([NAV_Menus:77]NP_Visible:4=True:C214)
		<>Menu_Btn_PAccueil:=[NAV_Menus:77]NP_Menu_Texte:3
		
		QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=[NAV_Menus:77]ID:1; *)
		QUERY:C277([NAV_Sous_Menus:78];  & ; [NAV_Sous_Menus:78]NS_Visible:6=True:C214)
		MultiSoc_Filter(->[NAV_Sous_Menus:78])
		
		ORDER BY:C49([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_Ordre:7; >)
		
		While (Not:C34(End selection:C36([NAV_Sous_Menus:78])))
			APPEND TO ARRAY:C911(<>TAB_Menu_Btn_PAccueil; [NAV_Sous_Menus:78]NS_Menu_Texte:4)
			
			NEXT RECORD:C51([NAV_Sous_Menus:78])
		End while 
		
	Else 
		OBJECT SET VISIBLE:C603(*; "Ligne_Btn_PAccueil"; False:C215)
	End if 
	
End if 

//========================================//
// Maraude
//========================================//
QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]NP_Menu_Libelle:2="<>Menu_Btn_Maraude")
MultiSoc_Filter(->[NAV_Menus:77])

If (Records in selection:C76([NAV_Menus:77])=1)
	
	If ([NAV_Menus:77]NP_Visible:4=True:C214)
		<>Menu_Btn_Maraude:=[NAV_Menus:77]NP_Menu_Texte:3
		
		QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=[NAV_Menus:77]ID:1; *)
		QUERY:C277([NAV_Sous_Menus:78];  & ; [NAV_Sous_Menus:78]NS_Visible:6=True:C214)
		MultiSoc_Filter(->[NAV_Sous_Menus:78])
		
		ORDER BY:C49([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_Ordre:7; >)
		
		While (Not:C34(End selection:C36([NAV_Sous_Menus:78])))
			APPEND TO ARRAY:C911(<>TAB_Menu_Btn_Maraude; [NAV_Sous_Menus:78]NS_Menu_Texte:4)
			
			NEXT RECORD:C51([NAV_Sous_Menus:78])
		End while 
		
	Else 
		OBJECT SET VISIBLE:C603(*; "Ligne_Btn_Maraude"; False:C215)
	End if 
	
End if 

//========================================//
// Autres Dossiers
//========================================//
QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]NP_Menu_Libelle:2="<>Menu_Btn_AD")
MultiSoc_Filter(->[NAV_Menus:77])

If (Records in selection:C76([NAV_Menus:77])=1)
	
	If ([NAV_Menus:77]NP_Visible:4=True:C214)
		<>Menu_Btn_AD:=[NAV_Menus:77]NP_Menu_Texte:3
		
		QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=[NAV_Menus:77]ID:1; *)
		QUERY:C277([NAV_Sous_Menus:78];  & ; [NAV_Sous_Menus:78]NS_Visible:6=True:C214)
		MultiSoc_Filter(->[NAV_Sous_Menus:78])
		
		ORDER BY:C49([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_Ordre:7; >)
		
		While (Not:C34(End selection:C36([NAV_Sous_Menus:78])))
			APPEND TO ARRAY:C911(<>TAB_Menu_Btn_AD; [NAV_Sous_Menus:78]NS_Menu_Texte:4)
			
			NEXT RECORD:C51([NAV_Sous_Menus:78])
		End while 
		
	Else 
		OBJECT SET VISIBLE:C603(*; "Ligne_Btn_AD"; False:C215)
	End if 
	
End if 

//========================================//
// Envoie
//========================================//
QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]NP_Menu_Libelle:2="<>Menu_Btn_Envoie")
MultiSoc_Filter(->[NAV_Menus:77])

If (Records in selection:C76([NAV_Menus:77])=1)
	
	If ([NAV_Menus:77]NP_Visible:4=True:C214)
		<>Menu_Btn_Envoie:=[NAV_Menus:77]NP_Menu_Texte:3
		
		QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=[NAV_Menus:77]ID:1; *)
		QUERY:C277([NAV_Sous_Menus:78];  & ; [NAV_Sous_Menus:78]NS_Visible:6=True:C214)
		MultiSoc_Filter(->[NAV_Sous_Menus:78])
		
		ORDER BY:C49([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_Ordre:7; >)
		
		While (Not:C34(End selection:C36([NAV_Sous_Menus:78])))
			APPEND TO ARRAY:C911(<>TAB_Menu_Btn_Envoie; [NAV_Sous_Menus:78]NS_Menu_Texte:4)
			
			NEXT RECORD:C51([NAV_Sous_Menus:78])
		End while 
		
	Else 
		OBJECT SET VISIBLE:C603(*; "Ligne_Btn_Envoie"; False:C215)
	End if 
	
End if 

//========================================//
// Statistiques
//========================================//
QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]NP_Menu_Libelle:2="<>Menu_Btn_Stats")
MultiSoc_Filter(->[NAV_Menus:77])

If (Records in selection:C76([NAV_Menus:77])=1)
	
	If ([NAV_Menus:77]NP_Visible:4=True:C214)
		<>Menu_Btn_Stats:=[NAV_Menus:77]NP_Menu_Texte:3
		
		QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=[NAV_Menus:77]ID:1; *)
		QUERY:C277([NAV_Sous_Menus:78];  & ; [NAV_Sous_Menus:78]NS_Visible:6=True:C214)
		MultiSoc_Filter(->[NAV_Sous_Menus:78])
		
		ORDER BY:C49([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_Ordre:7; >)
		
		While (Not:C34(End selection:C36([NAV_Sous_Menus:78])))
			APPEND TO ARRAY:C911(<>TAB_Menu_Btn_Stats; [NAV_Sous_Menus:78]NS_Menu_Texte:4)
			NEXT RECORD:C51([NAV_Sous_Menus:78])
		End while 
		
	Else 
		OBJECT SET VISIBLE:C603(*; "Ligne_Btn_Stats"; False:C215)
	End if 
	
End if 