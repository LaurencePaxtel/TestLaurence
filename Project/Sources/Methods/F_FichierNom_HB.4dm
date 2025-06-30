//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Fonction : F_FichierNom_HB
//{          Vendrdi 28 janvier 2011 à 14:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
$0:=""

C_DATE:C307($1)
C_TIME:C306($2)
C_TEXT:C284($3)  //Code du 
C_TEXT:C284($4)  //Fiche n°
C_TEXT:C284($5)  //Etat civil
C_LONGINT:C283($6)  //Age

C_TEXT:C284($va_Temp)
C_LONGINT:C283($vl_Position)

//••• Formatage de l'heure courante
$va_Temp:=String:C10($2; h mn s:K7:1)
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

$0:=$3+(" "*(3-Length:C16($3)))
$0:=$0+Substring:C12(String:C10(Year of:C25($1); "0000"); 3; 2)+String:C10(Month of:C24($1); "00")+String:C10(Day of:C23($1); "00")
$0:=$0+$va_Temp
$0:=$0+Substring:C12($4; 1; 1)+Substring:C12($4; 7)


If (7=8)  //02/03/2012
	$0:=$0+" "+Substring:C12($5; (Length:C16($5)-2); 2)
Else 
	$vl_Position:=Position:C15("("; $5)
	If ($vl_Position>0)
		$0:=$0+" "+Substring:C12($5; ($vl_Position+1); 2)
	Else 
		$0:=$0+" "+"XX"
	End if 
End if 


If ($6>99)
	$0:=$0+"99"
Else 
	$0:=$0+String:C10($6; "00")
End if 