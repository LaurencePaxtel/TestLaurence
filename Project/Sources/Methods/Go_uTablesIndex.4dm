//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uTablesIndex
//{
//{          Mercredi 29 janvier 2003 à 17:59
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

C_BOOLEAN:C305(vb_OK)

C_LONGINT:C283($ii)
$ii:=0
ARRAY INTEGER:C220(te_IndexQuelFichier; $ii)
ARRAY TEXT:C222(ta_IndexQuelFichier; $ii)
$ii:=42
vb_OK:=False:C215
ARRAY INTEGER:C220(te_IndexCheck; $ii)
ARRAY INTEGER:C220(te_IndexFichier; $ii)
ARRAY TEXT:C222(ta_IndexFichier; $ii)
ARRAY INTEGER:C220(te_IndexChamp; $ii)
ARRAY TEXT:C222(ta_IndexChamp; $ii)
ARRAY TEXT:C222(ta_IndexChampBis; $ii)
ARRAY BOOLEAN:C223(tb_IndexIndexé; $ii)
ARRAY INTEGER:C220(te_IndexIndexéOld; $ii)
ARRAY INTEGER:C220(te_IndexIndexé; $ii)


$va_TableNom:="Demandeur"
$ve_TableNo:=Table:C252(->[HeBerge:4])

$ii:=1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeBerge:4]HB_ReferenceID:1)
ta_IndexChamp{$ii}:="Référence"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeBerge:4]HB_ReferenceID:1)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1

$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeBerge:4]HB_Clé:2)
ta_IndexChamp{$ii}:="Clé"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeBerge:4]HB_Clé:2)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1

$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeBerge:4]HB_CléFam:47)
ta_IndexChamp{$ii}:="Clé famille"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeBerge:4]HB_CléFam:47)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1

$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=0
ta_IndexFichier{$ii}:="-"
te_IndexChamp{$ii}:=0
ta_IndexChamp{$ii}:="-"
ta_IndexChampBis{$ii}:="-"
tb_IndexIndexé{$ii}:=False:C215
te_IndexIndexé{$ii}:=0



$va_TableNom:="Hébergement"
$ve_TableNo:=Table:C252(->[HeberGement:5])
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_ReferenceID:1)
ta_IndexChamp{$ii}:="Référence"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_ReferenceID:1)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Nuit:2)
ta_IndexChamp{$ii}:="Jour/Nuit"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Nuit:2)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_FicheNuméro:3)
ta_IndexChamp{$ii}:="No de fiche"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_FicheNuméro:3)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Date:4)
ta_IndexChamp{$ii}:="Date"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Date:4)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_HeureAppel:5)
ta_IndexChamp{$ii}:="Heure d'appel"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_HeureAppel:5)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Permanencier:9)
ta_IndexChamp{$ii}:="Permanancier"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Permanencier:9)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Signalement:12)
ta_IndexChamp{$ii}:="Signalement"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Signalement:12)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_CodePostal:14)
ta_IndexChamp{$ii}:="Code postal"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_CodePostal:14)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_HB_ID:19)
ta_IndexChamp{$ii}:="Lien demandeur"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_HB_ID:19)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=5
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_EtatCivil:20)
ta_IndexChamp{$ii}:="Etat civil"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_EtatCivil:20)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Nom:21)
ta_IndexChamp{$ii}:="Nom"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Nom:21)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Orientation1:58)
ta_IndexChamp{$ii}:="Orientation 1"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Orientation1:58)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Orientation2:60)
ta_IndexChamp{$ii}:="Orientation 2"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Orientation2:60)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_LC_ID:61)
ta_IndexChamp{$ii}:="Centre d'hébergement : lien"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_LC_ID:61)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_CentreNom:62)
ta_IndexChamp{$ii}:="Centre d'hébergement : nom"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_CentreNom:62)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Cloturée:67)
ta_IndexChamp{$ii}:="Hébergement Clôturé"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Cloturée:67)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_CléFax:69)
ta_IndexChamp{$ii}:="Clé de fax"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_CléFax:69)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_AutreSolutio:88)
ta_IndexChamp{$ii}:="Autre solution"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_AutreSolutio:88)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Status:89)
ta_IndexChamp{$ii}:="Statut SP"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Status:89)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Réservation:91)
ta_IndexChamp{$ii}:="Réservation"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Réservation:91)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_NuitTOTAL:93)
ta_IndexChamp{$ii}:="Réservation Total des nuits"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_NuitTOTAL:93)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Reporté:94)
ta_IndexChamp{$ii}:="Réservation Reportée"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Reporté:94)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_NuitReste:95)
ta_IndexChamp{$ii}:="Réservation Nuits restantes"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_NuitReste:95)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_FamCompo:105)
ta_IndexChamp{$ii}:="Composition familiale"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_FamCompo:105)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[HeberGement:5]HG_Commentaires:181)
ta_IndexChamp{$ii}:="Commentaires"
ta_IndexChampBis{$ii}:=Field name:C257(->[HeberGement:5]HG_Commentaires:181)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1



$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=0
ta_IndexFichier{$ii}:="-"
te_IndexChamp{$ii}:=0
ta_IndexChamp{$ii}:="-"
ta_IndexChampBis{$ii}:="-"
tb_IndexIndexé{$ii}:=False:C215
te_IndexIndexé{$ii}:=0


$va_TableNom:="Centres d'hébergement"
$ve_TableNo:=Table:C252(->[LesCentres:9])
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[LesCentres:9]LC_RéférenceID:1)
ta_IndexChamp{$ii}:="Référence"
ta_IndexChampBis{$ii}:=Field name:C257(->[LesCentres:9]LC_RéférenceID:1)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[LesCentres:9]LC_Nom:4)
ta_IndexChamp{$ii}:="Nom"
ta_IndexChampBis{$ii}:=Field name:C257(->[LesCentres:9]LC_Nom:4)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[LesCentres:9]LC_Lieu:5)
ta_IndexChamp{$ii}:="Lieu"
ta_IndexChampBis{$ii}:=Field name:C257(->[LesCentres:9]LC_Lieu:5)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1



$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=0
ta_IndexFichier{$ii}:="-"
te_IndexChamp{$ii}:=0
ta_IndexChamp{$ii}:="-"
ta_IndexChampBis{$ii}:="-"
tb_IndexIndexé{$ii}:=False:C215
te_IndexIndexé{$ii}:=0


$va_TableNom:="Lits des centres"
$ve_TableNo:=Table:C252(->[CentresLits:16])
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[CentresLits:16]CL_LC_ID_date:1)
ta_IndexChamp{$ii}:="Référence date"
ta_IndexChampBis{$ii}:=Field name:C257(->[CentresLits:16]CL_LC_ID_date:1)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[CentresLits:16]CL_LC_ID:2)
ta_IndexChamp{$ii}:="Lien au centre"
ta_IndexChampBis{$ii}:=Field name:C257(->[CentresLits:16]CL_LC_ID:2)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[CentresLits:16]CL_Type:8)
ta_IndexChamp{$ii}:="Type"
ta_IndexChampBis{$ii}:=Field name:C257(->[CentresLits:16]CL_Type:8)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[CentresLits:16]CL_DateType:9)
ta_IndexChamp{$ii}:="Type date"
ta_IndexChampBis{$ii}:=Field name:C257(->[CentresLits:16]CL_DateType:9)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[CentresLits:16]CL_DateTypeIDLC:10)
ta_IndexChamp{$ii}:="Type référence"
ta_IndexChampBis{$ii}:=Field name:C257(->[CentresLits:16]CL_DateTypeIDLC:10)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[CentresLits:16]CL_Capacité:4)
ta_IndexChamp{$ii}:="Capacité"
ta_IndexChampBis{$ii}:=Field name:C257(->[CentresLits:16]CL_Capacité:4)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[CentresLits:16]CL_DispoTotal:5)
ta_IndexChamp{$ii}:="Disponibilité"
ta_IndexChampBis{$ii}:=Field name:C257(->[CentresLits:16]CL_DispoTotal:5)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[CentresLits:16]CL_Distribué:6)
ta_IndexChamp{$ii}:="Distribué"
ta_IndexChampBis{$ii}:=Field name:C257(->[CentresLits:16]CL_Distribué:6)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1
$ii:=$ii+1
te_IndexCheck{$ii}:=0
te_IndexFichier{$ii}:=$ve_TableNo
ta_IndexFichier{$ii}:=$va_TableNom
te_IndexChamp{$ii}:=Field:C253(->[CentresLits:16]CL_Restant:7)
ta_IndexChamp{$ii}:="Restant"
ta_IndexChampBis{$ii}:=Field name:C257(->[CentresLits:16]CL_Restant:7)
tb_IndexIndexé{$ii}:=True:C214
te_IndexIndexé{$ii}:=1

$jj:=$ii
champType:=0
champLong:=0
champIndexé:=False:C215
For ($ii; 1; $jj)
	If (te_IndexFichier{$ii}>0)
		GET FIELD PROPERTIES:C258(te_IndexFichier{$ii}; te_IndexChamp{$ii}; champType; champLong; champIndexé)
		tb_IndexIndexé{$ii}:=champIndexé
		te_IndexIndexé{$ii}:=Num:C11(champIndexé=True:C214)
	End if 
End for 




CLOSE WINDOW:C154

va_Titre:="Gestion des index"


$vl_Fenetre:=i_FenêtreNo(399; 508; 8; va_Titre; 1; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_uIndex")
CLOSE WINDOW:C154($vl_Fenetre)

<>PR_DévTablesDX:=0
If (vb_Show)
	Général_Show
End if 