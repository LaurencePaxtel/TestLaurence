//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutInitTable  
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

var $ii : Integer

MESSAGES OFF:C175

var $itemCentreNom_o : Object
var $plateForme_t : Text
If (Session:C1714.storage.intervenant.Plateforme#Null:C1517)
	$plateForme_t:=Session:C1714.storage.intervenant.Plateforme
Else 
	$plateForme_t:=Storage:C1525.intervenantsDetail.UserPlateforme
End if 

$itemCentreNom_o:=Web_JSON_Get_Centres_List("checkbox"; {titrePopup: "Prestations"; prestation: False:C215; plateforme: $plateForme_t})


$enumeration_o:={}
$enumeration_o.nom:="CentreNom"
$enumeration_o.item:=$itemCentreNom_o.list.extract("value")
$enumeration_o.champNumero:=62
$enumeration_o.champNom:=Field name:C257(Table:C252(->[HeberGement:5]); $enumeration_o.champNumero)
$enumeration_o.libelle:="Hébergement / prestation"
If (Session:C1714.storage#Null:C1517)
	// Gestion du storage de la session web
	Use (Session:C1714.storage.enumeration)
		Session:C1714.storage.enumeration.push(OB Copy:C1225($enumeration_o; ck shared:K85:29; Session:C1714.storage.enumeration))
	End use 
Else 
	
	If (Storage:C1525.enumeration=Null:C1517)
		Use (Storage:C1525)
			Storage:C1525.enumeration:=New shared collection:C1527()
		End use 
	End if 
	
	Use (Storage:C1525.enumeration)
		Storage:C1525.enumeration.push(OB Copy:C1225($enumeration_o; ck shared:K85:29; Storage:C1525.enumeration))
	End use 
End if 

storageEnumerationInit("Genre"; -><>ta_Genre)

//Users
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Vérification : Intervenants...")
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=1)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; <>ta_InUser; [INtervenants:10]IN_RéférenceID:1; <>tl_InUser)
SORT ARRAY:C229(<>ta_InUser; <>tl_InUser; >)

//Coordinateurs
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Vérification : Coordinateurs...")

QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=2)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; <>ta_InCoo)
SORT ARRAY:C229(<>ta_InCoo; >)
storageEnumerationInit("Coordinateur"; -><>ta_InCoo)

//Régulateurs
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Vérification : Régulateurs...")
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=3)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; <>ta_InRég)
SORT ARRAY:C229(<>ta_InRég; >)
storageEnumerationInit("Régulateur"; -><>ta_InRég)

//Permanencier
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Vérification : Permanencier...")
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=4)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; <>ta_InPerm)
SORT ARRAY:C229(<>ta_InPerm; >)
storageEnumerationInit("Permanencier"; -><>ta_InPerm)

//Infirmier
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Vérification : Infirmier...")
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=5)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; <>ta_InInf; [INtervenants:10]IN_RéférenceID:1; <>tl_InInf)
SORT ARRAY:C229(<>ta_InInf; <>tl_InInf; >)

// Médecins
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Vérification : Médecins...")
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=6)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; <>ta_InMéd; [INtervenants:10]IN_RéférenceID:1; <>tl_InMéd)
SORT ARRAY:C229(<>ta_InMéd; <>tl_InMéd; >)

// Médecins Hébergement
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Vérification : Médecins hébergement...")
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=7)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; <>ta_InMédH; [INtervenants:10]IN_RéférenceID:1; <>tl_InMédH)
SORT ARRAY:C229(<>ta_InMédH; <>tl_InMédH; >)

// Assistance sociale
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Vérification : Assistance sociale...")
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=8)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; <>ta_InAsSoc)
SORT ARRAY:C229(<>ta_InAsSoc; >)
storageEnumerationInit("Assistante_sociale"; -><>ta_InAsSoc)

// Opérateurs
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Vérification : Opérateurs...")
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=9)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; <>ta_InOpér; [INtervenants:10]IN_RéférenceID:1; <>tl_InOpér)
SORT ARRAY:C229(<>ta_InOpér; <>tl_InOpér; >)

// Demande de prestation
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Chargement : Demande de prestations...")
QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4="040/1@")
MultiSoc_Filter(->[TAbles:12])
SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; <>ta_DemP; [TAbles:12]TB_TT_Niveau:4; <>ta_DemPCd)
SORT ARRAY:C229(<>ta_DemPCd; <>ta_DemP; >)

// Adresses utiles
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Chargement : Adresses utiles...")
QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4="041/1@")
MultiSoc_Filter(->[TAbles:12])
SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; <>ta_AdUtil; [TAbles:12]TB_TT_Niveau:4; <>ta_AdUtilCd)
SORT ARRAY:C229(<>ta_AdUtilCd; <>ta_AdUtil; >)

// Stuations particulières
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Chargement : Stuations particulières...")
QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4="042/1@")
MultiSoc_Filter(->[TAbles:12])
SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; <>ta_SitPar; [TAbles:12]TB_TT_Niveau:4; <>ta_SitParCd)
SORT ARRAY:C229(<>ta_SitParCd; <>ta_SitPar; >)

// Arrondissements
Début_LoadTables("Code postal"; -><>ta_TBArr)

// Metro
Début_LoadTables("Metro"; -><>ta_TBMetro)

// Gares
Début_LoadTables("Gares"; -><>ta_TBGare)

// Places
Début_LoadTables("Places"; -><>ta_TBPlace)

// Portes
Début_LoadTables("Portes"; -><>ta_TBPorte)

// Maraude
Début_LoadTables("Maraude"; -><>ta_TBMaraud)

// Liens
Début_LoadTables("Liens"; -><>ta_TBLien)

// Lieu de naissance
Début_LoadTables("Lieu de naissance"; -><>ta_TBLieuNé)

// Situation de famille
Début_LoadTables("Situation de famille"; -><>ta_TBSitFam)

// Temps d'errance
Début_LoadTables("Temps d'errance"; -><>ta_TBTpsErr)

// Dernier hébergement
Début_LoadTables("Dernier hébergement"; -><>ta_TBDerHéb)

// Situation professionnelle
Début_LoadTables("Situation professionnelle"; -><>ta_TBSitPro)

// Dernier emploi
Début_LoadTables("Dernier emploi"; -><>ta_TBDerJob)

// Durée du dernier emploi
Début_LoadTables("Durée du dernier emploi"; -><>ta_TBDurJob)

// Niveau d'étude
Début_LoadTables("Niveau d'étude"; -><>ta_TBNivEtu)

// Pièces Identité
Début_LoadTables("Pièces d'identité"; -><>ta_TBPIdté)

// Type Etat Civil
// Début_LoadTables (->◊va_EtCiv_L;->◊va_EtCiv_R;->◊ta_TBEtCiv)
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Chargement : Etat Civil...")

QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4="008/1@")
MultiSoc_Filter(->[TAbles:12])

ORDER BY:C49([TAbles:12]; [TAbles:12]TB_Ordre:8; >)
SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; <>ta_TBEtCiv)

SORT ARRAY:C229(<>ta_TBEtCiv; >)
Web_Genere_Variable_Process(-><>ta_TBEtCiv)
storageEnumerationInit("Etat Civil"; -><>ta_TBEtCiv)

//Nationalité
Début_LoadTables("Nationalité"; -><>ta_TBNatio)

//Signalement
Début_LoadTables("Signalement"; -><>ta_TBSglt)

//Ressources actuelles
Début_LoadTables("Ressources actuelles"; -><>ta_TBResAct)

//Provenance
Début_LoadTables("Provenance"; -><>ta_TBProv)

//Plainte
Début_LoadTables("Plainte"; -><>ta_TBPlain)

//Hospitalisation
Début_LoadTables("Hospitalisation"; -><>ta_TBHospi)

//Traitement en cours
Début_LoadTables("Traitement en cours"; -><>ta_TBTrCour)

////Toxicologie
//Début_LoadTables(<>va_Toxico_L; -><>ta_TBToxico)

////Pneumologie
//Début_LoadTables(<>va_Pneumo_L; -><>ta_TBPneumo)

////Cardiologie
//Début_LoadTables(<>va_Cardio_L; -><>ta_TBCardio)

////Neurologie
//Début_LoadTables(<>va_Neuro_L; -><>ta_TBNeuro)

////Infectologie
//Début_LoadTables(<>va_Infect_L; -><>ta_TBInfect)

////Gastro-Entéro
//Début_LoadTables(<>va_Gastro_L; -><>ta_TBGastro)

////Psychiatrie
//Début_LoadTables(<>va_Psychi_L; -><>ta_TBPsychi)

////Dermatologie
//Début_LoadTables(<>va_Derm_L; -><>ta_TBDerm)

////Traumatologie
//Début_LoadTables(<>va_Trauma_L; -><>ta_TBTrauma)

////Divers
//Début_LoadTables(<>va_Divers_L; -><>ta_TBDivers)

////Traitement administré
//Début_LoadTables(<>va_TrAdm_L; -><>ta_TBTrAdm)

////Traitement de sortie
//Début_LoadTables(<>va_TrSort_L; -><>ta_TBTrSort)

//Orientation 1
Début_LoadTables("Orientation 1"; -><>ta_TBOr1)

//Orientation suite
Début_LoadTables("Orientation 1 suite"; -><>ta_TBOr1suite)

//Autre solution suite
Début_LoadTables("Autre solution suite"; -><>ta_AtSsuite)

//Orientation 2 ou localisation
Début_LoadTables("Orientation 2"; -><>ta_TBOr2)

//Autre solution
Début_LoadTables("Autre solution"; -><>ta_AtS)

////Appels
//Début_LoadTables(<>va_APP_L; -><>ta_Appels)

////Responsables
//Début_LoadTables(<>va_Resp_L; -><>ta_Resp)

////Chef de bord
//Début_LoadTables(<>va_ChB_L; -><>ta_ChB)

////N°EMA
//Début_LoadTables(<>va_EMA_L; -><>ta_EMA)

////Langues
//Début_LoadTables(<>va_Lgs_L; -><>ta_Lgs)

////Orient Social
//Début_LoadTables(<>va_OrSc_L; -><>ta_OrSc)

////Orient Médical
//Début_LoadTables(<>va_OrMd_L; -><>ta_OrMd)

//Dernier lieu d'hébergement
Début_LoadTables("Dernier lieu d'hébergement"; -><>ta_DerLH)

////Compagnie actuelle
//Début_LoadTables(<>va_CpAct_L; -><>ta_CpAct)

//Papiers d'identité
//Début_LoadTables (->◊va_Pidté_L;->◊va_Pidté_R;->◊ta_Pidté)

//2 juillet 2004
////#MR Signalement
//Début_LoadTables(<>va_MRsg_L; -><>ta_MRsg)

////#MR Suivi médical
//Début_LoadTables(<>va_MRsm_L; -><>ta_MRsm)

////#MR Pathologie
//Début_LoadTables(<>va_MRpt_L; -><>ta_MRpt)
////Fin 2 juillet 2004

////MR Couverture sociale
//Début_LoadTables(<>va_MRcs_L; -><>ta_MRcs)

////MR Ressources
//Début_LoadTables(<>va_MRrs_L; -><>ta_MRrs)

////MR Régime
//Début_LoadTables(<>va_MRrg_L; -><>ta_MRrg)

////MR Suivi social
//Début_LoadTables(<>va_MRss_L; -><>ta_MRss)

////MR Motif de refus
//Début_LoadTables(<>va_MRrefu_L; -><>ta_MRrefu)

////MR Sortie de centre
//Début_LoadTables(<>va_MRSctr_L; -><>ta_MRSctr)

////MR Personne majeure protégée
//Début_LoadTables(<>va_MRMpro_L; -><>ta_MRMpro)

////MR Personne chez qui aller
//Début_LoadTables(<>va_MRQui_L; -><>ta_MRQui)

////MR ConnuSSP
//Début_LoadTables(<>va_MRCssp_L; -><>ta_MRCssp)

////MR PremierSSP
//Début_LoadTables(<>va_MRPssp_L; -><>ta_MRPssp)

////MR Prise en charge
//Début_LoadTables(<>va_MRPch_L; -><>ta_MRPch)

////MR Demande
//Début_LoadTables(<>va_MRDem_L; -><>ta_MRDem)

////MR Etat général
//Début_LoadTables(<>va_MReGé_L; -><>ta_MReGé)

////MR Etat cutané
//Début_LoadTables(<>va_MReCu_L; -><>ta_MReCu)

////MR Relation
//Début_LoadTables(<>va_MRrel_L; -><>ta_MRrel)

////MR Quel mode
//Début_LoadTables(<>va_Qmod_L; -><>ta_Qmod)

////MR Quel Motif
//Début_LoadTables(<>va_Qmot_L; -><>ta_Qmot)

////MR Indices
//Début_LoadTables(<>va_Indic_L; -><>ta_Indic)

////MR Dépendances
//Début_LoadTables(<>va_Dépen_L; -><>ta_Dépen)
//TABLEAU VERS LISTE(<>ta_Dépen; "Dsi_Dépendance")

////MR Pathologies
//Début_LoadTables(<>va_Patho_L; -><>ta_Patho)
//TABLEAU VERS LISTE(<>ta_Patho; "Dsi_Patho")

////#MR HopitalLieu
//Début_LoadTables(<>va_HopL_L; -><>ta_HopL)

////#MR Lit infirmier
//Début_LoadTables(<>va_LitInf_L; -><>ta_LitInf)

////#MR Hygiène
//Début_LoadTables(<>va_MRhyg_L; -><>ta_MRhyg)

////#MR Handicap
//Début_LoadTables(<>va_MRhan_L; -><>ta_MRhan)

////#MR Quatier
//Début_LoadTables(<>va_MRqua_L; -><>ta_MRqua)

////#DS Orientation sociale
//Début_LoadTables(<>va_MRorS_L; -><>ta_MRorS)

////#DS Aide
//Début_LoadTables(<>va_MRaid_L; -><>ta_MRaid)

////#DS Prolongation
//Début_LoadTables(<>va_MRPro_L; -><>ta_MRPro)

////#DS PapiersIdentité
//Début_LoadTables(<>va_DSidté_L; -><>ta_DSidté)

////#DS Régime
//Début_LoadTables(<>va_DSrég_L; -><>ta_DSrég)

////#DS Suivi
//Début_LoadTables(<>va_DSsuivi_L; -><>ta_DSsuivi)

////#DS Compagnie
//Début_LoadTables(<>va_DScomp_L; -><>ta_DScomp)

////#DS Couverture sociale
//Début_LoadTables(<>va_DScs_L; -><>ta_DScs)

////DP Etat Psy
//Début_LoadTables(<>va_DPpsy_L; -><>ta_DPpsy)
//TABLEAU VERS LISTE(<>ta_DPpsy; "Dsp_Psychique")

////DP Antécédents
//Début_LoadTables(<>va_DPanté_L; -><>ta_DPanté)
//TABLEAU VERS LISTE(<>ta_DPanté; "Dsp_Anté")

////DP Orientation
//Début_LoadTables(<>va_DPOr_L; -><>ta_DPOr)


////#DM Mode d'entrée
//Début_LoadTables(<>va_DMmEnt_L; -><>ta_DMmEnt)

////#DM Mode de sortie
//Début_LoadTables(<>va_DMmSor_L; -><>ta_DMmSor)

////#DM Traitement administratif
//Début_LoadTables(<>va_DMtAdm_L; -><>ta_DMtAdm)

////#DM Traitement de sortie
//Début_LoadTables(<>va_DMtSor_L; -><>ta_DMtSor)

////#DM Poids
//Début_LoadTables(<>va_DMpds_L; -><>ta_DMpds)

////#DM Taille
//Début_LoadTables(<>va_DMTail_L; -><>ta_DMTail)

////#DM Vision loin gauche
//Début_LoadTables(<>va_DMvlg_L; -><>ta_DMvlg)

////#DM Vision loin droit
//Début_LoadTables(<>va_DMvld_L; -><>ta_DMvld)

////#DM Vision prés gauche
//Début_LoadTables(<>va_DMvpg_L; -><>ta_DMvpg)

////#DM Vision prés droit
//Début_LoadTables(<>va_DMvpd_L; -><>ta_DMvpd)

////#DM Antécédents
//Début_LoadTables(<>va_DManté_L; -><>ta_DManté)

////#DM Ethylisme
//Début_LoadTables(<>va_DMety_L; -><>ta_DMety)

////#DM Ethylisme Quantité
//Début_LoadTables(<>va_DMetyQ_L; -><>ta_DMetyQ)

////#DM Ethylisme Type
//Début_LoadTables(<>va_DMetyT_L; -><>ta_DMetyT)

////#DM Ethylisme Années
//Début_LoadTables(<>va_DMetyA_L; -><>ta_DMetyA)

////#DM TABAC
//Début_LoadTables(<>va_DMTab_L; -><>ta_DMTab)

////#DM TABAC paquets
//Début_LoadTables(<>va_DMTabP_L; -><>ta_DMTabP)

////#DM TABAC années
//Début_LoadTables(<>va_DMTabA_L; -><>ta_DMTabA)

////#DM Motif d'admission
//Début_LoadTables(<>va_DMmad_L; -><>ta_DMmad)

////#DM Examens
//Début_LoadTables(<>va_DMexam_L; -><>ta_DMexam)

////#DM Toxicomanie
//Début_LoadTables(<>va_DMtox_L; -><>ta_DMtox)


//#ACTIONS
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Chargement : ACTIONS...")

QUERY:C277([TypesTables:11]; [TypesTables:11]TT_Libellé:4="ACTIONS")
MultiSoc_Filter(->[TypesTables:11])

If (Records in selection:C76([TypesTables:11])=1)
	$ii:=[TypesTables:11]TT_RéférenceID:1
	
	QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_ID:2=$ii)
	MultiSoc_Filter(->[TAbles:12])
	
	SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; <>ta_ACTIONS)
	SORT ARRAY:C229(<>ta_ACTIONS; >)
	
	// Modified by: Kevin HASSAL (10-04-2019)
	If (Application type:C494#4D Server:K5:6)  //modification 10-04-2019 : condition ajouter pour régler le problème des énumerations en web
		
		If (Size of array:C274(<>ta_ACTIONS)>0)
			$ii:=Size of array:C274(<>ta_ACTIONS)+1
			
			INSERT IN ARRAY:C227(<>ta_ACTIONS; $ii)
			<>ta_ACTIONS{$ii}:="-"
		End if 
		
		$ii:=Size of array:C274(<>ta_ACTIONS)+1
		
		INSERT IN ARRAY:C227(<>ta_ACTIONS; $ii)
		<>ta_ACTIONS{$ii}:="Données "+xliff_Txt_Get_Indexed_String_(30108; 78)
	End if 
	
End if 

//#EXCLUSIONS
Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Chargement : EXCLUSIONS...")

QUERY:C277([TypesTables:11]; [TypesTables:11]TT_Libellé:4="EXCLUSIONS")
MultiSoc_Filter(->[TypesTables:11])

If (Records in selection:C76([TypesTables:11])=1)
	$ii:=[TypesTables:11]TT_RéférenceID:1
	
	QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_ID:2=$ii)
	MultiSoc_Filter(->[TAbles:12])
	
	SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; <>ta_EXCLUS)
	SORT ARRAY:C229(<>ta_EXCLUS; >)
End if 

//#FM Groupe
Début_LoadTables("FM Groupe"; -><>ta_FMGrp)

//#FM Composition famille
Début_LoadTables("FM Composition"; -><>ta_FMComp)

//#FM Nombre de personnes
Début_LoadTables("FM Nb personnes"; -><>ta_FMnbP)

//# FM Nombre de jours
Début_LoadTables("FM Nb jours"; -><>ta_FMnbJ)

//# FM Nombre de chambres
Début_LoadTables("FM Nb chambres"; -><>ta_FMnbC)

//# FM Cas spécifique
Début_LoadTables("FM Cas spécifique"; -><>ta_FMCaS)

//# FM Distribution 1
Début_LoadTables("FM Distri1"; -><>ta_FMDis1)

//# FM Distribution 2
Début_LoadTables("FM Distri2"; -><>ta_FMDis2)

//# FM Distribution 3
Début_LoadTables("FM Distri3"; -><>ta_FMDis3)

//# FM Distribution 4
Début_LoadTables("FM Distri4"; -><>ta_FMDis4)

//# FM Distribution 5
Début_LoadTables("FM Distri5"; -><>ta_FMDis5)

////# Dossier santé : Autonomie
//Début_LoadTables(<>va_DEAuto_L; -><>ta_DEAuto)

////# Dossier santé : Dépendance
//Début_LoadTables(<>va_DEDép_L; -><>ta_DEDép)

////# Dossier santé : Parasitose
//Début_LoadTables(<>va_DEPara_L; -><>ta_DEPara)

////# Dossier santé : Allergie
//Début_LoadTables(<>va_DEAlle_L; -><>ta_DEAlle)

////# Dossier santé : Mode Entrée
//Début_LoadTables(<>va_DEMdEnt_L; -><>ta_DEMdEnt)

////# Dossier santé : Motif Entrée
//Début_LoadTables(<>va_DEMtEnt_L; -><>ta_DEMtEnt)

////# Dossier santé : Objectif Patient
//Début_LoadTables(<>va_DEOPat_L; -><>ta_DEOPat)

////# Dossier santé : Objectif Equipe
//Début_LoadTables(<>va_DEOEquip_L; -><>ta_DEOEquip)

////# Dossier santé : Orientation
//Début_LoadTables(<>va_DEOrient_L; -><>ta_DEOrient)

////# Dossier santé : TabacType
//Début_LoadTables(<>va_DMTabT_L; -><>ta_DMTabT)

////# Dossier santé : Toxicomanie
//Début_LoadTables(<>va_DEToxi_L; -><>ta_DEToxi)

////# Dossier santé : Toxicomanie Qté
//Début_LoadTables(<>va_DEToxiQ_L; -><>ta_DEToxiQ)

////# Dossier santé : Toxicomanie Type
//Début_LoadTables(<>va_DEToxiT_L; -><>ta_DEToxiT)

////# Dossier santé : Toxicomanie Année
//Début_LoadTables(<>va_DEToxiA_L; -><>ta_DEToxiA)

////# Dossier santé : Vision quoi faire
//Début_LoadTables(<>va_DEVisionQF_L; -><>ta_DEVisionQF)

////# Dossier santé : Centre
//Début_LoadTables(<>va_DECtr_L; -><>ta_DECtr)

////# Dossier santé : Traitement habituel DE
//Début_LoadTables(<>va_DETrH_L; -><>ta_DETrH)

////# Dossier santé : Toxicomanie Contenant
//Début_LoadTables(<>va_DEToxiC_L; -><>ta_DEToxiC)

////#Dossier santé : Examen Adresse
//Début_LoadTables(<>va_DEExamAdr_L; -><>ta_DEExamAdr)

////#Dossier santé : Examen Service
//Début_LoadTables(<>va_DEExamSec_L; -><>ta_DEExamSec)

//05/01/2004
//#"Pièces d'identité 2"
Début_LoadTables("Pièces d'identité 2"; -><>ta_TBPIdté2)

//#"Pièces d'identité 3"
Début_LoadTables("Pièces d'identité 3"; -><>ta_TBPIdté3)

//Suivi social
Début_LoadTables("Suivi social"; -><>ta_TBSuiSoc)

//#"Suivi social 2"
Début_LoadTables("Suivi social 2"; -><>ta_TBSuiSoc2)

//#"Suivi social 3"
Début_LoadTables("Suivi social 3"; -><>ta_TBSuiSoc3)

//Couverture sociale
Début_LoadTables("Couverture sociale"; -><>ta_TBCouSoc)

//#"Couverture sociale 2"
Début_LoadTables("Couverture sociale 2"; -><>ta_TBCouSoc2)

//#"Couverture sociale 3"
Début_LoadTables("Couverture sociale 3"; -><>ta_TBCouSoc3)

//Ruptures majeures
Début_LoadTables("Ruptures majeures"; -><>ta_TBRupMaj)

//#"Ruptures majeures 2"
Début_LoadTables("Ruptures majeures 2"; -><>ta_TBRupMaj2)

//#"Ruptures majeures 3"
Début_LoadTables("Ruptures majeures 3"; -><>ta_TBRupMaj3)

//#"Ressources actuelles 2"
Début_LoadTables("Ressources actuelles 2"; -><>ta_TBResAct2)

//#"Ressources actuelles 3"
Début_LoadTables("Ressources actuelles 3"; -><>ta_TBResAct3)

//29/3/2007
//#"Liste d'URL"
Début_LoadTables("Liste d'URL"; -><>ta_URL)

//24/6/2008
//Liste des plateformes pour CHRS
Début_LoadTables("Liste des plateformes"; -><>ta_Plateforme)

//Liste des Attestations
Début_LoadTables("Liste des Attestations"; -><>ta_Attestations)  // #REW20170428-1 ce n'est plus utilisé

////# SIAO_Situation d'accueil
//<>va_SIAO_SiteAccueil_L:="SIAO Situation d'accueil"
//Début_LoadTables(<>va_SIAO_SiteAccueil_L; -><>ta_SIAO_SiteAccueil)

////# SIAO_Rôle
//<>va_SIAO_Role_L:="SIAO Rôle"
//Début_LoadTables(<>va_SIAO_Role_L; -><>ta_SIAO_Role)

////# SIAO_SituationPhysique
//<>va_SIAO_SitPhysique_L:="SIAO SituationPhysique"
//Début_LoadTables(<>va_SIAO_SitPhysique_L; -><>ta_SIAO_SitPhysique)

////# SIAO_Catégorie d'hébergement
//<>va_SIAO_CatHeberge_L:="SIAO Catégorie d'hébergement"
//Début_LoadTables(<>va_SIAO_CatHeberge_L; -><>ta_SIAO_CatHeberge)

////# SIAO_Catégorie de place
//<>va_SIAO_CatPlace_L:="SIAO Catégorie de place"
//Début_LoadTables(<>va_SIAO_CatPlace_L; -><>ta_SIAO_CatPlace)

////# SIAO_Catégorie StructureLogement
//<>va_SIAO_CatStruc_L:="SIAO Catégorie Structure"
//Début_LoadTables(<>va_SIAO_CatStruc_L; -><>ta_SIAO_CatStruc)

////# SIAO_SIAO_Compétent
//<>va_SIAO_Competent_L:="SIAO Compétent"
//Début_LoadTables(<>va_SIAO_Competent_L; -><>ta_SIAO_Competent)

////# SIAO_SIAO_Etat
//<>va_SIAO_Etat_L:="SIAO Etat"
//Début_LoadTables(<>va_SIAO_Etat_L; -><>ta_SIAO_Etat)

////# SIAO_SIAO_Civilité
//<>va_SIAO_Civilite_L:="SIAO Civilité"
//Début_LoadTables(<>va_SIAO_Civilite_L; -><>ta_SIAO_Civilite)

////# SIAO_SIAO_NeLeLieu
//<>va_SIAO_NeLeLieu_L:="SIAO ville"
//Début_LoadTables(<>va_SIAO_NeLeLieu_L; -><>ta_SIAO_NeLeLieu)

////# SIAO_SIAO_NeLePays
//<>va_SIAO_NeLePays_L:="SIAO Pays"
//Début_LoadTables(<>va_SIAO_NeLePays_L; -><>ta_SIAO_NeLePays)

////# SIAO_SIAO_SitFam
//<>va_SIAO_SitFam_L:="SIAO Sit. familiale"
//Début_LoadTables(<>va_SIAO_SitFam_L; -><>ta_SIAO_SitFam)

////# SIAO_SIAO_Parente
//<>va_SIAO_Parente_L:="SIAO Parenté"
//Début_LoadTables(<>va_SIAO_Parente_L; -><>ta_SIAO_Parente)

////# SIAO_SIAO_Nationalite
//<>va_SIAO_Nationalite_L:="SIAO Nationalité"
//Début_LoadTables(<>va_SIAO_Nationalite_L; -><>ta_SIAO_Nationalite)

////# SIAO_SIAO_Papier
//<>va_SIAO_Papier_L:="SIAO Papiers administratifs"
//Début_LoadTables(<>va_SIAO_Papier_L; -><>ta_SIAO_Papier)

////#SIAO_SIAO_Ressource
//<>va_SIAO_Ressource_L:="SIAO Ressources"
//Début_LoadTables(<>va_SIAO_Ressource_L; -><>ta_SIAO_Ressource)

////#SIAO_SIAO_Ressource
//<>va_SIAO_CouvSoc_L:="SIAO Couv. sociale"
//Début_LoadTables(<>va_SIAO_CouvSoc_L; -><>ta_SIAO_CouvSoc)

////#SIAO_SIAO_Locomotion
//<>va_SIAO_Locomotion_L:="SIAO Locomotion"
//Début_LoadTables(<>va_SIAO_Locomotion_L; -><>ta_SIAO_Locomotion)

////# SIAO_SIAO_SitProf
//<>va_SIAO_SitProf_L:="SIAO Sit.Prof"
//Début_LoadTables(<>va_SIAO_SitProf_L; -><>ta_SIAO_SitProf)

////# SIAO_SIAO_Endettement
//<>va_SIAO_Dette_L:="SIAO Endettement"
//Début_LoadTables(<>va_SIAO_Dette_L; -><>ta_SIAO_Dette)

////# SIAO_SIAO_CouSoc
//<>va_SIAO_CouvSoc_L:="SIAO Couv. Sociale"
//Début_LoadTables(<>va_SIAO_CouvSoc_L; -><>ta_SIAO_CouvSoc)

////# SIAO_SIAO_TypePapier
//<>va_SIAO_TypePapier_L:="SIAO TypePapier"
//Début_LoadTables(<>va_SIAO_TypePapier_L; -><>ta_SIAO_TypePapier)

////# SIAO_SIAO_CasSpec
//<>va_SIAO_CasSpec_L:="SIAO Cas Specific"
//Début_LoadTables(<>va_SIAO_CasSpec_L; -><>ta_SIAO_CasSpec)

////# SIAO_SIAO_LogementActuel
//<>va_SIAO_LogActuel_L:="SIAO LogementActuel"
//Début_LoadTables(<>va_SIAO_LogActuel_L; -><>ta_SIAO_LogActuel)

////# SIAO_SIAO_MotifDemande
//<>va_SIAO_MotifDem_L:="SIAO Motif demande"
//Début_LoadTables(<>va_SIAO_MotifDem_L; -><>ta_SIAO_MotifDem)

////# SIAO_SIAO_TitreSejour
//<>va_SIAO_TitreSej_L:="SIAO Titre séjour"
//Début_LoadTables(<>va_SIAO_TitreSej_L; -><>ta_SIAO_TitreSej)

////# SIAO_SIAO_Besoins
//<>va_SIAO_Besoins_L:="SIAO Besoins accomp."
//Début_LoadTables(<>va_SIAO_Besoins_L; -><>ta_SIAO_Besoins)

////# SIAO_SIAO_Type Acc. preconisé
//<>va_SIAO_TypeAcc_L:="SIAO Type accomp."
//Début_LoadTables(<>va_SIAO_TypeAcc_L; -><>ta_SIAO_TypeAcc)

////# SIAO_SIAO_Type Acc. Souhaité
//<>va_SIAO_TypeAccS_L:="SIAO Type accomp. souhaité"
//Début_LoadTables(<>va_SIAO_TypeAccS_L; -><>ta_SIAO_TypeAccS)

////# SIAO_SIAO_LogementAdapté
//<>va_SIAO_LogAdapte_L:="SIAO Logement adapté"
//Début_LoadTables(<>va_SIAO_LogAdapte_L; -><>ta_SIAO_LogAdapte)

////# SIAO_SIAO_Orientation
//<>va_SIAO_Orienter_L:="SIAO Proposition"
//Début_LoadTables(<>va_SIAO_Orienter_L; -><>ta_SIAO_Orienter)

////# SIAO_SIAO_Besoin aide financière
//<>va_SIAO_BesAidF_L:="SIAO B. Aide financière"
//Début_LoadTables(<>va_SIAO_BesAidF_L; -><>ta_SIAO_BesAidF)

////# SIAO_SIAO_AccueilCol
//<>va_SIAO_AccueilCol_L:="SIAO Accueil collectif"
//Début_LoadTables(<>va_SIAO_AccueilCol_L; -><>ta_SIAO_AccueilCol)

////# ◊va_SIAO_SanSitProf_L
//<>va_SIAO_SanSitProf_L:="SIAO Sans sit. Prof."
//Début_LoadTables(<>va_SIAO_SanSitProf_L; -><>ta_SIAO_SanSitProf)

////# SIAO_SIAO_EtatCivil
//<>va_SIAO_EtCiv_L:="SIAO Etat civil"
//Début_LoadTables(<>va_SIAO_EtCiv_L; -><>ta_SIAO_EtCiv)

////# SIAO_SIAO_Credit
//<>va_SIAO_Credit_L:="SIAO crédit"
//Début_LoadTables(<>va_SIAO_Credit_L; -><>ta_SIAO_Credit)

////# HG_DossierSIAO
//<>va_HG_DosSIAO_L:="HG DosSIAO"
//Début_LoadTables(<>va_HG_DosSIAO_L; -><>ta_HG_DosSIAO)

////# HG_TypeDemSIA
//<>va_HG_DosSIAO_L:="HG TDeSIAO"
//Début_LoadTables(<>va_HG_TypDemSIAO_L; -><>ta_HG_TypDemSIAO)

////# HG_TypePresSIA
//<>va_HG_DosSIAO_L:="HG TPeSIAO"
//Début_LoadTables(<>va_HG_TypPresSIAO_L; -><>ta_HG_TypPresSIAO)

////# HG_TypePlaceSIA
//<>va_HG_DosSIAO_L:="HG TPlSIAO"
//Début_LoadTables(<>va_HG_TypPlaceSIAO_L; -><>ta_HG_TypPlaceSIAO)

//# Type document des locations
Début_LoadTables("Locations: types des documents"; -><>ta_TypeDocLocation)

//# Locations : Libellé des charges
Début_LoadTables("Locations: Charges"; -><>ta_GL_LibelleCharges)

// Locations: Sinistres
Début_LoadTables("Locations: Sinistres"; -><>ta_GL_LibelleSinistres)

//# Modes de règlements
Début_LoadTables("Modes de règlements"; -><>ta_GL_ModesReglements)

//# Banques
Début_LoadTables("Banques"; -><>ta_GL_Banques)

//# Locations : Type du bien
Début_LoadTables("Locations: Type du bien"; -><>ta_GL_TypeBien)

//# TVA
Début_LoadTables("TVA"; -><>ta_TVA)

//# Dossiers en cours : Noms
Début_LoadTables("Dossiers en cours"; -><>ta_DossiersEncours)

//# Dossiers en cours : Jours de rappel
Début_LoadTables("Nbre des jours de rappel"; -><>ta_DOS_Jours_Rappel)

//# Planning : Types RDV
Début_LoadTables("Planning: Types RDV"; -><>ta_RDV_Types)

//# Planning : Presence
Début_LoadTables("Planning: Présence"; -><>ta_RDV_Presence)

//# Planning : Rappel
Début_LoadTables("Planning: Rappel"; -><>ta_RDV_Rappel)

//# Gestion immobilière : Types des équipements
Début_LoadTables("GI: Types des équipements"; -><>ta_GI_Types_Equipements)

//# Gestion immobilière : Garantie
Début_LoadTables("GI: Garantie"; -><>ta_GI_Garantie)

//# Gestion immobilière : Quantité initiale
Début_LoadTables("GI: Quantité initiale"; -><>ta_GI_Quantite_initiale)

//# Gestion immobilière : Types interventions
Début_LoadTables("GI: Types interventions"; -><>ta_GI_Types_Interventions)

//# Gestion immobilière : Prise en charge externe
Début_LoadTables("GI: Prise en charge externe"; -><>ta_GI_PEE)

// Gestion des participations : Années
Début_LoadTables("GP: Années"; -><>ta_GP_Annees)

// Emplacement
Début_LoadTables("Emplacement"; -><>ta_Emplacement)

// Modifié par : LPC (31/01/2024)
// Categorie des centres
Début_LoadTables("Centre: Categorie"; -><>ta_LC_Categorie)