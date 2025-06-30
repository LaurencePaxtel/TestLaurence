//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 22/11/18, 14:09:24
// ----------------------------------------------------
// Méthode : Web_Gere_Famille_Composition
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($type_t)

C_LONGINT:C283(ve_FamH; ve_FamF; ve_FamFe; ve_FamEMi; ve_FamEMa; ve_FamPMi; ve_FamPMa)

$type_t:=$1

Case of 
	: ($type_t="get")
		ve_FamH:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 2; 1))
		ve_FamF:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 4; 1))
		ve_FamFe:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 6; 1))
		ve_FamEMi:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 8; 2))
		ve_FamEMa:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 11; 2))
		ve_FamPMi:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 14; 1))
		ve_FamPMa:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 16; 1))
	: ($type_t="set")
		[HeberGement:5]HG_FamCompoVar:117:=""
		[HeberGement:5]HG_FamCompoVar:117:="H"+String:C10(ve_FamH)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"F"+String:C10(ve_FamF)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"B"+String:C10(ve_FamFe)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"e"+String:C10(ve_FamEMi; "00")
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"E"+String:C10(ve_FamEMa; "00")
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"p"+String:C10(ve_FamPMi)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"P"+String:C10(ve_FamPMa)
End case 