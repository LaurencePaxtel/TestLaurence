//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_RG_Regional
//{
//{          Jeudi 13 mai 2010 à 16:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)

C_DATE:C307(vd_DateDuJour)
C_TIME:C306(vh_HeurCourante)
<>vt_TexteRegional_ST:=<>va_T_Site+<>va_TAB+<>va_T_00+<>va_TAB+String:C10(vd_DateDuJour; Interne date court:K1:7)+<>va_TAB+String:C10(vh_HeurCourante; h mn s:K7:1)+<>va_TAB+"SSP région"