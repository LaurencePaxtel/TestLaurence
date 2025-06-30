//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_BoiteAuLettre
//{
//{          Lundi 26 février 2007 à 18:34:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
<>va_T_QuelleBoiteLettres:=$1
SET MENU BAR:C67(1)
READ ONLY:C145(*)
//Les données 
DebutDécVarDocu(0)

C_BOOLEAN:C305($vb_OK)

C_TEXT:C284(va_TransFrom)
vb_OK:=F_Report_FullDuplexVAR  //••   `Variables communes au report
F_Report_FullDuplexTableau

C_LONGINT:C283(vL_NbFiches)
C_LONGINT:C283(vl_RéfU_HG)
C_LONGINT:C283(vl_RéfU_HBB)
C_LONGINT:C283(vl_IDT_IDHB)
C_LONGINT:C283(vl_IDT_IDHG)
C_BOOLEAN:C305(vb_IDT_NUIT)
C_TEXT:C284(va_Rép)
C_TEXT:C284(va_Rép2)
C_LONGINT:C283(vl_NoRéfHG; vl_NoFicheHG; vl_NoRéfHGNb)
C_TEXT:C284(va_Réservation)
vL_NbFiches:=0
vl_RéfU_HG:=0
$vb_OK:=F_VariablesTransite(0; 2; False:C215)
ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)


P_Bal_A(-5)
vd_DateDocu:=Current date:C33
If (vt_RépCentre>"")
	P_BAL_B(2)
	
	Case of 
		: (<>va_T_QuelleBoiteLettres=<>va_T_LaBoiteLettres)  //BoîteAuxLettres
			$vl_Fenetre:=i_FenêtreNo(466; 578; -((16*45))-2; "Boite aux lettres ("+String:C10(vl_RépNombre)+") : "+<>vt_T_DossierRep; 22; "")
			DIALOG:C40([DiaLogues:3]; "DL_BoiteAuxLettres")
		: (<>va_T_QuelleBoiteLettres=<>va_T_LaBoiteDalo)  //BoîteDalo
			$vl_Fenetre:=i_FenêtreNo(466; 578; -((16*45))-2; "Boite des documents joints par mail : "+String:C10(vl_RépNombre); 22; "")
			DIALOG:C40([DiaLogues:3]; "DL_TablesTrans")
	End case 
	CLOSE WINDOW:C154($vl_Fenetre)
Else 
	ALERT:C41("Veuillez vérifier les paramètres 'Chemins & répertoires'.")
End if 

ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
<>va_T_QuelleBoiteLettres:=""
<>PR_AppelBAL:=0
