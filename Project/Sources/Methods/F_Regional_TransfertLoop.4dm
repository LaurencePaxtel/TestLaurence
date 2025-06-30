//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_Regional_Transfert
//{          Vendrdi 28 janvier 2011 à 14:45
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_LONGINT:C283($1)  //Indice de boucle
C_LONGINT:C283($2)  //Référence unique de la fiche hébergement
C_BOOLEAN:C305($3)  //Tache sur le serveur ou sur le poste mono
C_BOOLEAN:C305($4)  //Exporter au format windows

C_BOOLEAN:C305($vb_OK)

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=$2)
MultiSoc_Filter(->[HeberGement:5])
If (Records in selection:C76([HeberGement:5])=1)
	$vb_OK:=False:C215
	Repeat 
		IDLE:C311
		LOAD RECORD:C52([HeberGement:5])
	Until (Not:C34(Locked:C147([HeberGement:5])))
	
	//•• 1•• En fonction de la méthode exécuté Sur Serveur ou En monoposte
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
	
	
	vl_LC_Réf:=0
	va_LC_Nom:=""
	va_LC_Ad1:=""
	va_LC_Ad2:=""
	va_LC_CP:=""
	va_LC_Ville:=""
	va_LC_Tel:=""
	va_LC_Fax:=""
	va_LC_Pers:=""
	va_LC_Plateforme:=""
	vl_LC_Niveau:=0
	vl_LC_Capacité:=0
	va_LC_Dossier:=""  //• TRES IMPORTANT : LE REPERTOIRE DU CENTRE
	vl_LC_RéfTrans:=0
	
	
	$vb_OK:=True:C214
	//•• 2•• Recherche des données du Centre sélectionné
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
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
	Else 
		If (<>vb_T_ModeCHRS)
			$vb_OK:=False:C215
		End if 
	End if 
	//•• 3•• Construire le nom du fichier sur disque
	If ($vb_OK)
		vt_TitreDocument:=F_FichierExtention("TXT"; F_FichierNom_HB(vd_DateRéelle; vd_HeureRéelle; <>va_T_Site; [HeberGement:5]HG_FicheNuméro:3; [HeberGement:5]HG_EtatCivil:20; [HeberGement:5]HG_Age:23))
	End if 
	
	//•• 4•• Export des données
	If ($vb_OK)
		$h_RefDoc:=Create document:C266(vt_FullDuplexDossier+vt_TitreDocument)
		If (OK=1)
			USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
			$vb_Ok:=F_Regional_TransfertData($h_RefDoc; vd_DateRéelle; vd_HeureRéelle; 8; $4)  //8 pour STR de l'Ecran ASILE      
			USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
			
			CLOSE DOCUMENT:C267($h_RefDoc)
		End if 
	End if 
	
	
	
	
	
	//•• 5•• Mise à jour de du champ signifiant l'export
	If ($vb_OK)
		SAVE RECORD:C53([HeberGement:5])
		$0:=True:C214
	End if 
	UNLOAD RECORD:C212([HeberGement:5])
End if 
