If (Form event code:C388=Sur clic:K2:4)
	// Modified by: Kevin HASSAL (01/07/2020)
	// Ajout du contrôle pour ne pas autoriser la suppression des fiches facturées
	C_LONGINT:C283($total)
	C_OBJECT:C1216($table_o; $enregistrement_o; $autreTable_o)
	
	If (Records in selection:C76([HeberGement:5])>0)
		
		If (i_Confirmer("Supprimer : "+String:C10(vL_NbFiches)+" fiche(s)"+<>va_CR+"Confirmez-vous ?"))
			i_Message("Suppression en cours...")
			
			$total:=Records in selection:C76([HeberGement:5])
			COPY NAMED SELECTION:C331([HeberGement:5]; "$hebergements_sel")
			
			READ WRITE:C146([HeberGement:5])
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Facture:172=False:C215)
			
			If (Records in selection:C76([HeberGement:5])=$total)
				// Modifié par : Scanu Rémy - remy@connect-io.fr (09/07/2021)
				// Il faut modifier le nombre de lits disponibles dans la table [CentresLits]
				$table_o:=Create entity selection:C1512([HeberGement:5])
				
				For each ($enregistrement_o; $table_o)
					// On retrouve l'enregistrement de la table [LesCentres]
					//$autreTable_o:=ds.LesCentres.query("LC_Nom = :1";$enregistrement_o.HG_CentreNom)
					$autreTable_o:=$enregistrement_o.HG_LC_ID_4_LC_RéférenceID
					
					If ($autreTable_o.length=1)
						// Puis on recherche tous les enregistrements liées de la table [CentresLits] et on cherche ceux de la date de l'enregistrement [HeberGement]
						$autreTable_o:=$autreTable_o.LC_RéférenceID_8_CL_LC_ID.query("CL_Date = :1 AND CL_DispoTotal # :2"; $enregistrement_o.HG_Date; 0)
						
						// Bingo on a trouvé l'enregistrement, on met à jour les données
						If ($autreTable_o.length=1)
							$autreTable_o:=$autreTable_o.first()
							
							$autreTable_o.CL_Distribué:=$autreTable_o.CL_Distribué-1
							$autreTable_o.CL_Restant:=$autreTable_o.CL_Restant+1
							
							$autreTable_o.save()
						End if 
						
					End if 
					
				End for each 
				
				DELETE SELECTION:C66([HeberGement:5])
			Else 
				ALERT:C41("Suppression impossible car la sélection contient des fiches d'hébergement facturées.")
				
				USE NAMED SELECTION:C332("$hebergements_sel")
			End if 
			
			READ ONLY:C145([HeberGement:5])
			CLEAR NAMED SELECTION:C333("$hebergements_sel")
			
			vr_TotalDistri:=Sum:C1([HeberGement:5]HG_FamDistri5M:122)
			vL_NbFiches:=Records in selection:C76([HeberGement:5])
			
			If (vL_NbFiches>0)
				P_HébergementVeilleSort(2)
				
				OBJECT SET ENABLED:C1123(b_VoirPrtL; True:C214)
				OBJECT SET ENABLED:C1123(b_VoirPrt; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(b_VoirPrtL; False:C215)
				OBJECT SET ENABLED:C1123(b_VoirPrt; False:C215)
			End if 
			
			P_HébergementNotesBt(0)
			
			OBJECT SET ENABLED:C1123(b_ModCléHG; False:C215)
			OBJECT SET ENABLED:C1123(b_PrtAct; False:C215)
			OBJECT SET ENABLED:C1123(b_PrtActF; False:C215)
			OBJECT SET ENABLED:C1123(b_Excuse; False:C215)
			
			CLOSE WINDOW:C154
		End if 
		
	End if 
	
End if 