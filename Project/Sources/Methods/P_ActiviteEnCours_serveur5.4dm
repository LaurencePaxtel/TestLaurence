//%attributes = {"executedOnServer":true}
// Method P_ActiviteEnCours_serveur5  
// 


C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1
C_OBJECT:C1216($O_Objet)
$O_Objet:=OB Copy:C1225($P_Objet->)

MultiSoc_Init_On_Server(Count parameters:C259; $2)

C_BOOLEAN:C305($B_Dummy)
$B_Dummy:=P_ActiviteEnCours(0)

C_DATE:C307(D_Date; D_Date2)
D_Date:=OB Get:C1224($O_Objet; "D_Date"; Est une date:K8:7)
D_Date2:=OB Get:C1224($O_Objet; "D_Date2"; Est une date:K8:7)

<>va_T_RefusCHRS:=OB Get:C1224($O_Objet; "<>va_T_RefusCHRS"; Est un texte:K8:3)
<>va_T_RefusDEMANDEUR:=OB Get:C1224($O_Objet; "<>va_T_RefusDEMANDEUR"; Est un texte:K8:3)
rReports:=OB Get:C1224($O_Objet; "rReports"; Est un entier long:K8:6)
OB GET ARRAY:C1229($O_Objet; "tl_ActiviteEtatcivil"; tl_ActiviteEtatcivil)
OB GET ARRAY:C1229($O_Objet; "tl_ActiviteFiches"; tl_ActiviteFiches)
OB GET ARRAY:C1229($O_Objet; "tl_ActivitePersonnes"; tl_ActivitePersonnes)

$B_Dummy:=P_ActiviteEnCours(5)

OB SET:C1220($O_Objet; "<>va_T_RefusCHRS"; <>va_T_RefusCHRS)
OB SET:C1220($O_Objet; "<>va_T_RefusDEMANDEUR"; <>va_T_RefusDEMANDEUR)
OB SET:C1220($O_Objet; "rReports"; rReports)
OB SET ARRAY:C1227($O_Objet; "tl_ActiviteEtatcivil"; tl_ActiviteEtatcivil)
OB SET ARRAY:C1227($O_Objet; "tl_ActiviteFiches"; tl_ActiviteFiches)
OB SET ARRAY:C1227($O_Objet; "tl_ActivitePersonnes"; tl_ActivitePersonnes)

$P_Objet->:=OB Copy:C1225($O_Objet)