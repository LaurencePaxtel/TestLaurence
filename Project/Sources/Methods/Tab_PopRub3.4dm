//%attributes = {}
//Procédure : Uut_PopRub3
C_POINTER:C301($1)  //Ptr Rub : N° Fiche
C_TEXT:C284($2)  //Alpha Nom de la table 
C_POINTER:C301($3)  //Ptr Rub : La rubrique 1_1
C_POINTER:C301($4)  //Ptr Rub : La rubrique 1_2
C_POINTER:C301($5)  //Ptr Rub : La rubrique 2_1
C_POINTER:C301($6)  //Ptr Rub : La rubrique 2_2
C_POINTER:C301($7)  //Ptr Rub : La rubrique 3_1
C_POINTER:C301($8)  //Ptr Rub : La rubrique 3_2

C_POINTER:C301(vPtrT1_No)
C_TEXT:C284(vaPtrT1_L)
C_TEXT:C284(va_Lib_1_1)
C_TEXT:C284(va_Lib_1_2)
C_TEXT:C284(va_Lib_2_1)
C_TEXT:C284(va_Lib_2_2)
C_TEXT:C284(va_Lib_3_1)
C_TEXT:C284(va_Lib_3_2)
vPtrT1_No:=$1
vaPtrT1_L:=$2
va_Lib_1_1:=$3->
va_Lib_1_2:=$4->
va_Lib_2_1:=$5->
va_Lib_2_2:=$6->
va_Lib_3_1:=$7->
va_Lib_3_2:=$8->
va_Titre:="Fiche n° "+vPtrT1_No->
FORM SET INPUT:C55([DiaLogues:3]; "DL_TablesR3")

C_LONGINT:C283($vl_Fenetre)
$vl_Fenetre:=i_FenêtreNo(512; 134; 5; vaPtrT1_L; 4; "")
ADD RECORD:C56([DiaLogues:3]; *)
CLOSE WINDOW:C154($vl_Fenetre)
