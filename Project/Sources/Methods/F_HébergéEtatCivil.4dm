//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 25/04/23, 15:22:57
// ----------------------------------------------------
// Méthode : F_HébergéEtatCivil
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_LONGINT:C283($vl_Fenetre)

C_BOOLEAN:C305(vb_Valider)
C_TEXT:C284(va_EtCvTitre)
C_LONGINT:C283(ve_EtCvAccès; ve_EtCvSaisissable)

vb_Valider:=False:C215

ve_EtCvAccès:=$1
ve_EtCvSaisissable:=$1

Case of 
	: ($1=1)
		va_EtCvTitre:=[HeberGement:5]HG_FicheNuméro:3
		vd_Dt_Fich:=[HeberGement:5]HG_DateDuJour:82
		va_IDT_Typ1:=[HeberGement:5]HG_EtatCivil:20
		va_IDT_Typ2:=""
		va_IDT_Nom:=[HeberGement:5]HG_Nom:21
		va_IDT_Pré:=[HeberGement:5]HG_Prénom:22
		vd_IDT_NéLe:=[HeberGement:5]HG_DateNéLe:24
		ve_IDT_Age:=[HeberGement:5]HG_Age:23
		
		If (ve_IDT_Age=0)
			ve_IDT_Age:=Uut_HébergéAgePlus(->vd_IDT_NéLe; ->vd_Dt_Fich)
		End if 
		
		x_IDTG_1:=Num:C11([HeberGement:5]HG_Genre:96=False:C215)
		x_IDTG_2:=Num:C11([HeberGement:5]HG_Genre:96=True:C214)
		
		If (x_IDTG_1=x_IDTG_2)
			x_IDTG_1:=1
			x_IDTG_2:=0
		End if 
		
		rIDTFL1:=Num:C11([HeberGement:5]HG_YaFicheLiée:78=True:C214)
		rIDTFL2:=Num:C11([HeberGement:5]HG_YaFicheLiée:78=True:C214)
		
		ve_IDT_NbFL:=[HeberGement:5]HG_NbFicheLiée:79
		
		sIDTFL1:=Num:C11([HeberGement:5]HG_1erFicheLiée:80=True:C214)
		sIDTFL2:=Num:C11([HeberGement:5]HG_1erFicheLiée:80=True:C214)
		
		va_IDT_TyFL:=[HeberGement:5]HG_TypFicheLiée:81
		vl_IDT_Stat:=0
	: ($1=2)
		va_EtCvTitre:=[Maraude:24]MR_FicheNuméro:3
		vd_Dt_Fich:=[Maraude:24]MR_Date:4
		
		va_IDT_Typ1:=[Maraude:24]MR_EtatCivil:16
		va_IDT_Typ2:=""
		
		va_IDT_Nom:=[Maraude:24]MR_Nom:17
		va_IDT_Pré:=[Maraude:24]MR_Prénom:18
		vd_IDT_NéLe:=[Maraude:24]MR_DateNéLe:20
		ve_IDT_Age:=[Maraude:24]MR_Age:19
		
		If (ve_IDT_Age=0)
			ve_IDT_Age:=Uut_HébergéAgePlus(->vd_IDT_NéLe; ->vd_Dt_Fich)
		End if 
		
		x_IDTG_1:=Num:C11([Maraude:24]MR_Genre:42=False:C215)
		x_IDTG_2:=Num:C11([HeberGement:5]HG_Genre:96=True:C214)
		
		If (x_IDTG_1=x_IDTG_2)
			x_IDTG_1:=1
			x_IDTG_2:=0
		End if 
		
		vl_IDT_Stat:=0
	: ($1=3)
		va_EtCvTitre:=[DossierSocial:25]DS_FicheNuméro:3
		vd_Dt_Fich:=[DossierSocial:25]DS_Date:4
		
		va_IDT_Typ1:=[DossierSocial:25]DS_EtatCivil:11
		va_IDT_Typ2:=""
		
		va_IDT_Nom:=[DossierSocial:25]DS_Nom:12
		va_IDT_Pré:=[DossierSocial:25]DS_Prénom:16
		vd_IDT_NéLe:=[DossierSocial:25]DS_DateNéLe:18
		ve_IDT_Age:=[DossierSocial:25]DS_Age:17
		
		If (ve_IDT_Age=0)
			ve_IDT_Age:=Uut_HébergéAgePlus(->vd_IDT_NéLe; ->vd_Dt_Fich)
		End if 
		
		x_IDTG_1:=Num:C11([DossierSocial:25]DS_Genre:20=False:C215)
		x_IDTG_2:=Num:C11([DossierSocial:25]DS_Genre:20=True:C214)
		
		If (x_IDTG_1=x_IDTG_2)
			x_IDTG_1:=1
			x_IDTG_2:=0
		End if 
		
		vl_IDT_Stat:=0
	: ($1=4)
		va_EtCvTitre:=[DossierInfirmie:27]DI_FicheNuméro:3
		vd_Dt_Fich:=[DossierInfirmie:27]DI_Date:4
		
		va_IDT_Typ1:=[DossierInfirmie:27]DI_EtatCivil:12
		va_IDT_Typ2:=""
		
		va_IDT_Nom:=[DossierInfirmie:27]DI_Nom:13
		va_IDT_Pré:=[DossierInfirmie:27]DI_Prénom:14
		vd_IDT_NéLe:=[DossierInfirmie:27]DI_DateNéLe:16
		ve_IDT_Age:=[DossierInfirmie:27]DI_Age:15
		
		If (ve_IDT_Age=0)
			ve_IDT_Age:=Uut_HébergéAgePlus(->vd_IDT_NéLe; ->vd_Dt_Fich)
		End if 
		
		x_IDTG_1:=Num:C11([DossierInfirmie:27]DI_Genre:18=False:C215)
		x_IDTG_2:=Num:C11([DossierInfirmie:27]DI_Genre:18=True:C214)
		
		If (x_IDTG_1=x_IDTG_2)
			x_IDTG_1:=1
			x_IDTG_2:=0
		End if 
		
		vl_IDT_Stat:=0
	: ($1=5)
		va_EtCvTitre:=[DossierMedical:29]DM_FicheNuméro:3
		vd_Dt_Fich:=[DossierMedical:29]DM_Date:4
		
		va_IDT_Typ1:=[DossierMedical:29]DM_EtatCivil:12
		va_IDT_Typ2:=""
		
		va_IDT_Nom:=[DossierMedical:29]DM_Nom:13
		va_IDT_Pré:=[DossierMedical:29]DM_Prénom:14
		vd_IDT_NéLe:=[DossierMedical:29]DM_DateNéLe:16
		ve_IDT_Age:=[DossierMedical:29]DM_Age:15
		
		If (ve_IDT_Age=0)
			ve_IDT_Age:=Uut_HébergéAgePlus(->vd_IDT_NéLe; ->vd_Dt_Fich)
		End if 
		
		x_IDTG_1:=Num:C11([DossierMedical:29]DM_Genre:18=False:C215)
		x_IDTG_2:=Num:C11([DossierMedical:29]DM_Genre:18=True:C214)
		
		If (x_IDTG_1=x_IDTG_2)
			x_IDTG_1:=1
			x_IDTG_2:=0
		End if 
		
		vl_IDT_Stat:=0
	: ($1=6)
		va_EtCvTitre:=[DossierPsycho:28]DY_FicheNuméro:3
		vd_Dt_Fich:=[DossierPsycho:28]DY_Date:4
		
		va_IDT_Typ1:=[DossierPsycho:28]DY_EtatCivil:12
		va_IDT_Typ2:=""
		
		va_IDT_Nom:=[DossierPsycho:28]DY_Nom:13
		va_IDT_Pré:=[DossierPsycho:28]DY_Prénom:14
		vd_IDT_NéLe:=[DossierPsycho:28]DY_DateNéLe:16
		ve_IDT_Age:=[DossierPsycho:28]DY_Age:15
		
		If (ve_IDT_Age=0)
			ve_IDT_Age:=Uut_HébergéAgePlus(->vd_IDT_NéLe; ->vd_Dt_Fich)
		End if 
		
		x_IDTG_1:=Num:C11([DossierPsycho:28]DY_Genre:18=False:C215)
		x_IDTG_2:=Num:C11([DossierPsycho:28]DY_Genre:18=True:C214)
		
		If (x_IDTG_1=x_IDTG_2)
			x_IDTG_1:=1
			x_IDTG_2:=0
		End if 
		
		vl_IDT_Stat:=0
	: ($1=7)
		va_EtCvTitre:=[DossierSante:33]DE_FicheNuméro:3
		vd_Dt_Fich:=[DossierSante:33]DE_Date:4
		
		va_IDT_Typ1:=[DossierSante:33]DE_EtatCivil:13
		va_IDT_Typ2:=""
		
		va_IDT_Nom:=[DossierSante:33]DE_Nom:14
		va_IDT_Pré:=[DossierSante:33]DE_Prénom:15
		vd_IDT_NéLe:=[DossierSante:33]DE_DateNéLe:17
		ve_IDT_Age:=[DossierSante:33]DE_Age:16
		
		If (ve_IDT_Age=0)
			ve_IDT_Age:=Uut_HébergéAgePlus(->vd_IDT_NéLe; ->vd_Dt_Fich)
		End if 
		
		x_IDTG_1:=Num:C11([DossierSante:33]DE_Genre:19=False:C215)
		x_IDTG_2:=Num:C11([DossierSante:33]DE_Genre:19=True:C214)
		
		If (x_IDTG_1=x_IDTG_2)
			x_IDTG_1:=1
			x_IDTG_2:=0
		End if 
		
		vl_IDT_Stat:=0
End case 

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergéEtatCivil")

$vl_Fenetre:=i_FenêtreNo(351; 362; 16; "Fiche n° "+va_EtCvTitre; 3; "")
ADD RECORD:C56([DiaLogues:3])  // crash en 16R4 - 16/08/2017 //lpc 08122017 ascenceur

UNLOAD RECORD:C212([DiaLogues:3])
READ ONLY:C145([DiaLogues:3])

CLOSE WINDOW:C154($vl_Fenetre)

$0:=vb_Valider