//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : Go_ConsoRGParClient
//{          Vendredi 28 janvier 2011 à 17:00
//{          Modifiée : lundi 31 janvier 2011 à 16:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($vb_OK; $vb_OKImport)
C_BOOLEAN:C305(vb_SurServeur)

C_BOOLEAN:C305(vb_SurServeur; vb_UnePasse)
vb_SurServeur:=$1
vb_UnePasse:=($2=1)
READ ONLY:C145(*)
MESSAGES OFF:C175

//Déclarations des globales
C_BOOLEAN:C305(vb_OK; vb_Conso)
C_LONGINT:C283(gError; vl_ii; vl_ij; $vl_Position)
vb_OK:=False:C215
vb_Conso:=False:C215
gError:=0
vl_ii:=0
vl_ij:=0

C_TIME:C306(vh_Réf)
C_TEXT:C284(vt_CheminRepertoire)
vt_CheminRepertoire:=<>vt_CheminRégion

ARRAY TEXT:C222(ta_Conso_Document; 0)

C_LONGINT:C283($ii; $kk; $mm; $ii_Tour; $vl_FichesParTour; $vl_NbTours; $vl_FichesDerTours; $vl_FichesNombre; $vl_FichesDe; $vl_FichesA)
C_LONGINT:C283(vl_AlaFois_FichesNombre)
C_LONGINT:C283(vl_AlaFois_FichesParTour)
C_LONGINT:C283(vl_AlaFois_FichesDernierTour)
C_LONGINT:C283(vl_AlaFois_NombreDeTours)

C_LONGINT:C283(vl_AlaFois_FichesNoDe; vl_AlaFois_FichesNoA)
C_LONGINT:C283($vl_AfficheTours; $vl_AfficheNoFiche; $vl_AfficheToutes)
C_TEXT:C284($va_AfficheNbFiches)

C_TIME:C306($vh_HeureD; $vh_HeureF)
$vh_HeureD:=Current time:C178
$vh_HeureF:=$vh_HeureD
C_TEXT:C284(va_TransFrom)
$vb_OK:=F_Report_FullDuplexVAR  //••   `Variables communes au report
$vb_OK:=F_VariablesTransite(0; 2; False:C215)



<>vb_ConsoRAuto:=i_Confirmer("Lancer la consolidation régionale  (2 ème confirmation) ?")

If (<>vb_ConsoRAuto)
	<>va_ConsoR_ChronoTrans:=""
	<>va_ConsoR_ChronoTrans:=""
	Repeat 
		
		<>va_ConsoR_ChronoTrans:="Consolidation régionale en cours sur le poste : le "+String:C10(Current date:C33; Interne date court:K1:7)+" à "+String:C10(Current time:C178)
		POST OUTSIDE CALL:C329(<>PR_ConsoRGClient)
		
		
		$vh_HeureD:=Current time:C178
		$vh_HeureF:=$vh_HeureD
		$vl_AfficheToutes:=0
		
		//•(1) Les dates et heures    
		i_DateServeurPoste(vb_SurServeur)
		
		//•(2) Une condition
		If (vb_SurServeur)
			If (vd_HeureRéelle>=<>vh_ConsoRAuto1) & (vd_HeureRéelle<=<>vh_ConsoRAuto2)
				vb_Conso:=True:C214
			Else 
				vb_Conso:=False:C215
			End if 
		Else 
			vb_Conso:=True:C214
		End if 
		
		
		//•(3) Les répertoires de consolidation sur les 115 existent-ils    
		If (vb_Conso)
			$kk:=0
			$mm:=0
			ARRAY BOOLEAN:C223($tb_T_CheminsRegionaux; Size of array:C274(<>tt_T_CheminsRegionaux))
			If (Size of array:C274(<>tt_T_CheminsRegionaux)>0)
				
				For ($ii; 1; Size of array:C274(<>tt_T_CheminsRegionaux))
					vb_Conso:=F_Report_FullDuplexDossier(11; <>tt_T_CheminsRegionaux{$ii})
					If (vb_Conso=False:C215)
						$kk:=$kk+1
						$vb_OK:=F_Conso_RG_Message(vb_SurServeur; "NO"; "Consolidation régionale : pas de repertoire "+<>tt_T_CheminsRegionaux{$ii}; "Pas de consolidation")
						$tb_T_CheminsRegionaux{$ii}:=False:C215
					Else 
						$mm:=$mm+1
						$tb_T_CheminsRegionaux{$ii}:=True:C214
					End if 
				End for 
				vb_Conso:=($mm>0)
			Else 
				vb_Conso:=False:C215
				$vb_OK:=F_Conso_RG_Message(vb_SurServeur; "NO"; "Consolidation régionale : absence de tous les chemins"; "Pas de consolidation")
			End if 
		End if 
		
		//•(4) Le répertoire pas necessaire ici
		If (vb_Conso)
		End if 
		
		
		//•(5) y a t il des fiches    
		If (vb_Conso)
			$vb_OKImport:=False:C215
			For ($ii; 1; Size of array:C274($tb_T_CheminsRegionaux))
				If ($tb_T_CheminsRegionaux{$ii}=True:C214)
					$vb_OKImport:=True:C214
					DOCUMENT LIST:C474(<>tt_T_CheminsRegionaux{$ii}; ta_Conso_Document)
					If (Size of array:C274(ta_Conso_Document)>0)
						//NE CONSERVER QUE CE QUI EST UNE FICHE D HÉBERGEMENT
						vl_ii:=1
						vl_ij:=Size of array:C274(ta_Conso_Document)
						Repeat 
							//•(x1) Longueur 25 caractères
							If (Substring:C12(ta_Conso_Document{vl_ii}; Length:C16(ta_Conso_Document{vl_ii})-3; 4)=".TXT")
								$vb_OK:=(Length:C16(ta_Conso_Document{vl_ii})=29)
							Else 
								$vb_OK:=(Length:C16(ta_Conso_Document{vl_ii})=25)
							End if 
							//•(x2) Année               
							If ($vb_OK)
								$vb_OK:=(Num:C11(ta_Conso_Document{vl_ii}[[4]])>=0) & (Num:C11(ta_Conso_Document{vl_ii}[[4]])<=9)
								$vb_OK:=$vb_OK & ((Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 4; 2))>0) & (Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 4; 2))<=99))
							End if 
							//•(x3) Mois               
							If ($vb_OK)
								$vb_OK:=((Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 6; 2))>0) & (Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 6; 2))<=12))
							End if 
							//•(x4) Jour              
							If ($vb_OK)
								$vb_OK:=((Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 8; 2))>0) & (Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 8; 2))<=31))
							End if 
							//•(x5) h          
							If ($vb_OK)
								$vb_OK:=(ta_Conso_Document{vl_ii}[[12]]="h")
							End if 
							//•(x6) Jour   ou Nuit                 
							If ($vb_OK)
								$vb_OK:=((ta_Conso_Document{vl_ii}[[15]]="J") | (ta_Conso_Document{vl_ii}[[15]]="N"))
							End if 
							//•(x7) Homme   ou Femme             
							If ($vb_OK)
								$vb_OK:=((ta_Conso_Document{vl_ii}[[22]]="H") | (ta_Conso_Document{vl_ii}[[22]]="F"))
							End if 
							
							If ($vb_OK)
								vl_ii:=vl_ii+1
							Else 
								DELETE FROM ARRAY:C228(ta_Conso_Document; vl_ii; 1)
							End if 
							$vb_OK:=(vl_ii>Size of array:C274(ta_Conso_Document))
						Until ($vb_OK)
						
					End if 
					vb_Conso:=(Size of array:C274(ta_Conso_Document)>0)
					
					
					
					//•(6) Il y a des fiches
					If (vb_Conso)
						
						
						
						SORT ARRAY:C229(ta_Conso_Document; >)
						
						//On fait l'import  gError:=0
						ON ERR CALL:C155("i_Error")
						
						//Ici repeter la boucle car tout charger en une fois est périlleux
						//Alors on en prend 50 à la fois
						$vl_FichesNombre:=Size of array:C274(ta_Conso_Document)
						$vl_FichesParTour:=50
						$vl_NbTours:=$vl_FichesNombre\$vl_FichesParTour
						$vl_FichesDerTours:=$vl_FichesNombre%50
						If ($vl_NbTours<=0)
							$vl_NbTours:=1
						Else 
							If ($vl_FichesDerTours>0)
								$vl_NbTours:=$vl_NbTours+1
							End if 
						End if 
						$vl_AfficheTours:=0
						$vl_AfficheNoFiche:=0
						$va_AfficheNbFiches:=String:C10(Size of array:C274(ta_Conso_Document))
						
						If (vb_SurServeur=False:C215)
							i_Message("Consolidation régionale en cours…")
						End if 
						
						For ($ii_Tour; 1; $vl_NbTours)  //(•Nombre de tours
							//•(x1) Clacul des bornes        
							$vl_FichesDe:=1+($vl_FichesParTour*($ii_Tour-1))
							$vl_FichesA:=$vl_FichesParTour+($vl_FichesParTour*($ii_Tour-1))
							If ($ii_Tour=$vl_NbTours)
								If ($vl_FichesDerTours#$vl_FichesParTour)
									$vl_FichesA:=($vl_FichesParTour*($ii_Tour-1))+$vl_FichesDerTours
								End if 
							End if 
							
							//•(x2) Initialisation des tableaux
							DebutInitTabConso(0; 0)
							
							//•(x3) Les documents à ouvrir
							For (vl_ii; $vl_FichesDe; $vl_FichesA)  //•(x3) Les documents à ouvrir
								If (vb_SurServeur=False:C215)
									$vl_AfficheNoFiche:=$vl_AfficheNoFiche+1
									i_MessageSeul("Consolidation régionale en cours : "+$va_AfficheNbFiches+" / "+String:C10($vl_AfficheNoFiche))
								End if 
								vt_TitreDocument:=<>tt_T_CheminsRegionaux{$ii}+ta_Conso_Document{vl_ii}
								vt_TitreDocument:=F_FichierSuffixe(vt_TitreDocument)
								If (Test path name:C476(vt_TitreDocument)=Est un document:K24:1)
									
									USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
									
									vh_Réf:=Open document:C264(vt_TitreDocument)
									If (OK=1)
										$vl_AfficheToutes:=$vl_AfficheToutes+1
										//(•Découpage du nom du document Facultatif ici à préciser
										$vb_OK:=F_Report_FullDuplexTitre(ta_Conso_Document{vl_ii})
										//L'idée est de créer un tableau en mémoire et de l'enregistrer ensuite
										//(•Ligne de titre dans le document
										RECEIVE PACKET:C104(vh_Réf; <>vt_Buffer; <>va_CR)
										<>vt_Buffer:=Replace string:C233(<>vt_Buffer; <>va_LF; "")
										
										//ici on récuprere le departement : ◊va_RG_Dept
										$vl_Position:=Position:C15(<>va_Tab; <>vt_Buffer)
										<>vt_Buffer:=Substring:C12(<>vt_Buffer; $vl_Position+1)
										$vl_Position:=Position:C15(<>va_Tab; <>vt_Buffer)
										<>vt_Buffer:=Substring:C12(<>vt_Buffer; $vl_Position+1)
										$vl_Position:=Position:C15(<>va_Tab; <>vt_Buffer)
										<>vt_Buffer:=Substring:C12(<>vt_Buffer; $vl_Position+1)
										<>vt_Buffer:=Replace string:C233(<>vt_Buffer; <>va_CR; "")
										<>va_RG_Dept:=<>vt_Buffer
										
										//(•Découpage du contenu du document
										$vb_OK:=F_Report_FullDuplexDecoupage(vh_Réf)
										
										CLOSE DOCUMENT:C267(vh_Réf)
										//(•Déplacer le document
										If ($vb_OK)
											$vb_OK:=F_Regional_DossierLu(<>tt_T_CheminsRegionaux{$ii}; ta_Conso_Document{vl_ii})
										End if 
									End if 
									
									USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
								End if 
								
							End for   //•(x3) Les documents à ouvrir
							
							//•(x4) Création des enregistrements   
							If (Size of array:C274(<>tt_Conso_LeDocument)>0)
								If (vb_SurServeur=False:C215)
									i_MessageSeul("Consolidation régionale en cours "+String:C10($ii_Tour)+"/"+String:C10($vl_NbTours)+"passe , enregistrement de "+String:C10($vl_FichesA-$vl_FichesDe+1)+" fiches(s)")
								End if 
								$vb_OK:=F_Regional_Import
							End if 
						End for   //(•Nombre de tours
						
						If (vb_SurServeur=False:C215)
							CLOSE WINDOW:C154
						End if 
						$vh_HeureF:=Current time:C178
						$vb_OK:=F_Conso_RG_Message(vb_Serveur; "OK"; "Consolidation régionale effectuée"; "Début à "+String:C10($vh_HeureD)+" Fin à "+String:C10($vh_HeureF)+" Durée "+String:C10($vh_HeureF-$vh_HeureD)+" Pour "+String:C10($vl_AfficheToutes)+" fiche(s)")
						
					End if 
					
				End if 
			End for 
			
			If ($vb_OKImport)
				<>va_ConsoR_ChronoTrans:="Dernière consolidation régionale sur le poste : le "+String:C10(Current date:C33; Interne date court:K1:7)+" à "+String:C10(Current time:C178)
				POST OUTSIDE CALL:C329(<>PR_ConsoRGClient)
			End if 
			$vb_OKImport:=False:C215
		End if 
		
		
		//•(7) on s'endort ou on quitte 
		If (vb_UnePasse)
			vb_OK:=True:C214
		Else 
			vb_OK:=(<>vb_ConsoRAuto=False:C215)
			If (<>vb_ConsoRAuto)
				<>va_ConsoR_ChronoTrans:=<>va_ConsoR_ChronoTrans+<>va_CR
				<>va_ConsoR_ChronoTrans:=<>va_ConsoR_ChronoTrans+"Process endormi …"
				POST OUTSIDE CALL:C329(<>PR_ConsoRGClient)
				
				DELAY PROCESS:C323(Current process:C322; <>vl_ConsoRTicks)
				
				<>va_ConsoR_ChronoTrans:="Process réveillé …"+<>va_CR
				POST OUTSIDE CALL:C329(<>PR_ConsoRGClient)
				
				If (<>vb_ConsoRAuto)
					DébutInitConsoR(4)
				End if 
				vb_OK:=(<>vb_ConsoRAuto=False:C215)
			End if 
		End if 
		
		
		If (vb_OK=False:C215)
			<>va_ConsoR_ChronoTrans:=<>va_ConsoR_ChronoTrans+"Consolidation régionale sur le poste : le "+String:C10(Current date:C33; Interne date court:K1:7)+" à "+String:C10(Current time:C178)
			POST OUTSIDE CALL:C329(<>PR_ConsoRGClient)
		End if 
		
	Until (vb_OK)
End if 
ON ERR CALL:C155("")

ARRAY TEXT:C222(ta_Conso_Document; 0)

ARRAY INTEGER:C220(<>te_Conso_Ligne; 0)
ARRAY TEXT:C222(<>tt_Conso_LeDocument; 0)
ARRAY TEXT:C222(<>ta_Conso_Titre; 0)
ARRAY TEXT:C222(<>tt_Conso_Valeur; 0)
ARRAY INTEGER:C220(<>te_Conso_Table; 0)
ARRAY INTEGER:C220(<>te_Conso_Champ; 0)
ARRAY INTEGER:C220(<>te_Conso_ChampType; 0)
ARRAY TEXT:C222(<>ta_Conso_ChampType; 0)


<>va_ConsoR_ChronoTrans:="Vous pouvez quitter, la consolidation régionale est arrêtée."
POST OUTSIDE CALL:C329(<>PR_ConsoRGClient)


<>PR_ConsoRGClientA:=0
POST OUTSIDE CALL:C329(<>PR_ConsoRGClient)
POST OUTSIDE CALL:C329(<>PR_ConsoListe)
BEEP:C151
BEEP:C151
