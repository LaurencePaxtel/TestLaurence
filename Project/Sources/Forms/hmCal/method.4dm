// Method hmCal  
// 
// 
// #SYNTAX: $L_Erreur:=hmCal(param_1;->param_N) 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : 
//     $2 Pointer         : 
//     $3 Date            : 
//     $4 Time            : 
//     $5 BLOB            : 
//     $6 Picture         : 
//     $7 Object          :
//     $8 real            :
//     $9 Boolean         :

// #DATE CREATION: 15/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		OBJECT SET ENABLED:C1123(*; "bcoche_ajout"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bcoche_modification"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bcoche_elargi"; False:C215)
		
		OBJECT SET HELP TIP:C1181(*; "bcoche_ajout"; "Indique si vous pouvez ajouter")
		OBJECT SET HELP TIP:C1181(*; "bcoche_modification"; "Indique si vous pouvez modifier")
		OBJECT SET HELP TIP:C1181(*; "bcoche_elargi"; "Indique si vous avez un droit élargi")
		
		
		//OBJECT SET HELP TIP(*;"button_month_backward";"Help for button_month_backward")
		//OBJECT SET HELP TIP(*;"button_month_forward";"Help for button_month_forward")
		OBJECT SET HELP TIP:C1181(*; "button_pasteboard"; "Copier le calendrier dans le presse-papiers")
		OBJECT SET HELP TIP:C1181(*; "button_quitter"; "Fermer le calendrier")
		OBJECT SET HELP TIP:C1181(*; "button_raz"; "Quitter la recherche rendez-vous usager")
		OBJECT SET HELP TIP:C1181(*; "count_usager"; "Le nombre d'usager affichés dans la liste")
		
		OBJECT SET HELP TIP:C1181(*; "input"; "Saisissez un nom d'usager")
		OBJECT SET HELP TIP:C1181(*; "list_vues"; "Choisir un calendrier")
		
		OBJECT SET HELP TIP:C1181(*; "pop_permanencier"; "Choisir un permanencier")
		//OBJECT SET HELP TIP(*;"lb_usagers";"texte")
		
		//OBJECT SET HELP TIP(*;"hmCal";"bb")
End case 