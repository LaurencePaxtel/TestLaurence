//%attributes = {"executedOnServer":true}
// Method P_FluxEnCours_serveur5  


C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1
C_OBJECT:C1216($O_Objet)
$O_Objet:=OB Copy:C1225($P_Objet->)

MultiSoc_Init_On_Server(Count parameters:C259; $2)

ARRAY INTEGER:C220(te_xCentre; 0)
ARRAY LONGINT:C221(tl_xCentre; 0)

vl_MoisLigneEtatCivil:=OB Get:C1224($O_Objet; "vl_MoisLigneEtatCivil"; Est un entier long:K8:6)

C_BOOLEAN:C305($B_Dummy)
$B_Dummy:=P_FluxEnCours(0)

C_DATE:C307(D_Date; D_Date2)
D_Date:=OB Get:C1224($O_Objet; "date"; Est une date:K8:7)
D_Date2:=OB Get:C1224($O_Objet; "date2"; Est une date:K8:7)

OB GET ARRAY:C1229($O_Objet; "te_xCentre"; te_xCentre)
OB GET ARRAY:C1229($O_Objet; "tl_xCentre"; tl_xCentre)
OB GET ARRAY:C1229($O_Objet; "tl_FluxFirst"; tl_FluxFirst)
OB GET ARRAY:C1229($O_Objet; "tl_FluxFirstP"; tl_FluxFirstP)
OB GET ARRAY:C1229($O_Objet; "tl_FluxFirstP_1"; tl_FluxFirstP_1)
OB GET ARRAY:C1229($O_Objet; "tl_FluxFirstP_2"; tl_FluxFirstP_2)
OB GET ARRAY:C1229($O_Objet; "tl_FluxFirstP_3"; tl_FluxFirstP_3)
OB GET ARRAY:C1229($O_Objet; "tl_FluxFirstP_4"; tl_FluxFirstP_4)
OB GET ARRAY:C1229($O_Objet; "tl_FluxIn"; tl_FluxIn)
OB GET ARRAY:C1229($O_Objet; "tl_FluxInP"; tl_FluxInP)
OB GET ARRAY:C1229($O_Objet; "tl_FluxInP_1"; tl_FluxInP_1)
OB GET ARRAY:C1229($O_Objet; "tl_FluxInP_2"; tl_FluxInP_2)
OB GET ARRAY:C1229($O_Objet; "tl_FluxInP_3"; tl_FluxInP_3)
OB GET ARRAY:C1229($O_Objet; "tl_FluxLast"; tl_FluxLast)
OB GET ARRAY:C1229($O_Objet; "tl_FluxLastP"; tl_FluxLastP)
OB GET ARRAY:C1229($O_Objet; "tl_FluxLastP_1"; tl_FluxLastP_1)
OB GET ARRAY:C1229($O_Objet; "tl_FluxLastP_2"; tl_FluxLastP_2)
OB GET ARRAY:C1229($O_Objet; "tl_FluxLastP_3"; tl_FluxLastP_3)
OB GET ARRAY:C1229($O_Objet; "tl_FluxLastP_4"; tl_FluxLastP_4)
OB GET ARRAY:C1229($O_Objet; "tl_FluxOut"; tl_FluxOut)
OB GET ARRAY:C1229($O_Objet; "tl_FluxOutN"; tl_FluxOutN)
OB GET ARRAY:C1229($O_Objet; "tl_FluxOutN_1"; tl_FluxOutN_1)
OB GET ARRAY:C1229($O_Objet; "tl_FluxOutN_2"; tl_FluxOutN_2)
OB GET ARRAY:C1229($O_Objet; "tl_FluxOutN_3"; tl_FluxOutN_3)
OB GET ARRAY:C1229($O_Objet; "tl_FluxOutN_4"; tl_FluxOutN_4)
OB GET ARRAY:C1229($O_Objet; "tl_FluxOutP"; tl_FluxOutP)
OB GET ARRAY:C1229($O_Objet; "tl_FluxOutP_1"; tl_FluxOutP_1)
OB GET ARRAY:C1229($O_Objet; "tl_FluxOutP_2"; tl_FluxOutP_2)
OB GET ARRAY:C1229($O_Objet; "tl_FluxOutP_3"; tl_FluxOutP_3)
OB GET ARRAY:C1229($O_Objet; "tl_FluxOutP_4"; tl_FluxOutP_4)
vl_FluxFirst:=OB Get:C1224($O_Objet; "vl_FluxFirst"; Est un entier long:K8:6)
vl_FluxFirstP:=OB Get:C1224($O_Objet; "vl_FluxFirstP"; Est un entier long:K8:6)
vl_FluxIn:=OB Get:C1224($O_Objet; "vl_FluxIn"; Est un entier long:K8:6)
vl_FluxInP:=OB Get:C1224($O_Objet; "vl_FluxInP"; Est un entier long:K8:6)
vl_FluxLast:=OB Get:C1224($O_Objet; "vl_FluxLast"; Est un entier long:K8:6)
vl_FluxLastP:=OB Get:C1224($O_Objet; "vl_FluxLastP"; Est un entier long:K8:6)
vl_FluxOut:=OB Get:C1224($O_Objet; "vl_FluxOut"; Est un entier long:K8:6)
vl_FluxOutN:=OB Get:C1224($O_Objet; "vl_FluxOutN"; Est un entier long:K8:6)
vl_FluxOutP:=OB Get:C1224($O_Objet; "vl_FluxOutP"; Est un entier long:K8:6)
vl_TrancheLigneEtatCivil:=OB Get:C1224($O_Objet; "vl_TrancheLigneEtatCivil"; Est un entier long:K8:6)


$B_Dummy:=P_FluxEnCours(5)


OB SET ARRAY:C1227($O_Objet; "te_xCentre"; te_xCentre)
OB SET ARRAY:C1227($O_Objet; "tl_xCentre"; tl_xCentre)
OB SET ARRAY:C1227($O_Objet; "tl_FluxFirst"; tl_FluxFirst)
OB SET ARRAY:C1227($O_Objet; "tl_FluxFirstP"; tl_FluxFirstP)
OB SET ARRAY:C1227($O_Objet; "tl_FluxFirstP_1"; tl_FluxFirstP_1)
OB SET ARRAY:C1227($O_Objet; "tl_FluxFirstP_2"; tl_FluxFirstP_2)
OB SET ARRAY:C1227($O_Objet; "tl_FluxFirstP_3"; tl_FluxFirstP_3)
OB SET ARRAY:C1227($O_Objet; "tl_FluxFirstP_4"; tl_FluxFirstP_4)
OB SET ARRAY:C1227($O_Objet; "tl_FluxIn"; tl_FluxIn)
OB SET ARRAY:C1227($O_Objet; "tl_FluxInP"; tl_FluxInP)
OB SET ARRAY:C1227($O_Objet; "tl_FluxInP_1"; tl_FluxInP_1)
OB SET ARRAY:C1227($O_Objet; "tl_FluxInP_2"; tl_FluxInP_2)
OB SET ARRAY:C1227($O_Objet; "tl_FluxInP_3"; tl_FluxInP_3)
OB SET ARRAY:C1227($O_Objet; "tl_FluxLast"; tl_FluxLast)
OB SET ARRAY:C1227($O_Objet; "tl_FluxLastP"; tl_FluxLastP)
OB SET ARRAY:C1227($O_Objet; "tl_FluxLastP_1"; tl_FluxLastP_1)
OB SET ARRAY:C1227($O_Objet; "tl_FluxLastP_2"; tl_FluxLastP_2)
OB SET ARRAY:C1227($O_Objet; "tl_FluxLastP_3"; tl_FluxLastP_3)
OB SET ARRAY:C1227($O_Objet; "tl_FluxLastP_4"; tl_FluxLastP_4)
OB SET ARRAY:C1227($O_Objet; "tl_FluxOut"; tl_FluxOut)
OB SET ARRAY:C1227($O_Objet; "tl_FluxOutN"; tl_FluxOutN)
OB SET ARRAY:C1227($O_Objet; "tl_FluxOutN_1"; tl_FluxOutN_1)
OB SET ARRAY:C1227($O_Objet; "tl_FluxOutN_2"; tl_FluxOutN_2)
OB SET ARRAY:C1227($O_Objet; "tl_FluxOutN_3"; tl_FluxOutN_3)
OB SET ARRAY:C1227($O_Objet; "tl_FluxOutN_4"; tl_FluxOutN_4)
OB SET ARRAY:C1227($O_Objet; "tl_FluxOutP"; tl_FluxOutP)
OB SET ARRAY:C1227($O_Objet; "tl_FluxOutP_1"; tl_FluxOutP_1)
OB SET ARRAY:C1227($O_Objet; "tl_FluxOutP_2"; tl_FluxOutP_2)
OB SET ARRAY:C1227($O_Objet; "tl_FluxOutP_3"; tl_FluxOutP_3)
OB SET ARRAY:C1227($O_Objet; "tl_FluxOutP_4"; tl_FluxOutP_4)
OB SET:C1220($O_Objet; "vl_FluxFirst"; vl_FluxFirst)
OB SET:C1220($O_Objet; "vl_FluxFirstP"; vl_FluxFirstP)
OB SET:C1220($O_Objet; "vl_FluxIn"; vl_FluxIn)
OB SET:C1220($O_Objet; "vl_FluxInP"; vl_FluxInP)
OB SET:C1220($O_Objet; "vl_FluxLast"; vl_FluxLast)
OB SET:C1220($O_Objet; "vl_FluxLastP"; vl_FluxLastP)
OB SET:C1220($O_Objet; "vl_FluxOut"; vl_FluxOut)
OB SET:C1220($O_Objet; "vl_FluxOutN"; vl_FluxOutN)
OB SET:C1220($O_Objet; "vl_FluxOutP"; vl_FluxOutP)
OB SET:C1220($O_Objet; "vl_TrancheLigneEtatCivil"; vl_TrancheLigneEtatCivil)

$P_Objet->:=OB Copy:C1225($O_Objet)

