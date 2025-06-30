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


P_Bal_A(-5)
vd_DateDocu:=Current date:C33
If (vt_RépCentre>"")
	P_BAL_B(2)
	Case of 
		: (<>va_T_QuelleBoiteLettres=<>va_T_LaBoiteLettres)  //BoîteAuxLettres
			$vl_Fenetre:=i_FenêtreNo(456; 508; -((16*45))-2; "Boite aux lettres ("+String:C10(vl_RépNombre)+") : "+<>vt_T_DossierRep; 22; "")
		: (<>va_T_QuelleBoiteLettres=<>va_T_LaBoiteDalo)  //BoîteDalo
			$vl_Fenetre:=i_FenêtreNo(456; 508; -((16*45))-2; "Boite des doccuments joints par mail : "+String:C10(vl_RépNombre); 22; "")
	End case 
	DIALOG:C40([DiaLogues:3]; "DL_TablesTrans")
	CLOSE WINDOW:C154($vl_Fenetre)
Else 
	ALERT:C41("Veuillez vérifier les paramètres 'Chemins & répertoires'.")
End if 

<>va_T_QuelleBoiteLettres:=""
<>PR_AppelBAL:=0
