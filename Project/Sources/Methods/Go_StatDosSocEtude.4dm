//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatSpécific
//{
//{          Mardi 24 mai 2005 à 10:32:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
READ ONLY:C145(*)

i_Message("Chargement en cours …")

ARRAY TEXT:C222(ta_Page; 2)
ta_Page{1}:="Répartitions"
ta_Page{2}:="Rapport"
ta_Page:=1

ARRAY TEXT:C222(ta_TBEtCivTemp; 0)
ARRAY TEXT:C222(ta_TBEtCivTemp2; 0)

C_TEXT:C284(va_CodeEnum)
C_TEXT:C284(va_LibEnum)

//Etat civil
va_CodeEnum:="EtaCv"
va_LibEnum:=""

//ici la table de regroupement de l'état civil
ARRAY TEXT:C222(ta_FuseEtCiv; 0)
QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceTable:2=va_CodeEnum)
MultiSoc_Filter(->[TableFusions:42])
If (Records in table:C83([TableFusions:42])>0)
	DISTINCT VALUES:C339([TableFusions:42]TF_Libellé:3; ta_FuseEtCiv)
End if 
ARRAY INTEGER:C220(te_FuseEtCivCheck; Size of array:C274(ta_FuseEtCiv))

C_LONGINT:C283($ii)
For ($ii; 1; Size of array:C274(ta_FuseEtCiv))
	te_FuseEtCivCheck{$ii}:=1
End for 


V_Stat_DosSocEt(0; 0)

CLOSE WINDOW:C154

va_Titre:="Statistiques : Dossier social Etude"
READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatFicheSocialeEt")
C_LONGINT:C283($vl_Fenetre)
$vl_Fenetre:=i_FenêtreNo(632; 436; 4; va_Titre; 1; "Quit_StatDosSocEt")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
V_Stat_DosSocEt(0; 0)

<>PR_StatEDS:=0
If (vb_Show)
	Général_Show
End if 