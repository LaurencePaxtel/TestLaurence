// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 27/06/2020, 14:37:34
// ----------------------------------------------------
// Method: [DiaLogues].DL_Participations.btn_valider
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $moisDebut_el; $mois_el; $annee_el; $i_el : Integer
var $continue_b : Boolean

var $participation_e : cs:C1710.ParticipationsEntity
var $participation_es : cs:C1710.ParticipationsSelection

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		READ WRITE:C146([Participations:116])
		
		$continue_b:=(String:C10(Form:C1466.referent)#"") & (String:C10(Form:C1466.coordinateur)#"")
		
		If ($continue_b=True:C214)
			
			For ($moisDebut_el; 1; 12)
				$date_d:=Date:C102("01/"+String:C10($moisDebut_el; "00")+"/"+String:C10(Year of:C25(Current date:C33)))
				
				QUERY:C277([Participations:116]; [Participations:116]PAR_HB_ID:2=PAR_HB_ReferenceID; *)
				QUERY:C277([Participations:116];  & ; [Participations:116]PAR_Mois:4=$moisDebut_el; *)
				QUERY:C277([Participations:116];  & ; [Participations:116]PAR_Annee:3=par_selected_year)
				
				MultiSoc_Filter(->[Participations:116])
				
				If (Records in selection:C76([Participations:116])=0)
					CREATE RECORD:C68([Participations:116])
					MultiSoc_Init_Structure(->[Participations:116])
					
					[Participations:116]PAR_HB_ID:2:=PAR_HB_ReferenceID
					[Participations:116]PAR_Mois:4:=$moisDebut_el
					[Participations:116]PAR_Annee:3:=par_selected_year
				End if 
				
				// Modifié par : Scanu Rémy (07/04/2023)
				// En mode compilé, on ne peut pas utiliser des variables locales avec la commande EXÉCUTER FORMULE
				$variable_c:=New collection:C1472
				
				For ($i_el; 1; 8)
					$variable_c.push(New object:C1471(\
						"name"; "[Participations]PAR_Ressource_"+String:C10($i_el); "value"; "Form.participation["+String:C10($moisDebut_el-1)+"].PAR_Ressource_"+String:C10($i_el)))
					$variable_c.push(New object:C1471(\
						"name"; "[Participations]PAR_Montant_"+String:C10($i_el); "value"; "Form.participation["+String:C10($moisDebut_el-1)+"].PAR_Montant_"+String:C10($i_el)))
				End for 
				
				outilsVariableAffectValueByProg($variable_c)
				
				[Participations:116]PAR_Montant_Total:16:=Form:C1466.participation[$moisDebut_el-1].PAR_Montant_Total
				[Participations:116]PAR_Taux:15:=Form:C1466.participation[$moisDebut_el-1].PAR_Taux
				[Participations:116]PAR_Montant_Participation:18:=Form:C1466.participation[$moisDebut_el-1].PAR_Montant_Participation
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (06/05/2021) et Re-modifié par Scanu Rémy (03/05/2023)
				[Participations:116]PAR_Menage:21:=String:C10(Form:C1466.personneMenage)
				
				// Modifié par : Scanu Rémy (22/12/2022) et Re-modifié par Scanu Rémy (17/04/2023)
				// Ajout des champs Extra & APL
				[Participations:116]PAR_Extra:35:=OB Copy:C1225(Form:C1466.extra[Lowercase:C14(outilsGetLibDate(2; $date_d))])
				
				[Participations:116]PAR_APL_Attente:20:=Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].montantEnvisage
				[Participations:116]PAR_APL_Date:23:=Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].dateReception
				[Participations:116]PAR_APL_Recu:22:=Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].montantRecu
				[Participations:116]PAR_APL_Solde:24:=Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].solde
				
				[Participations:116]PAR_Referent:27:=Form:C1466.referent
				[Participations:116]PAR_Coordinateur:28:=Form:C1466.coordinateur
				
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (14/04/2021) et re-modifié par Scanu Rémy - remy@connect-io.fr (03/05/2021)
				//Si ([Participations]PAR_Montant_Total>0)
				SAVE RECORD:C53([Participations:116])
				//Fin de si 
				
				UNLOAD RECORD:C212([Participations:116])
			End for 
			
			// Modifié par : Scanu Rémy (23/08/2023)
			// Ajout d'une sauvegarde pour la table [HeBerge] car on a rajouté le champ pour le mode de facturation
			SAVE RECORD:C53([HeBerge:4])
			
			VALIDATE TRANSACTION:C240
			ACCEPT:C269
			
			If (Form:C1466.forceEnvoi=True:C214)
				$mois_el:=Month of:C24(outilsPremierDuMois(Current date:C33)-1)
				$annee_el:=Year of:C25(outilsPremierDuMois(Current date:C33)-1)
				
				$participation_es:=ds:C1482.Participations.query("PAR_HB_ID = :1 AND PAR_Mois = :2 AND PAR_Annee = :3 AND PAR_participationWebID = 0"; PAR_HB_ReferenceID; $mois_el; $annee_el)
				
				If ($participation_es.length=1)
					$participation_e:=$participation_es.first()
					$solde_r:=$participation_e.soldeAnneeEnCours()
					
					If ($solde_r<0)
						$participation_e.sendMailAPL($solde_r)
					Else 
						ALERT:C41("Le solde n'étant pas inférieur à 0, aucun email n'est envoyé")
					End if 
					
				Else 
					ALERT:C41("Vous avez demandé la réactualisation du montant en retard des APL, mais aucune participation n'a été trouvé pour la période "+String:C10($mois_el)+"/"+String:C10($annee_el))
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Un coordinateur et un référent doivent être renseignés")
		End if 
		
End case 