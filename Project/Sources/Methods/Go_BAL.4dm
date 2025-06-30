//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_BAL
//{
//{          Lundi 26 février 2007 à 18:34:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)
READ ONLY:C145(*)
//Les données 
DebutDécVarDocu(0)

P_Bal_A(-5)
vd_DateDocu:=Current date:C33
P_BAL_B(2)

$vl_Fenetre:=i_FenêtreNo(456; 508; -((16*45))-2; "Boite aux lettres ("+String:C10(vl_RépNombre)+") : "+<>vt_T_DossierRep; 22; "")
DIALOG:C40([DiaLogues:3]; "DL_TablesTrans")
CLOSE WINDOW:C154($vl_Fenetre)
<>PR_AppelBAL:=0