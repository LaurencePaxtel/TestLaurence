//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 22/11/18, 14:40:02
// ----------------------------------------------------
// Méthode : Web_Fam_Set_Composition
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)

C_POINTER:C301($O_Data)

C_LONGINT:C283(ve_FamH; ve_FamF; ve_FamFe; ve_FamEMi; ve_FamEMa; ve_FamPMi; ve_FamPMa)

$O_Data:=$1

ve_FamH:=Num:C11(OB Get:C1224($O_Data->; "ve_famh"; Est un texte:K8:3))
ve_FamF:=Num:C11(OB Get:C1224($O_Data->; "ve_famf"; Est un texte:K8:3))
ve_FamFe:=Num:C11(OB Get:C1224($O_Data->; "ve_famfe"; Est un texte:K8:3))
ve_FamEMi:=Num:C11(OB Get:C1224($O_Data->; "ve_famemi"; Est un texte:K8:3))
ve_FamEMa:=Num:C11(OB Get:C1224($O_Data->; "ve_famema"; Est un texte:K8:3))
ve_FamPMi:=Num:C11(OB Get:C1224($O_Data->; "ve_fampmi"; Est un texte:K8:3))
ve_FamPMa:=Num:C11(OB Get:C1224($O_Data->; "ve_fampma"; Est un texte:K8:3))

Web_Gere_Famille_Composition("set")