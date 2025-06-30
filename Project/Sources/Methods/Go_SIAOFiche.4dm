//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Go_SIAOFiche
//{          Mercredi 1 décembre 2010 à 13:23
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1; $L_ID)
$L_ID:=$1

C_TEXT:C284($2; $va_Cas)
$va_Cas:=$2

C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_TEXT:C284($5)

C_LONGINT:C283(vl_SIAO_Action)
C_TEXT:C284(va_SIAO_Action)
C_TEXT:C284(va_SIAO_EtatCivil)

C_TEXT:C284(va_SIAO_UneDate)
C_DATE:C307(vd_SIAO_UneDate)

va_SIAO_EtatCivil:=$5
C_BOOLEAN:C305(vb_Show; $vb_OK)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
C_TEXT:C284(vt_UnTexte; vt_TransTexte)
V_IDT_Déc(0)
C_LONGINT:C283(vl_CleUnique_ID; $vl_Fenetre; vl_CleUnique_SIAO; r1; r2; r3; u1; u2; vl_SelCleUnique_ID)
C_LONGINT:C283(vL_Nb_HB_F; vL_Nb_HG_F)
vL_Nb_HB_F:=0
vL_Nb_HG_F:=0
C_TEXT:C284(va_NNN; va_FrappeClavier; va_IDT_CléFam)
va_NNN:=""
va_FrappeClavier:=""
va_IDT_CléFam:=""

C_LONGINT:C283(vl_RéfU_HBB)
C_TEXT:C284(va_IDT_LienFam)
C_TEXT:C284(va_IDT_Typ1)
C_TEXT:C284(va_IDT_Clé)
C_TEXT:C284(va_IDT_Nom)
C_TEXT:C284(va_IDT_Pré)
C_DATE:C307(vd_IDT_NéLe)
C_LONGINT:C283(ve_IDT_Age)
C_LONGINT:C283(ve_IDT_PCAge)
C_LONGINT:C283(x_IDTG_1)
C_LONGINT:C283(x_IDTG_2)

va_IDT_LienFam:=""
va_IDT_Typ1:=""
va_IDT_Clé:=""
va_IDT_Nom:=""
va_IDT_Pré:=""
vd_IDT_NéLe:=!00-00-00!
ve_IDT_Age:=0
ve_IDT_PCAge:=0
x_IDTG_1:=0
x_IDTG_2:=0

READ ONLY:C145(*)
SET MENU BAR:C67(1)


P_SIAO_Var(0; 0)

$vb_OK:=F_SIAO_Var_Page(0; 0)
$vb_OK:=F_SIAO_Var_SP(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //PERSONNE
$vb_OK:=F_SIAO_Var_AD(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //ADRESSE
$vb_OK:=F_SIAO_Var_SsCS(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //RENSEIGNEMENTS ADMINISTRATIFS
$vb_OK:=F_SIAO_Var_SsSP(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION PROFESSIONNELLE
$vb_OK:=F_SIAO_Var_SsRS(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //RESSOURCES
$vb_OK:=F_SIAO_Var_SsDT(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //ENDETTEMENT
$vb_OK:=F_SIAO_Var_SsLG(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DU LOGEMENT
$vb_OK:=F_SIAO_Var_SsDL(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DE LA DEMANDE DE LOGEMENT

$vb_OK:=F_SIAO_Var_SsBS(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //EVALUATION REALISEE PAR LE PROFESSIONNEL
$vb_OK:=F_SIAO_Var_SsPR(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //PRECONISATION DU PROFESSIONNEL
//$vb_OK:=F_SIAO_Var_SsPS(0;0;0;◊vp_SIAO_PointeurVide;0)  `PRECONISATION DU PROFES
$vb_OK:=F_SIAO_Var_SsPP(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //PROPOSITIONS

$vb_OK:=F_SIAO_Var_SsTotal(0; 0; 0; <>vp_SIAO_PointeurVide; 0)  //Totaux
$vb_OK:=F_SIAO_Var_AddPersonne(0; 0)
$vb_OK:=F_SIAO_Var_ModPersonne(0; 0)
C_PICTURE:C286(vi_Ss_PP_Signature)


MESSAGES OFF:C175

If ($va_Cas="X")  //Existe ou pas
	
	// #BS MIGRATION 10/6/16
	// Ajouté un lien pour contourner cette syntaxe qui ne crashait pas en 6.7 sans lien
	QUERY:C277([SIAO:50]; [SIAO_Personnes:51]Sp_Personne_ID:3=$L_ID)
	MultiSoc_Filter(->[SIAO:50])
	
	If (Records in selection:C76([SIAO:50])>0)
		vl_CleUnique_SIAO:=[SIAO:50]Si_RéférenceID:1  // [SIAO_Personnes]Sp_SIAO_ID
		If (i_Confirmer("Cette personne est déjà rattachée à un dossier."+<>va_CR+"Voulez-vous voir le dossier ?"))
			$1:=vl_CleUnique_SIAO
			$va_Cas:="M"
		End if 
	Else 
		vl_CleUnique_SIAO:=0
		$va_Cas:="A"
	End if 
	
End if 

If ($va_Cas="M")  //Modifier
	
	vl_CleUnique_SIAO:=$L_ID
	
	QUERY:C277([SIAO:50]; [SIAO:50]Si_RéférenceID:1=vl_CleUnique_SIAO)
	MultiSoc_Filter(->[SIAO:50])
	If (Records in selection:C76([SIAO:50])=1)
		
		READ WRITE:C146([SIAO:50])
		If (i_NonVerrou(->[SIAO:50]))
			FORM SET INPUT:C55([SIAO:50]; "Si_EcranSaisie")
			$vl_Fenetre:=i_FenêtreNo(1024; 655; 4; "Demande SIAO"; 1; "Quit_SIAOFiche")
			MODIFY RECORD:C57([SIAO:50]; *)
			UNLOAD RECORD:C212([SIAO:50])
			CLOSE WINDOW:C154($vl_Fenetre)
			READ ONLY:C145([SIAO:50])
		End if 
	Else 
		ALERT:C41(String:C10(Records in selection:C76([SIAO:50]))+" fiche trouvée dans "+Table name:C256(->[SIAO:50]))
	End if 
End if 

If ($va_Cas="A")  //Ajouter Nouveau
	vl_CleUnique_ID:=$L_ID
	vl_SIAO_Action:=$3
	vl_SIAO_Referent:=$4
	va_SIAO_EtatCivil:=$5
	READ WRITE:C146([SIAO:50])
	FORM SET INPUT:C55([SIAO:50]; "Si_EcranSaisie")
	$vl_Fenetre:=i_FenêtreNo(1024; 655; 4; "Demande SIAO"; 1; "Quit_SIAOFiche")
	ADD RECORD:C56([SIAO:50])  //lpc 08122017 ascenceur
	UNLOAD RECORD:C212([SIAO:50])
	CLOSE WINDOW:C154($vl_Fenetre)
	READ ONLY:C145([SIAO:50])
	vl_CleUnique_ID:=0
End if 



If ($va_Cas="D")  //Dupliquer
	
	READ WRITE:C146([SIAO:50])
	QUERY:C277([SIAO:50]; [SIAO:50]Si_RéférenceID:1=$L_ID)
	MultiSoc_Filter(->[SIAO:50])
	If (Records in selection:C76([SIAO:50])=1)
		If (i_NonVerrou(->[SIAO:50]))
			$vb_OK:=F_SIAO_FicheDupliquer($L_ID; $3)
			FORM SET INPUT:C55([SIAO:50]; "Si_EcranSaisie")
			$vl_Fenetre:=i_FenêtreNo(1024; 655; 4; "Demande SIAO"; 1; "Quit_SIAOFiche")
			MODIFY RECORD:C57([SIAO:50]; *)
			UNLOAD RECORD:C212([SIAO:50])
			CLOSE WINDOW:C154($vl_Fenetre)
			POST OUTSIDE CALL:C329(<>PR_SIAOListe)
		End if 
	Else 
		ALERT:C41("Acune fiche trouvée.")
	End if 
	UNLOAD RECORD:C212([SIAO:50])
	READ ONLY:C145([SIAO:50])
End if 


If (vb_Show)
	Général_Show
	POST OUTSIDE CALL:C329(<>PR_Genéral)
End if 
<>PR_SIAOFiche:=0