//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Tab_PopIn2
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)  //Ptr Nom de la table 
C_POINTER:C301($2)  //Ptr Critère unique de la table 
C_POINTER:C301($3)  //Ptr Tableau
C_POINTER:C301($4)  //Ptr Variable 1 à alimenter en retour
C_POINTER:C301($5)  //Ptr Variable 2 à alimenter en retour
C_POINTER:C301($6)  //Ptr Variable de tri ou hiérarchie

C_LONGINT:C283($vl_Fenetre)

If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	$4->:=""
	$5->:=""
Else 
	C_TEXT:C284(vaT2_L)
	C_POINTER:C301(vPtrT2_R)
	C_POINTER:C301(vPtrT2_Tab)
	C_POINTER:C301(vPtrT2_Var1)
	C_POINTER:C301(vPtrT2_Var2)
	C_POINTER:C301(vPtrT2_Tri)
	
	vaT2_L:=$1
	vPtrT2_R:=$2
	vPtrT2_Tab:=$3
	vPtrT2_Var1:=$4
	vPtrT2_Var2:=$5
	vPtrT2_Tri:=$6
	
	ARRAY TEXT:C222(t_TabNiv1; 0)
	ARRAY TEXT:C222(t_TabNiv2; 0)
	
	COPY ARRAY:C226(vPtrT2_Tab->; t_TabNiv1)
	
	$vl_Fenetre:=i_FenêtreNo(558; 412; 5; vaT2_L; 4; "")
	DIALOG:C40([DiaLogues:3]; "DL_TablesN2")
	
	CLOSE WINDOW:C154($vl_Fenetre)
	
	If (OK=1)
		$4->:=vPtrT2_Var1->
		$5->:=vPtrT2_Var2->
		
		va_Ptr_Var1:=vPtrT2_Var1->
		va_Ptr_Var2:=vPtrT2_Var2->
	End if 
	
End if 