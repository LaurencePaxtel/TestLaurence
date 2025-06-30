//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_Report_FullDuplexLoop
//{          Vendrdi 24 octobre 2008 à 16:11
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_LONGINT:C283($1)  //Indice de boucle
C_LONGINT:C283($2)  //Référence unique de la fiche hébergement
C_BOOLEAN:C305($3)  //Tache sur le serveur ou sur le poste mono
C_BOOLEAN:C305($4)  //Exporter au format windows
C_BOOLEAN:C305($vb_OK)


QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=$2)
If (Records in selection:C76([HeberGement:5])=1)
	$vb_OK:=False:C215
	Repeat 
		IDLE:C311
		LOAD RECORD:C52([HeberGement:5])
	Until (Not:C34(Locked:C147([HeberGement:5])))
	
	//En fonction de la méthode exécuté Sur Serveur ou En monoposte
	If ($3)  //vb_Serveur
		vd_DateServeur:=Current date:C33(*)
		vd_HeureServeur:=Current time:C178(*)
		vd_DateRéelle:=vd_DateServeur
		vd_HeureRéelle:=vd_HeureServeur+(8*3600)
		If (vd_HeureRéelle>?23:59:59?)
			vd_DateRéelle:=vd_DateRéelle+1
			vd_HeureRéelle:=vd_HeureRéelle-(24*3600)
		End if 
	Else 
		vd_DateRéelle:=Current date:C33
		vd_HeureRéelle:=Current time:C178
		vd_DateServeur:=vd_DateRéelle
		vd_HeureServeur:=vd_HeureRéelle-(8*3600)
		If (vd_HeureServeur<?00:00:00?)
			vd_DateServeur:=vd_DateServeur-1
			vd_HeureServeur:=(24*3600)+vd_HeureServeur
		End if 
	End if 
	vh_HrJF:=vd_HeureRéelle
	
	//•••• Recherche des données du Centre sélectionné
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
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
		$vb_OK:=True:C214
	End if 
	
	//•••• Construire le nom du fichier sur disque
	If ($vb_OK)
		$vb_Ok:=F_Report_FullDuplexFichier(->vt_TitreDocument; vd_DateRéelle; vd_HeureRéelle; <>va_T_Site; [HeberGement:5]HG_FicheNuméro:3; [HeberGement:5]HG_EtatCivil:20; [HeberGement:5]HG_Age:23)
		If ($vb_OK)
			vt_TitreDocument:=F_FichierSuffixe(vt_TitreDocument)
		End if 
	End if 
	
	
	//•••• Export des données
	If ($vb_OK)
		$0:=False:C215
		
		$h_RefDoc:=Create document:C266(vt_FullDuplexDossier+vt_TitreDocument)
		If (OK=1)
			
			USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
			If (<>vb_FullDuplexDataB)
				$vb_Ok:=F_Report_FullDuplexDonnées_B($h_RefDoc; vd_DateRéelle; vd_HeureRéelle; 8; $4)  //n'est pas mise ne marche car change les imports
			Else 
				$vb_Ok:=F_Report_FullDuplexDonnées($h_RefDoc; vd_DateRéelle; vd_HeureRéelle; 8; $4)  //8 pour STR de l'Ecran ASILE
			End if 
			USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
			CLOSE DOCUMENT:C267($h_RefDoc)
			
		End if 
	End if 
	
	//•••• Mise à jour de du champ signifiant l'export
	If ($vb_OK)
		If (va_TransFrom="Transfert")
			P_Transfert_HBAlors("Transfert")
		End if 
		[HeberGement:5]HG_1_TransHeure:70:=vd_HeureRéelle
		SAVE RECORD:C53([HeberGement:5])
		$0:=True:C214
	End if 
	
	UNLOAD RECORD:C212([HeberGement:5])
End if 

