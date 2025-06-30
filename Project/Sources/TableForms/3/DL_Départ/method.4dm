//Formulaire MAIN
C_LONGINT:C283($vl_EventFF)

$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur clic:K2:4)
	: ($vl_EventFF=Sur chargement:K2:1)
		Menu_Init  //Kevin HASSAL
		
		<>NAV_Parametrage:="Paramétrage"
		
		<>ve_GenéralQuitter:=0
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP))  //| (Appartient au groupe(Utilisateur courant;◊Groupe_ADMIN))
		Else 
			DébutBtMenu(5; "")
		End if 
		
		Handle couleurs accueil($vl_EventFF)  // #20180504-5
		
		OBJECT SET VISIBLE:C603(*; "Prestation_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Lum_@"; False:C215)
		
		If (<>vb_UserLOFT)
			OBJECT SET VISIBLE:C603(*; "Lum_@"; True:C214)
		End if 
		
		If (<>vb_UserMessagerie)
			Process_Go3(-><>PR_Messagerie115; "Go_Messagerie"; <>va_Messagerie115; 64; <>Va_Messagerie115)
		End if 
		
		SET TIMER:C645(60*5)
		
		OBJECT SET VISIBLE:C603(*; "SansPrest_@"; <>vb_T_SansPrestations)
		
		<>Va_CentreCtrl:=<>va_UserPlateforme
		
		P_RondProcessEnCours("ReportAuto")
		P_RondProcessEnCours("TransfertDistant")
		
		SOC_Get_Config
		
		If (Not:C34(SO_Planning_Web_Activer))
			OBJECT SET VISIBLE:C603(*; "@planning_web@"; False:C215)
		End if 
		
	: ($vl_EventFF=Sur minuteur:K2:25)
		<>DDJ:=Current date:C33  //Sur le dialogue de depart
		<>va_ServDH:=String:C10(Current date:C33(*); Système date abrégé:K1:2)+" - "+String:C10(Current time:C178(*); h mn:K7:2)
		
		P_RondProcessEnCours("ReportAuto")
		P_RondProcessEnCours("TransfertDistant")
		
		REDRAW:C174(<>DDJ)
		REDRAW:C174(<>va_ServDH)
		
		SET TIMER:C645(600)
		
	: ($vl_EventFF=Sur menu sélectionné:K2:14)
		// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
		// Ajout d'un menu pour accéder à la barre d'appel sans que l'utilisateur ait besoin de redémarrer le programme
		i_MenuChoisi
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		
		If (<>vb_FondCouleur)
			<>vb_FondCouleur:=False:C215
			Handle couleurs accueil($vl_EventFF)  // #20180504-5
			
			REDRAW WINDOW:C456
		Else 
			
			If (<>ve_GenéralQuitter=-1)
				CANCEL:C270
			End if 
			
		End if 
		
End case 