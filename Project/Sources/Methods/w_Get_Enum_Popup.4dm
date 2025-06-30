//%attributes = {}
// Method w_Get_Popups  
// 
// 
// #SYNTAX: w_Get_Popups($T_Nom_liste;->$rT_Values 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : 
//     $2 Pointer         : 
//     $3 Date            : 
//     $4 Time            : 
//     $5 BLOB            : 
//     $6 Picture         : 
//     $7 Object          :
//     $8 real            :
//     $9 Boolean         :

// #DATE CREATION: 16/08/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_TEXT:C284($1; $T_Selecteur)  // fournira la propriété de l'ob
$T_Selecteur:=$1
C_POINTER:C301($2; $P_Param)
$P_Param:=$2

CLEAR VARIABLE:C89($P_Output)
Case of 
	: ($T_Selecteur="etat civil")
		$P_Output:=-><>ta_TBEtCiv
		
	: ($T_Selecteur="Code postal")  //Arrondissements
		$P_Output:=-><>ta_TBArr
	: ($T_Selecteur="Metro")  //Metro
		$P_Output:=-><>ta_TBMetro
	: ($T_Selecteur="Gares")  //Gares
		$P_Output:=-><>ta_TBGare
	: ($T_Selecteur="Places")  //Places
		$P_Output:=-><>ta_TBPlace
	: ($T_Selecteur="Portes")  //Portes- Emplacement
		$P_Output:=-><>ta_TBPorte
	: ($T_Selecteur="Maraude")  //Maraude
		$P_Output:=-><>ta_TBMaraud
	: ($T_Selecteur="Liens")  //Liens
		$P_Output:=-><>ta_TBLien
	: ($T_Selecteur="Lieu de naissance")  //Lieu de naissance
		$P_Output:=-><>ta_TBLieuNé
	: ($T_Selecteur="Situation de famille")  //Situation de famille
		$P_Output:=-><>ta_TBSitFam
	: ($T_Selecteur="Temps d'errance")  //Temps d'errance
		$P_Output:=-><>ta_TBTpsErr
	: ($T_Selecteur="Dernier hébergement")  //Dernier hébergement
		$P_Output:=-><>ta_TBDerHéb
	: ($T_Selecteur="Situation professionnelle")  //Situation professionnelle
		$P_Output:=-><>ta_TBSitPro
	: ($T_Selecteur="Dernier emploi")  //Dernier emploi
		$P_Output:=-><>ta_TBDerJob
	: ($T_Selecteur="Durée du dernier emploi")  //Durée du dernier emploi
		$P_Output:=-><>ta_TBDurJob
	: ($T_Selecteur="Niveau d'étude")  //Niveau d'étude
		$P_Output:=-><>ta_TBNivEtu
	: ($T_Selecteur="Pièces d'identité")  //Pièces Identité
		$P_Output:=-><>ta_TBPIdté
	: ($T_Selecteur="Nationalité")  //Nationalité
		$P_Output:=-><>ta_TBNatio
	: ($T_Selecteur="Signalement")  //Signalement
		$P_Output:=-><>ta_TBSglt
	: ($T_Selecteur="Ressources actuelles")  //Ressources actuelles
		$P_Output:=-><>ta_TBResAct
	: ($T_Selecteur="Suivi social")  //Suivi social
		$P_Output:=-><>ta_TBSuiSoc
	: ($T_Selecteur="Couverture sociale")  //Couverture sociale
		$P_Output:=-><>ta_TBCouSoc
	: ($T_Selecteur="Ruptures majeures")  //Ruptures majeures
		$P_Output:=-><>ta_TBRupMaj
	: ($T_Selecteur="Provenance")  //Provenance
		$P_Output:=-><>ta_TBProv
	: ($T_Selecteur="Plainte")  //Plainte
		$P_Output:=-><>ta_TBPlain
	: ($T_Selecteur="Hospitalisation")  //Hospitalisation
		$P_Output:=-><>ta_TBHospi
	: ($T_Selecteur="Traitement en cours")  //Traitement en cours
		$P_Output:=-><>ta_TBTrCour
	: ($T_Selecteur="Toxicologie")  //Toxicologie
		$P_Output:=-><>ta_TBToxico
	: ($T_Selecteur="Pneumologie")  //Pneumologie
		$P_Output:=-><>ta_TBPneumo
	: ($T_Selecteur="Cardiologie")  //Cardiologie
		$P_Output:=-><>ta_TBCardio
	: ($T_Selecteur="Neurologie")  //Neurologie
		$P_Output:=-><>ta_TBNeuro
	: ($T_Selecteur="Infectologie")  //Infectologie
		$P_Output:=-><>ta_TBInfect
	: ($T_Selecteur="Gastro-Entéro")  //Gastro-Entéro
		$P_Output:=-><>ta_TBGastro
	: ($T_Selecteur="Psychiatrie")  //Psychiatrie
		$P_Output:=-><>ta_TBPsychi
	: ($T_Selecteur="Dermatologie")  //Dermatologie
		$P_Output:=-><>ta_TBDerm
	: ($T_Selecteur="Traumatologie")  //Traumatologie
		$P_Output:=-><>ta_TBTrauma
	: ($T_Selecteur="Divers")  //Divers
		$P_Output:=-><>ta_TBDivers
	: ($T_Selecteur="Traitement administré")  //Traitement administré
		$P_Output:=-><>ta_TBTrAdm
	: ($T_Selecteur="Traitement de sortie")  //Traitement de sortie
		$P_Output:=-><>ta_TBTrSort
	: ($T_Selecteur="Orientation 1")  //Orientation 1
		$P_Output:=-><>ta_TBOr1
	: ($T_Selecteur="Orientation 1 suite")  //Orientation suite
		$P_Output:=-><>ta_TBOr1suite
	: ($T_Selecteur="Autre solution suite")  //Autre solution suite
		$P_Output:=-><>ta_AtSsuite
	: ($T_Selecteur="Orientation2")  //Orientation 2 ou localisation
		$P_Output:=-><>ta_TBOr2
	: ($T_Selecteur="Autre solution")  //Autre solution
		$P_Output:=-><>ta_AtS
	: ($T_Selecteur="Appels")  //Appels
		$P_Output:=-><>ta_Appels
	: ($T_Selecteur="Responsables")  //Responsables
		$P_Output:=-><>ta_Resp
	: ($T_Selecteur="Chef de bord")  //Chef de bord
		$P_Output:=-><>ta_ChB
	: ($T_Selecteur="N° EMA")  //N°EMA
		$P_Output:=-><>ta_EMA
	: ($T_Selecteur="Langues")  //Langues
		$P_Output:=-><>ta_Lgs
	: ($T_Selecteur="Orientation Sociale")  //Orient Social
		$P_Output:=-><>ta_OrSc
	: ($T_Selecteur="Orientation médicale")  //Orient Médical
		$P_Output:=-><>ta_OrMd
	: ($T_Selecteur="Dernier lieu d'hébergement")  //Dernier lieu d'hébergement
		$P_Output:=-><>ta_DerLH
	: ($T_Selecteur="Compagnie actuelle")  //Compagnie actuelle
		$P_Output:=-><>ta_CpAct
	: ($T_Selecteur="MR Signalement")  //#MR Signalement
		$P_Output:=-><>ta_MRsg
	: ($T_Selecteur="MR Suivi médical")  //#MR Suivi médical
		$P_Output:=-><>ta_MRsm
	: ($T_Selecteur="MR Pathologie")  //#MR Pathologie
		$P_Output:=-><>ta_MRpt
	: ($T_Selecteur="MR Couverture sociale")  //MR Couverture sociale
		$P_Output:=-><>ta_MRcs
	: ($T_Selecteur="MR Ressources")  //MR Ressources
		$P_Output:=-><>ta_MRrs
	: ($T_Selecteur="MR Régime")  //MR Régime
		$P_Output:=-><>ta_MRrg
	: ($T_Selecteur="MR Suivi social")  //MR Suivi social
		$P_Output:=-><>ta_MRss
	: ($T_Selecteur="MR Motif de refus")  //MR Motif de refus
		$P_Output:=-><>ta_MRrefu
	: ($T_Selecteur="MR Sortie de centre")  //MR Sortie de centre
		$P_Output:=-><>ta_MRSctr
	: ($T_Selecteur="MR Personne majeure protégée")  //MR Personne majeure protégée
		$P_Output:=-><>ta_MRMpro
	: ($T_Selecteur="MR Personne chez qui aller")  //MR Personne chez qui aller
		$P_Output:=-><>ta_MRQui
	: ($T_Selecteur="MR ConnuSSP")  //MR ConnuSSP
		$P_Output:=-><>ta_MRCssp
	: ($T_Selecteur="MR PremierSSP")  //MR PremierSSP
		$P_Output:=-><>ta_MRPssp
	: ($T_Selecteur="MR Prise en charge")  //MR Prise en charge
		$P_Output:=-><>ta_MRPch
	: ($T_Selecteur="MR Demande")  //MR Demande
		$P_Output:=-><>ta_MRDem
	: ($T_Selecteur="MR Etat général")  //MR Etat général
		$P_Output:=-><>ta_MReGé
	: ($T_Selecteur="MR Etat cutané")  //MR Etat cutané
		$P_Output:=-><>ta_MReCu
	: ($T_Selecteur="MR Relation")  //MR Relation
		$P_Output:=-><>ta_MRrel
	: ($T_Selecteur="MR Quel Mode")  //MR Quel mode
		$P_Output:=-><>ta_Qmod
	: ($T_Selecteur="MR Quel Motif")  //MR Quel Motif
		$P_Output:=-><>ta_Qmot
	: ($T_Selecteur="MR Indices")  //MR Indices
		$P_Output:=-><>ta_Indic
	: ($T_Selecteur="MR Dépendances")  //MR Dépendances
		$P_Output:=-><>ta_Dépen
	: ($T_Selecteur="MR Pathologies")  //MR Pathologies
		$P_Output:=-><>ta_Patho
	: ($T_Selecteur="MR Hopital Lieu")  //#MR HopitalLieu
		$P_Output:=-><>ta_HopL
	: ($T_Selecteur="MR Lit infirmier")  //#MR Lit infirmier
		$P_Output:=-><>ta_LitInf
	: ($T_Selecteur="MR Hygiène")  //#MR Hygiène
		$P_Output:=-><>ta_MRhyg
	: ($T_Selecteur="MR Handicap")  //#MR Handicap
		$P_Output:=-><>ta_MRhan
	: ($T_Selecteur="MR Quatier")  //#MR Quatier
		$P_Output:=-><>ta_MRqua
	: ($T_Selecteur="DS Orientation sociale")  //#DS Orientation sociale
		$P_Output:=-><>ta_MRorS
	: ($T_Selecteur="DS Aide")  //#DS Aide
		$P_Output:=-><>ta_MRaid
	: ($T_Selecteur="DS Prolongation")  //#DS Prolongation
		$P_Output:=-><>ta_MRPro
	: ($T_Selecteur="DS Papier Identité")  //#DS PapiersIdentité
		$P_Output:=-><>ta_DSidté
	: ($T_Selecteur="DS Régime")  //#DS Régime
		$P_Output:=-><>ta_DSrég
	: ($T_Selecteur="DS Suivi")  //#DS Suivi
		$P_Output:=-><>ta_DSsuivi
	: ($T_Selecteur="DS Compagnie")  //#DS Compagnie
		$P_Output:=-><>ta_DScomp
	: ($T_Selecteur="DS Couverture sociale")  //#DS Couverture sociale
		$P_Output:=-><>ta_DScs
	: ($T_Selecteur="DP Etat Psy")  //DP Etat Psy
		$P_Output:=-><>ta_DPpsy
	: ($T_Selecteur="DP Antécédents")  //DP Antécédents
		$P_Output:=-><>ta_DPanté
	: ($T_Selecteur="DP Orientation")  //DP Orientation
		$P_Output:=-><>ta_DPOr
	: ($T_Selecteur="DM Mode d'entrée")  //#DM Mode d'entrée
		$P_Output:=-><>ta_DMmEnt
	: ($T_Selecteur="DM Mode de sortie")  //#DM Mode de sortie
		$P_Output:=-><>ta_DMmSor
	: ($T_Selecteur="DM Traitement administratif")  //#DM Traitement administratif
		$P_Output:=-><>ta_DMtAdm
	: ($T_Selecteur="DM Traitement de sortie")  //#DM Traitement de sortie
		$P_Output:=-><>ta_DMtSor
	: ($T_Selecteur="DM Poids")  //#DM Poids
		$P_Output:=-><>ta_DMpds
	: ($T_Selecteur="DM Taille")  //#DM Taille
		$P_Output:=-><>ta_DMTail
	: ($T_Selecteur="DM Vision loin gauche")  //#DM Vision loin gauche
		$P_Output:=-><>ta_DMvlg
	: ($T_Selecteur="DM Vision loin droit")  //#DM Vision loin droit
		$P_Output:=-><>ta_DMvld
	: ($T_Selecteur="DM Vision prés gauche")  //#DM Vision prés gauche
		$P_Output:=-><>ta_DMvpg
	: ($T_Selecteur="DM Vision prés droit")  //#DM Vision prés droit
		$P_Output:=-><>ta_DMvpd
	: ($T_Selecteur="DM Antécédents")  //#DM Antécédents
		$P_Output:=-><>ta_DManté
	: ($T_Selecteur="DM Ethylisme")  //#DM Ethylisme
		$P_Output:=-><>ta_DMety
	: ($T_Selecteur=<>va_DMetyQ_L)  //#DM Ethylisme Quantité
		$P_Output:=-><>ta_DMetyQ
	: ($T_Selecteur=<>va_DMetyT_L)  //#DM Ethylisme Type
		$P_Output:=-><>ta_DMetyT
	: ($T_Selecteur=<>va_DMetyA_L)  //#DM Ethylisme Années
		$P_Output:=-><>ta_DMetyA
	: ($T_Selecteur=<>va_DMTab_L)  //#DM TABAC
		$P_Output:=-><>ta_DMTab
	: ($T_Selecteur=<>va_DMTabP_L)  //#DM TABAC paquets
		$P_Output:=-><>ta_DMTabP
	: ($T_Selecteur=<>va_DMTabA_L)  //#DM TABAC années
		$P_Output:=-><>ta_DMTabA
	: ($T_Selecteur=<>va_DMmad_L)  //#DM Motif d'admission
		$P_Output:=-><>ta_DMmad
	: ($T_Selecteur=<>va_DMexam_L)  //#DM Examens
		$P_Output:=-><>ta_DMexam
	: ($T_Selecteur=<>va_DMtox_L)  //#DM Toxicomanie
		$P_Output:=-><>ta_DMtox
	: ($T_Selecteur="FM Groupe")  //#FM Groupe
		$P_Output:=-><>ta_FMGrp
	: ($T_Selecteur="FM Composition")  //#FM Composition famille
		$P_Output:=-><>ta_FMComp
	: ($T_Selecteur="FM Nb personnes")  //#FM Nombre de personnes
		$P_Output:=-><>ta_FMnbP
	: ($T_Selecteur="FM Nb jours")  //# FM Nombre de jours
		$P_Output:=-><>ta_FMnbJ
	: ($T_Selecteur="FM Nb chambres")  //# FM Nombre de chambres
		$P_Output:=-><>ta_FMnbC
	: ($T_Selecteur="FM Cas spécifique")  //# FM Cas spécifique
		$P_Output:=-><>ta_FMCaS
	: ($T_Selecteur="FM Distri1")  //# FM Distribution 1
		$P_Output:=-><>ta_FMDis1
	: ($T_Selecteur="FM Distri2")  //# FM Distribution 2
		$P_Output:=-><>ta_FMDis2
	: ($T_Selecteur="FM Distri3")  //# FM Distribution 3
		$P_Output:=-><>ta_FMDis3
	: ($T_Selecteur="FM Distri4")  //# FM Distribution 4
		$P_Output:=-><>ta_FMDis4
	: ($T_Selecteur="FM Distri5")  //# FM Distribution 5
		$P_Output:=-><>ta_FMDis5
	: ($T_Selecteur="Autonomie DE")  //# Dossier santé : Autonomie
		$P_Output:=-><>ta_DEAuto
	: ($T_Selecteur="Dépendance DE")  //# Dossier santé : Dépendance
		$P_Output:=-><>ta_DEDép
	: ($T_Selecteur="Parasitose DE")  //# Dossier santé : Parasitose
		$P_Output:=-><>ta_DEPara
	: ($T_Selecteur=<>va_DEAlle_L)  //# Dossier santé : Allergie
		$P_Output:=-><>ta_DEAlle
	: ($T_Selecteur=<>va_DEMdEnt_L)  //# Dossier santé : Mode Entrée
		$P_Output:=-><>ta_DEMdEnt
	: ($T_Selecteur=<>va_DEMtEnt_L)  //# Dossier santé : Motif Entrée
		$P_Output:=-><>ta_DEMtEnt
	: ($T_Selecteur=<>va_DEOPat_L)  //# Dossier santé : Objectif Patient
		$P_Output:=-><>ta_DEOPat
	: ($T_Selecteur=<>va_DEOEquip_L)  //# Dossier santé : Objectif Equipe
		$P_Output:=-><>ta_DEOEquip
	: ($T_Selecteur=<>va_DEOrient_L)  //# Dossier santé : Orientation
		$P_Output:=-><>ta_DEOrient
	: ($T_Selecteur=<>va_DMTabT_L)  //# Dossier santé : TabacType
		$P_Output:=-><>ta_DMTabT
	: ($T_Selecteur=<>va_DEToxi_L)  //# Dossier santé : Toxicomanie
		$P_Output:=-><>ta_DEToxi
	: ($T_Selecteur=<>va_DEToxiQ_L)  //# Dossier santé : Toxicomanie Qté
		$P_Output:=-><>ta_DEToxiQ
	: ($T_Selecteur=<>va_DEToxiT_L)  //# Dossier santé : Toxicomanie Type
		$P_Output:=-><>ta_DEToxiT
	: ($T_Selecteur=<>va_DEToxiA_L)  //# Dossier santé : Toxicomanie Année
		$P_Output:=-><>ta_DEToxiA
	: ($T_Selecteur=<>va_DEVisionQF_L)  //# Dossier santé : Vision quoi faire
		$P_Output:=-><>ta_DEVisionQF
	: ($T_Selecteur=<>va_DECtr_L)  //# Dossier santé : Centre
		$P_Output:=-><>ta_DECtr
	: ($T_Selecteur=<>va_DETrH_L)  //# Dossier santé : Traitement habituel DE
		$P_Output:=-><>ta_DETrH
	: ($T_Selecteur=<>va_DEToxiC_L)  //# Dossier santé : Toxicomanie Contenant
		$P_Output:=-><>ta_DEToxiC
	: ($T_Selecteur=<>va_DEExamAdr_L)  //#Dossier santé : Examen Adresse
		$P_Output:=-><>ta_DEExamAdr
	: ($T_Selecteur=<>va_DEExamSec_L)  //#Dossier santé : Examen Service
		$P_Output:=-><>ta_DEExamSec
	: ($T_Selecteur="Pièces d'identité 2")  //#"Pièces d'identité 2"
		$P_Output:=-><>ta_TBPIdté2
	: ($T_Selecteur="Pièces d'identité 3")  //#"Pièces d'identité 3"
		$P_Output:=-><>ta_TBPIdté3
	: ($T_Selecteur="Suivi social 2")  //#"Suivi social 2"
		$P_Output:=-><>ta_TBSuiSoc2
	: ($T_Selecteur="Suivi social 3")  //#"Suivi social 3"
		$P_Output:=-><>ta_TBSuiSoc3
	: ($T_Selecteur="Couverture sociale 2")  //#"Couverture sociale 2"
		$P_Output:=-><>ta_TBCouSoc2
	: ($T_Selecteur="Couverture sociale 3")  //#"Couverture sociale 3"
		$P_Output:=-><>ta_TBCouSoc3
	: ($T_Selecteur="Ruptures majeures 2")  //#"Ruptures majeures 2"
		$P_Output:=-><>ta_TBRupMaj2
	: ($T_Selecteur="Ruptures majeures 3")  //#"Ruptures majeures 3"
		$P_Output:=-><>ta_TBRupMaj3
	: ($T_Selecteur="Ressources actuelles 2")  //#"Ressources actuelles 2"
		$P_Output:=-><>ta_TBResAct2
	: ($T_Selecteur="Ressources actuelles 3")  //#"Ressources actuelles 3"
		$P_Output:=-><>ta_TBResAct3
	: ($T_Selecteur="Liste d'URL")  //#"Liste d'URL"
		$P_Output:=-><>ta_URL
	: ($T_Selecteur="Liste des plateformes")  //Liste des plateformes pour CHRS
		$P_Output:=-><>ta_Plateforme
	: ($T_Selecteur=<>va_Categorie)  //Liste des catégories des centres
		$P_Output:=-><>ta_Categorie
	: ($T_Selecteur="Liste des Attestations")  //Liste des Attestations         // #REW20170428-1 ce n'est plus utilisé
		$P_Output:=-><>ta_Attestations
	: ($T_Selecteur="SIAO Situation d'accueil")  //# SIAO_Situation d'accueil
		$P_Output:=-><>ta_SIAO_SiteAccueil
	: ($T_Selecteur=<>va_SIAO_Role_L)  //# SIAO_Rôle
		$P_Output:=-><>ta_SIAO_Role
	: ($T_Selecteur=<>va_SIAO_SitPhysique_L)  //# SIAO_SituationPhysique
		$P_Output:=-><>ta_SIAO_SitPhysique
	: ($T_Selecteur=<>va_SIAO_CatHeberge_L)  //# SIAO_Catégorie d'hébergement
		$P_Output:=-><>ta_SIAO_CatHeberge
	: ($T_Selecteur=<>va_SIAO_CatPlace_L)  //# SIAO_Catégorie de place
		$P_Output:=-><>ta_SIAO_CatPlace
	: ($T_Selecteur=<>va_SIAO_CatStruc_L)  //# SIAO_Catégorie StructureLogement
		$P_Output:=-><>ta_SIAO_CatStruc
	: ($T_Selecteur=<>va_SIAO_Competent_L)  //# SIAO_SIAO_Compétent
		$P_Output:=-><>ta_SIAO_Competent
	: ($T_Selecteur=<>va_SIAO_Etat_L)  //# SIAO_SIAO_Etat
		$P_Output:=-><>ta_SIAO_Etat
	: ($T_Selecteur=<>va_SIAO_Civilite_L)  //# SIAO_SIAO_Civilité
		$P_Output:=-><>ta_SIAO_Civilite
	: ($T_Selecteur=<>va_SIAO_NeLeLieu_L)  //# SIAO_SIAO_NeLeLieu
		$P_Output:=-><>ta_SIAO_NeLeLieu
	: ($T_Selecteur=<>va_SIAO_NeLePays_L)  //# SIAO_SIAO_NeLePays
		$P_Output:=-><>ta_SIAO_NeLePays
	: ($T_Selecteur=<>va_SIAO_SitFam_L)  //# SIAO_SIAO_SitFam
		$P_Output:=-><>ta_SIAO_SitFam
	: ($T_Selecteur=<>va_SIAO_Parente_L)  //# SIAO_SIAO_Parente
		$P_Output:=-><>ta_SIAO_Parente
	: ($T_Selecteur=<>va_SIAO_Nationalite_L)  //# SIAO_SIAO_Nationalite
		$P_Output:=-><>ta_SIAO_Nationalite
	: ($T_Selecteur=<>va_SIAO_Papier_L)  //# SIAO_SIAO_Papier
		$P_Output:=-><>ta_SIAO_Papier
	: ($T_Selecteur=<>va_SIAO_Ressource_L)  //#SIAO_SIAO_Ressource
		$P_Output:=-><>ta_SIAO_Ressource
	: ($T_Selecteur=<>va_SIAO_CouvSoc_L)  //#SIAO_SIAO_Ressource
		$P_Output:=-><>ta_SIAO_CouvSoc
	: ($T_Selecteur=<>va_SIAO_Locomotion_L)  //#SIAO_SIAO_Locomotion
		$P_Output:=-><>ta_SIAO_Locomotion
	: ($T_Selecteur=<>va_SIAO_SitProf_L)  //# SIAO_SIAO_SitProf
		$P_Output:=-><>ta_SIAO_SitProf
	: ($T_Selecteur=<>va_SIAO_Dette_L)  //# SIAO_SIAO_Endettement
		$P_Output:=-><>ta_SIAO_Dette
	: ($T_Selecteur=<>va_SIAO_CouvSoc_L)  //# SIAO_SIAO_CouSoc
		$P_Output:=-><>ta_SIAO_CouvSoc
	: ($T_Selecteur=<>va_SIAO_TypePapier_L)  //# SIAO_SIAO_TypePapier
		$P_Output:=-><>ta_SIAO_TypePapier
	: ($T_Selecteur=<>va_SIAO_CasSpec_L)  //# SIAO_SIAO_CasSpec
		$P_Output:=-><>ta_SIAO_CasSpec
	: ($T_Selecteur=<>va_SIAO_LogActuel_L)  //# SIAO_SIAO_LogementActuel
		$P_Output:=-><>ta_SIAO_LogActuel
	: ($T_Selecteur=<>va_SIAO_MotifDem_L)  //# SIAO_SIAO_MotifDemande
		$P_Output:=-><>ta_SIAO_MotifDem
	: ($T_Selecteur=<>va_SIAO_TitreSej_L)  //# SIAO_SIAO_TitreSejour
		$P_Output:=-><>ta_SIAO_TitreSej
	: ($T_Selecteur=<>va_SIAO_Besoins_L)  //# SIAO_SIAO_Besoins
		$P_Output:=-><>ta_SIAO_Besoins
	: ($T_Selecteur=<>va_SIAO_TypeAcc_L)  //# SIAO_SIAO_Type Acc. preconisé
		$P_Output:=-><>ta_SIAO_TypeAcc
	: ($T_Selecteur=<>va_SIAO_TypeAccS_L)  //# SIAO_SIAO_Type Acc. Souhaité
		$P_Output:=-><>ta_SIAO_TypeAccS
	: ($T_Selecteur=<>va_SIAO_LogAdapte_L)  //# SIAO_SIAO_LogementAdapté
		$P_Output:=-><>ta_SIAO_LogAdapte
	: ($T_Selecteur=<>va_SIAO_Orienter_L)  //# SIAO_SIAO_Orientation
		$P_Output:=-><>ta_SIAO_Orienter
	: ($T_Selecteur=<>va_SIAO_BesAidF_L)  //# SIAO_SIAO_Besoin aide financière
		$P_Output:=-><>ta_SIAO_BesAidF
	: ($T_Selecteur=<>va_SIAO_AccueilCol_L)  //# SIAO_SIAO_AccueilCol
		$P_Output:=-><>ta_SIAO_AccueilCol
	: ($T_Selecteur=<>va_SIAO_SanSitProf_L)  //# ◊va_SIAO_SanSitProf_L
		$P_Output:=-><>ta_SIAO_SanSitProf
	: ($T_Selecteur=<>va_SIAO_EtCiv_L)  //# SIAO_SIAO_EtatCivil
		$P_Output:=-><>ta_SIAO_EtCiv
	: ($T_Selecteur=<>va_SIAO_Credit_L)  //# SIAO_SIAO_Credit
		$P_Output:=-><>ta_SIAO_Credit
	: ($T_Selecteur="HG DosSIAO")  //# HG_DossierSIAO
		$P_Output:=-><>ta_HG_DosSIAO
		
		// Modified by: Kevin HASSAL (27-01-2019)
		
	: ($T_Selecteur="Locations: types des documents")  //# Locations : Type document des locations
		$P_Output:=-><>ta_TypeDocLocation
	: ($T_Selecteur="Locations: Sinistres")  //# Locations : Libellés des sinistres/travaux
		$P_Output:=-><>ta_GL_LibelleSinistres
	: ($T_Selecteur="Locations: Charges")  //# Locations : Libellé des charges
		$P_Output:=-><>ta_GL_LibelleCharges
	: ($T_Selecteur="Modes de règlements")  //# Modes de règlements
		$P_Output:=-><>ta_GL_ModesReglements
	: ($T_Selecteur="Banques")  //# Banques
		$P_Output:=-><>ta_GL_Banques
	: ($T_Selecteur="Locations: Type du bien")  //# Locations : Libellé des charges
		$P_Output:=-><>ta_GL_TypeBien
	: ($T_Selecteur="TVA")  //# TVA
		$P_Output:=-><>ta_TVA
	Else 
		ASSERT:C1129(False:C215; "liste inconnue")
End case 

COPY ARRAY:C226($P_Output->; $P_Param->)
























