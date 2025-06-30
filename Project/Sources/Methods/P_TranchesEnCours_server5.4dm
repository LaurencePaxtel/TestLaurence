//%attributes = {"executedOnServer":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : 
// Date et heure : 15/04/21, 14:32:41
// ----------------------------------------------------
// Méthode : P_TranchesEnCours_server5
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1; $P_Objet)

C_BOOLEAN:C305($B_Dummy)
C_OBJECT:C1216($O_Objet)
C_POINTER:C301($P_Objet)

C_DATE:C307(D_Date; D_Date2)

ARRAY INTEGER:C220(te_xCentre; 0)

ARRAY LONGINT:C221(tl_xCentre; 0)
ARRAY LONGINT:C221(tl_TrancheOK; 0)

$P_Objet:=$1
$O_Objet:=OB Copy:C1225($P_Objet->)

MultiSoc_Init_On_Server(Count parameters:C259; $2)

vl_MoisLigneEtatCivil:=OB Get:C1224($O_Objet; "vl_MoisLigneEtatCivil"; Est un entier long:K8:6)
$B_Dummy:=P_TranchesEnCours(0)

D_Date:=OB Get:C1224($O_Objet; "date"; Est une date:K8:7)
D_Date2:=OB Get:C1224($O_Objet; "date2"; Est une date:K8:7)

OB GET ARRAY:C1229($O_Objet; "ta_TrancheDemande"; ta_TrancheDemande)

// Modifié par : Scanu Rémy - remy@connect-io.fr (15/04/2021) 
ta_TrancheDemande:=$O_Objet.trancheDemande

OB GET ARRAY:C1229($O_Objet; "te_TrancheAfficheDebut"; te_TrancheAfficheDebut)
OB GET ARRAY:C1229($O_Objet; "te_TrancheAfficheFin"; te_TrancheAfficheFin)
OB GET ARRAY:C1229($O_Objet; "te_xCentre"; te_xCentre)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol1"; tl_TrancheCol1)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol10"; tl_TrancheCol10)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol11"; tl_TrancheCol11)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol12"; tl_TrancheCol12)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol2"; tl_TrancheCol2)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol3"; tl_TrancheCol3)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol4"; tl_TrancheCol4)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol5"; tl_TrancheCol5)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol6"; tl_TrancheCol6)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol7"; tl_TrancheCol7)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol8"; tl_TrancheCol8)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol9"; tl_TrancheCol9)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheHGTemp"; tl_TrancheHGTemp)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheOK"; tl_TrancheOK)
OB GET ARRAY:C1229($O_Objet; "tl_TranchePersOld"; tl_TranchePersOld)
OB GET ARRAY:C1229($O_Objet; "tl_xCentre"; tl_xCentre)
vl_TrancheCol1:=OB Get:C1224($O_Objet; "vl_TrancheCol1"; Est un entier long:K8:6)
vl_TrancheCol10:=OB Get:C1224($O_Objet; "vl_TrancheCol10"; Est un entier long:K8:6)
vl_TrancheCol11:=OB Get:C1224($O_Objet; "vl_TrancheCol11"; Est un entier long:K8:6)
vl_TrancheCol12:=OB Get:C1224($O_Objet; "vl_TrancheCol12"; Est un entier long:K8:6)
vl_TrancheCol2:=OB Get:C1224($O_Objet; "vl_TrancheCol2"; Est un entier long:K8:6)
vl_TrancheCol3:=OB Get:C1224($O_Objet; "vl_TrancheCol3"; Est un entier long:K8:6)
vl_TrancheCol4:=OB Get:C1224($O_Objet; "vl_TrancheCol4"; Est un entier long:K8:6)
vl_TrancheCol5:=OB Get:C1224($O_Objet; "vl_TrancheCol5"; Est un entier long:K8:6)
vl_TrancheCol6:=OB Get:C1224($O_Objet; "vl_TrancheCol6"; Est un entier long:K8:6)
vl_TrancheCol7:=OB Get:C1224($O_Objet; "vl_TrancheCol7"; Est un entier long:K8:6)
vl_TrancheCol8:=OB Get:C1224($O_Objet; "vl_TrancheCol8"; Est un entier long:K8:6)
vl_TrancheCol9:=OB Get:C1224($O_Objet; "vl_TrancheCol9"; Est un entier long:K8:6)
vl_TrancheColTotal:=OB Get:C1224($O_Objet; "vl_TrancheColTotal"; Est un entier long:K8:6)
vl_TrancheLigneEtatCivil:=OB Get:C1224($O_Objet; "vl_TrancheLigneEtatCivil"; Est un entier long:K8:6)

$B_Dummy:=P_TranchesEnCours(5)

OB SET ARRAY:C1227($O_Objet; "ta_TrancheDemande"; ta_TrancheDemande)
OB SET ARRAY:C1227($O_Objet; "te_TrancheAfficheDebut"; te_TrancheAfficheDebut)
OB SET ARRAY:C1227($O_Objet; "te_TrancheAfficheFin"; te_TrancheAfficheFin)
OB SET ARRAY:C1227($O_Objet; "te_xCentre"; te_xCentre)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol1"; tl_TrancheCol1)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol10"; tl_TrancheCol10)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol11"; tl_TrancheCol11)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol12"; tl_TrancheCol12)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol2"; tl_TrancheCol2)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol3"; tl_TrancheCol3)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol4"; tl_TrancheCol4)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol5"; tl_TrancheCol5)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol6"; tl_TrancheCol6)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol7"; tl_TrancheCol7)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol8"; tl_TrancheCol8)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol9"; tl_TrancheCol9)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheHGTemp"; tl_TrancheHGTemp)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheOK"; tl_TrancheOK)
OB SET ARRAY:C1227($O_Objet; "tl_TranchePersOld"; tl_TranchePersOld)
OB SET ARRAY:C1227($O_Objet; "tl_xCentre"; tl_xCentre)
OB SET:C1220($O_Objet; "vl_TrancheCol1"; vl_TrancheCol1)
OB SET:C1220($O_Objet; "vl_TrancheCol10"; vl_TrancheCol10)
OB SET:C1220($O_Objet; "vl_TrancheCol11"; vl_TrancheCol11)
OB SET:C1220($O_Objet; "vl_TrancheCol12"; vl_TrancheCol12)
OB SET:C1220($O_Objet; "vl_TrancheCol2"; vl_TrancheCol2)
OB SET:C1220($O_Objet; "vl_TrancheCol3"; vl_TrancheCol3)
OB SET:C1220($O_Objet; "vl_TrancheCol4"; vl_TrancheCol4)
OB SET:C1220($O_Objet; "vl_TrancheCol5"; vl_TrancheCol5)
OB SET:C1220($O_Objet; "vl_TrancheCol6"; vl_TrancheCol6)
OB SET:C1220($O_Objet; "vl_TrancheCol7"; vl_TrancheCol7)
OB SET:C1220($O_Objet; "vl_TrancheCol8"; vl_TrancheCol8)
OB SET:C1220($O_Objet; "vl_TrancheCol9"; vl_TrancheCol9)
OB SET:C1220($O_Objet; "vl_TrancheColTotal"; vl_TrancheColTotal)
OB SET:C1220($O_Objet; "vl_TrancheLigneEtatCivil"; vl_TrancheLigneEtatCivil)

$P_Objet->:=OB Copy:C1225($O_Objet)