//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : Go_Conso115AUTOOld
//{
//{          Vendredi 7 novembre 2008 à 14:36
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_BOOLEAN:C305($1)
READ ONLY:C145(*)
MESSAGES OFF:C175
C_BOOLEAN:C305($vb_OK)
C_BOOLEAN:C305(vb_OK; vb_Conso)
C_LONGINT:C283(gError; vl_ii)

C_LONGINT:C283($ii_Tour; $vl_FichesParTour; $vl_NbTours; $vl_FichesDerTours; $vl_FichesNombre)

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

C_LONGINT:C283($vl_FichesDe; $vl_FichesA)
C_TIME:C306(vh_Réf)

C_TEXT:C284(va_Centre_Rep)

vb_OK:=False:C215
vb_Conso:=False:C215
gError:=0
vl_ii:=0
vl_ij:=0
C_TEXT:C284(va_TransFrom)
vb_OK:=F_Report_FullDuplexVAR  //••   `Variables communes au report
vb_Serveur:=$1
If (vb_Serveur)
	$vb_OK:=True:C214
Else 
	$vb_OK:=i_Confirmer("Lancer la consolidation ?")
End if 

If ($vb_OK)
	$vb_OK:=False:C215
	
	If (vb_Serveur)
		//Variables Paramètres Généraux
		DebutDecVarParam
		QUERY:C277([SOciete:18]; [SOciete:18]SO_ReferenceID:1=1)
		MultiSoc_Filter(->[SOciete:18])
		If (Records in selection:C76([SOciete:18])=1)
			<>va_T_00:=[SOciete:18]SO_Libel00:2
			<>va_T_01:=[SOciete:18]SO_Libel01:3
			<>va_T_02:=[SOciete:18]SO_Libel02:4
			<>va_T_03:=[SOciete:18]SO_Libel03:5
			<>va_T_04:=[SOciete:18]SO_Libel04:6
			<>va_T_05:=[SOciete:18]SO_Libel05:7
			<>va_T_Site:=[SOciete:18]SO_Site:8
			<>vt_T_CheminRép:=[SOciete:18]SO_CheminRépertoire:11
			<>vt_T_CheminRépServeur:=[SOciete:18]SO_CheminRépertoireServeur:25
			<>vt_T_DossierRep:=[SOciete:18]SO_RépertoireSite:12
			<>vb_T_BoiteLettres:=[SOciete:18]SO_BoiteLettres:13
			<>vl_T_ColorCadreH:=[SOciete:18]SO_CouleurCadreH:14
			<>vl_T_ColorCadreC:=[SOciete:18]SO_CouleurCadreC:15
			<>vl_T_ColorCadreB:=[SOciete:18]SO_CouleurCadreB:16
			
			<>vb_T_ModeCHRS:=[SOciete:18]SO_ModeCHRS:17
			<>vb_T_Ecran115:=[SOciete:18]SO_Ecran115:18
			<>vb_T_MasqueETCV:=[SOciete:18]SO_MasqueEtatCivil:19
			<>vb_T_Cryptage:=[SOciete:18]SO_Cryptage:20
			
			<>vb_T_TransTransfert:=[SOciete:18]SO_TransTransfert:21
			
			<>vb_T_FullDuplex:=[SOciete:18]SO_155FullDuplex:22
			
			<>ve_T_CentreCode:=[SOciete:18]SO_CodeCentre:23
			P_CodeCentre(-><>vl_T_CentreCodeDebut; -><>vl_T_CentreCodeFin)
			<>vb_T_EcranGrand:=[SOciete:18]SO_EcranGrand:24
		End if 
		
		//Variables communes au report constantes
		DebutDecVarReport
		//Report automatiques  
		//Variable paramètres du report auto
		DebutDecVarParamRepAuto
		//Variable paramètres de la consolidation auto
		DebutDecVarParamConso115
		DébutInitConso115(0)
	Else 
		<>vb_Conso115Auto:=True:C214
		vb_OK:=True:C214
	End if 
	
	<>va_Conso_Chrono:=""
	ARRAY TEXT:C222(ta_Conso_Document; 0)
	
	If (<>vb_Conso115Auto)
		Repeat 
			$vh_HeureD:=Current time:C178
			$vh_HeureF:=$vh_HeureD
			$vl_AfficheToutes:=0
			
			//•(1) Les dates et heures    
			i_DateServeurPoste(vb_Serveur)
			//•(2) Une condition
			If (vb_Serveur)
				If (vd_HeureRéelle>=<>vh_Conso115Auto1) & (vd_HeureRéelle<=<>vh_Conso115Auto2)
					vb_Conso:=True:C214
				Else 
					vb_Conso:=False:C215
				End if 
			Else 
				vb_Conso:=True:C214
			End if 
			//•(3) Le répertoir de transfert existe-t-il    
			If (vb_Conso)
				vb_Conso:=F_Report_FullDuplexDossier(11; <>vt_T_CheminRép)
				If (vb_Conso=False:C215)
					$vb_OK:=F_Conso115_Message(vb_Serveur; "NO"; "Consolidation : absence de repertoire ou de chemin"; "Pas de consolidation")
				End if 
			End if 
			//•(4) Le répertoire pourle Centre 115 centralisateur  existe t il
			If (vb_Conso)
				// on cherche le répertoire on l'on exporte les fiches reportées
				//  ◊va_Rép_TransReport:="115Report"
				//  ◊va_Rép_TransReportLU:="115LU"
				vt_FullDuplexDossier:=<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12
				vb_Conso:=F_Report_FullDuplexDossier(11; vt_FullDuplexDossier)
				If (vb_Conso=False:C215)
					$vb_OK:=F_Conso115_Message(vb_Serveur; "NO"; "Consolidation : absence du repertoire '"+<>va_Rép_TransReport+"'"; "Pas de consolidation")
				End if 
			End if 
			//•(5) y a t il des fiches    
			If (vb_Conso)
				DOCUMENT LIST:C474(vt_FullDuplexDossier; ta_Conso_Document)
				If (Size of array:C274(ta_Conso_Document)>0)
					//NE CONSERVER QUE CE QUI EST UNE FICHE D HÉBERGEMENT
					vl_ii:=1
					vl_ij:=Size of array:C274(ta_Conso_Document)
					Repeat 
						//AH 09022508h15J01810 FS49.TXT            
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
			End if 
			//•(6) Il y a des fiches
			If (vb_Conso)
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
				
				If (7=8)
					If ($vl_FichesNombre>$vl_FichesParTour)
						$vl_NbTours:=$vl_FichesNombre\$vl_FichesParTour
						$vl_FichesDerTours:=$vl_FichesNombre%50
						If ($vl_FichesDerTours>0)
							$vl_NbTours:=$vl_NbTours+1
						End if 
					End if 
				End if 
				
				$vl_AfficheTours:=0
				$vl_AfficheNoFiche:=0
				$va_AfficheNbFiches:=String:C10(Size of array:C274(ta_Conso_Document))
				If (vb_Serveur=False:C215)
					i_Message("Consolidation en cours…")
				End if 
				//(•Nombre de tours
				For ($ii_Tour; 1; $vl_NbTours)
					//(•Clacul des bornes        
					$vl_FichesDe:=1+($vl_FichesParTour*($ii_Tour-1))
					$vl_FichesA:=$vl_FichesParTour+($vl_FichesParTour*($ii_Tour-1))
					If ($ii_Tour=$vl_NbTours)
						If ($vl_FichesDerTours#$vl_FichesParTour)
							$vl_FichesA:=($vl_FichesParTour*($ii_Tour-1))+$vl_FichesDerTours
						End if 
					End if 
					
					DebutInitTabConso(0; 0)
					
					//(•Les documents à ouvrir
					For (vl_ii; $vl_FichesDe; $vl_FichesA)
						
						
						If (vb_Serveur=False:C215)
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
								//(•Découpage du nom du document Facultatif ici à préciser
								$vb_OK:=F_Report_FullDuplexTitre(ta_Conso_Document{vl_ii})
								//L'idée est de créer un tableau en mémoire et de l'enregistrer ensuite
								//(•Ligne de titre dans le document
								RECEIVE PACKET:C104(vh_Réf; <>vt_Buffer; <>va_CR)
								<>vt_Buffer:=Replace string:C233(<>vt_Buffer; <>va_LF; "")
								//(•Découpage du contenu du document
								$vb_OK:=F_Report_FullDuplexDecoupage(vh_Réf)
								CLOSE DOCUMENT:C267(vh_Réf)
								//(•Déplacer le document
								$vb_OK:=F_Report_FullDuplexDeplaceLU(vt_FullDuplexDossier; ta_Conso_Document{vl_ii})
							End if 
							
							USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
						End if 
					End for   //(vl_ii;1;Taille tableau(ta_Conso_Document))
					
					If (Size of array:C274(<>tt_Conso_LeDocument)>0)
						If (vb_Serveur=False:C215)
							i_MessageSeul("Consolidation en cours, enregistrement de "+String:C10($vl_FichesA-$vl_FichesDe+1)+" fiches(s)")
						End if 
						$vb_OK:=F_Report_FullDuplexImport
					End if 
				End for   //($ii_Tour;1;$vl_NbTours)
				
				If (vb_Serveur=False:C215)
					CLOSE WINDOW:C154
				End if 
				
				$vh_HeureF:=Current time:C178
				$vb_OK:=F_Conso115_Message(vb_Serveur; "OK"; "Consolidation effectuée"; "Début à "+String:C10($vh_HeureD)+" Fin à "+String:C10($vh_HeureF)+" Durée "+String:C10($vh_HeureF-$vh_HeureD)+" Pour "+String:C10($vl_AfficheToutes)+" fiche(s)")
				
			End if 
			
			If (vb_Serveur)
				vb_OK:=(<>vb_Conso115Auto=False:C215)
				If (<>vb_Conso115Auto)
					DELAY PROCESS:C323(Current process:C322; <>vl_Conso115Ticks)
				End if 
				DébutInitConso115(0)
			Else 
				BEEP:C151
				BEEP:C151
				<>va_Conso_Chrono:="Dernière consolidation sur le poste : le "+String:C10(Current date:C33; Interne date court:K1:7)+" à "+String:C10(Current time:C178)
				vb_OK:=True:C214
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
	
End if 
If ($1)
	<>PR_ConsoServeur:=0
Else 
	<>PR_ConsoPoste:=0
	POST OUTSIDE CALL:C329(<>PR_ConsoListe)
End if 