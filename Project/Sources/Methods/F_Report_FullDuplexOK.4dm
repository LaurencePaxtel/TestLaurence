//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplexOK
//{
//{          Mardi 4 novembre 2008 à 18:46
//{          Modifiée : 4 novembre 2008 à 18:46
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)

//•(1) Est ce une base CHRS  en Full Duplex
$0:=<>vb_T_ModeCHRS & <>vb_T_FullDuplex