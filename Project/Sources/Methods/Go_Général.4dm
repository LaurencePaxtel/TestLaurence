//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 16/12/21, 15:20:25
// ----------------------------------------------------
// Méthode : Go_Général
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($ii)

ARRAY TEXT:C222(<>ta_FMGrpX; 0)
ARRAY INTEGER:C220(<>te_FMGrpCK; Size of array:C274(<>ta_FMGrp))
ARRAY INTEGER:C220(<>te_InPermCK; Size of array:C274(<>ta_InPerm))

READ ONLY:C145(*)
SET MENU BAR:C67(1)

CLEAR VARIABLE:C89(<>V_FicheNAct)

COPY ARRAY:C226(<>ta_FMGrp; <>ta_FMGrpX)

For ($ii; 1; Size of array:C274(<>ta_FMGrpX))
	<>te_FMGrpCK{$ii}:=0
End for 

For ($ii; 1; Size of array:C274(<>ta_InPerm))
	<>te_InPermCK{$ii}:=0
End for 

If (<>vb_UserLOFT)
	
	For ($ii; 1; Size of array:C274(<>ta_InPerm))
		QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Login:3=<>ta_InPerm{$ii})
		MultiSoc_Filter(->[INtervenants:10])
		
		If (Records in selection:C76([INtervenants:10])=1)
			
			If ([INtervenants:10]IN_LOFT:10)
				<>te_InPermCK{$ii}:=1
			End if 
			
		End if 
		
	End for 
	
End if 

DébutBtMenu(1)
NAV_Lancement_Navigateur("DL_Départ")

CLEAR VARIABLE:C89(<>PR_Genéral)