//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction :  F_UnDossierTypeNouveau
//{
//{          Mercredi 18 juillet 2001 à 10:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284(va_OldEtCiv)
va_OldEtCiv:=$2


va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
va_IDT_Titr:=va_IDT_Clé+" <> "+String:C10(ve_IDT_Age)+" an(s)"


ARRAY TEXT:C222(t_TabNiv1; 0)
COPY ARRAY:C226(<>ta_TBEtCiv; t_TabNiv1)
vb_Valider1:=False:C215
SORT ARRAY:C229(t_TabNiv1; >)

$vl_Fenetre:=i_FenêtreNo(356; 412; 16; "Type Etat civil"; 3; "")
DIALOG:C40([DiaLogues:3]; "DL_DossierEtatCivil")
CLOSE WINDOW:C154($vl_Fenetre)
If (OK=1)
	va_IDT_Typ1:=t_TabNiv1{t_TabNiv1}
	$0:=True:C214
End if 