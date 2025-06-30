//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uConsolidation
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
i_Message("Chargement en cours…")
C_TEXT:C284(va_Libel)
ARRAY TEXT:C222(ta_Libel; 6)
ta_libel{1}:="Centre initialisation "
ta_libel{2}:="Centre mise à jour "
ta_libel{3}:="Centre Export"
ta_libel{4}:="-"
ta_libel{5}:="Siège Import en provenance des centre"
ta_libel{6}:="Siège export des clés"
ta_libel:=1
ta_libel{0}:=ta_libel{ta_libel}
C_TIME:C306(vh_RefDoc)
C_TEXT:C284(va_EndOF; va_Eof)
va_EndOF:=Char:C90(13)+Char:C90(10)
va_Eof:=Char:C90(13)+Char:C90(10)
C_TEXT:C284(va_Site)
C_TEXT:C284(va_TypeRecu)
C_TEXT:C284(va_SiteRecu)
C_TEXT:C284(va_DtSRecu)
C_TEXT:C284(va_DtRecu)
C_TEXT:C284(va_NbClé)
C_TEXT:C284(va_NbMar)
C_TEXT:C284(va_NbDsS)
C_TEXT:C284(va_NbDsI)
C_TEXT:C284(va_NbDsY)
C_TEXT:C284(va_NbDsM)
C_DATE:C307(vd_DateSel)
vd_DateSel:=Current date:C33
va_Titre:="Consolidation"
CLOSE WINDOW:C154


ALERT:C41("Consolidation : fonctionnalité en cours de migration V6.")

<>PR_Conso:=0
If (vb_Show)
	Général_Show
End if 