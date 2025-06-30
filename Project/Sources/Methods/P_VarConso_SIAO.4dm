//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_VarConso_SIAO
//{          Lundi 6 juin 2011 à 6:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_LONGINT:C283($ii; $jj; $vl_Ligne; $vl_cas; $vl_Fiche; $vl_LigneChamp; $vl_FicheID)
C_TEXT:C284($vt_Buffer)
C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215

Case of 
	: ($1=0)
		C_LONGINT:C283(vl_ConsoB_DocumentLignes)
		C_TEXT:C284(va_ConsoB_Document)
		C_LONGINT:C283(vl_ConsoB_DocumentLignes)
		
		C_TEXT:C284(vt_ConsoB_Chemin)
		C_TEXT:C284(vt_ConsoB_CheminDossier)
		C_TEXT:C284(vt_ConsoB_Dossier)
		C_TEXT:C284(vt_ConsoB_Document)
		C_TEXT:C284(vt_ConsoB_Titre)
		
		C_TEXT:C284(vt_ConsoB_Buffer)
		
		C_TEXT:C284(va_ConsoB_Site; va_ConsoB_Demandeur; va_ConsoB_SIAOno; va_ConsoB_SIAODemCle)
		
		C_LONGINT:C283(vl_ID_SIAO; vl_ID_SIAO_Dem; vl_ID_SIAO_Referent; vl_ID_SIAO_Accueil; vl_ID_SIAO_Personne; vl_ID_SIAO_Adresse; vl_ID_SIAO_Situation)
		C_LONGINT:C283(vl_IDold_SIAO; vl_IDold_SIAO_Dem; vl_IDold_SIAO_Referent; vl_IDold_SIAO_Accueil; vl_IDold_SIAO_Personne; vl_IDold_SIAO_Adresse; vl_IDold_SIAO_Situation)
		
		
		ARRAY TEXT:C222(ta_Conso_Document; 0)
		
		ARRAY LONGINT:C221(tl_InSiao_Table; 0)
		ARRAY LONGINT:C221(tl_InSiao_Champ; 0)
		ARRAY LONGINT:C221(tl_ID_SIAO_Personne; 0)
		ARRAY LONGINT:C221(tl_IDold_SIAO_Personne; 0)
		ARRAY TEXT:C222(tt_InSiao_Valeur; 0; 0)
		
		C_TEXT:C284(va_InSiao_Col1)
		C_TEXT:C284(va_InSiao_Col2)
		C_TEXT:C284(va_InSiao_Col3)
		C_TEXT:C284(vt_InSiao_Col4)
		C_TEXT:C284(va_InSiao_Col5)
		C_TEXT:C284(va_InSiao_Col6)
		
		C_LONGINT:C283(vl_InSiao_Table)
		C_LONGINT:C283(vl_InSiao_Champ)
		C_LONGINT:C283(vl_InSiao_NbChamps)
		
	: ($1=3)
		vt_ConsoB_Chemin:=""
		vt_ConsoB_CheminDossier:=""
		vt_ConsoB_Dossier:=""
		
		
		ARRAY TEXT:C222(ta_Conso_Document; 0)
		ta_Conso_Document:=0
		vt_ConsoB_Document:=""
		vt_ConsoB_Titre:=""
		va_ConsoB_Site:=""
		va_ConsoB_Demandeur:=""
		va_ConsoB_SIAOno:=""
		
		vl_ID_SIAO:=0
		vl_ID_SIAO_Dem:=0
		vl_ID_SIAO_Referent:=0
		vl_ID_SIAO_Accueil:=0
		
		vl_ID_SIAO_Personne:=0
		vl_ID_SIAO_Adresse:=0
		vl_ID_SIAO_Situation:=0
		
		vl_IDold_SIAO:=0
		vl_IDold_SIAO_Dem:=0
		vl_IDold_SIAO_Referent:=0
		vl_IDold_SIAO_Accueil:=0
		
		vl_IDold_SIAO_Personne:=0
		vl_IDold_SIAO_Adresse:=0
		vl_IDold_SIAO_Situation:=0
		
		
	: ($1=4)
		t_ConsoB_Document:=""
		vt_ConsoB_Titre:=""
		
		
	: ($1=5)
		P_VarConso_SIAO(1)
		
		
		
		//•(1) Le répertoir de transfert existe-t-il  
		$vb_OK:=(Test path name:C476(<>vt_T_CheminRép)=Est un dossier:K24:2)
		If ($vb_OK=False:C215)
			//absence de repertoire TRANSFERT
		End if 
		
		//•(2) Le répertoire des SIAO  existe t il
		If ($vb_OK)
			vt_FullDuplexDossier:=<>vt_T_CheminRép+<>va_Rép_TransSIAO+Séparateur dossier:K24:12
			$vb_OK:=(Test path name:C476(vt_FullDuplexDossier)=Est un dossier:K24:2)
			If ($vb_OK=False:C215)
				//absence de repertoire SIAO
			End if 
		End if 
		
		
		//•(3) `Y t il des documents
		If ($vb_OK)
			DOCUMENT LIST:C474(vt_FullDuplexDossier; ta_Conso_Document)
			If (Size of array:C274(ta_Conso_Document)>0)
				//NE CONSERVER QUE CE QUI EST UNE FICHE SIAO
				vl_ii:=1
				vl_ij:=Size of array:C274(ta_Conso_Document)
				Repeat 
					//•(x1) Longueur 29 caractères
					If (Substring:C12(ta_Conso_Document{vl_ii}; Length:C16(ta_Conso_Document{vl_ii})-3; 4)=".TXT")
						$vb_OK:=(Length:C16(ta_Conso_Document{vl_ii})=29)
					Else 
						$vb_OK:=(Length:C16(ta_Conso_Document{vl_ii})=25)
					End if 
					
					//•(x2) Année               
					If ($vb_OK)
						$vb_OK:=((Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 1; 2))>0) & (Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 1; 2))<=99))
					End if 
					//•(x3) Mois               
					If ($vb_OK)
						$vb_OK:=((Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 3; 2))>0) & (Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 3; 2))<=12))
					End if 
					//•(x4) Jour              
					If ($vb_OK)
						$vb_OK:=((Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 5; 2))>0) & (Num:C11(Substring:C12(ta_Conso_Document{vl_ii}; 5; 2))<=31))
					End if 
					//•(x5) h          
					If ($vb_OK)
						$vb_OK:=(ta_Conso_Document{vl_ii}[[9]]="h")
					End if 
					
					If ($vb_OK)
						Case of 
							: (<>vl_T_SIAO_IU=0)  //Aucun
								$vb_OK:=False:C215
							: (<>vl_T_SIAO_IU=1)  //Insertion
								$vb_OK:=(ta_Conso_Document{vl_ii}[[25]]="i")
							: (<>vl_T_SIAO_IU=2)  //Urgence
								$vb_OK:=(ta_Conso_Document{vl_ii}[[25]]="u")
							: (<>vl_T_SIAO_IU=3)  //Les deux
						End case 
					End if 
					
					
					If ($vb_OK)
						vl_ii:=vl_ii+1
					Else 
						DELETE FROM ARRAY:C228(ta_Conso_Document; vl_ii; 1)
					End if 
					$vb_OK:=(vl_ii>Size of array:C274(ta_Conso_Document))
					
				Until ($vb_OK)
			End if 
		End if 
		
		
		vl_Conso_DocumentLignes:=Size of array:C274(ta_Conso_Document)
		va_ConsoB_Document:=String:C10(vl_Conso_DocumentLignes)+" dossier"+("s"*Num:C11(vl_Conso_DocumentLignes>1))+" trouvée"+("s"*Num:C11(vl_Conso_DocumentLignes>1))+" le "+String:C10(Current date:C33; Système date court:K1:1)+" à "+String:C10(Current time:C178; h mn:K7:2)
		ta_Conso_Document:=0
		vt_ConsoB_Document:=""
		vt_ConsoB_Titre:=""
		va_ConsoB_Site:=""
		va_ConsoB_Demandeur:=""
		va_ConsoB_SIAOno:=""
		
	: ($1=6)
		
		vt_ConsoB_Titre:="Dossier "
		vt_ConsoB_Titre:=vt_ConsoB_Titre+("d'insertion"*Num:C11(ta_Conso_Document{ta_Conso_Document}[[25]]="i"))+("d'urgence"*Num:C11(ta_Conso_Document{ta_Conso_Document}[[25]]="u"))
		vt_ConsoB_Titre:=vt_ConsoB_Titre+" n° "+Substring:C12(ta_Conso_Document{ta_Conso_Document}; 15; 10)
		vt_ConsoB_Titre:=vt_ConsoB_Titre+", transmis le "+Substring:C12(ta_Conso_Document{ta_Conso_Document}; 5; 2)+"/"+Substring:C12(ta_Conso_Document{ta_Conso_Document}; 3; 2)+"/"+Substring:C12(ta_Conso_Document{ta_Conso_Document}; 1; 2)
		vt_ConsoB_Titre:=vt_ConsoB_Titre+" à "+Substring:C12(ta_Conso_Document{ta_Conso_Document}; 7; 5)
		
		va_ConsoB_SIAOno:=Substring:C12(ta_Conso_Document{ta_Conso_Document}; 12; 13)
		vt_ConsoB_Document:=F_FichierSuffixe(vt_FullDuplexDossier+ta_Conso_Document{ta_Conso_Document})
		
		$vb_OK:=(Test path name:C476(vt_ConsoB_Document)=Est un document:K24:1)
		If ($vb_OK)
			$h_RefDoc:=Open document:C264(vt_ConsoB_Document)
			If (OK=1)
				
				USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
				
				$vl_Ligne:=0
				
				Repeat 
					RECEIVE PACKET:C104($h_RefDoc; $vt_Buffer; <>va_CR)
					$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
					$vl_Ligne:=$vl_Ligne+1
					If ($vt_Buffer#"SSPFINEXPORTSSPSIAO")
						Case of 
							: ($vl_Ligne=1)
								$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
								$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
								$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
								$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
								$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
								$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
								$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
								$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
								$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
								va_ConsoB_Site:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
								$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
								va_ConsoB_Demandeur:=$vt_Buffer
								//    : ($vl_Ligne=2)
								//   : ($vl_Ligne=3)
								//    : ($vl_Ligne=4)
								//   : ($vl_Ligne=5)
								//   $vl_Position:=Position(◊va_Tab;$vt_Buffer)
								//   $vt_Buffer:=Sous chaine($vt_Buffer;$vl_Position+1)
								//   $vl_Position:=Position(◊va_Tab;$vt_Buffer)
								//   $vt_Buffer:=Sous chaine($vt_Buffer;$vl_Position+1)
								//  $vl_Position:=Position(◊va_Tab;$vt_Buffer)
								//$vt_Buffer:=Sous chaine($vt_Buffer;$vl_Position+1)
								// $vl_Position:=Position(◊va_Tab;$vt_Buffer)
								//    va_ConsoB_SIAOno:=Sous chaine($vt_Buffer;1;$vl_Position-1)
								$vt_Buffer:="SSPFINEXPORTSSPSIAO"
						End case 
					End if 
					$vb_OK:=($vt_Buffer="SSPFINEXPORTSSPSIAO")
				Until ($vb_OK)
				CLOSE DOCUMENT:C267($h_RefDoc)
				USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
			End if 
		End if 
		If (va_ConsoB_Site>"")
			vt_ConsoB_Titre:=vt_ConsoB_Titre+<>va_CR+"Site :  "+va_ConsoB_Site
		End if 
		If (va_ConsoB_Demandeur>"")
			vt_ConsoB_Titre:=vt_ConsoB_Titre+<>va_CR+"Demandeur "+va_ConsoB_Demandeur
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=va_ConsoB_Demandeur)
			MultiSoc_Filter(->[HeBerge:4])
			If (Records in selection:C76([HeBerge:4])=1)
				QUERY:C277([SIAO:50]; [SIAO:50]Si_Demandeur_ID:21=[HeBerge:4]HB_ReferenceID:1)
				MultiSoc_Filter(->[SIAO:50])
				If (Records in selection:C76([SIAO:50])>0)
					vt_ConsoB_Titre:=vt_ConsoB_Titre+<>va_CR+"(déjà référencé + Dossier SIAO)"
				Else 
					vt_ConsoB_Titre:=vt_ConsoB_Titre+<>va_CR+"(déjà référencé)"
				End if 
			Else 
				vt_ConsoB_Titre:=vt_ConsoB_Titre+<>va_CR+"(non référencé)"
			End if 
		End if 
		
	: ($1=7)
		
		vl_ID_SIAO:=0
		vl_ID_SIAO_Dem:=0
		vl_ID_SIAO_Referent:=0
		vl_ID_SIAO_Accueil:=0
		vl_ID_SIAO_Personne:=0
		vl_ID_SIAO_Adresse:=0
		vl_ID_SIAO_Situation:=0
		
		vl_IDold_SIAO:=0
		vl_IDold_SIAO_Dem:=0
		vl_IDold_SIAO_Referent:=0
		vl_IDold_SIAO_Accueil:=0
		vl_IDold_SIAO_Personne:=0
		vl_IDold_SIAO_Adresse:=0
		vl_IDold_SIAO_Situation:=0
		$vb_OK:=False:C215
		If (Test path name:C476(vt_ConsoB_Document)=Est un document:K24:1)
			$vb_OK:=i_Confirmer("Import du Dossier : "+ta_Conso_Document{ta_Conso_Document})
		End if 
		If ($vb_OK)
			$vb_OK:=False:C215
			QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Numero:3=va_ConsoB_SIAOno)
			MultiSoc_Filter(->[SIAO:50])
			If (Records in selection:C76([SIAO:50])=0)  //REMETRE à O
				$vb_OK:=True:C214
			Else 
				BEEP:C151
				BEEP:C151
				If (i_Confirmer("Le Dossier SIAO n° "+va_ConsoB_SIAOno+" existe déjà !"+<>va_CR+<>va_CR+"Voulez-vous supprimer ce fichier d'import."))
					DELETE DOCUMENT:C159(vt_ConsoB_Document)
					If (OK=1)
						DELETE FROM ARRAY:C228(ta_Conso_Document; ta_Conso_Document; 1)
						ta_Conso_Document:=0
						P_VarConso_SIAO(3)
					End if 
				End if 
			End if 
		End if 
		
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
		
		If ($vb_OK)
			$vb_OK:=False:C215
			$h_RefDoc:=Open document:C264(vt_ConsoB_Document)
			If (OK=1)
				
				$vl_Ligne:=0
				//Est le bon document
				RECEIVE PACKET:C104($h_RefDoc; $vt_Buffer; <>va_CR)
				$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
				If (<>vb_CestUnMac=False:C215)
					$vt_Buffer:=_O_Win to Mac:C464($vt_Buffer)
				End if 
				
				If (($vt_Buffer="") | ($vt_Buffer="SSPFINEXPORTSSPSIAO"))
					CLOSE DOCUMENT:C267($h_RefDoc)
				Else 
					$vl_Ligne:=1
					P_SIAO_Lignes($vt_Buffer; $vl_Ligne)
					If (va_InSiao_Col1="SIAO SIAO Infos : ")
						If (i_Confirmer("Importer le dossier du demandeur : "+va_InSiao_Col6+<>va_CR+"Transmis par "+vt_InSiao_Col4))
							$vb_OK:=True:C214
						Else 
							CLOSE DOCUMENT:C267($h_RefDoc)
						End if 
					Else 
						CLOSE DOCUMENT:C267($h_RefDoc)
						ALERT:C41("Ce document n'est pas un fichier standard d'import SIAO !")
						DELETE DOCUMENT:C159(vt_ConsoB_Document)
						If (OK=1)
							DELETE FROM ARRAY:C228(ta_Conso_Document; ta_Conso_Document; 1)
							ta_Conso_Document:=0
							P_VarConso_SIAO(3)
						End if 
						
					End if 
				End if 
				
			End if 
		End if 
		
		//C'est le bon document
		If ($vb_OK)
			$vb_OK:=False:C215
			i_Message("Import SIAO : ")
			P_VarConso_SIAO(11)
			Repeat 
				$vl_Ligne:=$vl_Ligne+1
				RECEIVE PACKET:C104($h_RefDoc; $vt_Buffer; <>va_CR)
				$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
				If (<>vb_CestUnMac=False:C215)
					$vt_Buffer:=_O_Win to Mac:C464($vt_Buffer)
				End if 
				
				If (($vt_Buffer="") | ($vt_Buffer="SSPFINEXPORTSSPSIAO"))
					$vb_OK:=True:C214
				Else 
					P_SIAO_Lignes($vt_Buffer; $vl_Ligne)
					vl_InSiao_Champ:=Num:C11(va_InSiao_Col3)
					//•••• NOUVELLE SÉQUENCE
					If (vl_InSiao_Champ=-1)  //Nouvelle séquence          
						vl_InSiao_Table:=Num:C11(va_InSiao_Col2)
						vl_InSiao_NbChamps:=Num:C11(vt_InSiao_Col4)
						vl_InSiao_Fiches:=Num:C11(va_InSiao_Col5)
						Case of 
							: (Table:C252(vl_InSiao_Table)=(->[SIAO_SiteReference:54]))
								i_MessageSeul("Import SIAO : Accueil")
								vl_InSiao_Personnes:=1
								$vl_cas:=1
							: (Table:C252(vl_InSiao_Table)=(->[SIAO_SiteAccueil:55]))
								i_MessageSeul("Import SIAO : Référent")
								vl_InSiao_Personnes:=1
								$vl_cas:=1
							: (Table:C252(vl_InSiao_Table)=(->[SIAO:50]))
								i_MessageSeul("Import SIAO : Dossier")
								vl_InSiao_Personnes:=1
								$vl_cas:=1
							: (Table:C252(vl_InSiao_Table)=(->[SIAO_Personnes:51]))
								i_MessageSeul("Import SIAO : Personnes")
								vl_InSiao_Personnes:=Num:C11(va_InSiao_Col5)
								vl_InSiao_Fiches:=Num:C11(vl_InSiao_Personnes>0)
								$vl_cas:=2
							: (Table:C252(vl_InSiao_Table)=(->[Adresses:53]))
								i_MessageSeul("Import SIAO : Adresse")
								$vl_cas:=2
							: (Table:C252(vl_InSiao_Table)=(->[SIAO_Situations:52]))
								i_MessageSeul("Import SIAO : Situations")
								$vl_cas:=2
						End case 
						
						If (vl_InSiao_Fiches>0)  //•••• NOMBRE DE FICHES
							//••Les n° de table et de champs
							ARRAY LONGINT:C221(tl_InSiao_Table; vl_InSiao_NbChamps)
							ARRAY LONGINT:C221(tl_InSiao_Champ; vl_InSiao_NbChamps)
							For ($ii; 1; vl_InSiao_NbChamps)
								tl_InSiao_Table{$ii}:=vl_InSiao_Table
								tl_InSiao_Champ{$ii}:=$ii
							End for 
							For ($vl_Fiche; 1; vl_InSiao_Fiches)
								
								ARRAY TEXT:C222(tt_InSiao_Valeur; vl_InSiao_NbChamps; vl_InSiao_Personnes)
								
								For ($ii; 1; vl_InSiao_NbChamps)
									For ($jj; 1; vl_InSiao_Personnes)
										tt_InSiao_Valeur{$ii}{$jj}:=""
									End for 
								End for 
								$vl_LigneChamp:=0
								Repeat 
									$vl_Ligne:=$vl_Ligne+1
									$vl_LigneChamp:=$vl_LigneChamp+1
									RECEIVE PACKET:C104($h_RefDoc; $vt_Buffer; <>va_CR)
									$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
									If (<>vb_CestUnMac=False:C215)
										$vt_Buffer:=_O_Win to Mac:C464($vt_Buffer)
									End if 
									If (($vt_Buffer="") | ($vt_Buffer="SSPFINEXPORTSSPSIAO"))
										vl_InSiao_Champ:=0
									Else 
										P_SIAO_LignesPlus($vt_Buffer; $vl_LigneChamp; $vl_cas)
										vl_InSiao_Champ:=Num:C11(va_InSiao_Col3)
									End if 
								Until (vl_InSiao_Champ=0)
								Case of 
									: (Table:C252(vl_InSiao_Table)=(->[SIAO_SiteReference:54]))
										//i_MessageSeul ("Import SIAO : Accueil")
										vl_IDold_SIAO_Accueil:=Num:C11(tt_InSiao_Valeur{1}{1})
										QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_ReferenceNom:6=tt_InSiao_Valeur{6}{1})
										MultiSoc_Filter(->[SIAO_SiteReference:54])
										If (Records in selection:C76([SIAO_SiteReference:54])>0)
											vl_ID_SIAO_Accueil:=[SIAO_SiteReference:54]Sa_RéférenceID:1
										Else 
											CREATE RECORD:C68([SIAO_SiteReference:54])
											MultiSoc_Init_Structure(->[SIAO_SiteReference:54])
											[SIAO_SiteReference:54]Sa_RéférenceID:1:=Uut_Numerote(->[SIAO_SiteReference:54])
											vl_ID_SIAO_Accueil:=[SIAO_SiteReference:54]Sa_RéférenceID:1
											For ($ii; 2; vl_InSiao_NbChamps)
												P_ChaineEnChamp(vl_InSiao_Table; $ii; tt_InSiao_Valeur{$ii}{1})
											End for 
											SAVE RECORD:C53([SIAO_SiteReference:54])
											UNLOAD RECORD:C212([SIAO_SiteReference:54])
										End if 
										
									: (Table:C252(vl_InSiao_Table)=(->[SIAO_SiteAccueil:55]))
										//i_MessageSeul ("Import SIAO : Référents")
										vl_IDold_SIAO_Referent:=Num:C11(tt_InSiao_Valeur{1}{1})
										QUERY:C277([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_Nom:5=tt_InSiao_Valeur{5}{1}; *)
										QUERY:C277([SIAO_SiteAccueil:55];  & ; [SIAO_SiteAccueil:55]Sr_Prénom:6=tt_InSiao_Valeur{6}{1}; *)
										QUERY:C277([SIAO_SiteAccueil:55];  & ; [SIAO_SiteAccueil:55]Sr_Téléphone:9=tt_InSiao_Valeur{9}{1})
										MultiSoc_Filter(->[SIAO_SiteAccueil:55])
										If (Records in selection:C76([SIAO_SiteAccueil:55])>0)
											vl_ID_SIAO_Referent:=[SIAO_SiteAccueil:55]Sr_RéférenceID:1
										Else 
											CREATE RECORD:C68([SIAO_SiteAccueil:55])
											MultiSoc_Init_Structure(->[SIAO_SiteAccueil:55])
											[SIAO_SiteAccueil:55]Sr_RéférenceID:1:=Uut_Numerote(->[SIAO_SiteAccueil:55])
											vl_ID_SIAO_Referent:=[SIAO_SiteAccueil:55]Sr_RéférenceID:1
											For ($ii; 2; vl_InSiao_NbChamps)
												P_ChaineEnChamp(vl_InSiao_Table; $ii; tt_InSiao_Valeur{$ii}{1})
											End for 
											SAVE RECORD:C53([SIAO_SiteAccueil:55])
											UNLOAD RECORD:C212([SIAO_SiteAccueil:55])
										End if 
										
									: (Table:C252(vl_InSiao_Table)=(->[SIAO:50]))
										// i_MessageSeul ("Import SIAO : Fiche dossier SIAO")
										vl_IDold_SIAO:=Num:C11(tt_InSiao_Valeur{1}{1})
										//1er : Demandeur
										QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=tt_InSiao_Valeur{20}{1})
										MultiSoc_Filter(->[HeBerge:4])
										If (Records in selection:C76([HeBerge:4])=1)
											vl_ID_SIAO_Dem:=[HeBerge:4]HB_ReferenceID:1
											//[HéBergé]HB_Nom
											//[HéBergé]HB_Prénom
											//[HéBergé]HB_DateNéLe
										Else 
											CREATE RECORD:C68([HeBerge:4])
											MultiSoc_Init_Structure(->[HeBerge:4])
											[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
											vl_ID_SIAO_Dem:=[HeBerge:4]HB_ReferenceID:1
											[HeBerge:4]HB_Clé:2:=tt_InSiao_Valeur{20}{1}
											[HeBerge:4]HB_Nom:3:=""
											[HeBerge:4]HB_Prénom:4:=""
											[HeBerge:4]HB_DateNéLe:5:=!00-00-00!
											If (P_CleVersIdte([HeBerge:4]HB_Clé:2))
											End if 
											SAVE RECORD:C53([HeBerge:4])
											UNLOAD RECORD:C212([HeBerge:4])
										End if 
										//2r : LE DOSSIER SIAO                          
										CREATE RECORD:C68([SIAO:50])
										MultiSoc_Init_Structure(->[SIAO:50])
										[SIAO:50]Si_RéférenceID:1:=Uut_Numerote(->[SIAO:50])
										vl_ID_SIAO:=[SIAO:50]Si_RéférenceID:1
										For ($ii; 2; vl_InSiao_NbChamps)
											P_ChaineEnChamp(vl_InSiao_Table; $ii; tt_InSiao_Valeur{$ii}{1})
										End for 
										[SIAO:50]Si_Origine_SiteReference_ID:15:=vl_ID_SIAO_Accueil
										[SIAO:50]Si_OrigineSiteAccueil_ID:19:=vl_ID_SIAO_Referent
										[SIAO:50]Si_Demandeur_ID:21:=vl_ID_SIAO_Dem
										[SIAO:50]Si_Fins:47:=[SIAO:50]Si_Fins:47+1
										SAVE RECORD:C53([SIAO:50])
										UNLOAD RECORD:C212([SIAO:50])
										
									: (Table:C252(vl_InSiao_Table)=(->[SIAO_Personnes:51]))
										// i_MessageSeul ("Import SIAO : Fiche dossier Personnes")
										ARRAY LONGINT:C221(tl_ID_SIAO_Personne; vl_InSiao_Personnes)
										ARRAY LONGINT:C221(tl_IDold_SIAO_Personne; vl_InSiao_Personnes)
										For ($jj; 1; vl_InSiao_Personnes)
											tl_ID_SIAO_Personne{$jj}:=0
											tl_IDold_SIAO_Personne{$jj}:=0
											
											//1er : lien clé
											vl_IDold_SIAO_Dem:=Num:C11(tt_InSiao_Valeur{3}{$jj})
											
											QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=Uut_HébergéClép(tt_InSiao_Valeur{11}{$jj}; tt_InSiao_Valeur{13}{$jj}; tt_InSiao_Valeur{14}{$jj}))
											MultiSoc_Filter(->[HeBerge:4])
											If (Records in selection:C76([HeBerge:4])=1)
												vl_ID_SIAO_Dem:=[HeBerge:4]HB_ReferenceID:1
											Else 
												CREATE RECORD:C68([HeBerge:4])
												MultiSoc_Init_Structure(->[HeBerge:4])
												[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
												vl_ID_SIAO_Dem:=[HeBerge:4]HB_ReferenceID:1
												[HeBerge:4]HB_Nom:3:=tt_InSiao_Valeur{11}{$jj}
												[HeBerge:4]HB_Prénom:4:=tt_InSiao_Valeur{13}{$jj}
												[HeBerge:4]HB_DateNéLe:5:=Date:C102(tt_InSiao_Valeur{14}{$jj})
												[HeBerge:4]HB_Clé:2:=tt_InSiao_Valeur{20}{1}
												[HeBerge:4]HB_Clé:2:=Uut_HébergéClé(->[HeBerge:4]HB_Nom:3; ->[HeBerge:4]HB_Prénom:4; ->[HeBerge:4]HB_DateNéLe:5)
												[SIAO_Personnes:51]Sp_Genre:10:=(tt_InSiao_Valeur{10}{$jj}="1")
												SAVE RECORD:C53([HeBerge:4])
												UNLOAD RECORD:C212([HeBerge:4])
											End if 
											
											//2r : LES Personnes du dossier                  
											tl_IDold_SIAO_Personne{$jj}:=Num:C11(tt_InSiao_Valeur{1}{$jj})
											CREATE RECORD:C68([SIAO_Personnes:51])
											MultiSoc_Init_Structure(->[SIAO_Personnes:51])
											[SIAO_Personnes:51]Sp_RéférenceID:1:=Uut_Numerote(->[SIAO_Personnes:51])
											tl_ID_SIAO_Personne{$jj}:=[SIAO_Personnes:51]Sp_RéférenceID:1
											For ($ii; 2; vl_InSiao_NbChamps)
												P_ChaineEnChamp(vl_InSiao_Table; $ii; tt_InSiao_Valeur{$ii}{$jj})
											End for 
											[SIAO_Personnes:51]Sp_SIAO_ID:2:=vl_ID_SIAO
											[SIAO_Personnes:51]Sp_Personne_ID:3:=vl_ID_SIAO_Dem
											SAVE RECORD:C53([SIAO_Personnes:51])
											UNLOAD RECORD:C212([SIAO_Personnes:51])
										End for 
										
									: (Table:C252(vl_InSiao_Table)=(->[Adresses:53]))
										//i_MessageSeul ("Import SIAO : Fiche dossier Adresses")
										$vl_FicheID:=Uut_NumerotePlus(->[Adresses:53]; vl_InSiao_Personnes)
										For ($jj; 1; vl_InSiao_Personnes)
											CREATE RECORD:C68([Adresses:53])
											MultiSoc_Init_Structure(->[Adresses:53])
											[Adresses:53]AD_RéférenceID:1:=$vl_FicheID  //Uut_Numerote (->[Adresses])
											$vl_FicheID:=$vl_FicheID+1
											[Adresses:53]AD_Lien_Table:2:=String:C10(Table:C252(->[SIAO_Personnes:51]))
											[Adresses:53]AD_SIAO_ID:3:=vl_ID_SIAO
											[Adresses:53]AD_SIAO_Personne_ID:4:=tl_ID_SIAO_Personne{$jj}
											For ($ii; 5; vl_InSiao_NbChamps)
												P_ChaineEnChamp(vl_InSiao_Table; $ii; tt_InSiao_Valeur{$ii}{$jj})
											End for 
											SAVE RECORD:C53([Adresses:53])
											UNLOAD RECORD:C212([Adresses:53])
										End for 
										
									: (Table:C252(vl_InSiao_Table)=(->[SIAO_Situations:52]))
										i_MessageSeul("Import SIAO : Fiche situation: "+String:C10($vl_Fiche)+"/"+String:C10(vl_InSiao_Fiches))
										$vl_FicheID:=Uut_NumerotePlus(->[SIAO_Situations:52]; vl_InSiao_Personnes)
										For ($jj; 1; vl_InSiao_Personnes)
											CREATE RECORD:C68([SIAO_Situations:52])
											MultiSoc_Init_Structure(->[SIAO_Situations:52])
											[SIAO_Situations:52]Ss_RéférenceID:1:=$vl_FicheID  //Uut_Numerote (->[SIAO_Situations])
											$vl_FicheID:=$vl_FicheID+1
											[SIAO_Situations:52]Ss_SIAO_ID:2:=vl_ID_SIAO
											[SIAO_Situations:52]Ss_SIAO_Personne_ID:3:=tl_ID_SIAO_Personne{$jj}
											For ($ii; 4; vl_InSiao_NbChamps)
												P_ChaineEnChamp(vl_InSiao_Table; $ii; tt_InSiao_Valeur{$ii}{$jj})
											End for 
											SAVE RECORD:C53([SIAO_Situations:52])
											UNLOAD RECORD:C212([SIAO_Situations:52])
										End for 
										
								End case 
								
							End for 
						End if   //••••FIN  NOMBRE DE FICHES
					End if   //•••• FIN NOUVELLE SÉQUENCE•
				End if 
			Until ($vb_OK)
			CLOSE DOCUMENT:C267($h_RefDoc)
			P_VarConso_SIAO(12)
			CLOSE WINDOW:C154
			BEEP:C151
			BEEP:C151
			DELETE DOCUMENT:C159(vt_ConsoB_Document)
			If (OK=1)
				DELETE FROM ARRAY:C228(ta_Conso_Document; ta_Conso_Document; 1)
				ta_Conso_Document:=0
				P_VarConso_SIAO(3)
			End if 
			
		End if 
		USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
		
		
	: ($1=8)
		If (Test path name:C476(vt_ConsoB_Document)=Est un document:K24:1)
			If (i_Confirmer("Suppression du Dossier : "+ta_Conso_Document{ta_Conso_Document}))
				DELETE DOCUMENT:C159(vt_ConsoB_Document)
				If (OK=1)
					DELETE FROM ARRAY:C228(ta_Conso_Document; ta_Conso_Document; 1)
					ta_Conso_Document:=0
					vt_ConsoB_Titre:=""
					vl_Conso_DocumentLignes:=Size of array:C274(ta_Conso_Document)
					va_ConsoB_Document:=String:C10(vl_Conso_DocumentLignes)+" dossier"+("s"*Num:C11(vl_Conso_DocumentLignes>1))+" trouvée"+("s"*Num:C11(vl_Conso_DocumentLignes>1))+" le "+String:C10(Current date:C33; Système date court:K1:1)+" à "+String:C10(Current time:C178; h mn:K7:2)
				End if 
			End if 
		End if 
		
		
	: ($1=10)
		
		QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Numero:3=va_ConsoB_SIAOno)
		MultiSoc_Filter(->[SIAO:50])
		If (Records in selection:C76([SIAO:50])=1)
			Process_Go10(-><>PR_SIAOFiche; "Go_SIAOFiche"; "SIAO fiche"; 128; [SIAO:50]Si_RéférenceID:1; "M"; 0; 0; "")
		Else 
			StrAlerte(1; "")
		End if 
		
	: ($1=11)
		
		READ WRITE:C146([HeBerge:4])
		READ WRITE:C146([SIAO:50])
		READ WRITE:C146([SIAO_SiteReference:54])
		READ WRITE:C146([SIAO_SiteAccueil:55])
		READ WRITE:C146([SIAO_Personnes:51])
		READ WRITE:C146([Adresses:53])
		READ WRITE:C146([SIAO_Situations:52])
	: ($1=12)
		UNLOAD RECORD:C212([HeBerge:4])
		UNLOAD RECORD:C212([SIAO:50])
		UNLOAD RECORD:C212([SIAO_SiteReference:54])
		UNLOAD RECORD:C212([SIAO_SiteAccueil:55])
		UNLOAD RECORD:C212([SIAO_Personnes:51])
		UNLOAD RECORD:C212([Adresses:53])
		UNLOAD RECORD:C212([SIAO_Situations:52])
		
		READ ONLY:C145([HeBerge:4])
		READ ONLY:C145([SIAO:50])
		READ ONLY:C145([SIAO_SiteReference:54])
		READ ONLY:C145([SIAO_SiteAccueil:55])
		READ ONLY:C145([SIAO_Personnes:51])
		READ ONLY:C145([Adresses:53])
		READ ONLY:C145([SIAO_Situations:52])
End case 

