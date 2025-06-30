//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplexFichier
//{
//{          Vendrdi 24 octobre 2008 à 16:11
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
$0:=True:C214
C_POINTER:C301($1)  //Pointeur sur le nom du document
C_DATE:C307($2)
C_TIME:C306($3)
C_TEXT:C284($4)  //Code du 
C_TEXT:C284($5)  //Fiche n°
C_TEXT:C284($6)  //Etat civil
C_LONGINT:C283($7)  //Age

C_TEXT:C284($va_Temp)
C_LONGINT:C283($vl_Position)

//••• Formatage de l'heure courante
$va_Temp:=String:C10($3; h mn s:K7:1)
$va_Temp:=Replace string:C233($va_Temp; ":"; "")
If (Length:C16($va_Temp)>=6)
Else 
	$va_Temp:=("0"*(6-Length:C16($va_Temp)))+$va_Temp
End if 
$va_Temp:=Substring:C12($va_Temp; 1; 2)+"h"+Substring:C12($va_Temp; 3; 2)

//••• Titre du fichier sur disque
//• 3 c : Code du Site
//• 6 c : AAMMJJ
//• 5 c : HHhMM
//• 1 c : J(our) N(uit)
//• 5 c : 00000 numéro de la fiche
//• 2 c : Code Etat civil
//• 2 c : 00 âge

$1->:=$4+(" "*(3-Length:C16($4)))
$1->:=$1->+Substring:C12(String:C10(Year of:C25($2); "0000"); 3; 2)+String:C10(Month of:C24($2); "00")+String:C10(Day of:C23($2); "00")
$1->:=$1->+$va_Temp
$1->:=$1->+Substring:C12($5; 1; 1)+Substring:C12($5; 7)

If (7=8)  //12/01/2012
	$1->:=$1->+" "+Substring:C12($6; (Length:C16($6)-2); 2)
Else 
	$vl_Position:=Position:C15("("; $6)
	If ($vl_Position>0)
		$1->:=$1->+" "+Substring:C12($6; ($vl_Position+1); 2)
	Else 
		$1->:=$1->+" "+"XX"
	End if 
End if 


If ($7>99)
	$1->:=$1->+"99"
Else 
	$1->:=$1->+String:C10($7; "00")
End if 