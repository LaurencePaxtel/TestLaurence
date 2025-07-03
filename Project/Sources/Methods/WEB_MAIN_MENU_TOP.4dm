//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 00:55:48
// ----------------------------------------------------
// Méthode : WEB_MAIN_MENU_TOP
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($o; $s)

ARRAY TEXT:C222($MENU_TOP; 10; 10)
ARRAY TEXT:C222($SOUS_MENU_TOP; 20; 10)

If (Not:C34(w_connected))
	$o:=$o+1
	$MENU_TOP{$o}{1}:="Login"
	$MENU_TOP{$o}{2}:="/login"
	$MENU_TOP{$o}{3}:="login.png"
	
Else 
	$o:=$o+1
	$MENU_TOP{$o}{1}:="Usager"
	//$MENU_TOP{$o}{2}:="/INT?action=usager-list"
	$MENU_TOP{$o}{2}:="/home"
	$MENU_TOP{$o}{3}:="btn.png"
	
	// Modified by: Scanu Rémy - remy@connect-io.fr (23/12/2020)
	// Ajout de 2 sous-menus au menu Tableau de bord
	$o:=$o+1
	$MENU_TOP{$o}{1}:="Tableau de bord"
	$MENU_TOP{$o}{2}:="/INT?action=tableau-de-bord"
	$MENU_TOP{$o}{3}:=""
	
	$s:=$s+1
	$SOUS_MENU_TOP{$s}{1}:="Tableau de bord général"
	$SOUS_MENU_TOP{$s}{2}:="/INT?action=tableau-de-bord"
	$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
	$SOUS_MENU_TOP{$s}{4}:=""
	
	$s:=$s+1
	$SOUS_MENU_TOP{$s}{1}:="Situation financière usagers"
	$SOUS_MENU_TOP{$s}{2}:="/INT?action=situation-financiere-usagers"
	$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
	$SOUS_MENU_TOP{$s}{4}:=""
	
	If (Web_User_Check_Privilege("Statistiques web"))
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Données et Statistiques"
		$SOUS_MENU_TOP{$s}{2}:="/INT?action=HeberGement_statistiqueGenerer\" target=\"_blank"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:=""
	End if 
	
	If ([SOciete:18]SO_DC_Activer:140=False:C215)
		$o:=$o+1
		$MENU_TOP{$o}{1}:="Disponibilité des centres"
		$MENU_TOP{$o}{2}:="/INT?action=centres"
		$MENU_TOP{$o}{3}:="btn.png"
	End if 
	
	If ([SOciete:18]SO_GI_Activer:139=False:C215)
		//Si (Vrai)
		$o:=$o+1
		$MENU_TOP{$o}{1}:="Gestion immobilière"
		$MENU_TOP{$o}{2}:="/GL?action=usagers"
		$MENU_TOP{$o}{3}:=""
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Biens "
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=biens"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:=""
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Locations "
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=locations"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:=""
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Interventions "
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=interventions"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:=""
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Équipements "
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=equipements_biens"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:=""
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Sinistres"
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=sinistres"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:=""
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Locataires"
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=usager-list"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:=""
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Propriétaires"
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=proprietaires"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:=""
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Factures"
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=factures"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:=""
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Règlements"
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=reglements"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:=""
		
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Gestion de stock"
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=stocks"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:="fa fa-cube"
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Base documentaire"
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=base_documentaire"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:="fa fa-file-pdf-o"
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Paramétrage des équipements "
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=equipements"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:="fa fa-cog"
		
		$s:=$s+1
		$SOUS_MENU_TOP{$s}{1}:="Paramétrage IRL"
		$SOUS_MENU_TOP{$s}{2}:="/GL?action=irl"
		$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
		$SOUS_MENU_TOP{$s}{4}:="fa fa-cog"
	End if 
	
	If (SO_Planning_Web_Activer)
		$o:=$o+1
		$MENU_TOP{$o}{1}:="Planning"
		$MENU_TOP{$o}{2}:="/USR?action=planning"
		$MENU_TOP{$o}{3}:="btn.png"
	End if 
	
	$o:=$o+1
	$MENU_TOP{$o}{1}:=Session:C1714.storage.intervenant.Login
	//$MENU_TOP{$o}{2}:="/INT?action=usager-list"
	$MENU_TOP{$o}{2}:="/home"
	$MENU_TOP{$o}{3}:="buttonChangerPlateforme fa fa-user"
	
	$s:=$s+1
	$SOUS_MENU_TOP{$s}{1}:="Structures"
	$SOUS_MENU_TOP{$s}{2}:="deconnexion"
	$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
	$SOUS_MENU_TOP{$s}{4}:=""
	
	$s:=$s+1
	$SOUS_MENU_TOP{$s}{1}:="Déconnexion"
	$SOUS_MENU_TOP{$s}{2}:="/deconnexion"
	$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
	$SOUS_MENU_TOP{$s}{4}:="icon-off"
	
	$s:=$s+1
	$SOUS_MENU_TOP{$s}{1}:="Réintialiser le mot de passe"
	//$SOUS_MENU_TOP{$s}{2}:="/INT?action=usager-list&login=true&resetPassword=Vrai"
	$SOUS_MENU_TOP{$s}{2}:="/home?login=true&resetPassword=Vrai"
	$SOUS_MENU_TOP{$s}{3}:=String:C10($o)
	$SOUS_MENU_TOP{$s}{4}:="icon-refresh"
End if 

WebAGL_creer_menu(->$MENU_TOP; ->$SOUS_MENU_TOP)