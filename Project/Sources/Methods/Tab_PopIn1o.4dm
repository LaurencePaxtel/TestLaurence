//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Tab_PopIn1o
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)  //Ptr Nom de la table 
C_POINTER:C301($2)  //Ptr Tableau
C_POINTER:C301($3)  //Ptr Variable 1 à alimenter en retour

C_TEXT:C284(vaTab1NomL)
C_POINTER:C301(vPtrT2_Tab)
C_POINTER:C301(vPtrT2_Var1)
C_BOOLEAN:C305(vb_EtCv)
vaTab1NomL:=$1
vPtrT2_Tab:=$2
vPtrT2_Var1:=$3


C_TEXT:C284(vaTab1Titre)

ARRAY TEXT:C222(t_TabNiv1; 0)

COPY ARRAY:C226(vPtrT2_Tab->; t_TabNiv1)
vb_Valider1:=False:C215
SORT ARRAY:C229(t_TabNiv1; >)
vb_EtCv:=($2=(-><>ta_TBEtCiv))
$vl_Fenetre:=i_FenêtreNo(440; 412; 16; $1; 31; "")
DIALOG:C40([DiaLogues:3]; "DL_TablesN1n")
CLOSE WINDOW:C154($vl_Fenetre)
If (OK=1)
	$3->:=t_TabNiv1{t_TabNiv1}
End if 