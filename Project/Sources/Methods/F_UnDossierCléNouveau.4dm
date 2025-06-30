//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_UnDossierCléNouveau
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
$0:=False:C215

V_HG_Dec(0)
V_HG_Dec(1)

If (F_VariablesTransite(0; 0; False:C215))
End if 
If (F_VariablesTransite(1; 0; False:C215))
End if 

va_IDT_Typ1:=""
va_IDT_Nom:=""
va_IDT_Pré:=""
ve_IDT_Age:=0
vd_IDT_NéLe:=!00-00-00!
x_IDTG_1:=1
x_IDTG_2:=0

vb_NewEtC:=False:C215
va_IDT_Titr:=""
FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergéCléDossier")
$vl_Fenetre:=i_FenêtreNo(352; 362; 4; "Nouvelle fiche"; 3; "")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
$0:=vb_NewEtC