Class extends EntitySelection

Function exportCompta($entree_el : Integer)->$content_o : Object
	var $mois_t; $annee_t : Text
	var $accountProduct_i : Integer
	var $stop_b : Boolean
	var $date_d; $period_d; $periodPrevious_d : Date
	var $extra_o : Object
	
	var $participation_e : cs:C1710.ParticipationsEntity
	
	var $heberge_e : cs:C1710.HeBergeEntity
	var $heberge_es : cs:C1710.HeBergeSelection
	
	var $hebergement_es : cs:C1710.HeberGementSelection
	
	var $centre_e : cs:C1710.LesCentresEntity
	var $centre_es : cs:C1710.LesCentresSelection
	
	var $facture_e : cs:C1710.FacturesEntity
	var $factureLigne_es : cs:C1710.Factures_LignesSelection
	
	$content_o:=New object:C1471("export"; ""; "notificationError"; "")
	
	// Entête
	Case of 
		: ($1=1)  // Export compta IEC Participation / Hébergement
			$content_o.export:="Version"+Char:C90(Tabulation:K15:37)+"EEme"+Char:C90(Tabulation:K15:37)+"SEme"+Char:C90(Tabulation:K15:37)+"ERecpt"+Char:C90(Tabulation:K15:37)+"SRecpt"+Char:C90(Tabulation:K15:37)+"CJal"+Char:C90(Tabulation:K15:37)+"CSaisie"+Char:C90(Tabulation:K15:37)+\
				"CptTreso"+Char:C90(Tabulation:K15:37)+"EDate"+Char:C90(Tabulation:K15:37)+"Npiece"+Char:C90(Tabulation:K15:37)+"NFolio"+Char:C90(Tabulation:K15:37)+"NCompte"+Char:C90(Tabulation:K15:37)+"Debit"+Char:C90(Tabulation:K15:37)+"Credit"+Char:C90(Tabulation:K15:37)+"Libelle"+Char:C90(Tabulation:K15:37)+\
				"NFact"+Char:C90(Tabulation:K15:37)+"RefBanque"+Char:C90(Tabulation:K15:37)+"DateE"+Char:C90(Tabulation:K15:37)+"CLettrage"+Char:C90(Retour à la ligne:K15:40)
	End case 
	
	For each ($facture_e; This:C1470) Until ($stop_b=True:C214)
		$factureLigne_es:=$facture_e.AllFacturesLigne.orderBy("FACL_Montant_TTC desc")
		
		Case of 
			: ($1=1)  // Export compta IEC Participation / Hébergement
				$heberge_e:=Null:C1517
				$heberge_es:=ds:C1482.HeBerge.query("HB_ReferenceID = :1"; $facture_e.FAC_Origine_ID)
				
				$stop_b:=($heberge_es.length=0)
				
				If ($heberge_es.length>0)
					$heberge_e:=$heberge_es.first()
				End if 
				
				If ($stop_b=True:C214) & (String:C10($content_o.notificationError)="")
					$content_o.notificationError:="Impossible de faire l'export sur les factures car l'hébergé avec la référence ID « "+String:C10($facture_e.FAC_Origine_ID)+" » n'a pas pu être trouvé dans la base de donnée"
				End if 
				
				If ($stop_b=False:C215)
					
					Case of 
						: ($facture_e.FAC_Bien_ID#0)
							$centre_e:=ds:C1482.LesCentres.get($facture_e.FAC_Bien_ID)
						: ($facture_e.FAC_Libelle#"")  // On doit tenir compte que le champ [Factures]FAC_Bien_ID avant n'était pas renseigné ([HeberGement])
							$centre_e:=Null:C1517
							$centre_es:=ds:C1482.LesCentres.query("LC_Nom = :1"; $facture_e.FAC_Libelle)
							
							If ($centre_es.length>0)
								$centre_e:=$centre_es.first()
							End if 
							
						Else   // On doit tenir compte que le champ [Factures]FAC_Bien_ID avant n'était pas renseigné ([Participations])
							$mois_t:=Substring:C12($facture_e.FAC_Mois_Annee; 1; Position:C15("/"; $facture_e.FAC_Mois_Annee)-1)
							$annee_t:=Substring:C12($facture_e.FAC_Mois_Annee; Position:C15("/"; $facture_e.FAC_Mois_Annee)+1)
							
							$date_d:=Date:C102("01/"+$mois_t+"/"+$annee_t)
							$hebergement_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID.query("HG_Date >= :1 AND HG_Date <= :2"; $date_d; outilsDernierDuMois($date_d)).orderBy("HG_Date desc")
							
							If ($hebergement_es.length>0)
								$centre_e:=Null:C1517
								$centre_es:=ds:C1482.LesCentres.query("LC_RéférenceID = :1"; $hebergement_es[0].HG_LC_ID)
								
								If ($centre_es.length>0)
									$centre_e:=$centre_es.first()
								End if 
								
							End if 
							
					End case 
					
					$stop_b:=($centre_e=Null:C1517)
				End if 
				
				If ($stop_b=True:C214) & (String:C10($content_o.notificationError)="")
					$content_o.notificationError:="Impossible de faire l'export sur les factures car aucun centre n'a pu être trouvé pour la facture avec l'ID « "+String:C10($facture_e.ID)+" »"
				End if 
				
				If ($stop_b=False:C215)
					$stop_b:=($centre_e.OneFactureExport=Null:C1517)
				End if 
				
				If ($stop_b=True:C214) & (String:C10($content_o.notificationError)="")
					$content_o.notificationError:="Impossible de faire l'export sur les factures car le centre « "+$centre_e.LC_Nom+" » n'est pas rattaché à un service"
				End if 
				
				If ($stop_b=False:C215)
					$societe_e:=ds:C1482.SOciete.get($centre_e.OneFactureExport.OneStructure.STRC_Societe_ID)
					$period_d:=Date:C102("01/"+$facture_e.FAC_Mois_Annee)
					
					If ($periodPrevious_d#!00-00-00!)  // On est déjà passé sur une facture
						$stop_b:=(Year of:C25($period_d)#Year of:C25($periodPrevious_d))
					End if 
					
				End if 
				
				If ($stop_b=True:C214) & (String:C10($content_o.notificationError)="")
					$content_o.notificationError:="Impossible de faire l'export sur les factures qui sont sur plusieurs années !"
				End if 
				
				If ($stop_b=False:C215)
					$periodPrevious_d:=$period_d
					
					// Ajout de la première ligne débit (montant)
					$content_o.export:=$content_o.export+"2.0"+Char:C90(Tabulation:K15:37)+"ET01"+Char:C90(Tabulation:K15:37)+"1000"+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+"VE"+Char:C90(Tabulation:K15:37)+"VEUS"+Char:C90(Tabulation:K15:37)+\
						""+Char:C90(Tabulation:K15:37)+String:C10($facture_e.FAC_Date_Piece)+Char:C90(Tabulation:K15:37)+Replace string:C233($facture_e.FAC_No_Piece; "FAC/"; "")+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+\
						String:C10($centre_e.OneFactureExport.sectionCodeThird)+Uppercase:C13($heberge_e.HB_Nom)+Char:C90(Tabulation:K15:37)+Choose:C955($facture_e.FAC_Montant_TTC>=0; String:C10($facture_e.FAC_Montant_TTC); "")+Char:C90(Tabulation:K15:37)+\
						Choose:C955($facture_e.FAC_Montant_TTC<0; String:C10(Abs:C99($facture_e.FAC_Montant_TTC)); "")+Char:C90(Tabulation:K15:37)+Choose:C955($facture_e.FAC_Type_Piece="P"; "Participation"; "Hébergement")+" de "+\
						Lowercase:C14(outilsGetLibDate(2; $period_d))+" "+String:C10(Year of:C25($period_d))+" - "+$heberge_e.fullName()+Char:C90(Tabulation:K15:37)+$facture_e.FAC_No_Piece+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+\
						String:C10($facture_e.FAC_Date_Echeance)+Char:C90(Tabulation:K15:37)+""+Char:C90(Retour à la ligne:K15:40)
					
					If ($facture_e.FAC_Type_Piece="P")
						$participation_e:=ds:C1482.Participations.get($facture_e.FAC_Participation_ID)
					End if 
					
					// Ajout des lignes de crédit (Participation (montant + extra) | hébergement)
					For each ($factureLigne_e; $factureLigne_es)
						
						Case of 
							: ($factureLigne_e.FACL_Type_Ligne="participation")
								$accountProduct_i:=$societe_e.comptabilite.pariticipation
							: ($factureLigne_e.FACL_Type_Ligne="hebergement")
								$accountProduct_i:=$societe_e.comptabilite.hebergement
						End case 
						
						Case of 
							: ($factureLigne_e.FACL_Type_Ligne="participation") | ($factureLigne_e.FACL_Type_Ligne="hebergement")
								$content_o.export:=$content_o.export+"2.0"+Char:C90(Tabulation:K15:37)+"ET01"+Char:C90(Tabulation:K15:37)+"1000"+Char:C90(Tabulation:K15:37)+"ET01"+Char:C90(Tabulation:K15:37)+String:C10($centre_e.OneFactureExport.sectionCode)+Char:C90(Tabulation:K15:37)+"VE"+Char:C90(Tabulation:K15:37)+\
									"VEUS"+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+String:C10($facture_e.FAC_Date_Piece)+Char:C90(Tabulation:K15:37)+Replace string:C233($facture_e.FAC_No_Piece; "FAC/"; "")+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+\
									String:C10($accountProduct_i)+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+String:C10($factureLigne_e.FACL_Montant_TTC)+Char:C90(Tabulation:K15:37)+\
									Choose:C955($facture_e.FAC_Type_Piece="P"; "Participation"; "Hébergement")+" de "+Lowercase:C14(outilsGetLibDate(2; $period_d))+" "+String:C10(Year of:C25($period_d))+" - "+$heberge_e.fullName()+Char:C90(Tabulation:K15:37)+$facture_e.FAC_No_Piece+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+\
									String:C10($facture_e.FAC_Date_Echeance)+Char:C90(Tabulation:K15:37)+""+Char:C90(Retour à la ligne:K15:40)
							: ($factureLigne_e.FACL_Type_Ligne="participation extra")
								
								For each ($extra_o; $participation_e.PAR_Extra.detail)
									$accountProduct_i:=$societe_e.comptabilite.ph[Lowercase:C14($extra_o.libelle)]
									
									// Modifié par : Scanu Rémy (02/05/2023)
									If ($extra_o.montant>0)
										$content_o.export:=$content_o.export+"2.0"+Char:C90(Tabulation:K15:37)+"ET01"+Char:C90(Tabulation:K15:37)+"1000"+Char:C90(Tabulation:K15:37)+"ET01"+Char:C90(Tabulation:K15:37)+String:C10($centre_e.OneFactureExport.sectionCode)+Char:C90(Tabulation:K15:37)+"VE"+Char:C90(Tabulation:K15:37)+\
											"VEUS"+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+String:C10($facture_e.FAC_Date_Piece)+Char:C90(Tabulation:K15:37)+Replace string:C233($facture_e.FAC_No_Piece; "FAC/"; "")+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+\
											String:C10($accountProduct_i)+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+String:C10($extra_o.montant)+Char:C90(Tabulation:K15:37)+\
											"Charges de "+Lowercase:C14(outilsGetLibDate(2; $period_d))+" "+String:C10(Year of:C25($period_d))+" - "+$heberge_e.fullName()+Char:C90(Tabulation:K15:37)+$facture_e.FAC_No_Piece+Char:C90(Tabulation:K15:37)+""+Char:C90(Tabulation:K15:37)+\
											String:C10($facture_e.FAC_Date_Echeance)+Char:C90(Tabulation:K15:37)+""+Char:C90(Retour à la ligne:K15:40)
									End if 
									
								End for each 
								
						End case 
						
						outilsCleanVariable(->$accountProduct_i)
					End for each 
					
				End if 
				
		End case 
		
	End for each 