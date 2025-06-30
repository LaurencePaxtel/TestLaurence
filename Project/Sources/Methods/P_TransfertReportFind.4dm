//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : P_TransfertReportFind
//{
//{          Jeudi 4 décembre 2008 à 14:42
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
i_Message("Recheche en cours…")
F_Report_FullDuplexTableau
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
//4/11/2008
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
//Fin 4/11/2008
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Trans_DDASS:141=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)

MultiSoc_Filter(->[HeberGement:5])

vl_Fiches:=Records in selection:C76([HeberGement:5])
SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Trans_Réf_HG)
CLOSE WINDOW:C154