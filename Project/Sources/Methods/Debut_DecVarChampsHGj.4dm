//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 29/12/22, 15:26:48
// ----------------------------------------------------
// Méthode : Debut_DecVarChampsHGj
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($ii)

READ WRITE:C146([LesRubriques:21])

For ($ii; $2; $3)
	
	If (($ii>=$2) & ($ii<=$3))
		CREATE RECORD:C68([LesRubriques:21])
		MultiSoc_Init_Structure(->[LesRubriques:21])
		
		[LesRubriques:21]NuméroTri:1:=$ii
		[LesRubriques:21]RubOrdreSaisie:14:=$ii
		[LesRubriques:21]RubFichier:3:=Table:C252(->[HeberGement:5])
		
		[LesRubriques:21]RubNoSTR:12:=$1
		
		Case of 
			: (($ii>61) & ($ii<77))
				[LesRubriques:21]RubVisible:8:=False:C215
				[LesRubriques:21]RubSaississable:5:=False:C215
				[LesRubriques:21]RubPopVisible:9:=False:C215
				[LesRubriques:21]RubModifiable:10:=False:C215
				[LesRubriques:21]RubDéveloppeur:11:=False:C215
			: (($ii>102) & ($ii<=115))
				[LesRubriques:21]RubSaississable:5:=False:C215
				[LesRubriques:21]RubObligatoire:6:=False:C215
				[LesRubriques:21]RubVisible:8:=False:C215
				[LesRubriques:21]RubPopVisible:9:=False:C215
				[LesRubriques:21]RubModifiable:10:=False:C215
				[LesRubriques:21]RubDéveloppeur:11:=True:C214
			: (($ii>117) & ($ii<=124))
				[LesRubriques:21]RubSaississable:5:=True:C214
				[LesRubriques:21]RubObligatoire:6:=False:C215
				[LesRubriques:21]RubVisible:8:=True:C214
				[LesRubriques:21]RubPopVisible:9:=False:C215
				[LesRubriques:21]RubModifiable:10:=True:C214
				[LesRubriques:21]RubDéveloppeur:11:=False:C215
			: ($ii=130)
				[LesRubriques:21]RubSaississable:5:=False:C215
				[LesRubriques:21]RubObligatoire:6:=False:C215
				[LesRubriques:21]RubVisible:8:=True:C214
				[LesRubriques:21]RubPopVisible:9:=False:C215
				[LesRubriques:21]RubModifiable:10:=False:C215
				[LesRubriques:21]RubDéveloppeur:11:=False:C215
			: ($ii=131)  // #HPOP2017
				[LesRubriques:21]RubSaississable:5:=False:C215
				[LesRubriques:21]RubObligatoire:6:=False:C215
				[LesRubriques:21]RubVisible:8:=True:C214
				[LesRubriques:21]RubPopVisible:9:=False:C215
				[LesRubriques:21]RubModifiable:10:=False:C215
				[LesRubriques:21]RubDéveloppeur:11:=False:C215
			: ($ii=132)
				// Modifié par : Scanu Rémy (23/02/2023)
				[LesRubriques:21]RubSaississable:5:=True:C214
				[LesRubriques:21]RubObligatoire:6:=False:C215
				[LesRubriques:21]RubVisible:8:=True:C214
				[LesRubriques:21]RubPopVisible:9:=False:C215
				[LesRubriques:21]RubModifiable:10:=False:C215
				[LesRubriques:21]RubDéveloppeur:11:=False:C215
			: ($ii=133)
				// Modifié par : LPC (05/12/2023)
				[LesRubriques:21]RubSaississable:5:=True:C214
				[LesRubriques:21]RubObligatoire:6:=False:C215
				[LesRubriques:21]RubVisible:8:=True:C214
				[LesRubriques:21]RubPopVisible:9:=False:C215
				[LesRubriques:21]RubModifiable:10:=False:C215
				[LesRubriques:21]RubDéveloppeur:11:=False:C215
			Else 
				[LesRubriques:21]RubSaississable:5:=True:C214
				[LesRubriques:21]RubObligatoire:6:=False:C215
				[LesRubriques:21]RubVisible:8:=True:C214
				[LesRubriques:21]RubPopVisible:9:=False:C215
				[LesRubriques:21]RubModifiable:10:=True:C214
				[LesRubriques:21]RubDéveloppeur:11:=False:C215
		End case 
		
		If ($ii<=100)
			Debut_DecVarChampsHGj100($ii)
		Else 
			Debut_DecVarChampsHGj200($ii)
		End if 
		
	End if 
	
	If (($ii>=$2) & ($ii<=$3))
		SAVE RECORD:C53([LesRubriques:21])
		UNLOAD RECORD:C212([LesRubriques:21])
	End if 
	
End for 

READ ONLY:C145([LesRubriques:21])