//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 12/07/24, 16:00:48
// ----------------------------------------------------
// Méthode : outilsWebManageData
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $chaineTest_t; $chaineTestB_t; $propriete_t : Text
var $stop_b : Boolean
var $retour_o; $element_o; $statut_o : Object
var $data_c; $table_c : Collection

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeberGementSelection

var $Participations_e : cs:C1710.ParticipationsEntity

var $participationDette_e : cs:C1710.ParticipationsWebDetteEntity
var $participationDette_es : cs:C1710.ParticipationsWebDetteSelection

var $messagerie_e : cs:C1710.MessagerieEntity
var $messagerie_es : cs:C1710.MessagerieSelection

var $intervenant_e : cs:C1710.INtervenantsEntity

$retour_o:=New object:C1471

Case of 
	: (String:C10(w_visiteur.action)="deleteRecord")
		$table_c:=OB Keys:C1719(ds:C1482)
		
		If ($table_c.indexOf(String:C10(w_visiteur.data.table))#-1)
			$messagerie_e:=ds:C1482[String:C10(w_visiteur.data.table)].get(w_visiteur.data.id)
			
			If ($messagerie_e#Null:C1517)
				$statut_o:=$messagerie_e.drop()
			Else 
				$retour_o.notificationWarning:="L'enregistrement de la table [Messagerie] avec l'ID \""+String:C10(w_visiteur.data.id)+"\" n'a pas pu être trouvé dans la base de données"
			End if 
			
		Else 
			$retour_o.notificationWarning:="La table \""+String:C10(w_visiteur.data.table)+"\" n'a pas pu être trouvé dans la base de données"
		End if 
		
	: (String:C10(w_visiteur.action)="getInfoUserConnected")
		$retour_o:=OB Copy:C1225(w_visiteur)
	: (String:C10(w_visiteur.action)="getRecordsMessagerie")
		$chaineTest_t:="@Report rattrapage@"
		$chaineTestB_t:="@Report Auto@"
		$messagerie_es:=ds:C1482.Messagerie.query("Ref_Structure = :1 AND MS_Texte # :2 AND MS_Texte # :3"; String:C10(w_visiteur.refStructure); $chaineTest_t; $chaineTestB_t)
		
		If (w_visiteur.date#Null:C1517) && ((String:C10(w_visiteur.dateSigneComparaison)="=") | (String:C10(w_visiteur.dateSigneComparaison)=">=") | \
			(String:C10(w_visiteur.dateSigneComparaison)=">") | (String:C10(w_visiteur.dateSigneComparaison)="<=") | (String:C10(w_visiteur.dateSigneComparaison)="<"))
			$messagerie_es:=$messagerie_es.query("MS_Date "+String:C10(w_visiteur.dateSigneComparaison)+" :1"; Date:C102(w_visiteur.date))
		End if 
		
		If (w_visiteur.keyword#Null:C1517)
			$chaineTest_t:="@"+String:C10(w_visiteur.keyword)+"@"
			$messagerie_es:=$messagerie_es.query("OneIntervenant.IN_Login = :1 OR OneHeberge.HB_Clé = :1 OR MS_Texte = :1"; $chaineTest_t)
		End if 
		
		If (w_visiteur.service#Null:C1517) && (String:C10(w_visiteur.service)#"Tous")
			$chaineTest_t:="@"+String:C10(w_visiteur.service)+"@"
			$messagerie_es:=$messagerie_es.query("MS_Groupe = :1"; $chaineTest_t)
		End if 
		
		If (w_visiteur.priorite#Null:C1517) && (String:C10(w_visiteur.priorite)#"Toutes")
			$messagerie_es:=$messagerie_es.query("priorite = :1 "; Num:C11(w_visiteur.priorite))
		End if 
		
		$retour_o.totalRecords:=String:C10($messagerie_es.length)
		outilsManagePagination(Num:C11(w_visiteur.page); Num:C11(w_visiteur.nbResultatParPage); ->$messagerie_es; New object:C1471("orderField"; "MS_Date"; "orderInstruction"; "desc"))
		
		$data_c:=New collection:C1472
		
		For each ($messagerie_e; $messagerie_es)
			$data_c.push(New object:C1471(\
				"id"; $messagerie_e.UUID; \
				"date"; String:C10($messagerie_e.MS_Date); \
				"heure"; Time string:C180($messagerie_e.MS_Heure); \
				"intervenantID"; $messagerie_e.intervenantID; \
				"intervenantLogin"; ($messagerie_e.OneIntervenant#Null:C1517) ? $messagerie_e.OneIntervenant.IN_Login : ""; \
				"hebergeID"; $messagerie_e.hebergeID; \
				"hebergeCle"; ($messagerie_e.OneHeberge#Null:C1517) ? $messagerie_e.OneHeberge.HB_Clé : ""; \
				"service"; $messagerie_e.MS_Groupe; \
				"priorite"; $messagerie_e.priorite; \
				"message"; $messagerie_e.MS_Texte))
		End for each 
		
		$retour_o.data:=$data_c
	: (String:C10(w_visiteur.action)="newRecordMessagerie")
		
		$intervenant_e:=ds:C1482.INtervenants.get(Num:C11(w_visiteur.data.intervenantID))
		
		If ($intervenant_e#Null:C1517)
			$messagerie_e:=ds:C1482.Messagerie.createRecord(Date:C102(w_visiteur.data.date); $intervenant_e.ID; Num:C11(w_visiteur.data.usagerID); \
				String:C10(w_visiteur.data.groupe); Num:C11(w_visiteur.data.priorite); String:C10(w_visiteur.data.message); $intervenant_e.Ref_Structure)
			$retour_o.record:=$messagerie_e.toObject()
		Else 
			$retour_o.notificationWarning:="L'enregistrement de la table [INtervenants] avec l'ID \""+String:C10(w_visiteur.data.intervenantID)+"\" n'a pas pu être trouvé dans la base de données"
		End if 
		
	: (String:C10(w_visiteur.action)="modifyRecordMessagerie")
		$intervenant_e:=ds:C1482.INtervenants.get(Num:C11(w_visiteur.data.intervenantID))
		
		If ($intervenant_e#Null:C1517)
			$heberge_es:=ds:C1482.HeBerge.query("ID = :1 OR HB_ReferenceID = :1"; Num:C11(w_visiteur.hebergeID))
			
			If ($heberge_es.length>0)
				$heberge_e:=$heberge_es.first()
			End if 
			
			$messagerie_e:=ds:C1482.Messagerie.modifyRecord(String:C10(w_visiteur.data.id); Date:C102(w_visiteur.data.date); $intervenant_e.ID; Num:C11($heberge_e.ID); \
				String:C10(w_visiteur.data.groupe); Num:C11(w_visiteur.data.priorite); String:C10(w_visiteur.data.message); $intervenant_e.Ref_Structure)
			
			If ($messagerie_e=Null:C1517)
				$retour_o.notificationWarning:="L'enregistrement de la table [Messagerie] avec l'ID \""+String:C10(w_visiteur.data.id)+"\" n'a pas pu être trouvé dans la base de données"
			End if 
			
		Else 
			$retour_o.notificationWarning:="L'enregistrement de la table [INtervenants] avec l'ID \""+String:C10(w_visiteur.data.intervenantID)+"\" n'a pas pu être trouvé dans la base de données"
		End if 
		
	: (String:C10(w_visiteur.action)="getRecordHeberge")
		$heberge_es:=ds:C1482.HeBerge.query("ID = :1 OR HB_ReferenceID = :1"; Num:C11(w_visiteur.hebergeID))
		
		If ($heberge_es.length>0)
			$retour_o:=$heberge_es.first().toObject()
		Else 
			$retour_o.notificationWarning:="L'hebergé avec le champ [Heberge]ID ou [Heberge]HB_ReferenceID \""+String:C10(w_visiteur.hebergeID)+"\" n'a pas pu être trouvé dans la base de données"
		End if 
		
	: (String:C10(w_visiteur.action)="getRecordsParticipationWeb")
		$participations_es:=ds:C1482.Participations.query("PAR_HB_ID = :1 AND PAR_participationWebID # 0"; ds:C1482.HeBerge.get(Num:C11(w_visiteur.hebergeID)).HB_ReferenceID)
		
		
		If ($participations_es.length>0)
			
			Case of 
				: (Num:C11(w_visiteur.year)>0) & (Num:C11(w_visiteur.month)>0)
					$participations_es:=$participations_es.query("PAR_Annee = :1 AND PAR_Mois = :2"; Num:C11(w_visiteur.year); Num:C11(w_visiteur.month))
				: (Num:C11(w_visiteur.year)>0)
					$participations_es:=$participations_es.query("PAR_Annee = :1"; Num:C11(w_visiteur.year))
					
					If ($participations_es.length<12)
						
						For ($i_el; 1; 12)
							If ($participations_es.query("PAR_Mois = :1"; $i_el).length=0)
								$participations_e:=ds:C1482.ParticipationsWebBudget.searchAndCreateRecordIfDontExist($heberge_e.ID; Num:C11(w_visiteur.year); $i_el; 0; 0; 0; New collection:C1472; New collection:C1472; ""; 1; $heberge_e.Ref_Structure)
								$participations_es.add($participations_e)
							End if 
							
						End for 
						
					End if 
					
				: (Num:C11(w_visiteur.month)>0)
					$participations_es:=$participations_es.query("PAR_Mois = :1"; Num:C11(w_visiteur.month))
			End case 
			
			$participations_es:=$participations_es.orderBy("PAR_Annee asc, PAR_Mois asc")
			$data_c:=New collection:C1472
			
			For each ($participations_e; $participations_es)
				$data_c.push(New object:C1471(\
					"mois"; $participations_e.PAR_Mois; \
					"moisLib"; outilsGetLibDate(2; Date:C102("01/"+String:C10($participations_e.PAR_Mois)+"/"+String:C10(Year of:C25(Current date:C33)))); \
					"annee"; $participations_e.PAR_Annee; \
					"salaire"; $participations_e.participationWeb.salaire; \
					"apl"; $participations_e.participationWeb.apl; \
					"loyer"; $participations_e.participationWeb.loyer; \
					"ressource"; $participations_e.participationWeb.ressource.detail; \
					"charge"; $participations_e.participationWeb.charge.detail; \
					"forfaitParticipation"; $participations_e.PAR_Taux; \
					"totalParticipation"; $participations_e.PAR_Montant_Participation; \
					"nbPersonneMenage"; $participations_e.participationWeb.nbPersonneMenage; \
					"ID"; $participations_e.getKey()))
			End for each 
			
			$retour_o.data:=$data_c
		Else 
			$retour_o.notificationWarning:="L'hebergé avec le champ [Heberge]ID ou [Heberge]HB_ReferenceID \""+String:C10(w_visiteur.hebergeID)+"\" n'a pas pu être trouvé dans la base de données"
		End if 
		
	: (String:C10(w_visiteur.action)="newOrModifyRecordParticipationWeb")
		If (Value type:C1509(w_visiteur.data)=Est une collection:K8:32)
			
			For each ($element_o; w_visiteur.data) Until ($stop_b=True:C214)
				$heberge_e:=ds:C1482.HeBerge.query("ID = :1 OR HB_ReferenceID = :1"; Num:C11(w_visiteur.hebergeID)).first()
				
				If (Num:C11($element_o.annee)>0) & (Num:C11($element_o.mois)>0)
					$Participations_e:=ds:C1482.Participations.searchAndCreateRecordIfDontExistWeb(Num:C11(w_visiteur.hebergeID); Num:C11($element_o.annee); Num:C11($element_o.mois); 0; 0; 0; New collection:C1472; New collection:C1472; ""; 1; $heberge_e.Ref_Structure)
					$Participations_e.reload()
					
					$statut_o:=$Participations_e.webUpdate(Num:C11($element_o.salaire); Num:C11($element_o.loyer); Num:C11($element_o.apl); $element_o.ressource; $element_o.charge; Num:C11($element_o.forfaitParticipation); Num:C11($element_o.totalParticipation))
					$stop_b:=($statut_o.success=False:C215)
				End if 
				
			End for each 
			
			If ($stop_b)
				$retour_o.notificationWarning:="Au moins un enregistrement n'a pas pu s'enregistrer dans la base de données, veuillez recommencer."
			End if 
			
		Else 
			$retour_o.notificationWarning:="Le paramètre \"data\" n'est pas de type collection"
		End if 
		
		
	: (String:C10(w_visiteur.action)="getRecordsParticipationDette")
		$heberge_es:=ds:C1482.HeBerge.query("ID = :1 OR HB_ReferenceID = :1"; Num:C11(w_visiteur.hebergeID))
		
		If ($heberge_es.length>0)
			$heberge_e:=$heberge_es.first()
			$participationDette_es:=$heberge_e.AllParticipationsWebDette
			
			$data_c:=New collection:C1472
			
			For each ($participationDette_e; $participationDette_es)
				$data_c.push(New object:C1471(\
					"nbPersonneMenage"; $participationDette_e.nbPersonneMenage; \
					"dateSitBudget"; outilsDateFrVersDateIso(String:C10($participationDette_e.date)); \
					"modeFacturation"; String:C10($heberge_e.HB_FAC_Mode_Facturation); \
					"commentaire"; $participationDette_e.commentaire; \
					"dettes"; $participationDette_e.dette.detail; \
					"ID"; $participationDette_e.getKey()))
			End for each 
			
			$retour_o.data:=$data_c
		Else 
			$retour_o.notificationWarning:="L'hebergé avec le champ [Heberge]ID ou [Heberge]HB_ReferenceID \""+String:C10(w_visiteur.hebergeID)+"\" n'a pas pu être trouvé dans la base de données"
		End if 
		
	: (String:C10(w_visiteur.action)="newOrModifyRecordParticipationDette")
		$heberge_es:=ds:C1482.HeBerge.query("ID = :1 OR HB_ReferenceID = :1"; Num:C11(w_visiteur.hebergeID))
		
		If ($heberge_es.length>0)
			$heberge_e:=$heberge_es.first()
			
			If (Value type:C1509(w_visiteur.data)=Est un objet:K8:27)
				$participationWebDette_e:=ds:C1482.ParticipationsWebDette.searchAndCreateRecordIfDontExist($heberge_e.ID; !2000-01-01!; ""; New collection:C1472; 1; $heberge_e.Ref_Structure)
				$participationWebDette_e.reload()
				
				$statut_o:=$participationWebDette_e.update(Date:C102(w_visiteur.data.dateSitBudget); String:C10(w_visiteur.data.commentaire); w_visiteur.data.dettes; Num:C11(w_visiteur.data.nbPersonneMenage))
				$stop_b:=($statut_o.success=False:C215)
				
				If (String:C10(w_visiteur.data.modeFacturation)#"")
					$heberge_e.HB_FAC_Mode_Facturation:=String:C10(w_visiteur.data.modeFacturation)
				End if 
				
				$statut_o:=$heberge_e.save()
				$stop_b:=($statut_o.success=False:C215)
				
				If ($stop_b=True:C214)
					$retour_o.notificationWarning:="L'enregistrement n'a pas pu être mis à jour dans la base de données, veuillez recommencer."
				End if 
				
			Else 
				$retour_o.notificationWarning:="Le paramètre \"data\" n'est pas de type objet"
			End if 
			
		End if 
		
End case 

// On supprime les propriétés utilisées pour l'API
OB REMOVE:C1226(w_visiteur; "action")

If (w_visiteur.formRequest#Null:C1517)  // Purge pour requête POST, PUT et DELETE
	
	For each ($propriete_t; w_visiteur.formRequest)
		OB REMOVE:C1226(w_visiteur; $propriete_t)
	End for each 
	
	OB REMOVE:C1226(w_visiteur; "formRequest")
End if 

If (w_visiteur["X-METHOD"]="GET")  // Pour pour requête GET
	
	For each ($propriete_t; w_visiteur["X-URLParam"])
		OB REMOVE:C1226(w_visiteur; $propriete_t)
	End for each 
	
End if 

$retour_o.success:=($retour_o.notificationWarning=Null:C1517)
WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))