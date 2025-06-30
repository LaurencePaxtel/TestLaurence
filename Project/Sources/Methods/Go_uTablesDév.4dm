//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uTablesDév
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)
READ ONLY:C145(*)
C_LONGINT:C283($ii)
ARRAY TEXT:C222(ta_DévTables; 40)
ta_DévTables{1}:="Hébergés (Demandeurs)"
ta_DévTables{2}:="Hébergements"
ta_DévTables{3}:="Maraudes"
ta_DévTables{4}:="Centres"
ta_DévTables{5}:="Centres disponibilités"
ta_DévTables{6}:="-"
ta_DévTables{7}:="Table Type (Enumération famille)"
ta_DévTables{8}:="Table (Enumération valeurs)"

ta_DévTables{9}:="-"
ta_DévTables{10}:="Dossier social"
ta_DévTables{11}:="Dossier infirmier"
ta_DévTables{12}:="Dossier psycho-social"
ta_DévTables{13}:="Dossier médical"
ta_DévTables{14}:="Dossier santé"

ta_DévTables{15}:="-"
ta_DévTables{16}:="Table Départ"
ta_DévTables{17}:="Table Références"
ta_DévTables{18}:="Table Dialogue"
ta_DévTables{19}:="Table Champs"
ta_DévTables{20}:="Table Appels"
ta_DévTables{21}:="Table Demande"
ta_DévTables{22}:="Table Renseignements"
ta_DévTables{23}:="Table Mémo"

ta_DévTables{24}:="-"
ta_DévTables{25}:="Utilisateurs"
ta_DévTables{26}:="Privilèges utilisateurs"



ta_DévTables{27}:="-"
ta_DévTables{28}:="Gestion des index"

ta_DévTables{29}:="-"
ta_DévTables{30}:="Utilisation directe"

$ii:=30

$ii:=$ii+1
ta_DévTables{$ii}:="-"
$ii:=$ii+1
ta_DévTables{$ii}:="Export vers v12"



$ii:=$ii+1
ta_DévTables{$ii}:="-"
$ii:=$ii+1
ta_DévTables{$ii}:="Export BDOS"


$ii:=$ii+1
ta_DévTables{$ii}:="-"
$ii:=$ii+1
ta_DévTables{$ii}:="Appels"



$ii:=$ii+1
ta_DévTables{$ii}:="-"
$ii:=$ii+1
ta_DévTables{$ii}:="Menu général"



$ii:=$ii+1
ta_DévTables{$ii}:="-"
$ii:=$ii+1
ta_DévTables{$ii}:="FERMER"

$vl_Fenetre:=i_FenêtreNo(222; 26; -((16*45))-2; "Accès aux listes"; 22; "")
DIALOG:C40([DiaLogues:3]; "DL_TablesListes")
CLOSE WINDOW:C154($vl_Fenetre)
<>PR_DévTables:=0