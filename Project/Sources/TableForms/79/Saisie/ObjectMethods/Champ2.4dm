// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 06/11/18, 05:49:49
// ----------------------------------------------------
// Méthode : [Structures].Saisie.Champ2
// Description
// 
//
// Paramètres
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		If (([Structures:79]Ref_Structure:3#"") & ([Structures:79]Ref_Structure:3#"TMP"))
			OBJECT SET ENTERABLE:C238(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=Sur données modifiées:K2:15)
		[Structures:79]Ref_Structure:3:=Self:C308->
End case 
