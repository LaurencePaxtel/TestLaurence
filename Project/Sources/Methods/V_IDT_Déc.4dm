//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : V_IDT_Déc
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

Case of 
	: ($1=0)
		C_TEXT:C284(va_IDT_Clé)
		C_TEXT:C284(va_IDT_Titr)
		C_LONGINT:C283(vl_IDT_Lier)
		C_LONGINT:C283(vl_IDT_Old)
		
		
		C_TEXT:C284(va_IDT_LienFam)
		C_TEXT:C284(va_IDT_Typ1)
		C_TEXT:C284(va_IDT_TypTrans)
		C_TEXT:C284(va_IDT_Typ2)
		C_TEXT:C284(va_IDT_Nom)
		C_TEXT:C284(va_IDT_Pré)
		C_LONGINT:C283(ve_IDT_Age)
		C_LONGINT:C283(ve_IDT_PCAge)
		C_DATE:C307(vd_IDT_NéLe)
		C_TEXT:C284(va_IDT_Nat)
		
		C_LONGINT:C283(x_IDTG_1)
		C_LONGINT:C283(x_IDTG_2)
		
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
		
		
		C_LONGINT:C283(vl_IDT_Stat)
		C_LONGINT:C283(r_IDT_Statu)
		C_LONGINT:C283(rIDTFL1; rIDTFL2)
		C_LONGINT:C283(ve_IDT_NbFL)
		C_LONGINT:C283(sIDTFL1; sIDTFL2)
		C_TEXT:C284(va_IDT_TyFL)
		
		
		C_TEXT:C284(va_IDT_FGrp)
		C_BOOLEAN:C305(vb_IDT_FRes)
		C_TEXT:C284(va_IDT_Ffam)
		C_TEXT:C284(va_IDT_FCom)
		C_LONGINT:C283(ve_IDT_FPer)
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
		
		C_LONGINT:C283(ve_IDT_FJou)
		C_LONGINT:C283(ve_IDT_FChb)
		C_REAL:C285(vr_IDT_FPxJ)
		C_REAL:C285(vr_IDT_FPxT)
		
		
		C_TEXT:C284(va_IDT_CdP)
		C_TEXT:C284(va_IDT_Gare)
		C_TEXT:C284(va_IDT_Metr)
		C_TEXT:C284(va_IDT_Plac)
		
		
		C_TEXT:C284(va_IDT_AssSoc)
		
		
		//25/03/2004 Pour la saisie par groupe
		
		C_TEXT:C284(va_HGGP_CléChéf)
		C_TEXT:C284(va_HGGP_Signalement)
		C_TEXT:C284(va_HGGP_SignalCentre)
		
		C_TEXT:C284(va_HGGP_Emplacement)
		C_TEXT:C284(va_HGGP_Permanencier)
		C_BOOLEAN:C305(vb_HGGP_Réservation)
		C_LONGINT:C283(vl_HGGP_NuitCours)
		C_LONGINT:C283(vl_HGGP_NuitTOTAL)
		C_LONGINT:C283(vl_HGGP_NuitReste)
		C_TEXT:C284(va_HGGP_Orientation1)
		C_TEXT:C284(va_HGGP_Orientation2)
		
		C_TEXT:C284(va_HGGP_CentreNom)
		C_TEXT:C284(va_HGGP_CentreARR)
		C_TEXT:C284(va_HGGP_CentrePlateforme)
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
		
		
		va_IDT_CdP:=""
		va_IDT_Gare:=""
		va_IDT_Metr:=""
		va_IDT_Plac:=""
		
		va_IDT_AssSoc:=""
	: ($1=2)
		
		If (7=8)  //????????????????????????
			
			If ([HeberGement:5]HG_LienParenté:26>0)
				
				If (i_Confirmer("Reportez-vous le lien!"))
					vl_IDT_Lier:=[HeberGement:5]HG_LienParenté:26
				End if 
				
			End if 
			
		End if 
		
		vl_IDT_Old:=[HeberGement:5]HG_ReferenceID:1
		
		//va_IDT_Typ1:=[HéberGement]HG_EtatCivil
		va_IDT_Typ2:=""
		va_IDT_Nom:=[HeberGement:5]HG_Nom:21
		va_IDT_Pré:=[HeberGement:5]HG_Prénom:22
		
		vd_IDT_NéLe:=[HeberGement:5]HG_DateNéLe:24
		ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
		va_IDT_Nat:=[HeberGement:5]HG_Nationalité:25
		
		x_IDTG_1:=Num:C11([HeberGement:5]HG_Genre:96=False:C215)
		x_IDTG_2:=Num:C11([HeberGement:5]HG_Genre:96=True:C214)
		
		va_IDT_Lien:=[HeberGement:5]HG_Lien:18
		va_IDT_SitF:=[HeberGement:5]HG_SituFamille:29
		va_IDT_DerH:=[HeberGement:5]HG_DernierHéber:35
		
		va_IDT_TpEr:=[HeberGement:5]HG_TempsErrance:34
		va_IDT_SitP:=[HeberGement:5]HG_SituProfess:36
		va_IDT_DerE:=[HeberGement:5]HG_DernierEmplo:37
		va_IDT_DurE:=[HeberGement:5]HG_DuréSanEmplo:38
		va_IDT_NivE:=[HeberGement:5]HG_NiveauEtude:43
		
		va_IDT_Pt1:=[HeberGement:5]HG_PiècesIdté1:31
		va_IDT_Pt2:=[HeberGement:5]HG_PiècesIdté2:32
		va_IDT_Pt3:=[HeberGement:5]HG_PiècesIdté3:33
		
		va_IDT_Sv1:=[HeberGement:5]HG_SuiviSocial1:49
		va_IDT_Sv2:=[HeberGement:5]HG_SuiviSocial2:50
		va_IDT_Sv3:=[HeberGement:5]HG_SuiviSocial3:51
		
		va_IDT_Cv1:=[HeberGement:5]HG_CouvSocial1:53
		va_IDT_Cv2:=[HeberGement:5]HG_CouvSocial2:54
		va_IDT_Cv3:=[HeberGement:5]HG_CouvSocial3:55
		
		va_IDT_RM1:=[HeberGement:5]HG_RupMajeur1:40
		va_IDT_RM2:=[HeberGement:5]HG_RupMajeur2:41
		va_IDT_RM3:=[HeberGement:5]HG_RupMajeur3:42
		va_IDT_RM11:=[HeberGement:5]HG_RupMajeur1_2:72
		va_IDT_RM21:=[HeberGement:5]HG_RupMajeur2_2:73
		va_IDT_RM31:=[HeberGement:5]HG_RupMajeur3_2:74
		
		va_IDT_RA1:=[HeberGement:5]HG_Ressources1:45
		va_IDT_RA2:=[HeberGement:5]HG_Ressources2:46
		va_IDT_RA3:=[HeberGement:5]HG_Ressources3:47
		va_IDT_RA11:=[HeberGement:5]HG_Ressource1_2:75
		va_IDT_RA21:=[HeberGement:5]HG_Ressource2_2:76
		va_IDT_RA31:=[HeberGement:5]HG_Ressource3_2:77
		ve_IDT_St:=Num:C11([HeberGement:5]HG_Status:89=True:C214)
		
		
		va_IDT_FGrp:=[HeberGement:5]HG_FamGroupe:102
		vb_IDT_FRes:=[HeberGement:5]HG_FamChef:103
		va_IDT_Ffam:=[HeberGement:5]HG_FamClé:104
		va_IDT_FCom:=[HeberGement:5]HG_FamCompo:105
		ve_IDT_FPer:=[HeberGement:5]HG_FamNbPers:106
		
		va_IDT_FDi1:=[HeberGement:5]HG_FamDistri1:112
		va_IDT_FDi2:=[HeberGement:5]HG_FamDistri2:113
		va_IDT_FDi3:=[HeberGement:5]HG_FamDistri3:114
		va_IDT_FDi4:=[HeberGement:5]HG_FamDistri4:115
		va_IDT_FDi5:=[HeberGement:5]HG_FamDistri5:116
		va_IDT_FCSp:=[HeberGement:5]HG_FamCasSpéc:111
		va_IDT_Fvar:=[HeberGement:5]HG_FamCompoVar:117
		
		//26/01/2004
		vr_IDT_FDi1:=[HeberGement:5]HG_FamDistri1M:118
		vr_IDT_FDi2:=[HeberGement:5]HG_FamDistri2M:119
		vr_IDT_FDi3:=[HeberGement:5]HG_FamDistri3M:120
		vr_IDT_FDi4:=[HeberGement:5]HG_FamDistri4M:121
		vr_IDT_FDi5:=[HeberGement:5]HG_FamDistri5M:122
		//fin 26/01/2004
		
		ve_IDT_FJou:=[HeberGement:5]HG_FamNbJour:107
		ve_IDT_FChb:=[HeberGement:5]HG_FamNbChambre:108
		vr_IDT_FPxJ:=[HeberGement:5]HG_FamPrixJour:109
		vr_IDT_FPxT:=[HeberGement:5]HG_FamTotal:110
		
		va_IDT_CdP:=[HeberGement:5]HG_CodePostal:14
		va_IDT_Gare:=[HeberGement:5]HG_Gare:15
		va_IDT_Metr:=[HeberGement:5]HG_Métro:16
		va_IDT_Plac:=[HeberGement:5]HG_Emplacement:17
		
		va_IDT_AssSoc:=[HeberGement:5]HG_AssistSocial:87
		
		
End case 