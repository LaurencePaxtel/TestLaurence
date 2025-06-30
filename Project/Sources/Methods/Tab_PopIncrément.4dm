//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Tab_PopIncrément
//{
//{          Vendredi 8 octobre 2004 à 12:2751:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TEXT:C284($1)  //Ptr Nom de la table 
C_POINTER:C301($2)  //Ptr Tableau
C_POINTER:C301($3)  //Ptr Variable 1 à alimenter en retour
If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	$3->:=""
Else 
	
	C_TEXT:C284(vaTab1NomL)
	C_POINTER:C301(vPtrT2_Tab)
	C_POINTER:C301(vPtrT2_Var1)
	
	vaTab1NomL:=$1
	vPtrT2_Tab:=$2
	vPtrT2_Var1:=$3
	ARRAY TEXT:C222(t_TabNiv1; 0)
	COPY ARRAY:C226(vPtrT2_Tab->; t_TabNiv1)
	
	If (Size of array:C274(t_TabNiv1)>0)
		If ($3->>"")
			$Pos:=Find in array:C230(t_TabNiv1; $3->)
			If ($Pos>0)
				If ($Pos<Size of array:C274(t_TabNiv1))
					$3->:=t_TabNiv1{$Pos+1}
				End if 
			End if 
		Else 
			$3->:=t_TabNiv1{1}
		End if 
	End if 
	
End if 