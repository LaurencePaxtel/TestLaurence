// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 24/02/20, 18:05:02
// ----------------------------------------------------
// Method: [Factures].factures_liste.btn_export_compta1
// Description
// 
//
// Parameters
// ----------------------------------------------------

// Modifié par : Scanu Rémy - remy@connect-io.fr (11/06/2021)
// Reprise totale de la méthode objet...
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_TEXT:C284($impression_modele; $pdf_path; $subject; $msg_text_1; $msg_text_2; $msg_text_3; $msg_text_4; $destinataire_t)
		C_LONGINT:C283($i; $total_records; $total_sent; $pos)
		C_OBJECT:C1216($transporter_o; $email_o; $statut_o)
		
		$pos:=Find in array:C230(tb_fac_choix; True:C214)
		
		If ($pos>0)
			READ ONLY:C145([HeBerge:4])
			SOC_Get_Config
			
			If (Size of array:C274(tb_fac_modeles_imp)>1)
				UTL_Form_Popup("Modèles d'impression"; ->tb_fac_modeles_imp; ->$impression_modele)
			End if 
			
			If (OK=1)
				outilsProgressBar(0; "Initialisation"; True:C214)
				
				$transporter_o:=outilsMailGestion(1)
				$total_records:=Size of array:C274(tb_fac_id)
				
				For ($i; 1; Size of array:C274(tb_fac_id))
					
					If (tb_fac_choix{$i})
						outilsProgressBar($i/$total_records; "Envoi de la facture "+String:C10($i)+"/"+String:C10($total_records))
						
						QUERY:C277([Factures:86]; [Factures:86]ID:1=tb_fac_id{$i})
						MultiSoc_Filter(->[Factures:86])
						
						QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
						MultiSoc_Filter(->[Factures_Lignes:87])
						
						ORDER BY:C49([Factures_Lignes:87]; [Factures_Lignes:87]FACL_No_Ordre:7; >)
						
						//CHERCHER([HeBerge];[HeBerge]HB_ReferenceID=[Factures]FAC_Destinataire_ID)
						QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Factures:86]FAC_Origine_ID:37)
						MultiSoc_Filter(->[HeBerge:4])
						
						$destinataire_t:=[HeBerge:4]HB_Email:68
						
						If ($destinataire_t#"")
							//GES_Imp_Maj_Variables (->[Factures])
							GES_Imp_Maj_Variables(->[Factures:86]; $impression_modele)
							
							$pdf_path:=AGL_Fiche_Print(->[Factures:86]; "print_hg_ancien"; ->[Factures_Lignes:87])
							
							If (Test path name:C476($pdf_path)=Est un document:K24:1)
								
								If ([Factures:86]FAC_Montant_TTC:8>0)
									
									If ([Factures:86]FAC_No_Piece:2#"")
										$subject:="Facture N° "+[Factures:86]FAC_No_Piece:2+" du "+String:C10([Factures:86]FAC_Date_Piece:3)
									Else 
										$subject:="Facture provisoire du "+String:C10([Factures:86]FAC_Date_Piece:3)
									End if 
									
								Else 
									$subject:="Avoir N° "+[Factures:86]FAC_No_Piece:2+" du "+String:C10([Factures:86]FAC_Date_Piece:3)
								End if 
								
								If ([Factures:86]FAC_Type_Facturation:49="Participations")
									$subject:=Replace string:C233($subject; "Facture"; "Participation")
								End if 
								
								$msg_text_1:="Bonjour,"
								
								If ([Factures:86]FAC_Montant_TTC:8>0)
									$msg_text_2:="Vous trouverez ci joint la "+$subject+", d'un Montant TTC de "+String:C10([Factures:86]FAC_Montant_TTC:8; "###,###,##0.00")+" €."
								Else 
									$msg_text_2:="Vous trouverez ci joint l'"+$subject+", d'un Montant TTC de "+String:C10([Factures:86]FAC_Montant_TTC:8; "###,###,##0.00")+" €."
								End if 
								
								$msg_text_3:="Merci!"
								
								If (SOC_Fac_Mail_Texte#"")
									SOC_Fac_Mail_Texte:=Replace string:C233(SOC_Fac_Mail_Texte; "$montant_ttc"; String:C10([Factures:86]FAC_Montant_TTC:8; "###,###,##0.00")+" €")
									SOC_Fac_Mail_Texte:=Replace string:C233(SOC_Fac_Mail_Texte; "$numero_piece"; [Factures:86]FAC_No_Piece:2)
									SOC_Fac_Mail_Texte:=Replace string:C233(SOC_Fac_Mail_Texte; "$date_piece"; String:C10([Factures:86]FAC_Date_Piece:3))
									SOC_Fac_Mail_Texte:=Replace string:C233(SOC_Fac_Mail_Texte; "\r"; "<br/>&nbsp;&nbsp;&nbsp;")
									
									If ([Factures:86]FAC_Montant_TTC:8<0)
										SOC_Fac_Mail_Texte:=Replace string:C233(SOC_Fac_Mail_Texte; "la facture"; "l'avoir")
									End if 
									
									$msg_text_2:=SOC_Fac_Mail_Texte
									CLEAR VARIABLE:C89($msg_text_3)
								End if 
								
								// Modifié par : Scanu Rémy - remy@connect-io.fr (05/07/2021)
								// Paxtel passe par Mailjet dorénavant
								$email_o:=New object:C1471("emetteur"; SO_Email; \
									"destinataire"; $destinataire_t; \
									"cc"; SO_Email; \
									"objet"; $subject; \
									"message"; MAIL_HTML_Generate($msg_text_1; $msg_text_2; $msg_text_3; $msg_text_4); \
									"pieceJointe"; New collection:C1472(MAIL New attachment:C1644($pdf_path)))
								
								$statut_o:=outilsMailGestion(2; $transporter_o; $email_o)
								
								If (Bool:C1537($statut_o.success)=True:C214)
									$total_sent:=$total_sent+1
								Else 
									ALERT:C41("Impossible d'envoyer l'email : "+$statut_o.statusText)
								End if 
								
								DELETE DOCUMENT:C159($pdf_path)
							End if 
							
						Else 
							ALERT:C41("Impossible d'envoyer la facture "+String:C10(tb_fac_id{$i})+" à "+tb_fac_usager{$i}+" car l'adresse email est inexistante")
						End if 
						
					End if 
					
					If (progressBar_el=0)
						$i:=$total_records
					End if 
					
				End for 
				
				outilsProgressBar(1; "arrêt")
				
				If ($total_sent>0)
					ALERT:C41(String:C10($total_sent)+" factures envoyées avec succès")
				Else 
					ALERT:C41("Aucune facture n'a été envoyée")
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Veuillez sélectionner une ou plusieurs factures à envoyer par email")
		End if 
		
End case 