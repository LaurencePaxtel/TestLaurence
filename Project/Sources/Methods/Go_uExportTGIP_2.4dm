//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uExportTGIP_2
//{
//{          Jeudi 4 décembre 2003 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

ALL RECORDS:C47([HeberGement:5])
MultiSoc_Filter(->[HeberGement:5])

C_TEXT:C284(vt_NomFic; vt_texte)
C_TEXT:C284(va_nbFic)
va_nbFic:=String:C10(Records in selection:C76([HeberGement:5]))
vt_NomFic:=vt_DebtNomFic+"_2 Hebergements"
$ii:=0
i_Message("Export `2 - Les hebergements  …")
C_TIME:C306($h_RefDoc)
$h_RefDoc:=?00:00:00?

If (Records in selection:C76([HeberGement:5])>0)
	
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; >)
	MultiSoc_Filter(->[HeberGement:5])
	//FIRST RECORD([HeberGement])
	
	$h_RefDoc:=Create document:C266(vt_NomFic)
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		SEND PACKET:C103($h_RefDoc; "Reference interne"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Numero"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Jour ou Nuit"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Lien personne"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Etat civil"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Genre"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Nom"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Prenom"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "NeLe"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Age"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Date"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Heure"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Signalement"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Signalement suite"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Identite1"+va_TAB+"Identite2"+va_TAB+"Identite3"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Ressources1_1"+va_TAB+"Ressources1_2"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Ressources2_1"+va_TAB+"Ressources2_2"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Ressources3_1"+va_TAB+"Ressources3_2"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Suivi social 1"+va_TAB+"Suivi social 2"+va_TAB+"Suivi social 3"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Couverture sociale 1"+va_TAB+"Couverture sociale 2"+va_TAB+"Couverture sociale 3"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Rupture majeure 1_1"+va_TAB+"Rupture majeure 1_2"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Rupture majeure 2_1"+va_TAB+"Rupture majeure 2_2"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Rupture majeure 3_1"+va_TAB+"Rupture majeure 3_2"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Code postal"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Gare"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Metro"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Emplacement"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Maraude 1"+va_TAB+"Maraude 2"+va_TAB+"Maraude 3"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Liens de parente"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Nationalite"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Situation de famille"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Temps d'errance"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Dernier hebergement"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Situation professionnelle"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Dernier emploi"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Duree sans emploi"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Niveau d'etude"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Orientation 1"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Orientation 2"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Autre solution"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Centre d'hebergement"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Lien Centre"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "CP"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "DS"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Reservation active"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Jour en cours"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Total Jours"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Etat du report"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "En attente"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "En attente heure"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Transmise"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Transmise heure"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Prise en charge"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Prise en charge heure"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Cloturee"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Cloturee heure"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Lit medicalise"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "SP"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Coordinateur"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Regulateur"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Permanencier"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Assistante sociale"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Famille Groupe"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Chef responsable"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Cle de lien"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Famille Homme"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille femme"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Femme enceinte"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Enfant Mineur"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Enfant Majeur"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Parent Mineur"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Parent Majeur"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Famille Nb personnes"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Nb jours"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Nb chambres"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Prix par jour"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Prix total"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Famille Distri 1"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Distri 2"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Distri 3"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Distri 4"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Famille Distri 5"+va_TAB)
		
		
		SEND PACKET:C103($h_RefDoc; "Famille cas specific")
		
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		SEND PACKET:C103($h_RefDoc; <>va_LF)
		If (vb_OKTêtes)
			Repeat 
				$ii:=$ii+1
				i_MessageSeul("Export `2 - Les hebergements  - "+va_nbFic+" / "+String:C10($ii))
				
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_ReferenceID:1)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_FicheNuméro:3)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Jour"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215))+("Nuit"*Num:C11([HeberGement:5]HG_Nuit:2=True:C214)))+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_HB_ID:19)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_EtatCivil:20)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Masculin"*Num:C11([HeberGement:5]HG_Genre:96=False:C215))+("Feminin"*Num:C11([HeberGement:5]HG_Genre:96=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Nom:21)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Prénom:22)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_DateNéLe:24; Interne date court:K1:7)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_Age:23)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_Date:4; Interne date court:K1:7)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_HeureAppel:5; h mn s:K7:1)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Signalement:12)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_SignalCentre:13)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_PiècesIdté1:31)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_PiècesIdté2:32)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_PiècesIdté3:33)+va_TAB)
				
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Ressources1:45)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Ressource1_2:75)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Ressources2:46)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Ressource2_2:76)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Ressources3:47)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Ressource3_2:77)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_SuiviSocial1:49)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_SuiviSocial2:50)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_SuiviSocial3:51)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_CouvSocial1:53)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_CouvSocial2:54)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_CouvSocial3:55)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_RupMajeur1:40)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_RupMajeur1_2:72)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_RupMajeur2:41)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_RupMajeur2_2:73)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_RupMajeur3:42)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_RupMajeur3_2:74)+va_TAB)
				
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_CodePostal:14)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Gare:15)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Métro:16)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Emplacement:17)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Maraude1_1:10)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Maraude2_1:98)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Maraude3_1:100)+va_TAB)
				
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Lien:18)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Nationalité:25)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_SituFamille:29)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_TempsErrance:34)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_DernierHéber:35)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_SituProfess:36)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_DernierEmplo:37)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_DuréSanEmplo:38)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_NiveauEtude:43)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Orientation1:58)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Orientation2:60)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_AutreSolutio:88)+va_TAB)
				
				
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_CentreNom:62)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_LC_ID:61)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_CentreARR:63)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeberGement:5]HG_DispoSpé:90=False:C215))+("Oui"*Num:C11([HeberGement:5]HG_DispoSpé:90=True:C214)))+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeberGement:5]HG_Réservation:91=False:C215))+("Oui"*Num:C11([HeberGement:5]HG_Réservation:91=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_NuitenCours:92)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_NuitTOTAL:93)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Reporté:94)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeberGement:5]HG_EnAttente:64=False:C215))+("Oui"*Num:C11([HeberGement:5]HG_EnAttente:64=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_AttenteHeur:83; h mn s:K7:1)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeberGement:5]HG_Transmis:65=False:C215))+("Oui"*Num:C11([HeberGement:5]HG_Transmis:65=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_TransmisHeur:84; h mn s:K7:1)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeberGement:5]HG_PriseCharge:66=False:C215))+("Oui"*Num:C11([HeberGement:5]HG_PriseCharge:66=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_PrChargeHeur:85; h mn s:K7:1)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeberGement:5]HG_Cloturée:67=False:C215))+("Oui"*Num:C11([HeberGement:5]HG_Cloturée:67=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_CloturéeHeur:86; h mn s:K7:1)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeberGement:5]HG_Médicalisé:56=False:C215))+("Oui"*Num:C11([HeberGement:5]HG_Médicalisé:56=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeberGement:5]HG_Status:89=False:C215))+("Oui"*Num:C11([HeberGement:5]HG_Status:89=True:C214)))+va_TAB)
				
				
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Coordinateur:7)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Régulateur:8)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_Permanencier:9)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_AssistSocial:87)+va_TAB)
				
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_FamGroupe:102)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeberGement:5]HG_FamChef:103=False:C215))+("Oui"*Num:C11([HeberGement:5]HG_FamChef:103=True:C214)))+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_FamClé:104)+va_TAB)
				
				ve_FamH:=0
				ve_FamF:=0
				ve_FamFe:=0
				ve_FamEMi:=0
				ve_FamEMa:=0
				ve_FamPMi:=0
				ve_FamPMa:=0
				If ([HeberGement:5]HG_FamCompoVar:117>"")
					ve_FamH:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 2; 1))
					ve_FamF:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 4; 1))
					ve_FamFe:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 6; 1))
					ve_FamEMi:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 8; 2))
					ve_FamEMa:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 11; 2))
					ve_FamPMi:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 14; 1))
					ve_FamPMa:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 16; 1))
					
				End if 
				
				SEND PACKET:C103($h_RefDoc; String:C10(ve_FamH)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10(ve_FamF)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10(ve_FamFe)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10(ve_FamEMi)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10(ve_FamEMa)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10(ve_FamPMi)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10(ve_FamPMa)+va_TAB)
				
				
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_FamNbPers:106)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_FamNbJour:107)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_FamNbChambre:108)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_FamPrixJour:109; "## ### ##0,00")+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeberGement:5]HG_FamTotal:110; "## ### ##0,00")+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_FamDistri1:112)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_FamDistri2:113)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_FamDistri3:114)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_FamDistri4:115)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_FamDistri5:116)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeberGement:5]HG_FamCasSpéc:111))
				
				SEND PACKET:C103($h_RefDoc; <>va_CR)
				SEND PACKET:C103($h_RefDoc; <>va_LF)
				
				
				NEXT RECORD:C51([HeberGement:5])
			Until (End selection:C36([HeberGement:5]))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
		
	End if 
End if 
CLOSE WINDOW:C154