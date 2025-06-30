//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Tab_PopUser
//{
//{          Mardi 12 avril 2011 à 10:15
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)  //Ptr Nom de la table 
C_POINTER:C301($2)  //Ptr Tableau 1
C_POINTER:C301($3)  //Ptr Variable 1 à alimenter en retour

C_POINTER:C301($4)  //Ptr Tableau 2
C_POINTER:C301($5)  //Ptr Variable 2 à alimenter en retour

If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	$3->:=""
	$5->:=0
Else 
	C_TEXT:C284(vaTab1NomL)
	C_POINTER:C301(vPtrT2_Tab)
	C_POINTER:C301(vPtrT2_Var1)
	
	vaTab1NomL:=$1
	vPtrT2_Tab:=$2
	vPtrT2_Var1:=$3
	
	ARRAY TEXT:C222(t_TabNiv1; 0)
	
	COPY ARRAY:C226(vPtrT2_Tab->; t_TabNiv1)
	
	
	vb_Valider1:=False:C215
	SORT ARRAY:C229(t_TabNiv1; >)
	$vl_Fenetre:=i_FenêtreNo(356; 412; 5; $1; 3; "")
	DIALOG:C40([DiaLogues:3]; "DL_TablesN1")
	CLOSE WINDOW:C154($vl_Fenetre)
	If (OK=1)
		$3->:=t_TabNiv1{t_TabNiv1}
		$5->:=$4->{t_TabNiv1}
	End if 
End if 