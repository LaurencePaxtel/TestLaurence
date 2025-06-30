//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : DebutDecVarReport
//{
//{          Vendrdi 31 octobre 2008 à 15:00
//{          Modifiée : 31 octobre 2008 à 15:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284(<>va_RepR)  // Reporté
C_TEXT:C284(<>va_RepRE)  // Reporté mais excusé et non clôturé
C_TEXT:C284(<>va_RepRP)  // Reporté par prolongation la première fois
C_TEXT:C284(<>va_RepF)  // Fin
C_TEXT:C284(<>va_RepA)  // Absence
C_TEXT:C284(<>va_RepO)  // O Réorienté
C_TEXT:C284(<>va_RepE)  // Libellé du Report effectué
C_TEXT:C284(<>va_Rép_TransReport; <>va_Rép_TransReportLU; <>va_Rép_TransReportREFUS; <>va_FINEXPORT)

C_LONGINT:C283(<>ve_RepE)  // Libellé du Report effectué 0 on y va 1 jour 2 Nuit 3 JB

<>va_RepR:="R"
<>va_RepRE:="RE"
<>va_RepRP:="RP"
<>va_RepF:="F"
<>va_RepA:="A"
<>va_RepO:="O"

<>va_RepE:=""

<>va_Rép_TransReport:="115Report"
<>va_Rép_TransReportLU:="115LU"
<>va_Rép_TransReportREFUS:="115REFUS"

<>va_FINEXPORT:="SSPFINEXPORTSSP"

<>ve_RepE:=0