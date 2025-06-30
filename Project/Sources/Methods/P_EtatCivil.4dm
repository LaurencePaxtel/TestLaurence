//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 27/02/23, 17:22:25
// ----------------------------------------------------
// Méthode : P_EtatCivil
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($vl_Position)

Case of 
	: ($1="Sexe_rIDTG_1")
		rIDTG_1:=1
		rIDTG_2:=0
		
		$vl_Position:=Position:C15("("; $2)
		
		If ($vl_Position>0)
			
			If (Substring:C12($2; $vl_Position+1; 1)="F")
				rIDTG_1:=0
				rIDTG_2:=1
			End if 
			
		End if 
		
	: ($1="Sexe_HG_Genre")
		[HeberGement:5]HG_Genre:96:=False:C215
		$vl_Position:=Position:C15("("; $2)
		
		If ($vl_Position>0)
			
			If (Substring:C12($2; $vl_Position+1; 1)="F")
				[HeberGement:5]HG_Genre:96:=True:C214
			End if 
			
		End if 
		
End case 