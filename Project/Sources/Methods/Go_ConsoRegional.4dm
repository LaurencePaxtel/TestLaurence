//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : Go_ConsoRégional
//{          Mardi 2 novembre 2010 à 17:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_BOOLEAN:C305($1)
C_BOOLEAN:C305($vb_OK)
C_BOOLEAN:C305(vb_SurServeur)
vb_SurServeur:=$1

MultiSoc_Init_On_Server(Count parameters:C259; $2)

READ ONLY:C145(*)
MESSAGES OFF:C175
//Déclarations des globales
C_BOOLEAN:C305(vb_OK; vb_Conso; vb_Message)
C_LONGINT:C283(gError; vl_ii; vl_ij; vl_ThermoIndice; vl_Fiches; vl_ThermoPas; $vl_Position)
vb_OK:=False:C215
vb_Conso:=False:C215
vb_Message:=False:C215
gError:=0
vl_ii:=0
vl_ij:=0
C_TIME:C306(vh_Réf)
C_LONGINT:C283($ii)
C_LONGINT:C283($vl_AfficheToutes)
C_TEXT:C284($va_Conso_Titre)
C_TEXT:C284($vt_Buffer)


ARRAY TEXT:C222(ta_Conso_Document; 0)
ARRAY TEXT:C222(ta_Conso_DocumentDos; 0)
C_TEXT:C284(va_TransFrom)
$vb_OK:=F_Report_FullDuplexVAR  //••   `Variables communes au report
$vb_OK:=F_VariablesTransite(0; 2; False:C215)

C_TIME:C306($vh_HeureD; $vh_HeureF)
$vh_HeureD:=Current time:C178
$vh_HeureF:=$vh_HeureD

If (vb_SurServeur)
	DébutInitConsoR(4)
Else 
	<>vb_ConsoRAuto:=i_Confirmer("Lancer la consolidation régionale (2 ème confirmation) ?")
End if 

If (<>vb_ConsoRAuto)
	<>va_ConsoR_Chrono:=""
	Repeat 
		$vh_HeureD:=Current time:C178
		$vh_HeureF:=$vh_HeureD
		$vl_AfficheToutes:=0
		
		//•(1) Les dates et heures    
		i_DateServeurPoste(vb_SurServeur)
		
		//•(2) Une condition
		If (vb_SurServeur)
			vb_Conso:=((vd_HeureRéelle>=<>vh_ConsoRAuto1) & (vd_HeureRéelle<=<>vh_ConsoRAuto2))
		Else 
			vb_Conso:=True:C214
		End if 
		
		//•(3) Le ou les répertoires de consolidation régionale existent-t-ils
		If (vb_Conso)
			vb_Conso:=F_RG_LesRepertoires
		End if 
		
		//•(4) `Les répertoires de consolidation régionale LU existent-t-ils
		If (vb_Conso)
			vb_Conso:=F_RG_LesRepertoiresLus
		End if 
		
		//•(5) y a t il des fiches    
		If (vb_Conso)
			vb_Conso:=F_RG_LaSelection
		End if 
		
		
		//•(6) Il y a des fiches
		If (vb_Conso)
			<>va_ConsoR_Site:=<>va_T_Departement
			//On fait l'import  ou l'export gError:=0
			ON ERR CALL:C155("i_Error")
			Case of 
				: (<>ve_ConsoRegion_Mode=0)  //Mode de consolidation régionale inactivé
					//On ne peut pas arriver ici
				: (<>ve_ConsoRegion_Mode=1)  //Mode de consolidation régionale de type 115 : export
					//Exporter les fiches
					vl_Fiches:=Records in selection:C76([HeberGement:5])
					vl_ThermoPas:=vl_Fiches\10
					If (vl_ThermoPas=0)
						vl_ThermoPas:=10
					End if 
					vl_ThermoIndice:=0
					If (vb_SurServeur=False:C215)
						<>va_TransfertRegional_Action:=<>va_TransfertRegional_Action0  //"Thermo init"
						POST OUTSIDE CALL:C329(<>PR_ConsoRParam)
					End if 
					
					FIRST RECORD:C50([HeberGement:5])
					APPLY TO SELECTION:C70([HeberGement:5]; F_RG_LesFiches)
					
				: (<>ve_ConsoRegion_Mode=2)  //Serveur régionale : import
					//Importer les fiches
					For ($ii; 1; Size of array:C274(ta_Conso_Document))
						ARRAY TEXT:C222($ta_Conso_P_Titre; 0)
						ARRAY TEXT:C222($ta_Conso_P_Valeur; 0)
						ARRAY INTEGER:C220($te_Conso_P_Table; 0)
						ARRAY INTEGER:C220($te_Conso_P_Champ; 0)
						ARRAY INTEGER:C220($te_Conso_P_ChampType; 0)
						
						ARRAY TEXT:C222($ta_Conso_H_Titre; 0)
						ARRAY TEXT:C222($ta_Conso_H_Valeur; 0)
						ARRAY INTEGER:C220($te_Conso_H_Table; 0)
						ARRAY INTEGER:C220($te_Conso_H_Champ; 0)
						ARRAY INTEGER:C220($te_Conso_H_ChampType; 0)
						
						
						vt_TitreDocument:=tt_Conso_DocumentDos{$ii}+ta_Conso_Document{$ii}
						vt_TitreDocument:=F_FichierSuffixe(vt_TitreDocument)
						If (Test path name:C476(vt_TitreDocument)=Est un document:K24:1)
							
							USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
							
							vh_Réf:=Open document:C264(vt_TitreDocument)
							If (OK=1)
								//(•Découpage du nom du document
								$vb_OK:=F_Report_FullDuplexTitre(ta_Conso_Document{$ii})
								$vb_OK:=F_RG_FicheTitre(ta_Conso_Document{$ii})
								//(•Ligne de titre dans le document
								RECEIVE PACKET:C104(vh_Réf; <>vt_Buffer; <>va_CR)
								<>vt_Buffer:=Replace string:C233(<>vt_Buffer; <>va_LF; "")
								$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
								$vb_OK:=(Substring:C12($vt_Buffer; 1; $vl_Position-1)="INFOS REGIONALES")
								If ($vb_OK)
									RECEIVE PACKET:C104(vh_Réf; <>vt_Buffer; <>va_CR)
									<>vt_Buffer:=Replace string:C233(<>vt_Buffer; <>va_LF; "")
									$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
									$va_Conso_Titre:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
									$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
									If ($va_Conso_Titre="PERSONNE REGIONAL")
										Repeat 
											RECEIVE PACKET:C104(vh_Réf; <>vt_Buffer; <>va_CR)
											<>vt_Buffer:=Replace string:C233(<>vt_Buffer; <>va_LF; "")
											$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
											$va_Conso_Titre:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
											$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
											$vb_OK:=($va_Conso_Titre="HEBERGEMENT REGIONAL")
											If ($vb_OK=False:C215)
												$kk:=Size of array:C274($ta_Conso_P_Titre)+1
												INSERT IN ARRAY:C227($ta_Conso_P_Titre; $kk)
												INSERT IN ARRAY:C227($ta_Conso_P_Valeur; $kk)
												INSERT IN ARRAY:C227($te_Conso_P_Table; $kk)
												INSERT IN ARRAY:C227($te_Conso_P_Champ; $kk)
												INSERT IN ARRAY:C227($te_Conso_P_ChampType; $kk)
												
												$ta_Conso_P_Titre{$kk}:=$va_Conso_Titre
												
												$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
												$ta_Conso_P_Valeur{$kk}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
												$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
												
												$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
												$te_Conso_P_Table{$kk}:=Num:C11(Substring:C12($vt_Buffer; 1; $vl_Position-1))
												$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
												
												$te_Conso_P_Champ{$kk}:=Num:C11($vt_Buffer)
												$te_Conso_P_ChampType{$kk}:=(Type:C295(Field:C253($te_Conso_P_Table{$kk}; $te_Conso_P_Champ{$kk})->))
												
											End if 
										Until ($vb_OK)
										If ($va_Conso_Titre="HEBERGEMENT REGIONAL")
											Repeat 
												RECEIVE PACKET:C104(vh_Réf; <>vt_Buffer; <>va_CR)
												<>vt_Buffer:=Replace string:C233(<>vt_Buffer; <>va_LF; "")
												$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
												$va_Conso_Titre:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
												$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
												$vb_OK:=($va_Conso_Titre="SSPFIN REGIONALSSP")
												If ($vb_OK=False:C215)
													$kk:=Size of array:C274($ta_Conso_H_Titre)+1
													INSERT IN ARRAY:C227($ta_Conso_H_Titre; $kk)
													INSERT IN ARRAY:C227($ta_Conso_H_Valeur; $kk)
													INSERT IN ARRAY:C227($te_Conso_H_Table; $kk)
													INSERT IN ARRAY:C227($te_Conso_H_Champ; $kk)
													INSERT IN ARRAY:C227($te_Conso_H_ChampType; $kk)
													
													$ta_Conso_H_Titre{$kk}:=$va_Conso_Titre
													
													$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
													$ta_Conso_H_Valeur{$kk}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
													$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
													
													$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
													$te_Conso_H_Table{$kk}:=Num:C11(Substring:C12($vt_Buffer; 1; $vl_Position-1))
													$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
													
													$te_Conso_H_Champ{$kk}:=Num:C11($vt_Buffer)
													$te_Conso_H_ChampType{$kk}:=(Type:C295(Field:C253($te_Conso_H_Table{$kk}; $te_Conso_H_Champ{$kk})->))
													
												End if 
											Until ($vb_OK)
										End if 
									End if 
									
									
									
								End if 
								
								
								
								//(•Découpage du contenu du document
								CLOSE DOCUMENT:C267(vh_Réf)
								//(•Déplacer le document
								$vb_OK:=F_RG_DocumentsDéplacer(tt_Conso_DocumentDos{$ii}; ta_Conso_Document{$ii}; "LU")
								
							End if 
							
							USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
						End if 
					End for 
			End case 
			
			ON ERR CALL:C155("")
		End if 
		
		
		//• Endormir ou quitter
		If (vb_SurServeur)
			If (<>vb_ConsoRAuto)
				DELAY PROCESS:C323(Current process:C322; <>vl_ConsoRTicks)
				DébutInitConsoR(4)
				vb_OK:=(<>vb_ConsoRAuto=False:C215)
			End if 
		Else 
			BEEP:C151
			<>va_Conso_Chrono:="Dernière consolidation régionale sur le poste : le "+String:C10(Current date:C33; Interne date court:K1:7)+" à "+String:C10(Current time:C178)
			<>vb_ConsoRAuto:=False:C215
			vb_OK:=True:C214
		End if 
	Until (vb_OK)
End if 



If ($1)
	<>PR_ConsoRServeur:=0
Else 
	<>PR_ConsoRPoste:=0
	// ◊PR_ConsoLocal:=0
	//APPELER PROCESS(◊PR_ConsoListe)
End if 