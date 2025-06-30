//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : Go_ConsoParProcess
//{          Lundi 5 mai 2011 à 14:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)
C_BOOLEAN:C305($vb_OK)

C_TEXT:C284($va_AfficheNbFiches)
C_LONGINT:C283($ii_Tour; $vl_Type; $vl_Position; $vl_AfficheTours; $vl_AfficheNoFiche; $vl_AfficheToutes)
C_TIME:C306($vh_HeureD; $vh_HeureF)

C_TEXT:C284(va_FamilleRepertoire; va_TransFrom)
C_LONGINT:C283(gError; vl_ii; vl_ij; vl_AlaFois_FichesNombre; vl_AlaFois_FichesParTour; vl_AlaFois_FichesDernierTour; \
vl_AlaFois_NombreDeTours; vl_AlaFois_FichesNoDe; vl_AlaFois_FichesNoA)
C_BOOLEAN:C305(vb_SurServeur; vb_OK; vb_Conso)
C_TIME:C306(vh_Réf)

ARRAY TEXT:C222(ta_Conso_Document; 0)

$vh_HeureD:=Current time:C178
$vh_HeureF:=$vh_HeureD

$vb_OK:=F_Report_FullDuplexVAR
$vb_OK:=F_VariablesTransite(0; 2; False:C215)
$vb_OK:=F_SIAO_DansHebergement("Declarer")

va_FamilleRepertoire:=""

gError:=0
vl_ii:=0
vl_ij:=0

vb_OK:=False:C215
vb_Conso:=False:C215

vb_SurServeur:=$1
MultiSoc_Init_On_Server(Count parameters:C259; $2)

READ ONLY:C145(*)
MESSAGES OFF:C175

If (vb_SurServeur)
	DébutInitConso115(4)
Else 
	<>vb_Conso115Auto:=i_Confirmer("Lancer la consolidation (2 ème confirmation) ?")
End if 

If (<>vb_Conso115Auto)
	<>va_Conso_Chrono:=""
	
	Repeat 
		$vh_HeureD:=Current time:C178
		$vh_HeureF:=$vh_HeureD
		$vl_AfficheToutes:=0
		
		i_DateServeurPoste(vb_SurServeur)
		
		If (vb_SurServeur)
			
			If (vd_HeureRéelle>=<>vh_Conso115Auto1) & (vd_HeureRéelle<=<>vh_Conso115Auto2)
				vb_Conso:=True:C214
			Else 
				vb_Conso:=False:C215
			End if 
			
		Else 
			vb_Conso:=True:C214
		End if 
		
		If (vb_Conso)
			vb_Conso:=F_Report_FullDuplexDossier(11; <>vt_T_CheminRép)
			
			If (vb_Conso=False:C215)
				$vb_OK:=F_Conso115_Message(vb_SurServeur; "NO"; "Consolidation : absence de repertoire ou de chemin"; "Pas de consolidation")
			End if 
			
		End if 
		
		If (vb_Conso)
			
			For ($vl_Type; 1; 2)
				$vh_HeureD:=Current time:C178
				$vh_HeureF:=$vh_HeureD
				$vl_AfficheToutes:=0
				
				If ($vl_Type=1)
					vt_FullDuplexDossier:=<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12
					vb_Conso:=F_Report_FullDuplexDossier(11; vt_FullDuplexDossier)
					
					If (vb_Conso=False:C215)
						$vb_OK:=F_Conso115_Message(vb_SurServeur; "NO"; "Consolidation : absence du repertoire '"+<>va_Rép_TransReport+"'"; "Pas de consolidation")
					End if 
					
				End if 
				
				If ($vl_Type=2)
					vt_FullDuplexDossier:=<>vt_T_CheminRép+<>va_Rép_TransPresta+Séparateur dossier:K24:12
					vb_Conso:=F_Report_FullDuplexDossier(11; vt_FullDuplexDossier)
					
					If (vb_Conso=False:C215)
						$vb_OK:=F_Conso115_Message(vb_SurServeur; "NO"; "Consolidation : absence du repertoire '"+<>va_Rép_TransPresta+"'"; "Pas de consolidation")
					End if 
					
				End if 
				
				If (vb_Conso)
					DOCUMENT LIST:C474(vt_FullDuplexDossier; ta_Conso_Document)
					vb_Conso:=F_FichiersNbExportes(->ta_Conso_Document)
				End if 
				
				If (vb_Conso)
					ON ERR CALL:C155("i_Error")
					
					$vb_OK:=F_FichesAlaFois(Size of array:C274(ta_Conso_Document))
					
					$vl_AfficheTours:=0
					$vl_AfficheNoFiche:=0
					$va_AfficheNbFiches:=String:C10(Size of array:C274(ta_Conso_Document))
					
					If (vb_SurServeur=False:C215)
						
						If ($vl_Type=1)  // La consolidation des fiches d'hébergement
							i_Message("Consolidation des hébergements en cours…")
						End if 
						
						If ($vl_Type=2)  // La consolidation des fiches de prestation
							i_Message("Consolidation des prestations en cours…")
						End if 
						
					End if 
					
					For ($ii_Tour; 1; vl_AlaFois_NombreDeTours)  // Nombre de tours    
						F_FichesAlaFoisBornes($ii_Tour)
						DebutInitTabConso(0; 0)
						
						For (vl_ii; vl_AlaFois_FichesNoDe; vl_AlaFois_FichesNoA)  // Les documents à ouvrir
							
							If (vb_SurServeur=False:C215)
								$vl_AfficheNoFiche:=$vl_AfficheNoFiche+1
								i_MessageSeul("Consolidation en cours : "+$va_AfficheNbFiches+" / "+String:C10($vl_AfficheNoFiche))
							End if 
							
							vt_TitreDocument:=vt_FullDuplexDossier+ta_Conso_Document{vl_ii}
							vt_TitreDocument:=F_FichierSuffixe(vt_TitreDocument)
							
							If (Test path name:C476(vt_TitreDocument)=Est un document:K24:1)
								USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
								vh_Réf:=Open document:C264(vt_TitreDocument)
								
								If (OK=1)
									$vl_AfficheToutes:=$vl_AfficheToutes+1
									$vb_OK:=F_Report_FullDuplexTitre(ta_Conso_Document{vl_ii})
									
									RECEIVE PACKET:C104(vh_Réf; <>vt_Buffer; <>va_CR)
									<>vt_Buffer:=Replace string:C233(<>vt_Buffer; <>va_LF; "")
									
									If (Substring:C12(<>vt_Buffer; 1; 7)="Infos :")
										$vl_Position:=Position:C15(<>va_Tab; <>vt_Buffer)
										
										//Titre
										<>vt_Buffer:=Substring:C12(<>vt_Buffer; $vl_Position+1)
										$vl_Position:=Position:C15(<>va_Tab; <>vt_Buffer)
										
										//Valeur
										<>vt_Buffer:=Substring:C12(<>vt_Buffer; $vl_Position+1)
										$vl_Position:=Position:C15(<>va_Tab; <>vt_Buffer)
										
										vl_LC_Prestation:=Num:C11(Substring:C12(<>vt_Buffer; 1; $vl_Position-1))
										
										$vb_OK:=F_Report_FullDuplexDecoupage(vh_Réf)
									End if 
									
									CLOSE DOCUMENT:C267(vh_Réf)
									
									If ($vb_OK)
										$vb_OK:=F_Report_FullDuplexDeplaceLU(vt_FullDuplexDossier; ta_Conso_Document{vl_ii})
									End if 
									
								End if 
								
								USE CHARACTER SET:C205(*; 1)  // Reset Filtre import. BS Migration v15
							End if 
							
						End for   //•(x3) Les documents à ouvrir
						
						If (Size of array:C274(<>tt_Conso_LeDocument)>0)
							
							If (vb_SurServeur=False:C215)
								i_MessageSeul("Consolidation en cours, enregistrement de "+String:C10(vl_AlaFois_FichesNoA-vl_AlaFois_FichesNoDe+1)+" fiches(s)")
							End if 
							
							$vb_OK:=F_Report_FullDuplexImport
						End if 
						
					End for 
					
					If (vb_SurServeur=False:C215)
						CLOSE WINDOW:C154
					End if 
					
					$vh_HeureF:=Current time:C178
					
					If ($vl_Type=1)  // La consolidation des fiches d'hébergement
						$vb_OK:=F_Conso115_Message(vb_Serveur; "OK"; "Consolidation des hébergements effectuée"; "Début à "+String:C10($vh_HeureD)+" Fin à "+String:C10($vh_HeureF)+" Durée "+String:C10($vh_HeureF-$vh_HeureD)+" Pour "+String:C10($vl_AfficheToutes)+" fiche(s)")
					End if 
					
					If ($vl_Type=2)  // La consolidation des fiches de prestation
						$vb_OK:=F_Conso115_Message(vb_Serveur; "OK"; "Consolidation des prestations effectuée"; "Début à "+String:C10($vh_HeureD)+" Fin à "+String:C10($vh_HeureF)+" Durée "+String:C10($vh_HeureF-$vh_HeureD)+" Pour "+String:C10($vl_AfficheToutes)+" fiche(s)")
					End if 
					
				End if 
				
			End for 
			
			<>va_Conso_ChronoTrans:="Dernière consolidation sur le poste : le "+String:C10(Current date:C33; Interne date court:K1:7)+" à "+String:C10(Current time:C178)
			POST OUTSIDE CALL:C329(<>PR_ConsoClient)
		End if 
		
		vb_OK:=(<>vb_Conso115Auto=False:C215)
		
		If (vb_SurServeur)
			
			If (<>vb_Conso115Auto)
				DELAY PROCESS:C323(Current process:C322; <>vl_Conso115Ticks)
				
				DébutInitConso115(4)
				vb_OK:=(<>vb_Conso115Auto=False:C215)
			End if 
			
		Else 
			<>va_Conso_Chrono:="Dernière consolidation sur le poste : le "+String:C10(Current date:C33; Interne date court:K1:7)+" à "+String:C10(Current time:C178)
			<>vb_Conso115Auto:=False:C215
			
			vb_OK:=True:C214
		End if 
		
	Until (vb_OK)
	
End if 

ON ERR CALL:C155("")

ARRAY TEXT:C222(ta_Conso_Document; 0)

ARRAY TEXT:C222(<>tt_Conso_LeDocument; 0)
ARRAY TEXT:C222(<>ta_Conso_Titre; 0)
ARRAY TEXT:C222(<>tt_Conso_Valeur; 0)
ARRAY TEXT:C222(<>ta_Conso_ChampType; 0)

ARRAY INTEGER:C220(<>te_Conso_Ligne; 0)
ARRAY INTEGER:C220(<>te_Conso_Table; 0)
ARRAY INTEGER:C220(<>te_Conso_Champ; 0)
ARRAY INTEGER:C220(<>te_Conso_ChampType; 0)

If ($1)
	<>PR_ConsoServeur:=0
Else 
	<>PR_ConsoPoste:=0
	<>PR_ConsoLocal:=0
	
	POST OUTSIDE CALL:C329(<>PR_ConsoListe)
End if 