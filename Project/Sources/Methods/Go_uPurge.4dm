//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uPurge  
//{
//{          Mercredi 29 Octobre 1997 à 12:47:45
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

P_Profil

C_DATE:C307(vd_ReportPurgeDt; vd_ReportPurgeDtLast)
vd_ReportPurgeDt:=!00-00-00!
vd_ReportPurgeDtLast:=!00-00-00!
C_LONGINT:C283(vl_ReportPurgeNb)

C_DATE:C307(vd_DtDéb)
C_DATE:C307(vd_DtFin)
C_TEXT:C284(va_DtDéb)
ARRAY TEXT:C222(ta_vd_DtDéb; 0)
C_DATE:C307(vd_DtDébR)
C_DATE:C307(vd_DtFinR)

C_DATE:C307(vd_DtDébTr)
C_DATE:C307(vd_DtFinTr)

C_DATE:C307(vd_DtDébL)
C_DATE:C307(vd_DtFinL)
C_TEXT:C284(va_SupCP)
va_SupCP:=""
C_TEXT:C284(va_NoF1)
C_TEXT:C284(va_NoF2)
va_NoF1:=""
va_NoF2:=""
vd_DtDéb:=!00-00-00!
vd_DtFin:=!00-00-00!
va_DtDéb:=""
ARRAY TEXT:C222(ta_vd_DtDéb; 0)
vd_DtDébL:=!00-00-00!
vd_DtFinL:=!00-00-00!
vd_DtDébR:=!00-00-00!
vd_DtFinR:=!00-00-00!


vd_DtDébTr:=!00-00-00!
vd_DtFinTr:=!00-00-00!


C_DATE:C307(vd_DtDéb6)
C_DATE:C307(vd_DtFin6)
vd_DtDéb6:=!00-00-00!
vd_DtFin6:=!00-00-00!

C_DATE:C307(vd_DtDébFno)
C_DATE:C307(vd_DtFinFno)
vd_DtDébFno:=!00-00-00!
vd_DtFinFno:=!00-00-00!
C_LONGINT:C283(ve_DtMoisFno)
C_LONGINT:C283(ve_DtAnnéeFno)
ve_DtMoisFno:=0
ve_DtAnnéeFno:=0

C_TEXT:C284(vaCol2)
vaCol2:="Fiches"

C_LONGINT:C283(vl_K_Ctre_SerieA; vl_K_Ctre_SerieAD; vl_K_Ctre_SerieAF)
C_LONGINT:C283(vl_K_Ctre_SerieCD; vl_K_Ctre_SerieCF)

C_LONGINT:C283(vl_K_Ctre_Serie; vl_K_Ctre_SerieD; vl_K_Ctre_SerieF; vl_K_Ctre_SerieNo)


C_DATE:C307(vd_DtRAZ)
C_TEXT:C284(va_DtRAZ)
C_LONGINT:C283(vl_DtRAZ_Nombre)

C_BOOLEAN:C305(vb_CacherPour)
vb_CacherPour:=True:C214

// STRING LIST TO ARRAY(30005;ta_InfoNom)

// #BS Migration v15 30/05/16
// Remplacement de la commande obsolète
// STRING LIST TO ARRAY par xliff_STRING_LIST_TO_ARRAY
ARRAY TEXT:C222(ta_InfoNom; 0)
xliff_STRING_LIST_TO_ARRAY_(30005; ->ta_InfoNom)




C_TEXT:C284(vt_InfoTEXTE)

REDUCE SELECTION:C351([HeBerge:4]; 0)

READ WRITE:C146([DiaLogues:3])
va_Titre:="Purge des fichiers"
//$vl_Fenetre:=i_FenêtreNo (786;558;4;va_Titre;1;"Quit_Simple")
//$vl_Fenetre:=i_FenêtreNo (786;608;4;va_Titre;1;"Quit_Simple")
$vl_Fenetre:=i_FenêtreNo(876; 608; 4; va_Titre; 1; "Quit_Simple")
FORM SET INPUT:C55([DiaLogues:3]; "DL_Purge")
ADD RECORD:C56([DiaLogues:3]; *)
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_Purge:=0
If (vb_Show)
	Général_Show
End if 
