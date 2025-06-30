//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ConsoRégion_Divers
//{
//{          Mercredi 3 novembre 2010 à 15:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ve_Process)
C_LONGINT:C283($ii)
C_TEXT:C284($vt_Temp)
Case of 
	: ($1=0)  //CHARGEMENT
		<>vt_ConsoRTXT:=""
		<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Base de type : "+("CHRS"*Num:C11(<>vb_T_ModeCHRS))+("115"*Num:C11(<>vb_T_ModeCHRS=False:C215))
		If (<>vb_T_FullDuplex)
			<>vt_ConsoRTXT:=<>vt_ConsoRTXT+" en full duplex."
		End if 
		<>vt_ConsoRTXT:=<>vt_ConsoRTXT+<>va_CR
		Case of 
			: (<>ve_ConsoRegion_Mode=0)
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Mode de consolidation régionale inactivé"
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+<>va_CR
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Plage des codes centres : de "+String:C10(<>vl_T_CentreCodeDebut)+" à "+String:C10(<>vl_T_CentreCodeFin)
			: (<>ve_ConsoRegion_Mode=1)
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Mode de consolidation régionale de type 115"
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+<>va_CR
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Plage des codes centres : de "+String:C10(<>vl_T_CentreCodeDebut)+" à "+String:C10(<>vl_T_CentreCodeFin)
			: (<>ve_ConsoRegion_Mode=2)
				<>vt_ConsoRTXT:=""
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Serveur régionale"
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Mode de consolidation régionale"
		End case 
		
		r1:=Num:C11(<>vb_ConsoRAuto=True:C214)
		r2:=Num:C11(<>vb_ConsoRAuto=False:C215)
		<>vh_ConsoRTicks:=<>vl_ConsoRTicks/60
		OBJECT SET ENABLED:C1123(p1; False:C215)
		OBJECT SET ENABLED:C1123(p2; False:C215)
		OBJECT SET ENABLED:C1123(p3; False:C215)
		OBJECT SET VISIBLE:C603(vl_Thermomètre; False:C215)
		
		If (<>vl_TypeApplication=4D mode distant:K5:5)
			OBJECT SET ENABLED:C1123(b_ConsoSurServeur; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b_ConsoSurServeur; False:C215)
		End if 
		
	: ($1=1)  //Etat des PROCESS
		va_ConsoProcessEtat:=""
		p1:=1
		p2:=0
		p3:=0
		$ve_Process:=0
		$ii:=-10000
		Case of 
			: (<>ve_ConsoRegion_Mode=0)
				va_ConsoProcessEtat:="Aucun process lancé"
			: (<>ve_ConsoRegion_Mode=1)
				$vb_OK:=True:C214
				$ve_Process:=Process number:C372("ConsoRServeur"; *)
				If ($ve_Process#0)
					va_ConsoProcessEtat:="Process consolidation export régional lancé sur le serveur"
					p1:=0
					p2:=0
					p3:=1
					$ii:=Process state:C330($ve_Process)
					$vb_OK:=False:C215
				End if 
				If ($vb_OK)
					$ve_Process:=Process number:C372("ConsoRLocal")
					If ($ve_Process>0)
						p1:=0
						p2:=1
						p3:=0
						va_ConsoProcessEtat:="Process consolidation export régional lancé sur le poste : "
						$ii:=Process state:C330($ve_Process)
					End if 
				End if 
				
			: (<>ve_ConsoRegion_Mode=2)
				$vb_OK:=True:C214
				$ve_Process:=Process number:C372("ConsoRServeur"; *)
				If ($ve_Process#0)
					va_ConsoProcessEtat:="Process consolidation import régional lancé sur le serveur"
					p1:=0
					p2:=0
					p3:=1
					$ii:=Process state:C330($ve_Process)
					$vb_OK:=False:C215
				End if 
				If ($vb_OK)
					$ve_Process:=Process number:C372("ConsoRLocal")
					If ($ve_Process>0)
						p1:=0
						p2:=1
						p3:=0
						va_ConsoProcessEtat:="Process consolidation import régional lancé sur le poste : "
						$ii:=Process state:C330($ve_Process)
					End if 
				End if 
		End case 
		If ($ii#-10000)
			Case of 
				: ($ii=-1)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+" Détruit "
				: ($ii=1)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"Endormi"
				: ($ii=-100)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"Inexistant"
				: ($ii=0)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"En exécution"
				: ($ii=6)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"Dialogue caché"
				: ($ii=5)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"Suspendu"
				: ($ii=3)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"En attente entrée sortie"
				: ($ii=4)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"En attente drapeau interne"
				: ($ii=2)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"En attente événement"
			End case 
		End if 
		
		If (p1=1)
			OBJECT SET ENABLED:C1123(b_ConsoSurEtat; False:C215)
			OBJECT SET ENABLED:C1123(b_ConsoSurArreter; False:C215)
			OBJECT SET VISIBLE:C603(vl_Thermomètre; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(b_ConsoSurEtat; True:C214)
			OBJECT SET ENABLED:C1123(b_ConsoSurArreter; True:C214)
			OBJECT SET VISIBLE:C603(vl_Thermomètre; ($ii=0))
		End if 
		
		
	: ($1=2)  //ARRETER PROCESS
		Case of 
			: (p1=1)
				BEEP:C151
				ALERT:C41("Aucun process de consolidation régionale n'est lancé !")
			: (p2=1)
				If (i_Confirmer("Arrêter le process de consolidation régional lancé sur le poste ?"))
					<>vb_TransfertRegional_Fin:=True:C214
					Repeat 
					Until (<>PR_ConsoRPoste=0)
					P_ConsoRégion_Divers(1)
				End if 
			: (p3=1)
				ALERT:C41("Pour arrêter le process de consolidation région lancé sur le serveur :"+"Veuiller positionner la valeur du paramètre 'Automatique' à non, "+"enregistrer les paramètres et attrendre la fin du cycle.")
		End case 
		
	: ($1=3)  //PROCESS sur le poste
		Case of 
			: (p1=1)
				If (<>PR_ConsoRPoste=0)
					//◊PR_ConsoRServeur:=Executer sur serveur("Go_ConsoRegional";0;"ConsoRServeu
					<>PR_ConsoRPoste:=New process:C317("Go_ConsoRegional"; 0; "ConsoRLocal"; False:C215)  //updt
					Repeat 
					Until (<>PR_ConsoRPoste>0)
					P_ConsoRégion_Divers(1)
				Else 
					ALERT:C41("Le process est déjà lancé sur le poste !")
				End if 
			: (p2=1)
				If (<>PR_ConsoRPoste=0)
					<>PR_ConsoRPoste:=New process:C317("Go_ConsoRegional"; 0; "ConsoRLocal"; False:C215)  //updt
					Repeat 
					Until (<>PR_ConsoRPoste>0)
					P_ConsoRégion_Divers(1)
				Else 
					ALERT:C41("Le process est déjà lancé sur le poste !")
				End if 
				
			: (p3=1)
				ALERT:C41("Le process est déjà lancé sur le serveur !")
		End case 
		
		
	: ($1=4)  //PROCESS sur le Serveur
		Case of 
			: (p1=1)
				$ve_Process:=Process number:C372("ConsoRServeur"; *)
				If ($ve_Process=0)
					<>PR_ConsoRServeur:=Execute on server:C373("Go_ConsoRegional"; 0; "ConsoRServeur"; True:C214; <>ref_soc_active)
					Repeat 
						$ve_Process:=Process number:C372("ConsoRServeur"; *)
					Until ($ve_Process#0)
					P_ConsoRégion_Divers(1)
				Else 
					ALERT:C41("Le process est déjà lancé sur le serveur !")
				End if 
				
			: (p2=1)
				ALERT:C41("Le process est déjà lancé sur le poste !")
				
			: (p3=1)
				$ve_Process:=Process number:C372("ConsoRServeur"; *)
				If ($ve_Process=0)
					<>PR_ConsoRServeur:=Execute on server:C373("Go_ConsoRegional"; 0; "ConsoRServeur"; True:C214; <>ref_soc_active)
					Repeat 
						$ve_Process:=Process number:C372("ConsoRServeur"; *)
					Until ($ve_Process#0)
					P_ConsoRégion_Divers(1)
				Else 
					ALERT:C41("Le process est déjà lancé sur le serveur !")
				End if 
				
		End case 
		
		
	: ($1=10)  //CHARGEMENT
		
		Case of 
			: (<>ve_ConsoRegion_Mode=0)
				<>vt_ConsoRTXT:=""
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Base de type : "+("CHRS"*Num:C11(<>vb_T_ModeCHRS))+("115"*Num:C11(<>vb_T_ModeCHRS=False:C215))
				If (<>vb_T_FullDuplex)
					<>vt_ConsoRTXT:=<>vt_ConsoRTXT+" en full duplex."
				End if 
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+<>va_CR
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Mode de consolidation régionale inactivé"
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+<>va_CR
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Plage des codes centres : de "+String:C10(<>vl_T_CentreCodeDebut)+" à "+String:C10(<>vl_T_CentreCodeFin)
			: (<>ve_ConsoRegion_Mode=1)
				<>vt_ConsoRTXT:=""
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Base de type : "+("CHRS"*Num:C11(<>vb_T_ModeCHRS))+("115"*Num:C11(<>vb_T_ModeCHRS=False:C215))
				If (<>vb_T_FullDuplex)
					<>vt_ConsoRTXT:=<>vt_ConsoRTXT+" en full duplex."
				End if 
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+<>va_CR
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Mode de consolidation régionale de type 115"
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+<>va_CR
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Plage des codes centres : de "+String:C10(<>vl_T_CentreCodeDebut)+" à "+String:C10(<>vl_T_CentreCodeFin)
			: (<>ve_ConsoRegion_Mode=2)
				<>vt_ConsoRTXT:=""
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Serveur régionale"
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+<>va_CR
				<>vt_ConsoRTXT:=<>vt_ConsoRTXT+"Mode de consolidation régionale"
		End case 
		
		
		OBJECT SET VISIBLE:C603(*; "b_Periode_@"; False:C215)
		OBJECT SET ENABLED:C1123(b_ConsoSurPoste; True:C214)
		
		Case of 
			: (<>ve_ConsoRegion_Mode=0)
				OBJECT SET TITLE:C194(b_ConsoSurPoste; "Lancer le process")
				OBJECT SET ENABLED:C1123(b_ConsoSurPoste; False:C215)
			: (<>ve_ConsoRegion_Mode=1)
				OBJECT SET VISIBLE:C603(*; "b_Periode_@"; True:C214)
				OBJECT SET TITLE:C194(b_ConsoSurPoste; "Lancer l'export")
			: (<>ve_ConsoRegion_Mode=2)
				OBJECT SET TITLE:C194(b_ConsoSurPoste; "Lancer l'import")
		End case 
		
		
	: ($1=11)  //Etat des PROCESS
		va_ConsoProcessEtat:=""
		$ve_Process:=0
		$ii:=-10000
		Case of 
			: (<>ve_ConsoRegion_Mode=0)
				va_ConsoProcessEtat:="Aucun process lancé"
			: (<>ve_ConsoRegion_Mode=1)
				$vb_OK:=True:C214
				$ve_Process:=Process number:C372("ConsoRServeur"; *)
				If ($ve_Process#0)
					va_ConsoProcessEtat:="Process consolidation export régional lancé sur le serveur"
					$ii:=Process state:C330($ve_Process)
					$vb_OK:=False:C215
				End if 
				If ($vb_OK)
					$ve_Process:=Process number:C372("ConsoRLocal")
					If ($ve_Process>0)
						va_ConsoProcessEtat:="Process consolidation export régional lancé sur le poste : "
						$ii:=Process state:C330($ve_Process)
					Else 
						va_ConsoProcessEtat:="Process consolidation export régional  : aucun process lancé"
					End if 
				End if 
				
			: (<>ve_ConsoRegion_Mode=2)
				$vb_OK:=True:C214
				$ve_Process:=Process number:C372("ConsoRServeur"; *)
				If ($ve_Process#0)
					va_ConsoProcessEtat:="Process consolidation import régional lancé sur le serveur"
					$ii:=Process state:C330($ve_Process)
					$vb_OK:=False:C215
				End if 
				If ($vb_OK)
					$ve_Process:=Process number:C372("ConsoRLocal")
					If ($ve_Process>0)
						va_ConsoProcessEtat:="Process consolidation import régional lancé sur le poste : "
						$ii:=Process state:C330($ve_Process)
					Else 
						va_ConsoProcessEtat:="Process consolidation import régional : aucun process lancé"
					End if 
				End if 
		End case 
		If ($ii#-10000)
			Case of 
				: ($ii=-1)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+" Détruit "
				: ($ii=1)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"Endormi"
				: ($ii=-100)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"Inexistant"
				: ($ii=0)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"En exécution"
				: ($ii=6)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"Dialogue caché"
				: ($ii=5)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"Suspendu"
				: ($ii=3)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"En attente entrée sortie"
				: ($ii=4)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"En attente drapeau interne"
				: ($ii=2)
					va_ConsoProcessEtat:=va_ConsoProcessEtat+"En attente événement"
			End case 
		End if 
		
		
		
		
	: ($1=12)  //ARRETER PROCESS
	: ($1=13)  //PROCESS sur le poste
		Case of 
			: (<>ve_ConsoRegion_Mode=0)
				
			: (<>ve_ConsoRegion_Mode=1)
				$vb_O:=False:C215
				If (vb_ExportEnCours)
					//Export en cours          
				Else 
					$vb_OK:=i_Confirmer("Lancer l'export régionale ?")
					If ($vb_OK)
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4>=vd_Date1; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2)
						MultiSoc_Filter(->[HeberGement:5])
						$ii:=Records in selection:C76([HeberGement:5])
						If ($ii>0)
							$vb_OK:=i_Confirmer("Lancer l'export régionale de "+String:C10($ii; "# ### ##0")+" fiche(s) ?"+<>va_CR+"(2 ème confirmation)")
						Else 
							$vb_OK:=False:C215
							ALERT:C41("Acune fiche à exporter !")
						End if 
					End if 
				End if 
				
				If ($vb_OK)  //EXPORT
					vb_ExportEnCours:=True:C214
					OBJECT SET ENABLED:C1123(b_ConsoSurPoste; False:C215)
					ON ERR CALL:C155("i_Error")
					vl_Thermomètre:=$ii
					vl_ThermoIndice:=0
					
					vd_DateRéelle:=Current date:C33
					vd_HeureRéelle:=Current time:C178
					<>va_ConsoR_Site:=<>va_T_Departement
					$vt_Temp:=<>vt_ConsoRegion_Dosssier
					<>vt_ConsoRegion_Dosssier:=Select folder:C670("Sélectionnez le dossier d'accueil ?")
					If (OK=1)
						FIRST RECORD:C50([HeberGement:5])
						MESSAGES OFF:C175
						vb_Message:=True:C214
						i_Message("Export en cours")
						APPLY TO SELECTION:C70([HeberGement:5]; F_RG_LesFiches)
						vb_Message:=False:C215
						CLOSE WINDOW:C154
					End if 
					<>vt_ConsoRegion_Dosssier:=$vt_Temp
					ON ERR CALL:C155("")
					
					OBJECT SET ENABLED:C1123(b_ConsoSurPoste; True:C214)
					vb_ExportEnCours:=False:C215
				End if 
				
			: (<>ve_ConsoRegion_Mode=2)
				
				If (vb_ImportEnCours)
					$vb_OK:=False:C215
					//Import en cours          
				Else 
					$vb_OK:=i_Confirmer("Lancer l'import régional ?")
					If ($vb_OK)
						$vb_OK:=False:C215
						vt_Conso_Dossier:=Select folder:C670("Sélectionnez le dossier à importer ?")
						If (OK=1)
							DOCUMENT LIST:C474(vt_Conso_Dossier; ta_Conso_Document)
							$vb_OK:=F_RG_LesDocuments(->ta_Conso_Document)
							If ($vb_OK)
								$vb_OK:=i_Confirmer("Lancer l'import régional de "+String:C10(Size of array:C274(ta_Conso_Document); "# ### ##0")+" document(s) ?"+<>va_CR+"(2 ème confirmation)")
							Else 
								ALERT:C41("Aucun document ne correspond à l'import régional !")
							End if 
							
						End if 
					End if 
				End if 
				
				If ($vb_OK)
					i_Message("Import régional…")
					For ($ii; 1; Size of array:C274(ta_Conso_Document))
						$vb_OK:=F_RG_LesDocumentsTableau(0; 0)
						
						vt_TitreDocument:=vt_Conso_Dossier+ta_Conso_Document{$ii}
						vt_TitreDocument:=F_FichierSuffixe(vt_TitreDocument)
						If (Test path name:C476(vt_TitreDocument)=Est un document:K24:1)
							$vb_OK:=F_RG_LesDocuments(->ta_Conso_Document)
							If ($vb_OK)
								vh_Réf:=Open document:C264(vt_TitreDocument)
								If (OK=1)
									
									//(•Découpage du nom du document
									$vb_OK:=F_Report_FullDuplexTitre(ta_Conso_Document{$ii})
									i_MessageSeul("Import régional : "+String:C10(Size of array:C274(ta_Conso_Document); "# ### ##0")+" / "+String:C10($ii; "# ### ##0")+"   -   "+<>va_Conso_FicheGenre+" "+<>va_Conso_FicheAge)
									
									//(•Lecture du document
									USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
									$vb_OK:=F_RG_LesDocumentsDecoupe(vh_Réf)
									USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
									
									CLOSE DOCUMENT:C267(vh_Réf)
									
									//(•Déplacer le document        
									If ($vb_OK)
										$vb_OK:=F_RG_DocumentsDéplacer(vt_Conso_Dossier; ta_Conso_Document{$ii}; "LU")
									End if 
									//(•Importer le document                          
									If ($vb_OK)
										$vb_OK:=F_RG_FicheImporter
									End if 
								End if 
							End if 
						End if 
					End for 
					CLOSE WINDOW:C154
				End if 
		End case 
End case 


