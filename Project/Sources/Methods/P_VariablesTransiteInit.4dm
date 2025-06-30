//%attributes = {"preemptive":"capable"}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_VariablesTransiteInit
//{
//{          Lundi 29 mars 2004 à 11:07:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  //Quoi

Case of 
	: ($1=0)
		//DECLARATION DES VARIABLES
		//V_IDT_Déc
		//Divers à vérifier
		C_TEXT:C284(va_IDT_Clé)  //Clé de l'hébergé
		C_TEXT:C284(va_IDT_Titr)  //Titre pour # fenêtres
		C_TEXT:C284(va_IDT_LienFam)  //[HéberGement]HG_FamClé
		
		C_LONGINT:C283(ve_IDT_PCAge)  //Age saisie pour calculer la date de naissance
		C_LONGINT:C283(vl_IDT_Stat)  //Valeu du Champ statut
		C_LONGINT:C283(r_IDT_Statu)  //Check box pour le champ Statut
		C_LONGINT:C283(rIDTFL1; rIDTFL2)  //Check box pour le champ YaFicheLiée
		C_LONGINT:C283(sIDTFL1; sIDTFL2)  //Check box pour le champ 1ère FicheLiée
		C_TEXT:C284(va_IDT_TyFL)  //[HéberGement]HG_TypFicheLiée
		
		C_LONGINT:C283(vl_IDT_Old)
		
		//Report
		C_BOOLEAN:C305(vb_IDT_JN)
		C_TEXT:C284(va_IDT_JN)
		
		//Report
		C_TEXT:C284(va_IDT_Util)
		C_TEXT:C284(va_IDT_Coo)
		C_TEXT:C284(va_IDT_Rég)
		C_TEXT:C284(va_IDT_Per)
		C_TEXT:C284(va_IDT_Mar)
		
		// Modified by: Kevin HASSAL (15/02/2020)
		C_TEXT:C284(va_IDT_Mar_2_2; va_IDT_Mar_3_1)
		C_DATE:C307(va_IDT_Mar_1_2va_IDT_Mar_3_2)
		//Report
		C_TEXT:C284(va_IDT_AsSo)
		
		//Report
		C_TEXT:C284(va_IDT_SGls)
		C_TEXT:C284(va_IDT_SG)
		C_TEXT:C284(va_IDT_SGct)
		
		//à supprimer C_ALPHA(30;va_IDT_CdP)
		//et remplacer par C_ALPHA(30;va_IDT_CP)
		C_TEXT:C284(va_IDT_Gare)
		C_TEXT:C284(va_IDT_Metr)
		//à supprimer C_ALPHA(80;va_IDT_Plac)
		//et remplacer par C_ALPHA(30;va_IDT_Emp)
		
		//10/1/2008
		C_TEXT:C284(va_IDT_Plateforme)
		//FIN 10/1/2008
		
		//4/11/2008
		C_TEXT:C284(va_IDT_PlateformeCentre)
		C_BOOLEAN:C305(vb_IDT_TransDDASS)
		C_LONGINT:C283(vl_IDT_TransRéf)
		C_TEXT:C284(va_IDT_TransFiche)
		C_LONGINT:C283(vl_IDT_Trans_HBID)
		C_LONGINT:C283(vl_IDT_Trans_CLD)
		C_TEXT:C284(va_IDT_TransCentre)
		C_TEXT:C284(va_IDT_TransFamClé)
		C_TEXT:C284(va_IDT_TransPlateforme)
		//FIN 4/11/2008
		
		//Report
		C_TEXT:C284(va_IDT_CP)
		C_TEXT:C284(va_IDT_Emp)
		
		
		C_TEXT:C284(va_IDT_Typ1)
		C_TEXT:C284(va_IDT_TypTrans)
		C_TEXT:C284(va_IDT_Typ2)
		
		C_TEXT:C284(va_IDT_Nom)
		C_TEXT:C284(va_IDT_Pré)
		C_DATE:C307(vd_IDT_NéLe)
		
		
		C_LONGINT:C283(ve_IDT_Age)
		C_TEXT:C284(va_IDT_Nat)  //Nationalité
		C_LONGINT:C283(vl_IDT_Lier)  //Lien de parenté
		C_LONGINT:C283(ve_IDT_NbFL)  //Nombre de fiches liées
		
		//V_IDT_Déc
		C_LONGINT:C283(x_IDTG_1)  //Féminin
		C_LONGINT:C283(x_IDTG_2)  //Masculin ou l'inverse
		
		C_TEXT:C284(va_IDT_Lien)
		C_TEXT:C284(va_IDT_SitF)
		C_TEXT:C284(va_IDT_DerH)
		
		C_TEXT:C284(va_IDT_TpEr)
		C_TEXT:C284(va_IDT_SitP)
		C_TEXT:C284(va_IDT_DerE)
		C_TEXT:C284(va_IDT_DurE)
		C_TEXT:C284(va_IDT_NivE)
		
		C_TEXT:C284(va_IDT_Pt1)
		C_TEXT:C284(va_IDT_Pt2)
		C_TEXT:C284(va_IDT_Pt3)
		
		C_TEXT:C284(va_IDT_Sv1)
		C_TEXT:C284(va_IDT_Sv2)
		C_TEXT:C284(va_IDT_Sv3)
		
		C_TEXT:C284(va_IDT_Cv1)
		C_TEXT:C284(va_IDT_Cv2)
		C_TEXT:C284(va_IDT_Cv3)
		
		C_TEXT:C284(va_IDT_RM1)
		C_TEXT:C284(va_IDT_RM2)
		C_TEXT:C284(va_IDT_RM3)
		C_TEXT:C284(va_IDT_RM11)
		C_TEXT:C284(va_IDT_RM21)
		C_TEXT:C284(va_IDT_RM31)
		
		C_TEXT:C284(va_IDT_RA1)
		C_TEXT:C284(va_IDT_RA2)
		C_TEXT:C284(va_IDT_RA3)
		C_TEXT:C284(va_IDT_RA11)
		C_TEXT:C284(va_IDT_RA21)
		C_TEXT:C284(va_IDT_RA31)
		C_LONGINT:C283(ve_IDT_St)
		
		//Report
		C_TEXT:C284(va_IDT_Or1)
		C_TEXT:C284(va_IDT_Or1Suite)
		C_TEXT:C284(va_IDT_Or2)
		C_TEXT:C284(va_IDT_AutS)
		C_TEXT:C284(va_IDT_AutS2)
		
		//Report
		C_LONGINT:C283(ve_IDT_LCID)  //Centre : ID
		C_TEXT:C284(va_IDT_LCC)  //Centre : Nom
		C_TEXT:C284(va_IDT_LCA)  //Centre : Arrondissement
		
		
		C_LONGINT:C283(ve_IDT_NoN)  //Réservation : Nuit en cours
		C_LONGINT:C283(ve_IDT_TotN)  //Réservation : Nuit TOTAL
		C_TEXT:C284(va_IDT_TypeReport)  // `Réservation : Type de report
		
		C_LONGINT:C283(ve_IDT_ProlongTotN)  //Réservation pour la prolongation : Nuit TOTAL
		
		//11/05/2004
		C_BOOLEAN:C305(vb_IDT_ER)
		C_DATE:C307(vd_IDT_ERDtD)
		C_DATE:C307(vd_IDT_ERDtF)
		C_LONGINT:C283(ve_IDT_ERNoN)
		C_LONGINT:C283(ve_IDT_ERTotN)
		C_BOOLEAN:C305(vb_IDT_Remp)
		C_LONGINT:C283(vl_IDT_Remp)
		C_TEXT:C284(va_IDT_Remp)
		
		C_TEXT:C284(va_IDT_CtrJN)
		vb_IDT_ER:=False:C215
		vd_IDT_ERDtD:=!00-00-00!
		vd_IDT_ERDtF:=!00-00-00!
		ve_IDT_ERNoN:=0
		ve_IDT_ERTotN:=0
		vb_IDT_Remp:=False:C215
		vl_IDT_Remp:=0
		va_IDT_Remp:=""
		va_IDT_CtrJN:=""
		//fin 11/05/2004
		
		C_TEXT:C284(va_IDT_FGrp)
		C_BOOLEAN:C305(vb_IDT_FRes)
		C_TEXT:C284(va_IDT_Ffam)
		C_TEXT:C284(va_IDT_FCom)
		C_LONGINT:C283(ve_IDT_FPer)
		
		C_LONGINT:C283(ve_IDT_FJou)
		C_LONGINT:C283(ve_IDT_FChb)
		C_REAL:C285(vr_IDT_FPxJ)
		C_REAL:C285(vr_IDT_FPxT)
		
		C_TEXT:C284(va_IDT_FDi1)
		C_TEXT:C284(va_IDT_FDi2)
		C_TEXT:C284(va_IDT_FDi3)
		C_TEXT:C284(va_IDT_FDi4)
		C_TEXT:C284(va_IDT_FDi5)
		C_TEXT:C284(va_IDT_FCSp)
		C_TEXT:C284(va_IDT_Fvar)
		
		//26/01/2004
		C_REAL:C285(vr_IDT_FDi1)
		C_REAL:C285(vr_IDT_FDi2)
		C_REAL:C285(vr_IDT_FDi3)
		C_REAL:C285(vr_IDT_FDi4)
		C_REAL:C285(vr_IDT_FDi5)
		//fin 26/01/2004
		
		
		//25/03/2004 Pour la saisie par groupe
		C_TEXT:C284(va_HGGP_CléChéf)
		C_TEXT:C284(va_HGGP_Signalement)
		C_TEXT:C284(va_HGGP_SignalCentre)
		C_TEXT:C284(va_HGGP_Permanencier)
		C_BOOLEAN:C305(vb_HGGP_Réservation)
		C_LONGINT:C283(vl_HGGP_NuitCours)
		C_LONGINT:C283(vl_HGGP_NuitTOTAL)
		C_LONGINT:C283(vl_HGGP_NuitReste)
		C_TEXT:C284(va_HGGP_Orientation1)
		C_TEXT:C284(va_HGGP_Orientation2)
		C_TEXT:C284(va_HGGP_Emplacement)
		
		C_TEXT:C284(va_HGGP_CentreNom)
		C_TEXT:C284(va_HGGP_CentreARR)
		C_LONGINT:C283(vl_HGGP_LC_ID)
		C_BOOLEAN:C305(vb_HGGP_Médicalisé)
		
		C_TEXT:C284(va_HGGP_FamGroupe)
		C_BOOLEAN:C305(vb_HGGP_FamC)
		C_TEXT:C284(va_HGGP_FamClé)
		C_TEXT:C284(va_HGGP_FamCompoVar)
		C_TEXT:C284(va_HGGP_FamCompo)
		C_LONGINT:C283(vl_HGGP_FamNbPers)
		
		C_LONGINT:C283(vl_HGGP_FamNbP)
		C_LONGINT:C283(vl_HGGP_FamNbJ)
		C_LONGINT:C283(vl_HGGP_FamNbC)
		C_REAL:C285(vr_HGGP_FamPrixJ)
		C_REAL:C285(vr_HGGP_FamPrixT)
		
		C_TEXT:C284(va_HGGP_FamSpéc)
		//Fin : 25/03/2004 Pour la saisie par groupe    
		C_TIME:C306(vh_HGGP_AttHeure; vh_HGGP_TransHeure; vh_HGGP_PrChHeure; vh_HGGP_ClôHeure)
		C_BOOLEAN:C305(vb_HGGP_Att; vb_HGGP_Trans; vb_HGGP_PrCh; vb_HGGP_Clô)
		C_TEXT:C284(va_HGGP_AutreSol1)
		C_TEXT:C284(va_HGGP_AutreSol2)
		//Fin : 15/06/2004 Pour la saisie par groupe    
		
		//??
		C_LONGINT:C283(ve_IDT_ProlongTotN)
		C_TEXT:C284(va_IDT_ProlongGroupe)
		C_LONGINT:C283(vl_IDT_ProlongLC)
		C_TEXT:C284(va_IDT_ProlongCompo)
		C_TEXT:C284(va_IDT_ProlongCompoV)
		C_LONGINT:C283(ve_IDT_ProlongNbP)
		C_LONGINT:C283(ve_IDT_ProlongNbJ)
		C_LONGINT:C283(ve_IDT_ProlongNbC)
		C_REAL:C285(vr_IDT_ProlongPxJ)
		C_REAL:C285(vr_IDT_ProlongPxT)
		
		ve_IDT_ProlongTotN:=0
		va_IDT_ProlongGroupe:=""
		vl_IDT_ProlongLC:=0
		
		//FLAG du SIAO2/12/2011
		C_BOOLEAN:C305(vb_IDT_Falg_Daho)
		C_BOOLEAN:C305(vb_IDT_Falg_Capacite)
		C_BOOLEAN:C305(vb_IDT_Falg_Violence)
		C_BOOLEAN:C305(vb_IDT_Falg_Logement)
		C_BOOLEAN:C305(vb_IDT_Falg_Orientation)
		C_BOOLEAN:C305(vb_IDT_Falg_Souhait)
		C_BOOLEAN:C305(vb_IDT_Falg_RefusStrut)
		C_BOOLEAN:C305(vb_IDT_Falg_RefusPers)
		
		//Dossier SIAO du  13/12/2011
		C_TEXT:C284(va_IDT_DossierSIAO)
		
		//Types SIAO du  23/12/2011
		C_TEXT:C284(va_IDT_TypeDemande; va_IDT_TypePrescripteur; va_IDT_TypePlace)
	: ($1=1)
		va_IDT_Clé:=""
		va_IDT_Titr:=""
		vl_IDT_Lier:=0
		
		vl_IDT_Old:=0
		va_IDT_LienFam:=""
		
		//va_IDT_Typ1:=""
		va_IDT_Typ2:=""
		//va_IDT_Nom:=""
		//va_IDT_Pré:=""
		//ve_IDT_Age:=0
		ve_IDT_PCAge:=0
		//vd_IDT_NéLe:=!00/00/00!
		va_IDT_Nat:=""
		
		//x_IDTG_1:=1
		//x_IDTG_2:=0
		
		va_IDT_Lien:=""
		va_IDT_SitF:=""
		va_IDT_DerH:=""
		
		va_IDT_TpEr:=""
		va_IDT_SitP:=""
		va_IDT_DerE:=""
		va_IDT_DurE:=""
		va_IDT_NivE:=""
		
		va_IDT_Pt1:=""
		va_IDT_Pt2:=""
		va_IDT_Pt3:=""
		
		va_IDT_Sv1:=""
		va_IDT_Sv2:=""
		va_IDT_Sv3:=""
		
		va_IDT_Cv1:=""
		va_IDT_Cv2:=""
		va_IDT_Cv3:=""
		
		va_IDT_RM1:=""
		va_IDT_RM2:=""
		va_IDT_RM3:=""
		va_IDT_RM11:=""
		va_IDT_RM21:=""
		va_IDT_RM31:=""
		
		va_IDT_RA1:=""
		va_IDT_RA2:=""
		va_IDT_RA3:=""
		va_IDT_RA11:=""
		va_IDT_RA21:=""
		va_IDT_RA31:=""
		ve_IDT_St:=0
		
		vl_IDT_Stat:=0
		r_IDT_Statu:=0
		rIDTFL1:=0
		rIDTFL2:=0
		ve_IDT_NbFL:=0
		sIDTFL1:=0
		sIDTFL2:=0
		va_IDT_TyFL:=""
		
		va_IDT_FGrp:=""
		vb_IDT_FRes:=False:C215
		va_IDT_Ffam:=""
		va_IDT_FCom:=""
		ve_IDT_FPer:=0
		va_IDT_FDi1:=""
		va_IDT_FDi2:=""
		va_IDT_FDi3:=""
		va_IDT_FDi4:=""
		va_IDT_FDi5:=""
		va_IDT_FCSp:=""
		va_IDT_Fvar:=""
		
		//26/01/2004
		vr_IDT_FDi1:=0
		vr_IDT_FDi2:=0
		vr_IDT_FDi3:=0
		vr_IDT_FDi4:=0
		vr_IDT_FDi5:=0
		//fin 26/01/2004
		
		ve_IDT_FJou:=0
		ve_IDT_FChb:=0
		vr_IDT_FPxJ:=0
		vr_IDT_FPxT:=0
		
		va_IDT_CP:=""
		va_IDT_Gare:=""
		va_IDT_Metr:=""
		va_IDT_Emp:=""
		
		va_IDT_AsSo:=""
		
		va_IDT_CtrJN:=""
		
		//10/1/2008
		va_IDT_Plateforme:=""
		//FIN 10/1/2008
		
		// Modified by: Kevin HASSAL (07/08/2019)
		// Ajout du HG_Signalement et Maraude_1_1 (champs à dupliquer)
		va_HG_Signalement:=""
		va_HG_Maraude1_1:=""
	: ($1=3)
		vl_IDT_Old:=-1
		
		va_IDT_Clé:=[HeBerge:4]HB_Clé:2
		
		va_IDT_Typ2:=""
		va_IDT_Nom:=[HeBerge:4]HB_Nom:3
		va_IDT_Pré:=[HeBerge:4]HB_Prénom:4
		
		vd_IDT_NéLe:=[HeBerge:4]HB_DateNéLe:5
		ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
		va_IDT_Nat:=""
		
		x_IDTG_1:=Num:C11([HeBerge:4]HG_Genre:39=False:C215)
		x_IDTG_2:=Num:C11([HeBerge:4]HG_Genre:39=True:C214)
		
		va_IDT_Lien:=""
		va_IDT_SitF:=""
		va_IDT_DerH:=""
		
		va_IDT_TpEr:=""
		va_IDT_SitP:=""
		va_IDT_DerE:=""
		va_IDT_DurE:=""
		va_IDT_NivE:=""
		
		va_IDT_Pt1:=""
		va_IDT_Pt2:=""
		va_IDT_Pt3:=""
		
		va_IDT_Sv1:=""
		va_IDT_Sv2:=""
		va_IDT_Sv3:=""
		
		va_IDT_Cv1:=""
		va_IDT_Cv2:=""
		va_IDT_Cv3:=""
		
		va_IDT_RM1:=""
		va_IDT_RM2:=""
		va_IDT_RM3:=""
		va_IDT_RM11:=""
		va_IDT_RM21:=""
		va_IDT_RM31:=""
		
		va_IDT_RA1:=""
		va_IDT_RA2:=""
		va_IDT_RA3:=""
		va_IDT_RA11:=""
		va_IDT_RA21:=""
		va_IDT_RA31:=""
		ve_IDT_St:=0
		
		va_IDT_FGrp:=Storage:C1525.dispositif.HG_ASFamGroupe
		vb_IDT_FRes:=False:C215
		va_IDT_Ffam:=""
		va_IDT_FCom:=""
		ve_IDT_FPer:=0
		va_IDT_FDi1:=""
		va_IDT_FDi2:=""
		va_IDT_FDi3:=""
		va_IDT_FDi4:=""
		va_IDT_FDi5:=""
		va_IDT_FCSp:=""
		va_IDT_Fvar:=""
		
		//26/01/2004
		vr_IDT_FDi1:=0
		vr_IDT_FDi2:=0
		vr_IDT_FDi3:=0
		vr_IDT_FDi4:=0
		vr_IDT_FDi5:=0
		//fin 26/01/2004
		
		va_IDT_CP:=""
		va_IDT_Gare:=""
		va_IDT_Metr:=""
		va_IDT_Emp:=""
		
		va_IDT_AsSo:=""
		
		//10/1/2008
		va_IDT_Plateforme:=""
		//FIN 10/1/2008
		
		//FLAG du SIAO2/12/2011
		vb_IDT_Falg_Daho:=False:C215
		vb_IDT_Falg_Capacite:=False:C215
		vb_IDT_Falg_Violence:=False:C215
		vb_IDT_Falg_Logement:=False:C215
		vb_IDT_Falg_Orientation:=False:C215
		vb_IDT_Falg_Souhait:=False:C215
		vb_IDT_Falg_RefusStrut:=False:C215
		vb_IDT_Falg_RefusPers:=False:C215
		
		//Dossier SIAO du  13/12/2011
		va_IDT_DossierSIAO:=""
		//Type SIAO du  23/12/2011
		va_IDT_TypeDemande:=""
		va_IDT_TypePrescripteur:=""
		va_IDT_TypePlace:=""
	: ($1=5)
		//INITIALISATIONS partie Saisie par groupe
		va_HGGP_Signalement:=""
		va_HGGP_SignalCentre:=""
		va_HGGP_Permanencier:=""
		vb_HGGP_Réservation:=False:C215
		vl_HGGP_NuitCours:=0
		vl_HGGP_NuitTOTAL:=0
		vl_HGGP_NuitReste:=0
		
		va_HGGP_Orientation1:=""
		va_HGGP_Orientation2:=""
		
		va_HGGP_CentreNom:=""
		va_HGGP_CentreARR:=""
		vl_HGGP_LC_ID:=0
		vb_HGGP_Médicalisé:=False:C215
		
		va_HGGP_FamGroupe:=""
		vb_HGGP_FamC:=False:C215
		va_HGGP_FamClé:=""
		va_HGGP_FamCompoVar:=""
		va_HGGP_FamCompo:=""
		vl_HGGP_FamNbPers:=0
		
		vl_HGGP_FamNbP:=0
		vl_HGGP_FamNbJ:=0
		vl_HGGP_FamNbC:=0
		vr_HGGP_FamPrixJ:=0
		vr_HGGP_FamPrixT:=0
		
		va_HGGP_FamSpéc:=""
		
		vh_HGGP_AttHeure:=?00:00:00?
		vh_HGGP_TransHeure:=?00:00:00?
		vh_HGGP_PrChHeure:=?00:00:00?
		vh_HGGP_ClôHeure:=?00:00:00?
		
		vb_HGGP_Att:=False:C215
		vb_HGGP_Trans:=False:C215
		vb_HGGP_PrCh:=False:C215
		vb_HGGP_Clô:=False:C215
		
		va_HGGP_AutreSol1:=""
		va_HGGP_AutreSol2:=""
End case 