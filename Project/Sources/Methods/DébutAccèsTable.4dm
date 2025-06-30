//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutAccèsTable  
//{          initialisation des variable Référence des Tables
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Demande de prestation
//<>va_DemP_R:="040/1@"
//<>va_DemP_L:="Demande de prestations"

//Adresses utiles
//<>va_AdUtil_R:="041/1@"
//<>va_AdUtil_L:="Adresses utiles"

//Stuations particulières
//<>va_SitPar_R:="042/1@"
//<>va_SitPar_L:="Stuations particulières"

//Pour ces tables la recherche se fait sur le type
//Users
//Coordinateurs
//Régulateurs
//Permanencier
//Infirmier
//Médecins
//Médecins Hébergement


////Toxicologie
//<>va_Toxico_L:="Toxicologie"
//<>va_Toxico_R:="025/1@"

////Pneumologie
//<>va_Pneumo_L:="Pneumologie"
//<>va_Pneumo_R:="026/1@"

////Cardiologie
//<>va_Cardio_L:="Cardiologie"
//<>va_Cardio_R:="027/1@"

////Neurologie
//<>va_Neuro_L:="Neurologie"
//<>va_Neuro_R:="028/1@"

////Infectologie
//<>va_Infect_L:="Infectologie"
//<>va_Infect_R:="029/1@"

////Gastro-Entéro
//<>va_Gastro_L:="Gastro-Entéro"
//<>va_Gastro_R:="030/1@"

////Psychiatrie
//<>va_Psychi_L:="Psychiatrie"
//<>va_Psychi_R:="031/1@"

////Dermatologie
//<>va_Derm_L:="Dermatologie"
//<>va_Derm_R:="032/1@"

////Traumatologie
//<>va_Trauma_L:="Traumatologie"
//<>va_Trauma_R:="033/1@"

////Divers
//<>va_Divers_L:="Divers"
//<>va_Divers_R:="034/1@"

////Traitement administré
//<>va_TrAdm_L:="Traitement administré"
//<>va_TrAdm_R:="035/1@"

////Traitement de sortie
//<>va_TrSort_L:="Traitement de sortie"
//<>va_TrSort_R:="036/1@"

////#Appels
//<>va_APP_L:="Appels"
//Début_LienTable(-><>va_APP_L; -><>va_APP_R)

////#Responsables
//<>va_Resp_L:="Responsables"
//Début_LienTable(-><>va_Resp_L; -><>va_Resp_R)

////#Chef de bord
//<>va_ChB_L:="Chef de bord"
//Début_LienTable(-><>va_ChB_L; -><>va_ChB_R)

////#N° EMA
//<>va_EMA_L:="N° EMA"
//Début_LienTable(-><>va_EMA_L; -><>va_EMA_R)

////#Langues
//<>va_Lgs_L:="Langues"
//Début_LienTable(-><>va_Lgs_L; -><>va_Lgs_R)

////#Orient Social
//<>va_OrSc_L:="Orientation Sociale"
//Début_LienTable(-><>va_OrSc_L; -><>va_OrSc_R)

////#Orient Médical
//<>va_OrMd_L:="Orientation médicale"
//Début_LienTable(-><>va_OrMd_L; -><>va_OrMd_R)

////#Compagnie actuelle
//<>va_CpAct_L:="Compagnie actuelle"
//Début_LienTable(-><>va_CpAct_L; -><>va_CpAct_R)

////#MR Signalement
//<>va_MRsg_L:="MR Signalement"
//Début_LienTable(-><>va_MRsg_L; -><>va_MRsg_R)

////#MR Suivi médical
//<>va_MRsm_L:="MR Suivi médical"
//Début_LienTable(-><>va_MRsm_L; -><>va_MRsm_R)

////#MR Pathologie
//<>va_MRpt_L:="MR Pathologie"
//Début_LienTable(-><>va_MRpt_L; -><>va_MRpt_R)

////#MR Couverture sociale
//<>va_MRcs_L:="MR Couverture sociale"
//Début_LienTable(-><>va_MRcs_L; -><>va_MRcs_R)

////#MR Ressources
//<>va_MRrs_L:="MR Ressources"
//Début_LienTable(-><>va_MRrs_L; -><>va_MRrs_R)

////#MR Régime
//<>va_MRrg_L:="MR Régime"
//Début_LienTable(-><>va_MRrg_L; -><>va_MRrg_R)

////#MR Suivi social
//<>va_MRss_L:="MR Suivi social"
//Début_LienTable(-><>va_MRss_L; -><>va_MRss_R)

////#MR Motif de refus
//<>va_MRrefu_L:="MR Motif de refus"
//Début_LienTable(-><>va_MRrefu_L; -><>va_MRrefu_R)

////#MR Sortie de centre
//<>va_MRSctr_L:="MR Sortie de centre"
//Début_LienTable(-><>va_MRSctr_L; -><>va_MRSctr_R)

////#MR Personne majeure protégée
//<>va_MRMpro_L:="MR Personne majeure protégée"
//Début_LienTable(-><>va_MRMpro_L; -><>va_MRMpro_R)

////#MR Personne chez qui aller
//<>va_MRQui_L:="MR Personne chez qui aller"
//Début_LienTable(-><>va_MRQui_L; -><>va_MRQui_R)

////#MR ConnuSSP
//<>va_MRCssp_L:="MR ConnuSSP"
//Début_LienTable(-><>va_MRCssp_L; -><>va_MRCssp_R)

////#MR PremierSSP
//<>va_MRPssp_L:="MR PremierSSP"
//Début_LienTable(-><>va_MRPssp_L; -><>va_MRPssp_R)

////#MR Prise en charge
//<>va_MRPch_L:="MR Prise en charge"
//Début_LienTable(-><>va_MRPch_L; -><>va_MRPch_R)

////#MR Demande
//<>va_MRDem_L:="MR Demande"
//Début_LienTable(-><>va_MRDem_L; -><>va_MRDem_R)

////#MR Etat général
//<>va_MReGé_L:="MR Etat général"
//Début_LienTable(-><>va_MReGé_L; -><>va_MReGé_R)

////#MR Etat cutané
//<>va_MReCu_L:="MR Etat cutané"
//Début_LienTable(-><>va_MReCu_L; -><>va_MReCu_R)

////#MR Etat Relation
//<>va_MRrel_L:="MR Relation"
//Début_LienTable(-><>va_MRrel_L; -><>va_MRrel_R)

////#MR Quel mode
//<>va_Qmod_L:="MR Quel Mode"
//Début_LienTable(-><>va_Qmod_L; -><>va_Qmod_R)

////#MR Quel Motif
//<>va_Qmot_L:="MR Quel Motif"
//Début_LienTable(-><>va_Qmot_L; -><>va_Qmot_R)

////#MR Indices
//<>va_Indic_L:="MR Indices"
//Début_LienTable(-><>va_Indic_L; -><>va_Indic_R)
////#MR Dépendances
//<>va_Dépen_L:="MR Dépendances"
//Début_LienTable(-><>va_Dépen_L; -><>va_Dépen_R)

////#MR Pathologies
//<>va_Patho_L:="MR Pathologies"
//Début_LienTable(-><>va_Patho_L; -><>va_Patho_R)

////#MR Hopital Lieu
//<>va_HopL_L:="MR Hopital Lieu"
//Début_LienTable(-><>va_HopL_L; -><>va_HopL_R)

////#MR Lit infirmier
//<>va_LitInf_L:="MR Lit infirmier"
//Début_LienTable(-><>va_LitInf_L; -><>va_LitInf_R)

////#MR Hygiène
//<>va_MRhyg_L:="MR Hygiène"
//Début_LienTable(-><>va_MRhyg_L; -><>va_MRhyg_R)

////#MR Handicap
//<>va_MRhan_L:="MR Handicap"
//Début_LienTable(-><>va_MRhan_L; -><>va_MRhan_R)

////#MR Quatier
//<>va_MRqua_L:="MR Quatier"
//Début_LienTable(-><>va_MRqua_L; -><>va_MRqua_R)

////#DS Orientation sociale
//<>va_MRorS_L:="DS Orientation sociale"
//Début_LienTable(-><>va_MRorS_L; -><>va_MRorS_R)

////#DS Aide
//<>va_MRaid_L:="DS Aide"
//Début_LienTable(-><>va_MRaid_L; -><>va_MRaid_R)

////#DS Prolongation
//<>va_MRPro_L:="DS Prolongation"
//Début_LienTable(-><>va_MRPro_L; -><>va_MRPro_R)

////#DS PapiersIdentité
//<>va_DSidté_L:="DS Papier Identité"
//Début_LienTable(-><>va_DSidté_L; -><>va_DSidté_R)

////#DS Régime
//<>va_DSrég_L:="DS Régime"
//Début_LienTable(-><>va_DSrég_L; -><>va_DSrég_R)

////#DS Suivi
//<>va_DSsuivi_L:="DS Suivi"
//Début_LienTable(-><>va_DSsuivi_L; -><>va_DSsuivi_R)

////#DS Compagnie
//<>va_DScomp_L:="DS Compagnie"
//Début_LienTable(-><>va_DScomp_L; -><>va_DScomp_R)

////#DS Couverture sociale
//<>va_DScs_L:="DS Couverture sociale"
//Début_LienTable(-><>va_DScs_L; -><>va_DScs_R)

////#DP Etat Psy
//<>va_DPpsy_L:="DP Etat Psy"
//Début_LienTable(-><>va_DPpsy_L; -><>va_DPpsy_R)

////#DP Antécédents
//<>va_DPanté_L:="DP Antécédents"
//Début_LienTable(-><>va_DPanté_L; -><>va_DPanté_R)

////#DP Orientation
//<>va_DPOr_L:="DP Orientation"
//Début_LienTable(-><>va_DPOr_L; -><>va_DPOr_R)

////#DM Mode d'entrée
//<>va_DMmEnt_L:="DM Mode d'entrée"
//Début_LienTable(-><>va_DMmEnt_L; -><>va_DMmEnt_R)

////#DM Mode de sortie
//<>va_DMmSor_L:="DM Mode de sortie"
//Début_LienTable(-><>va_DMmSor_L; -><>va_DMmSor_R)

////#DM Traitement administratif
//<>va_DMtAdm_L:="DM Traitement administratif"
//Début_LienTable(-><>va_DMtAdm_L; -><>va_DMtAdm_R)

////#DM Traitement de sortie
//<>va_DMtSor_L:="DM Traitement de sortie"
//Début_LienTable(-><>va_DMtSor_L; -><>va_DMtSor_R)

////#DM Poids
//<>va_DMpds_L:="DM Poids"
//Début_LienTable(-><>va_DMpds_L; -><>va_DMpds_R)

////#DM Taille
//<>va_DMTail_L:="DM Taille"
//Début_LienTable(-><>va_DMTail_L; -><>va_DMTail_R)

////#DM Vision loin gauche
//<>va_DMvlg_L:="DM Vision loin gauche"
//Début_LienTable(-><>va_DMvlg_L; -><>va_DMvlg_R)

////#DM Vision loin droit
//<>va_DMvld_L:="DM Vision loin droit"
//Début_LienTable(-><>va_DMvld_L; -><>va_DMvld_R)

////#DM Vision prés gauche
//<>va_DMvpg_L:="DM Vision prés gauche"
//Début_LienTable(-><>va_DMvpg_L; -><>va_DMvpg_R)

////#DM Vision prés droit
//<>va_DMvpd_L:="DM Vision prés droit"
//Début_LienTable(-><>va_DMvpd_L; -><>va_DMvpd_R)

////#DM Antécédents
//<>va_DManté_L:="DM Antécédents"
//Début_LienTable(-><>va_DManté_L; -><>va_DManté_R)

////#DM Ethylisme
//<>va_DMety_L:="DM Ethylisme"
//Début_LienTable(-><>va_DMety_L; -><>va_DMety_R)

////#DM Ethylisme Quantité
//<>va_DMetyQ_L:="DM Ethylisme Quantité"
//Début_LienTable(-><>va_DMetyQ_L; -><>va_DMetyQ_R)

////#DM Ethylisme Type
//<>va_DMetyT_L:="DM Ethylisme Type"
//Début_LienTable(-><>va_DMetyT_L; -><>va_DMetyT_R)

////#DM Ethylisme Années
//<>va_DMetyA_L:="DM Ethylisme Années"
//Début_LienTable(-><>va_DMetyA_L; -><>va_DMetyA_R)

////#DM TABAC
//<>va_DMTab_L:="DM TABAC"
//Début_LienTable(-><>va_DMTab_L; -><>va_DMTab_R)

////#DM TABAC paquets
//<>va_DMTabP_L:="DM TABAC paquets"
//Début_LienTable(-><>va_DMTabP_L; -><>va_DMTabP_R)

////#DM TABAC années
//<>va_DMTabA_L:="DM TABAC années"
//Début_LienTable(-><>va_DMTabA_L; -><>va_DMTabA_R)

////#DM Motif d'admission
//<>va_DMmad_L:="DM Motif d'admission"
//Début_LienTable(-><>va_DMmad_L; -><>va_DMmad_R)

////#DM Examens
//<>va_DMexam_L:="DM Examens"
//Début_LienTable(-><>va_DMexam_L; -><>va_DMexam_R)

////#DM Toxicomanie
//<>va_DMtox_L:="DM Toxicomanie"
//Début_LienTable(-><>va_DMtox_L; -><>va_DMtox_R)

////# Dossier santé : Autonomie
//<>va_DEAuto_L:="Autonomie DE"
//Début_LienTable(-><>va_DEAuto_L; -><>va_DEAuto_R)

////# Dossier santé : Dépendance
//<>va_DEDép_L:="Dépendance DE"
//Début_LienTable(-><>va_DEDép_L; -><>va_DEDép_R)

////# Dossier santé : Parasitose
//<>va_DEPara_L:="Parasitose DE"
//Début_LienTable(-><>va_DEPara_L; -><>va_DEPara_R)

////# Dossier santé : Allergie
//<>va_DEAlle_L:="Allergie DE"
//Début_LienTable(-><>va_DEAlle_L; -><>va_DEAlle_R)

////# Dossier santé : Mode Entrée
//<>va_DEMdEnt_L:="Mode Entrée DE"
//Début_LienTable(-><>va_DEMdEnt_L; -><>va_DEMdEnt_R)

////# Dossier santé : Motif Entrée
//<>va_DEMtEnt_L:="Motif Entrée DE"
//Début_LienTable(-><>va_DEMtEnt_L; -><>va_DEMtEnt_R)

////# Dossier santé : Objectif Patient
//<>va_DEOPat_L:="Objectif Patient DE"
//Début_LienTable(-><>va_DEOPat_L; -><>va_DEOPat_R)

////# Dossier santé : Objectif Equipe
//<>va_DEOEquip_L:="Objectif Equipe DE"
//Début_LienTable(-><>va_DEOEquip_L; -><>va_DEOEquip_R)

////# Dossier santé : Orientation
//<>va_DEOrient_L:="Orientation DE"
//Début_LienTable(-><>va_DEOrient_L; -><>va_DEOrient_R)

////# Dossier santé : TabacType
//<>va_DMTabT_L:="Tabac Type DE"
//Début_LienTable(-><>va_DMTabT_L; -><>va_DMTabT_R)

////# Dossier santé : Toxicomanie
//<>va_DEToxi_L:="Toxicomanie DE"
//Début_LienTable(-><>va_DEToxi_L; -><>va_DEToxi_R)

////# Dossier santé : Toxicomanie Qté
//<>va_DEToxiQ_L:="Toxicomanie Qté DE"
//Début_LienTable(-><>va_DEToxiQ_L; -><>va_DEToxiQ_R)

////# Dossier santé : Toxicomanie Type
//<>va_DEToxiT_L:="Toxicomanie Type DE"
//Début_LienTable(-><>va_DEToxiT_L; -><>va_DEToxiT_R)

////# Dossier santé : Toxicomanie année
//<>va_DEToxiA_L:="Toxicomanie année DE"
//Début_LienTable(-><>va_DEToxiA_L; -><>va_DEToxiA_R)

////# Dossier santé : Vision quoi faire
//<>va_DEVisionQF_L:="Vision quoi faire DE"
//Début_LienTable(-><>va_DEVisionQF_L; -><>va_DEVisionQF_R)

////# Dossier santé : Centre
//<>va_DECtr_L:="Centres DE"
//Début_LienTable(-><>va_DECtr_L; -><>va_DECtr_R)

////# Dossier santé : Traitement habituel DE
//<>va_DETrH_L:="Traitement habituel DE"
//Début_LienTable(-><>va_DETrH_L; -><>va_DETrH_R)

////# Dossier santé : Toxicomanie Contenant
//<>va_DEToxiC_L:="Toxicomanie Contenant DE"
//Début_LienTable(-><>va_DEToxiC_L; -><>va_DEToxiC_R)

////# Dossier santé : Examen Adresse
//<>va_DEExamAdr_L:="Examen Adresse DE"
//Début_LienTable(-><>va_DEExamAdr_L; -><>va_DEExamAdr_R)
////# Dossier santé : Examen Service
//<>va_DEExamSec_L:="Examen Service DE"
//Début_LienTable(-><>va_DEExamSec_L; -><>va_DEExamSec_R)
