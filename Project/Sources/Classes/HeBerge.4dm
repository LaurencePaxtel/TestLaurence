Class extends DataClass

Function searchAndCreateRecordIfDontExist($nom_t : Text; $prenom_t : Text; $dateNaissance_t : Text; $refStructure_t : Text; $importApplicationMobile_b : Boolean)->$heberge_e : cs:C1710.HeBergeEntity
	var $dateNaissance_d : Date
	var $statut_o : Object
	
	var $heberge_es : cs:C1710.HeBergeSelection
	
	$nom_t:=Uppercase:C13($nom_t)
	$prenom_t:=Uppercase:C13($prenom_t)
	
	$heberge_es:=ds:C1482.HeBerge.query("HB_Nom = :1 AND HB_Prénom = :2 AND HB_DateNéLe = :3 AND Ref_Structure = :4"; $nom_t; $prenom_t; Date:C102($dateNaissance_t); $refStructure_t)
	
	Case of 
		: ($heberge_es.length>1)  // Pas normal de se retrouver dans ce cas
			TRACE:C157
		: ($heberge_es.length=1)
			$heberge_e:=$heberge_es[0]
		Else   // Création de la fiche [HeBerge]
			$heberge_e:=ds:C1482.HeBerge.new()
			
			$heberge_e.HB_ReferenceID:=Uut_Numerote(->[HeBerge:4])
			$heberge_e.HB_Nom:=$nom_t
			$heberge_e.HB_Prénom:=$prenom_t
			
			$heberge_e.HB_DateNéLe:=Date:C102($dateNaissance_t)
			$dateNaissance_d:=$heberge_e.HB_DateNéLe
			
			$heberge_e.HB_Clé:=Uut_HébergéClé(->$nom_t; ->$prenom_t; ->$dateNaissance_d)
			$heberge_e.Ref_Structure:=$refStructure_t
			$heberge_e.importApplicationMobile:=$importApplicationMobile_b
			
			$statut_o:=$heberge_e.save()
			
			If ($statut_o.success=False:C215)
				TRACE:C157
			End if 
			
	End case 
	
	If ($heberge_e#Null:C1517)
		
		If ($heberge_e.situationBudgetaire=Null:C1517)
			$heberge_e.situationBudgetaire:=New object:C1471
			
			$heberge_e.situationBudgetaire.dateSitBudget:=Date:C102(String:C10(w_visiteur.date))
			$heberge_e.situationBudgetaire.nbPersonneMenage:=Num:C11(String:C10(w_visiteur.nbPersonneMenage))
			$heberge_e.situationBudgetaire.commentaire:=String:C10(w_visiteur.commentaire)
			
			$heberge_e.situationBudgetaire.budget:=New object:C1471
			
			$heberge_e.situationBudgetaire.budget.salaire:=0
			$heberge_e.situationBudgetaire.budget.loyer:=0
			$heberge_e.situationBudgetaire.budget.apl:=0
			
			$heberge_e.situationBudgetaire.budget.charge:=New collection:C1472
			$heberge_e.situationBudgetaire.budget.ressource:=New collection:C1472
			
			$heberge_e.situationBudgetaire.dette:=New object:C1471
			$heberge_e.situationBudgetaire.dette.detail:=New collection:C1472
			
			$statut_o:=$heberge_e.save()
		End if 
		
	End if 
	