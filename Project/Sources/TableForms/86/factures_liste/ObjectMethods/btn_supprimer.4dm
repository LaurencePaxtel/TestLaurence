// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 13/02/20, 13:04:12
// ----------------------------------------------------
// Method: [Factures].Liste_HB.btn_imprimer
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($msg)
C_LONGINT:C283($i; $j; $pos)
C_BOOLEAN:C305($continu)

var $montant_r : Real
var $statut_o : Object
var $facture_c : Collection

var $facture_e : cs:C1710.FacturesEntity
var $facture_es : cs:C1710.FacturesSelection

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CONFIRM:C162("Vous êtes entrain de supprimer des factures et/ou règlements sélectionnés, voulez-vous continuer ?"; "Oui"; "Non")
		
		If (ok=1)
			$continu:=True:C214
			$pos:=Find in array:C230(tb_fac_choix; True:C214)
			
			If ($pos>0)
				START TRANSACTION:C239
				
				READ WRITE:C146([Factures:86])
				READ WRITE:C146([Factures_Lignes:87])
				READ WRITE:C146([HeberGement:5])
				READ WRITE:C146([Participations:116])
				
				For ($i; 1; Size of array:C274(tb_fac_id))
					
					If (tb_fac_choix{$i})  //| Appartient au groupe(Utilisateur courant; <>Groupe_Comptable))
						
						If (User in group:C338(Current user:C182; <>Groupe_Comptable))
							
							If (tb_fac_numero_piece{$i}#"RC/@")  // Suppression d'une facture
								QUERY:C277([Factures:86]; [Factures:86]ID:1=tb_fac_id{$i})
								MultiSoc_Filter(->[Factures:86])
								
								If (Records in selection:C76([Factures:86])=1)
									
									If (Not:C34(Locked:C147([Factures:86])))
										
										// Modifié par : Scanu Rémy (21/12/2021)
										Case of 
											: ([Factures:86]FAC_Type:21="Provisoire") | User in group:C338(Current user:C182; <>Groupe_Comptable)
												
												If ([Factures:86]FAC_Type_Facturation:49="Participations")
													READ WRITE:C146([Participations:116])
													
													// Modifié par : Scanu Rémy - remy@connect-io.fr (09/06/2021)
													// Du fait de la modification dans le formulaire [Factures]Liste_P, il faut changer la recherche...
													//CHERCHER([Participations];[Participations]ID=[Factures]FAC_Origine_ID)
													QUERY:C277([Participations:116]; [Participations:116]ID:1=[Factures:86]FAC_Participation_ID:62)
													MultiSoc_Filter(->[Participations:116])
													
													If (Records in selection:C76([Participations:116])=1)
														
														If (Not:C34(Locked:C147([Participations:116])))
															[Participations:116]PAR_Facture:19:=False:C215
															SAVE RECORD:C53([Participations:116])
														Else 
															$continu:=False:C215
															$msg:="La fiche de participation est vérrouillée"
														End if 
														
													End if 
													
												End if 
												
												QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
												MultiSoc_Filter(->[Factures_Lignes:87])
												
												While (Not:C34(End selection:C36([Factures_Lignes:87])))
													ARRAY TEXT:C222($tb_données; 0)
													
													UTL_Cut_Text(->[Factures_Lignes:87]FACL_Service_Ids:30; ->$tb_données; ";")
													ARRAY LONGINT:C221($tb_donnees_num; Size of array:C274($tb_données))
													
													For ($j; 1; Size of array:C274($tb_données))
														$tb_donnees_num{$j}:=Num:C11($tb_données{$j})
													End for 
													
													READ WRITE:C146([HeberGement:5])
													
													QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tb_donnees_num)
													APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_Facture:172:=False:C215)
													
													USE SET:C118("LockedSet")
													
													If (Records in set:C195("LockedSet")>0)
														$continu:=False:C215
													End if 
													
													NEXT RECORD:C51([Factures_Lignes:87])
												End while 
												
												LOAD RECORD:C52([Factures_Lignes:87])
												
												DELETE RECORD:C58([Factures:86])
												DELETE SELECTION:C66([Factures_Lignes:87])
											: ([Factures:86]FAC_Type:21="Avoir")
												$continu:=False:C215
												
												If ($msg#"")
													$msg:=$msg+Char:C90(Retour chariot:K15:38)
												End if 
												
												$msg:=$msg+"Impossible de supprimer l'avoir "+[Factures:86]FAC_No_Piece:2+" car il est définitif"
											: ([Factures:86]FAC_Type:21="Définitive")
												$continu:=False:C215
												
												If ($msg#"")
													$msg:=$msg+Char:C90(Retour chariot:K15:38)
												End if 
												
												$msg:=$msg+"Impossible de supprimer la facture "+[Factures:86]FAC_No_Piece:2+" car elle est définitive"
										End case 
										
									Else 
										$continu:=False:C215
										
										If ($msg#"")
											$msg:=$msg+Char:C90(Retour chariot:K15:38)
										End if 
										
										$msg:=$msg+"Impossible de supprimer la facture "+[Factures:86]FAC_No_Piece:2+" car elle est verouillée."
									End if 
									
								Else 
									$continu:=False:C215
									$msg:="La facture avec l'ID "+String:C10(tb_fac_id{$i})+" n'a pas pu être trouvée dans la base de donnée"
								End if 
								
							Else   // Suppression d'un règlement
								QUERY:C277([Reglements:93]; [Reglements:93]ID:1=tb_fac_id{$i})
								MultiSoc_Filter(->[Reglements:93])
								
								$facture_c:=Split string:C1554([Reglements:93]REG_Origine_IDS:21; ";")
								$facture_es:=ds:C1482.Factures.query("ID in :1"; $facture_c).orderBy("FAC_Annee desc, FAC_Mois desc")
								
								$montant_r:=[Reglements:93]REG_Montant:5
								
								For each ($facture_e; $facture_es) Until ($montant_r=0)
									
									If ($montant_r>$facture_e.FAC_Solde_Regle)
										$montant_r:=$montant_r-$facture_e.FAC_Solde_Regle
										$facture_e.FAC_Solde_Regle:=0
									Else 
										$facture_e.FAC_Solde_Regle:=$facture_e.FAC_Solde_Regle-$montant_r
										CLEAR VARIABLE:C89($montant_r)
									End if 
									
									If ($facture_e.FAC_Solde_Regle#$facture_e.FAC_Montant_TTC)
										$facture_e.FAC_Statut:=""
										$facture_e.FAC_Regle:=False:C215
									End if 
									
									Case of 
										: ($facture_e.FAC_Regle=True:C214)  //  Réglé
											$facture_e.FAC_Regle_Status_Color:=0x0044FC7B
										: ($facture_e.FAC_Solde_Regle>0) & ($facture_e.FAC_Solde_Regle#$facture_e.FAC_Montant_TTC)  // Réglé partiellement
											$facture_e.FAC_Regle_Status_Color:=0x00FCB944
										Else   // Non réglé 
											$facture_e.FAC_Regle_Status_Color:=0x00FC5944
									End case 
									
									$statut_o:=$facture_e.save()
								End for each 
								
								DELETE RECORD:C58([Reglements:93])
							End if 
							
						Else 
							$continu:=False:C215
							$msg:="Vous n'êtes pas autorisé à supprimer une facture ou un règlement"
						End if 
						
					End if 
					
					If (tb_fac_choix{$i}) & ($continu=False:C215)
						$i:=Size of array:C274(tb_fac_id)
					End if 
					
					UNLOAD RECORD:C212([Factures:86])
					UNLOAD RECORD:C212([Reglements:93])
				End for 
				
				If ($msg="")
					$msg:="Impossible de supprimer les factures sélectionnées"
				End if 
				
				If (Not:C34($continu))
					CANCEL TRANSACTION:C241
					ALERT:C41($msg)
				Else 
					VALIDATE TRANSACTION:C240
					
					FAC_Get_Liste_Factures
					ALERT:C41("Suppression effectuée avec succès")
				End if 
				
			Else 
				ALERT:C41("Veuillez sélectionner une ou plusieurs facture à supprimer")
			End if 
			
		End if 
		
End case 