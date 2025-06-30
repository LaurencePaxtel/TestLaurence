//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 31/10/19, 13:30:26
// ----------------------------------------------------
// Method: Web_HB_Fiche_Init
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284(va_JourNuit)
C_BOOLEAN:C305(vb_T_ModeCHRS)

va_JourNuit:=$1

//Accès_User

V_HG_Dec(0)
V_HG_Dec(1)

V_IDT_Déc(0)
V_IDT_Déc(1)

P_VariablesTransiteInit(0)
P_VariablesTransiteInit(1)

// Modifié par : Scanu Rémy (25/09/2023)
//Web_Genere_Variable_Process(-><>va_UserPlateforme)
vb_T_ModeCHRS:=True:C214
vb_MaxFichesHG:=True:C214

// vl_Num_HBE:=Uut_Numerote115($vb_Date)  //?????(*))  `Uut_NumeroteMensuel 
vl_RéfU_HG:=Uut_Numerote(->[HeberGement:5])

//********************************************
If (Web_F_HébergementCtrlCréation(va_JourNuit))
	
	If (vl_NbHéberGements>0)
		F_VariablesTransite(2; 1; True:C214)
	Else 
		F_VariablesTransite(3; 1; False:C215)
	End if 
	
	x_IDTG_1:=rIDTG_1
	x_IDTG_2:=rIDTG_2
Else 
	vb_PasseR:=False:C215
End if 

CREATE RECORD:C68([HeberGement:5])
MultiSoc_Init_Structure(->[HeberGement:5])

//**************************************************

P_HébergementNo(va_JourNuit)  // Numérotation et affectation de la fiche d'hébergement
P_HébergementNoRéf

If (F_VariablesTransite(4; 1; False:C215))  // Affectation des champs (dans le cas d'un nouvel hébegement avec historique)
	F_VariablesTransite(6; 0; False:C215)
End if 

If ((Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "ASILE").length=1))
	[HeberGement:5]HG_FamCompoVar:117:=""
	//P_HG_Famille(0)
	//P_HG_FamilleChef(0)
Else 
	[HeberGement:5]HG_FamGroupe:102:=Storage:C1525.dispositif.HG_ASPasFamGroupe  //"115"  
End if 

If (vb_T_ModeCHRS)  // • Base CHRS
	[HeberGement:5]HG_Plateforme:139:=va_UserPlateforme
	
	If (Length:C16(va_UserPlateforme)>3)
		va_CtrLib:=Substring:C12(va_UserPlateforme; 1; 4)
	Else 
		va_CtrLib:=va_UserPlateforme
	End if 
	
	F_Report_FullPlateforme(->[HeberGement:5]HG_Trans_DDASS:141; [HeberGement:5]HG_Plateforme:139)
End if 

[HeberGement:5]HG_ReferenceID:1:=Uut_Numerote(->[HeberGement:5])

If (va_JourNuit="N")
	[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("N"; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
Else 
	[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("J"; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
End if 

[HeberGement:5]HG_DateNéLe:24:=[HeBerge:4]HB_DateNéLe:5
[HeberGement:5]HG_DateCreationFiche:149:=Current date:C33(*)
[HeberGement:5]HG_Nom:21:=[HeBerge:4]HB_Nom:3
[HeberGement:5]HG_Prénom:22:=[HeBerge:4]HB_Prénom:4