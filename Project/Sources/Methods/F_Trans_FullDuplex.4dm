//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_Trans_FullDuplex
//{
//{          Mardi 18 octobre 2008 à 15:47
//{          
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($vt_RépCentreLu)
C_LONGINT:C283($ii; $ij)
C_TEXT:C284($va_Lignes)

$vb_OK:=True:C214
//•(1) Le répertoir de transfert existe-t-il        
If ($vb_OK)
	$vb_Ok:=F_Report_FullDuplexDossier(11; <>vt_T_CheminRép)
	If ($vb_OK=False:C215)
		ALERT:C41("Veuillez vérifier le chemin d'accès du répertoire de transfert !")
	End if 
End if 

//•(2) Le srépertoires des centres existent-t-ils     
If ($vb_OK)
	For ($ii; 1; Size of array:C274(ta_CTNom))
		If (tl_CTSél{$ii}=1)  //•••• Centre sélectionné
			$vb_OK:=False:C215
			//•••• Recherche des données du Centre sélectionné
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tl_CTRéf{$ii})
			MultiSoc_Filter(->[LesCentres:9])
			If (Records in selection:C76([LesCentres:9])=1)
				vl_LC_Réf:=[LesCentres:9]LC_RéférenceID:1
				va_LC_Nom:=[LesCentres:9]LC_Nom:4
				va_LC_Ad1:=[LesCentres:9]LC_Adr1:24
				va_LC_Ad2:=[LesCentres:9]LC_Adr2:25
				va_LC_CP:=[LesCentres:9]LC_CP:27
				va_LC_Ville:=[LesCentres:9]LC_Ville:28
				va_LC_Tel:=[LesCentres:9]LC_Téléphone:29
				va_LC_Fax:=[LesCentres:9]LC_Télécopie2:31
				va_LC_Pers:=[LesCentres:9]LC_Responsable:32
				va_LC_Plateforme:=[LesCentres:9]LC_Plateforme:56
				vl_LC_Niveau:=[LesCentres:9]LC_Niveau:52
				vl_LC_Capacité:=[LesCentres:9]LC_DispoJour:48
				va_LC_Dossier:=[LesCentres:9]LC_Répertoire:54  //• TRES IMPORTANT : LE REPERTOIRE DU CENTRE
				vl_LC_RéfTrans:=[LesCentres:9]LC_Trans_RéférenceID:57
				$vb_OK:=(va_LC_Dossier>"")
			End if 
			
			//•(3) Le répertoire du report pour le Centre  existe t il
			If ($vb_OK)
				//•••• Si la fiche Centre a un code Reperoire
				//•••• • Teste de l'existence du répertoire Centre
				//•••• • SINON Création du répertoire Centre
				//•••• • Teste de l'existence du répertoire Centre pour les fiches lues
				//•••• • SINON Création du répertoire Centre pour les fiches lues        
				vt_FullDuplexDossier:=<>vt_T_CheminRép+va_LC_Dossier+Séparateur dossier:K24:12
				$vb_OK:=F_Report_FullDuplexDossier(12; vt_FullDuplexDossier)
				If ($vb_OK)
					$vt_RépCentreLu:=<>vt_T_CheminRép+va_LC_Dossier+Séparateur dossier:K24:12+va_LC_Dossier+" LU"+Séparateur dossier:K24:12
					$vb_OK:=F_Report_FullDuplexDossier(12; $vt_RépCentreLu)
				End if 
			End if 
			
			
			//•(4) On constitue le tableau
			If ($vb_OK)
				$vb_OK:=False:C215
				F_Report_FullDuplexTableau
				
				//   $vl_Fenetre:=i_FenêtreNo (500;20;5;"";8;"")
				i_Message("Centre : "+[LesCentres:9]LC_Nom:4+" - "+[LesCentres:9]LC_Lieu:5+" / Transfert ")
				USE SET:C118("E_Hébergé")
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=tl_CTRéf{$ii})
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_1_TransHeure:70=?00:00:00?)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FamClé:104; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >)
				vl_NbHB:=Records in selection:C76([HeberGement:5])
				If (vl_NbHB>0)
					FIRST RECORD:C50([HeberGement:5])
					SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Trans_Réf_HG)
					$va_Lignes:=String:C10(Size of array:C274(tl_Trans_Réf_HG))
					
					READ WRITE:C146([HeberGement:5])
					For ($ij; 1; Size of array:C274(tl_Trans_Réf_HG))
						i_MessageSeul("Centre : "+[LesCentres:9]LC_Nom:4+" - "+[LesCentres:9]LC_Lieu:5+" / Transfert : "+$va_Lignes+"/"+String:C10($ij))
						$vb_OK:=F_Report_FullDuplexLoop($ij; tl_Trans_Réf_HG{$ij}; False:C215; False:C215)
					End for 
					UNLOAD RECORD:C212([HeberGement:5])
					READ ONLY:C145([HeberGement:5])
					QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_Trans_Réf_HG)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FamClé:104; >; *)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >)
					F_Report_FullDuplexTableau
				Else 
					USE SET:C118("E_Hébergé")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=tl_CTRéf{$ii})
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FamClé:104; >; *)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >)
					vl_NbHB:=Records in selection:C76([HeberGement:5])
				End if 
				CLOSE WINDOW:C154
			End if 
		End if 
	End for 
End if 