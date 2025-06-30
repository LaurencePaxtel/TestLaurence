//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 18/02/22, 16:49:19
// ----------------------------------------------------
// Méthode : P_Clé_HG_App
// Description
// 
//
// Paramètres
// ----------------------------------------------------
[HeberGement:5]HG_Nom:21:=va_IDT_Nom
[HeberGement:5]HG_Prénom:22:=va_IDT_Pré
[HeberGement:5]HG_DateNéLe:24:=vd_IDT_NéLe

// Modifié par : Scanu Rémy (18/02/2022)
//[HeberGement]HG_Age:=Uut_HébergéAgePlus (->[HeberGement]HG_DateNéLe;->[HeberGement]HG_DateDuJour)
[HeberGement:5]HG_Age:23:=Uut_HébergéAgePlus(->[HeberGement:5]HG_DateNéLe:24; ->[HeberGement:5]HG_Date:4)