//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_SIAOFicheSurDisqueFichier
//{          Jeudi 12 mai 2011 à 17:31
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
$0:=True:C214
C_POINTER:C301($1)  //Pointeur sur le nom du document
C_DATE:C307($2)
C_TIME:C306($3)
C_TEXT:C284($4)  //Fiche n°
C_LONGINT:C283($5)  //Type
C_TEXT:C284($va_Temp)

//••• Formatage de l'heure courante
$va_Temp:=String:C10($3; h mn s:K7:1)
$va_Temp:=Replace string:C233($va_Temp; ":"; "")
If (Length:C16($va_Temp)>=6)
Else 
	$va_Temp:=("0"*(6-Length:C16($va_Temp)))+$va_Temp
End if 
$va_Temp:=Substring:C12($va_Temp; 1; 2)+"h"+Substring:C12($va_Temp; 3; 2)

//••• Titre du fichier sur disque
//• 6 c : AAMMJJ
//• 5 c : HHhMM
//• 13 c : 00000 numéro de la fiche

$1->:=Substring:C12(String:C10(Year of:C25($2); "0000"); 3; 2)+String:C10(Month of:C24($2); "00")+String:C10(Day of:C23($2); "00")
$1->:=$1->+$va_Temp
$1->:=$1->+$4
$1->:=$1->+("i"*Num:C11($5=1))+("u"*Num:C11($5=0))