//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DebutDécProces  
//{          initialisation des variable process
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($process_el)

C_LONGINT:C283(<>PR_Genéral)  // Menu général ou dialogue départ
<>PR_Genéral:=0

C_LONGINT:C283(<>PR_GenéralLib)  // Menu général ou dialogue départ les libellés
<>PR_GenéralLib:=0

C_LONGINT:C283(<>PR_Mire)  // Process mire
<>PR_Mire:=0

C_LONGINT:C283(<>PR_APropos)  // Process à propos
<>PR_APropos:=0

C_TEXT:C284(<>vt_AProposMes)  // A propos Ordre type
<>vt_AProposMes:=""

C_TEXT:C284(<>vt_APropos)  // A propos Contenu du message
<>vt_APropos:=""

C_LONGINT:C283(<>PR_GIP)  // Demandes de renseignements
<>PR_GIP:=0

C_LONGINT:C283(<>PR_GIPRG)  // Demandes de renseignements dans prestations
<>PR_GIPRG:=0

C_LONGINT:C283(<>PR_AS)  // Associations
<>PR_AS:=0

C_LONGINT:C283(<>PR_CEL)  // Centres d'hébergement
<>PR_CEL:=0

C_LONGINT:C283(<>PR_Lits)  // Table des disponiblités de centres
<>PR_Lits:=0

C_LONGINT:C283(<>PR_LitsFacil)  // Table des disponiblités de centres facil
<>PR_LitsFacil:=0

C_LONGINT:C283(<>PR_Disponible)  // Dialogue Calcul des disponiblités de centres
<>PR_Disponible:=0

// Modifié par : Scanu Rémy (20/10/2022)
$process_el:=Process number:C372("Appel")

If ($process_el>0)
	POST OUTSIDE CALL:C329($process_el)
End if 

C_LONGINT:C283(<>PR_Appel)  // Palette des appels
<>PR_Appel:=0

C_LONGINT:C283(<>PR_AppelAdd)  // Ajouter un appel
<>PR_AppelAdd:=0

C_LONGINT:C283(<>PR_AppelLis)  // Liste des appels
<>PR_AppelLis:=0

C_LONGINT:C283(<>PR_AppelMem)  // Memo
<>PR_AppelMem:=0

C_LONGINT:C283(<>PR_AppelRéserve)
<>PR_AppelRéserve:=0

C_LONGINT:C283(<>PR_AppelRapport)
<>PR_AppelRapport:=0

// Process du PopUp UTILIAIRES
C_LONGINT:C283(<>PR_Tab)  // Gestion des Tables d'énumération
<>PR_Tab:=0

C_LONGINT:C283(<>PR_INT)  // Intervenants
<>PR_INT:=0

C_LONGINT:C283(<>PR_INTPr)  // Intervenants profils
<>PR_INTPr:=0

C_LONGINT:C283(<>PR_INTRaz)  // Intervenants RAZ mot de passe
<>PR_INTRaz:=0

C_LONGINT:C283(<>PR_INTChanger)  // Intervenants changer de user
<>PR_INTChanger:=0

C_LONGINT:C283(<>PR_Purge)  // Gestion de Purges
<>PR_Purge:=0

C_LONGINT:C283(<>PR_ModNé)  // Gestion des dates de naissance
<>PR_ModNé:=0

C_LONGINT:C283(<>PR_Raison)  // Société
<>PR_Raison:=0

C_LONGINT:C283(<>PR_Rubrique)  // Gestion des libellés et attributs des champs
<>PR_Rubrique:=0

C_LONGINT:C283(<>PR_NoFicheH)  // Gestion des numérotations uniques
<>PR_NoFicheH:=0

C_LONGINT:C283(<>PR_Conso)  // Consolidation non développé
<>PR_Conso:=0

C_LONGINT:C283(<>PR_AgeDéfaut)  // Age par défaut des inconnus
<>PR_AgeDéfaut:=0

C_LONGINT:C283(<>PR_RésReport)  // Vue des reports des fiches hébergement
<>PR_RésReport:=0

C_LONGINT:C283(<>PR_STR)  // Les ressources STR
<>PR_STR:=0

C_LONGINT:C283(<>PR_TXT)  // Les ressources TXT
<>PR_TXT:=0

C_LONGINT:C283(<>PR_LOFT)  // Le centre LOFT
<>PR_LOFT:=0

C_LONGINT:C283(<>PR_ReportAUTO)  // Report automatiques
<>PR_ReportAUTO:=0

C_LONGINT:C283(<>PR_ReportDial)  // Report automatiques action
<>PR_ReportDial:=0

C_LONGINT:C283(<>PR_ReportLocal)  // Report automatiques ProcessLocal
<>PR_ReportLocal:=0

C_LONGINT:C283(<>PR_DévTables)  // Vue développeur des tables
<>PR_DévTables:=0

C_LONGINT:C283(<>PR_DévTablesHB)  // Vue Table Hébergés
<>PR_DévTablesHB:=0

C_LONGINT:C283(<>PR_DévTablesHG)  // Vue Table Hébergements
<>PR_DévTablesHG:=0

C_LONGINT:C283(<>PR_DévTablesMR)  // Vue Table Maraudes
<>PR_DévTablesMR:=0

C_LONGINT:C283(<>PR_DévTablesLC)  // Vue Table Centres
<>PR_DévTablesLC:=0

C_LONGINT:C283(<>PR_DévTablesCL)  // Vue Table CentresLits
<>PR_DévTablesCL:=0

C_LONGINT:C283(<>PR_DévTablesTType)  // Vue Table TType
<>PR_DévTablesTType:=0

C_LONGINT:C283(<>PR_DévTablesTT)  // Vue Table TT
<>PR_DévTablesTT:=0

C_LONGINT:C283(<>PR_DévTablesDP)  // Vue Table DP
<>PR_DévTablesDP:=0

C_LONGINT:C283(<>PR_DévTablesRU)  // Vue Table RU
<>PR_DévTablesRU:=0

C_LONGINT:C283(<>PR_DévTablesDL)  // Vue Table DL
<>PR_DévTablesDL:=0

C_LONGINT:C283(<>PR_DévTablesRB)  // Vue Table RB (riques)
<>PR_DévTablesRB:=0

C_LONGINT:C283(<>PR_DévTablesM0)  // Vue Table Mémo
<>PR_DévTablesM0:=0

C_LONGINT:C283(<>PR_DévTablesTD)  // Vue Table Demande
<>PR_DévTablesTD:=0

C_LONGINT:C283(<>PR_DévTablesAP)  // Vue Table Appels
<>PR_DévTablesAP:=0

C_LONGINT:C283(<>PR_DévTablesRG)  // Vue Table RenseiGnements
<>PR_DévTablesRG:=0

C_LONGINT:C283(<>PR_DévTablesIN)  // Vue Table IN
<>PR_DévTablesIN:=0

C_LONGINT:C283(<>PR_DévTablesMP)  // Les mots de passe
<>PR_DévTablesDL:=0

C_LONGINT:C283(<>PR_DévTablesDM)  // Vue Table Dossier médical
<>PR_DévTablesDM:=0

C_LONGINT:C283(<>PR_DévTablesDi)  // Vue Table Dossier infirmier
<>PR_DévTablesDi:=0

C_LONGINT:C283(<>PR_DévTablesDY)  // Vue Table Dossier Psycho
<>PR_DévTablesDY:=0

C_LONGINT:C283(<>PR_DévTablesDS)  // Vue Table Dossier social
<>PR_DévTablesDS:=0

C_LONGINT:C283(<>PR_DévTablesDE)  // Vue Table Dossier santé
<>PR_DévTablesDE:=0

C_LONGINT:C283(<>PR_DévTablesDX)  // Vue Gestion des index
<>PR_DévTablesDX:=0

//Hébergement
C_LONGINT:C283(<>PR_Hébergement)  // Hébergement Jour ou nuit (nouveau)
<>PR_Hébergement:=0

C_LONGINT:C283(<>PR_HébergementC)  // Hébergement Recherche
<>PR_HébergementC:=0

C_LONGINT:C283(<>PR_HébergementR)  // Hébergement Modifier dans recherche
<>PR_HébergementR:=0

C_LONGINT:C283(<>PR_HébergementV)  // Hébergement Modifier dans veille
<>PR_HébergementV:=0

C_LONGINT:C283(<>PR_HébergementMul)  // Hébergement Multiples
<>PR_HébergementMul:=0

C_LONGINT:C283(<>PR_HébergementH)  // Hébergement Historique
<>PR_HébergementH:=0

C_LONGINT:C283(<>PR_HébergementGpe)  // Hébergement Groupe
<>PR_HébergementGpe:=0

C_LONGINT:C283(<>PR_HébergementLst)  // Hébergement Liste
<>PR_HébergementLst:=0

C_LONGINT:C283(<>PR_HébergementP)  // Hébergement dans prolongation
<>PR_HébergementP:=0

C_LONGINT:C283(<>PR_Lien)  // Hébergement Lien familliale
<>PR_Lien:=0

C_LONGINT:C283(<>PR_Fax)  // Gestion des FAX
<>PR_Fax:=0

C_LONGINT:C283(<>PR_HBTexteH)  // Texte Hotel pour les fax et statistiques
<>PR_HBTexteH:=0

C_LONGINT:C283(<>PR_HBTexteF)  // Texte Fax pour les fax et statistiques
<>PR_HBTexteF:=0

C_LONGINT:C283(<>PR_Item)  // Correction des Items
<>PR_Item:=0

C_LONGINT:C283(<>PR_Fusion)  // Fusion de deux héberges et de leurs hébergements
<>PR_Fusion:=0

C_LONGINT:C283(<>PR_HébergementVeille)  // Hébergement Veille
<>PR_HébergementVeille:=0

C_LONGINT:C283(<>PR_HébergementVeille)  // Hébergement Veille
<>PR_HébergementVeille:=0

C_LONGINT:C283(<>PR_MaraudeVeille)  // Maraude Veille
<>PR_MaraudeVeille:=0

C_LONGINT:C283(<>PR_Maraude)  // Maraude Jour ou nuit (nouveau)
<>PR_Maraude:=0

C_LONGINT:C283(<>PR_DosSocialVeille)  // Dossier social Veille
<>PR_DosSocialVeille:=0

C_LONGINT:C283(<>PR_HébergementRG)  // Prestations Renseignements
<>PR_HébergementRG:=0

C_LONGINT:C283(<>PR_Repor)  // Hébergement Report
<>PR_Repor:=0

//Statistiques
C_LONGINT:C283(<>PR_StatC)  // Coordinateur
<>PR_StatC:=0

C_LONGINT:C283(<>PR_StatC2)  // Coordinateur S
<>PR_StatC2:=0

C_LONGINT:C283(<>PR_StatC3)  // Coordinateur C
<>PR_StatC3:=0

C_LONGINT:C283(<>PR_StatD)  // Direction
<>PR_StatD:=0

C_LONGINT:C283(<>PR_StatD2)  // Direction2
<>PR_StatD2:=0

C_LONGINT:C283(<>PR_StatE)  // Etude
<>PR_StatE:=0

C_LONGINT:C283(<>PR_StatE)  // Etude S
<>PR_StatE:=0

C_LONGINT:C283(<>PR_StatS)  // Spécifique
<>PR_StatS:=0

// Modifié par : Scanu Rémy (11/04/2023)
C_LONGINT:C283(<>PR_StatSejour)  // Séjour
<>PR_StatSejour:=0

C_LONGINT:C283(<>PR_StatC)  // DASS
<>PR_StatC:=0

C_LONGINT:C283(<>PR_StatCtr)  // Centres
<>PR_StatCtr:=0

C_LONGINT:C283(<>PR_StatGrp)  // Groupe
<>PR_StatGrp:=0

C_LONGINT:C283(<>PR_StatEMA)  // EMA
<>PR_StatEMA:=0

C_LONGINT:C283(<>PR_StatFsoc)  // Fiches sociales
<>PR_StatFsoc:=0

C_LONGINT:C283(<>PR_StatSM)  // Spécifique maraude
<>PR_StatSM:=0

C_LONGINT:C283(<>PR_StatEM)  // Etude maraude
<>PR_StatEM:=0

C_LONGINT:C283(<>PR_StatEDS)  // Etude Dossier social
<>PR_StatEDS:=0

C_LONGINT:C283(<>PR_StatGraphe)  // Graphe
<>PR_StatGraphe:=0

C_LONGINT:C283(<>PR_StatCtrOcup)  // Centres occupation
<>PR_StatCtrOcup:=0

// Dossiers
C_LONGINT:C283(<>PR_DoS)  // Dossier social
<>PR_DoS:=0

C_LONGINT:C283(<>PR_Doi)  // Dossier infirmier
<>PR_Doi:=0

C_LONGINT:C283(<>PR_DoP)  // Dossier Psycho
<>PR_DoP:=0

C_LONGINT:C283(<>PR_DoM)  // Dossier Médical
<>PR_DoM:=0

C_LONGINT:C283(<>PR_DoE)  // Dossier Santé
<>PR_DoE:=0

// Notes
C_LONGINT:C283(<>PR_HBNotes)  // Note
<>PR_HBNotes:=0

C_LONGINT:C283(<>PR_HBNotesV)  // Note dans veille
<>PR_HBNotesV:=0

C_LONGINT:C283(<>PR_HBNotesP)  // Note dans purges
<>PR_HBNotesP:=0

C_LONGINT:C283(<>PR_HBNotesSIAO)  // Note dans SIAO
<>PR_HBNotesSIAO:=0

C_LONGINT:C283(<>PR_HBAction)  // Note Action
<>PR_HBAction:=0

C_LONGINT:C283(<>PR_HBActionV)  // Note Action dans veille
<>PR_HBActionV:=0

C_LONGINT:C283(<>PR_HBST)  // Note SP
<>PR_HBST:=0

C_LONGINT:C283(<>PR_HBSTV)  // Note SP dans veille
<>PR_HBSTV:=0

C_LONGINT:C283(<>PR_HBSTSIAO)  // Note SP dans SIAO
<>PR_HBSTSIAO:=0

C_LONGINT:C283(<>PR_HBSP)  // Note SP dans purges
<>PR_HBSP:=0

C_LONGINT:C283(<>PR_HBActionF)  // Note Action F
<>PR_HBActionF:=0

C_LONGINT:C283(<>PR_HBActionFV)  // Note Action F dans veille
<>PR_HBActionFV:=0

C_LONGINT:C283(<>PR_FusionMem)  // Memo fusion
<>PR_FusionMem:=0

C_LONGINT:C283(<>PR_Messagerie; <>PR_Messagerie2)  // Messagerie
<>PR_Messagerie:=0
<>PR_Messagerie2:=0

C_LONGINT:C283(<>PR_MessagerieSté; <>PR_Messagerie115)  // Messagerie
<>PR_MessagerieSté:=0
<>PR_Messagerie115:=0

C_LONGINT:C283(<>PR_Export0312770)  // Export
<>PR_Export0312770:=0

C_LONGINT:C283(<>PR_Export0312771)  // Export
<>PR_Export0312771:=0

C_LONGINT:C283(<>PR_Export0312772)  // Export
<>PR_Export0312772:=0

C_LONGINT:C283(<>PR_Export0312773)  // Export
<>PR_Export0312773:=0

C_LONGINT:C283(<>PR_CoorD)  // Coordinateur par défaut
<>PR_CoorD:=0

C_LONGINT:C283(<>PR_AsileD)  // Asile par défaut
<>PR_AsileD:=0

C_LONGINT:C283(<>PR_SigltD)  // Signalements liés aux touches F1 F2 
<>PR_SigltD:=0

C_LONGINT:C283(<>PR_GpeNb)  // Groupes nombre de membres 
<>PR_GpeNb:=0

C_LONGINT:C283(<>PR_DupChamp)  // Champ à dupliquer
<>PR_DupChamp:=0

C_LONGINT:C283(<>PR_CentreEXC)  // Gestion des centres
<>PR_CentreEXC:=0

C_LONGINT:C283(<>PR_AutreSolD)  // Autres solutions par défaut
<>PR_AutreSolD:=0

C_LONGINT:C283(<>PR_Prolongation)  // Prolongation des hébergements
<>PR_Prolongation:=0

C_LONGINT:C283(<>PR_ProlongationID)  // Prolongation : Paramètres
<>PR_ProlongationID:=0

C_LONGINT:C283(<>PR_HébergementExc)  // Excusé : Annulation
<>PR_HébergementExc:=0

C_LONGINT:C283(<>PR_HébergementRemp)  // Excusé : Remplaçant
<>PR_HébergementRemp:=0

C_LONGINT:C283(<>PR_HébergementDéc)  // Aide décisionnelle
<>PR_HébergementDéc:=0

C_LONGINT:C283(<>PR_JN)  // Paramètres disponibilité J ou N
<>PR_JN:=0

C_LONGINT:C283(<>PR_MessagerieVSM)
<>PR_MessagerieVSM:=0

C_LONGINT:C283(<>PR_FusionNotes)
<>PR_FusionNotes:=0

C_LONGINT:C283(<>PR_FusionEtCv)
<>PR_FusionEtCv:=0

C_LONGINT:C283(<>PR_TransFax)
<>PR_TransFax:=0

C_LONGINT:C283(<>PR_AppelBAL)
<>PR_AppelBAL:=0

C_LONGINT:C283(<>PR_AppelLive)
<>PR_AppelLive:=0

C_LONGINT:C283(<>PR_LienGPS)
<>PR_LienGPS:=0

C_LONGINT:C283(<>PR_MaxFiche)
<>PR_MaxFiche:=0

C_LONGINT:C283(<>PR_ConsoParam)  // Consolidation des Fiches en provenance des CHRS et importées dans le 115
<>PR_ConsoParam:=0

C_LONGINT:C283(<>PR_Conso115)  // Consolidation des Fiches en provenance des CHRS et importées dans le 115
<>PR_Conso115:=0

C_LONGINT:C283(<>PR_Conso115Voir)  // Voir des Fiches en provenance des CHRS et importées dans le 115
<>PR_Conso115Voir:=0

C_LONGINT:C283(<>PR_ConsoServeur)  // Consolidation automatique ProcessServeur
<>PR_ConsoServeur:=0

C_LONGINT:C283(<>PR_ConsoPoste)  // Consolidation automatique ProcessPoste
<>PR_ConsoPoste:=0

C_LONGINT:C283(<>PR_ConsoLocal)  // Consolidation automatique Local
<>PR_ConsoLocal:=0

C_LONGINT:C283(<>PR_ConsoClient)  // Consolidation Client
<>PR_ConsoClient:=0

C_LONGINT:C283(<>PR_ConsoClientA)  // Consolidation Client
<>PR_ConsoClientA:=0

C_LONGINT:C283(<>PR_ConsoListe)
<>PR_ConsoListe:=0

//2/11/2010
C_LONGINT:C283(<>PR_ConsoRParam)  // Consolidation Régionale Paramètres
<>PR_ConsoRParam:=0

C_LONGINT:C283(<>PR_ConsoRServeur)  // Consolidation Régionale automatique ProcessServeur
<>PR_ConsoRServeur:=0

C_LONGINT:C283(<>PR_ConsoRPoste)  // Consolidation Régionale automatique ProcessPoste
<>PR_ConsoRPoste:=0

C_LONGINT:C283(<>PR_ConsoRGClient; <>PR_ConsoRGClientA)  // Consolidation Régionale Client
<>PR_ConsoRGClient:=0
<>PR_ConsoRGClientA:=0

C_LONGINT:C283(<>PR_Occupation)  // Tableau de bord d'occupation
<>PR_Occupation:=0

C_LONGINT:C283(<>PR_TransReport)
<>PR_TransReport:=0

C_LONGINT:C283(<>PR_Pointage)  // Parametre de prestation pointage
<>PR_Pointage:=0

C_LONGINT:C283(<>PR_ItemGrouper)  // Regroupement d'items
<>PR_ItemGrouper:=0

C_LONGINT:C283(<>PR_ItemGrouper)  // Regroupement d'items
<>PR_ItemGrouper:=0

C_LONGINT:C283(<>PR_Présentation)  // Regroupement d'items
<>PR_Présentation:=0

C_LONGINT:C283(<>PR_DesStats)  // Regroupement d'items
<>PR_DesStats:=0

C_LONGINT:C283(<>PR_Website)
<>PR_Website:=0

C_LONGINT:C283(<>PR_Bottin)
<>PR_Bottin:=0

C_LONGINT:C283(<>PR_Correction)
<>PR_Correction:=0

C_LONGINT:C283(<>PR_Stat_TroisEnfants)
<>PR_Stat_TroisEnfants:=0

C_LONGINT:C283(<>PR_Stat_TroisFoisRien)
<>PR_Stat_TroisFoisRien:=0

C_LONGINT:C283(<>PR_Stat_Typologie)
<>PR_Stat_Typologie:=0

C_LONGINT:C283(<>PR_Stat_Tranche)
<>PR_Stat_Tranche:=0

C_LONGINT:C283(<>PR_Stat_TrancheContinue)  // 28/06/2010
<>PR_Stat_TrancheContinue:=0

C_LONGINT:C283(<>PR_Stat_Flux)  // 21/04/2011
<>PR_Stat_Flux:=0

C_LONGINT:C283(<>PR_Sortants)
<>PR_Sortants:=0

C_LONGINT:C283(<>PR_ParamMail)
<>PR_ParamMail:=0

C_LONGINT:C283(<>PR_SomOrient1)
<>PR_SomOrient1:=0

C_LONGINT:C283(<>PR_SIAO)
<>PR_SIAO:=0

C_LONGINT:C283(<>PR_SIAOListe)
<>PR_SIAOListe:=0

C_LONGINT:C283(<>PR_SIAOFiche)
<>PR_SIAOFiche:=0

C_LONGINT:C283(<>PR_CleUnique_ID)
<>PR_CleUnique_ID:=0

C_LONGINT:C283(<>PR_OccupationWeek)  // Occupation hébdomadaire
<>PR_OccupationWeek:=0

C_LONGINT:C283(<>PR_MachineLaver)
<>PR_MachineLaver:=0

C_LONGINT:C283(<>PR_SIAODiv)
<>PR_SIAODiv:=0

C_LONGINT:C283(<>PR_SIAOStats)
<>PR_SIAOStats:=0

C_LONGINT:C283(<>PR_LesLogs)
<>PR_LesLogs:=0

C_LONGINT:C283(<>PR_ConsoSIAO)  // Consolidation SIAO
<>PR_ConsoSIAO:=0

C_LONGINT:C283(<>PR_BDOS)  // Export SIAO
<>PR_BDOS:=0

C_LONGINT:C283(<>PR_HgSiaoD)  // SIAO données dans fiche gébergement par defaut
<>PR_HgSiaoD:=0
C_LONGINT:C283(<>PR_SiaoQuoi)
<>PR_SiaoQuoi:=0

C_LONGINT:C283(<>PR_Stat_Activite)  // 06/02/2012
<>PR_Stat_Activite:=0

C_LONGINT:C283(<>PR_ConsoTransfert; <>PR_ConsoTransfertAuto)  // 16/05/2012
<>PR_ConsoTransfert:=0
<>PR_ConsoTransfertAuto:=0

C_LONGINT:C283(<>PR_Facturation)
<>PR_Facturation:=0

C_LONGINT:C283(<>PR_Dossiers_Encours)
<>PR_Dossiers_Encours:=0

C_LONGINT:C283(<>PR_Dossiers_Encours_Liste)
<>PR_Dossiers_Encours_Liste:=0

C_LONGINT:C283(<>PR_PLA_Recurring_Tasks)
<>PR_PLA_Recurring_Tasks:=0

C_LONGINT:C283(<>PR_GI_Stock)
<>PR_GI_Stock:=0

C_LONGINT:C283(<>PR_Participations)
<>PR_Participations:=0