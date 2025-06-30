// ----------------------------------------------------
// Développeur (OS) : Kevin HASSAL
// Date et heure : 03/09/18, 03:42:22
// ----------------------------------------------------
// Méthode : Trigger sur [HeBerge]
// Description
// 
//
// Paramètres
// ----------------------------------------------------

If (Trigger event:C369=Sur sauvegarde nouvel enreg:K3:1) | (Trigger event:C369=Sur sauvegarde enregistrement:K3:2)
	[HeBerge:4]HB_TimeStamp:86:=outilsTimeStamp(Current date:C33(*); Current time:C178(*))
End if 

Case of 
	: (Trigger event:C369=Sur sauvegarde nouvel enreg:K3:1)
		// Modifié par : Scanu Rémy (02/06/2023)
		// Ajout des infos pour la situation budgetaire
		[HeBerge:4]situationBudgetaire:85:=New object:C1471
		
		[HeBerge:4]situationBudgetaire:85.dateSitBudget:=!00-00-00!
		[HeBerge:4]situationBudgetaire:85.nbPersonneMenage:=1
		[HeBerge:4]situationBudgetaire:85.commentaire:=""
		
		[HeBerge:4]situationBudgetaire:85.budget:=New object:C1471
		
		[HeBerge:4]situationBudgetaire:85.budget.salaire:=0
		[HeBerge:4]situationBudgetaire:85.budget.loyer:=0
		[HeBerge:4]situationBudgetaire:85.budget.apl:=0
		
		[HeBerge:4]situationBudgetaire:85.budget.charge:=New collection:C1472
		[HeBerge:4]situationBudgetaire:85.budget.ressource:=New collection:C1472
		
		[HeBerge:4]situationBudgetaire:85.dette:=New object:C1471
		[HeBerge:4]situationBudgetaire:85.dette.detail:=New collection:C1472
		
		MultiSoc_Init_Structure(->[HeBerge:4])
	: (Trigger event:C369=Sur sauvegarde enregistrement:K3:2)
		MultiSoc_Init_Structure(->[HeBerge:4])
End case 