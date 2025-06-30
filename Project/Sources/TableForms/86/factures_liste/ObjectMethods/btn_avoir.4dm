// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 03/03/20, 20:57:39
// ----------------------------------------------------
// Method: [Factures].factures_liste.btn_avoir
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_TEXT:C284($msg; $ids_hebergements; $avoir_t)
		C_LONGINT:C283($i; $j; $k; $pos; $id_facture; $id_avoir; $k_el)
		C_REAL:C285($montantTTC_r)
		C_BOOLEAN:C305($continu)
		C_OBJECT:C1216($enregistrement_o)
		
		ARRAY REAL:C219($avoir_ai; 0)
		
		GES_Definition_Champs("facture")
		
		$continu:=True:C214
		$pos:=Find in array:C230(tb_fac_choix; True:C214)
		
		If ($pos>0)
			CONFIRM:C162("Vous êtes entrain de créer des avoirs pour les factures sélectionnées, voulez-vous continuer ?"; "Oui"; "Non")
			
			If (ok=1)
				START TRANSACTION:C239
				
				For ($i; 1; Size of array:C274(tb_fac_id))
					
					If (tb_fac_choix{$i})
						QUERY:C277([Factures:86]; [Factures:86]ID:1=tb_fac_id{$i})
						MultiSoc_Filter(->[Factures:86])
						
						If (Records in selection:C76([Factures:86])=1)
							
							If ([Factures:86]FAC_No_Piece:2#"")
								$id_facture:=[Factures:86]ID:1
								
								DUPLICATE RECORD:C225([Factures:86])
								
								[Factures:86]FAC_Date_Piece:3:=Current date:C33(*)
								[Factures:86]FAC_No_Piece:2:=SO_Avoir_Prefixe+"/"+UTL_Numerotation_Piece(->[Factures:86]FAC_Date_Piece:3)
								
								// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
								// [Factures]FAC_Origine_ID = [Heberge]HB_ReferenceID et non l'id de la facture qui a servi à créer l'avoir
								//[Factures]FAC_Origine_ID:=$id_facture
								[Factures:86]FAC_Statut:16:="Réglée"
								[Factures:86]FAC_Regle:41:=True:C214
								[Factures:86]FAC_Regle_Status_Color:44:=0x0044FC7B  // Réglé
								
								// Modifié par : Scanu Rémy - remy@connect-io.fr (01/07/2021)
								// On stocke l'id de la facture d'origine et on ne mets aucune réglement dans l'avoir
								[Factures:86]FAC_Avoir_ID:38:=$id_facture
								[Factures:86]FAC_Solde_Regle:26:=0
								
								// Modifié par : Scanu Rémy (13/12/2021)
								$soldeDu_cal_r:=ds:C1482.Factures.get([Factures:86]ID:1).FAC_Solde_Du_cal
								Repeat 
									$avoir_t:=Request:C163("Montant de l'avoir ?"; String:C10($soldeDu_cal_r); "Valider"; "Annuler")
									
									If (OK=1)
										
										Case of 
											: (Num:C11($avoir_t)<=0)
												ALERT:C41("Le montant de l'avoir doit être strictement supérieur à 0 €")
											: (Num:C11($avoir_t)>$soldeDu_cal_r)
												ALERT:C41("Le montant de l'avoir doit être inférieur ou égal au montant du solde du de la facture("+String:C10($soldeDu_cal_r)+" €)")
												
												CLEAR VARIABLE:C89($avoir_t)
										End case 
										
									Else 
										$msg:="Création de l'avoir annulé"
									End if 
									
								Until (Num:C11($avoir_t)>0) | (OK=0)
								
								$continu:=(OK=1)
								
								[Factures:86]FAC_Montant_TTC:8:=-Num:C11($avoir_t)
								APPEND TO ARRAY:C911($avoir_ai; Num:C11($avoir_t))
								
								// Modifié par : Scanu Rémy - remy@connect-io.fr (27/07/2021)
								[Factures:86]FAC_Type:21:="Avoir"
								
								SAVE RECORD:C53([Factures:86])
								
								$id_avoir:=[Factures:86]ID:1
								
								QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=$id_facture)
								MultiSoc_Filter(->[Factures_Lignes:87])
								
								ARRAY LONGINT:C221($tb_lig_id; 0)
								SELECTION TO ARRAY:C260([Factures_Lignes:87]ID:1; $tb_lig_id)
								
								For ($j; 1; Size of array:C274($tb_lig_id))
									READ WRITE:C146([Factures_Lignes:87])
									
									QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=$id_facture; *)
									QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]ID:1=$tb_lig_id{$j})
									MultiSoc_Filter(->[Factures_Lignes:87])
									
									$ids_hebergements:=[Factures_Lignes:87]FACL_Service_Ids:30
									
									[Factures_Lignes:87]FACL_Service_Ids:30:=""
									SAVE RECORD:C53([Factures_Lignes:87])
									
									//=============================
									// Annulation des fiches d'hébergement facturées
									//=============================
									ARRAY TEXT:C222($tb_données; 0)
									
									UTL_Cut_Text(->$ids_hebergements; ->$tb_données; ";")
									ARRAY LONGINT:C221($tb_donnees_num; Size of array:C274($tb_données))
									
									For ($k; 1; Size of array:C274($tb_données))
										$tb_donnees_num{$k}:=Num:C11($tb_données{$k})
									End for 
									
									READ WRITE:C146([HeberGement:5])
									
									QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tb_donnees_num)
									APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_Facture:172:=False:C215)
									
									USE SET:C118("LockedSet")
									
									If (Records in set:C195("LockedSet")>0)
										$continu:=False:C215
									End if 
									//====================================
									
									DUPLICATE RECORD:C225([Factures_Lignes:87])
									
									// Modifié par : Scanu Rémy (05/07/2022)
									//[Factures_Lignes]FACL_Quantite:=-1
									[Factures_Lignes:87]FACL_Quantite:18:=-[Factures_Lignes:87]FACL_Quantite:18
									
									[Factures_Lignes:87]FACL_Piece_ID:3:=$id_avoir
									
									// Modifié par : Scanu Rémy (30/06/2022)
									//[Factures_Lignes]FACL_Montant_HT:=Num($avoir_t)
									//[Factures_Lignes]FACL_Prix_Unit_HT:=Num($avoir_t)
									
									GES_Calcul_Ligne
									SAVE RECORD:C53([Factures_Lignes:87])
								End for 
								
								READ WRITE:C146([Factures:86])
								
								QUERY:C277([Factures:86]; [Factures:86]ID:1=$id_avoir)
								MultiSoc_Filter(->[Factures:86])
								
								QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
								MultiSoc_Filter(->[Factures_Lignes:87])
								
								// Modifié par : Scanu Rémy - remy@connect-io.fr (01/07/2021)
								$montantTTC_r:=[Factures:86]FAC_Montant_TTC:8
								Web_Piece_Calcul_Pied_2(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; "facture")
								
								[Factures:86]FAC_Montant_TTC:8:=$montantTTC_r
								SAVE RECORD:C53([Factures:86])
							Else 
								CLEAR VARIABLE:C89($continu)
								
								$msg:="Impossible de créer un avoir pour les factures provisoires"
							End if 
							
						Else 
							CLEAR VARIABLE:C89($continu)
						End if 
						
					End if 
					
				End for 
				
				If ($msg="")
					$msg:="Impossible de génerer les avoirs pour les factures sélectionnées"
				End if 
				
				If (Not:C34($continu))
					CANCEL TRANSACTION:C241
					
					ALERT:C41($msg)
				Else 
					
					For ($i; 1; Size of array:C274(tb_fac_id))
						
						If (tb_fac_choix{$i})
							// Modifié par : Scanu Rémy - remy@connect-io.fr (01/07/2021)
							// Il faut passé la facture d'origine à régler également
							$enregistrement_o:=ds:C1482.Factures.get(tb_fac_id{$i})
							$k_el:=$k_el+1
							
							If ($enregistrement_o#Null:C1517)
								
								If ($enregistrement_o.FAC_Solde_Du_cal<=0)
									$enregistrement_o.FAC_Statut:="Réglée"
									$enregistrement_o.FAC_Regle:=True:C214
								Else 
									$enregistrement_o.FAC_Statut:=""
									$enregistrement_o.FAC_Regle:=False:C215
								End if 
								
								Case of 
									: ($enregistrement_o.FAC_Solde_Du_cal<=0)  //  réglé
										$enregistrement_o.FAC_Regle_Status_Color:=0x0044FC7B
									: ($enregistrement_o.FAC_Solde_Du_cal>0)  // réglé partiellement
										$enregistrement_o.FAC_Regle_Status_Color:=0x00FCB944
									Else   // non réglé 
										$enregistrement_o.FAC_Regle_Status_Color:=0x00FC5944
								End case 
								
								$enregistrement_o.save()
							End if 
							
						End if 
						
					End for 
					
					VALIDATE TRANSACTION:C240
					FAC_Get_Liste_Factures
					
					ALERT:C41("Opération effectuée avec succès")
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Veuillez sélectionner une ou plusieurs factures")
		End if 
		
End case 