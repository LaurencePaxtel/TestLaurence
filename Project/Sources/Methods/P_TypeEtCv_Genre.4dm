//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_TypeEtCv_Genre
//{
//{          Lundi 17 janvier 2011 à 16:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_LONGINT:C283($ii)

$2->:=1
$3->:=0
If ($1>"")
	$ii:=Position:C15("("; $1)
	If ($ii>0)
		$ii:=$ii+1
		$2->:=Num:C11($1[[$ii]]#"F")
		$3->:=Num:C11($1[[$ii]]="F")
	End if 
	If (7=8)
		$2->:=Num:C11(Substring:C12($1; Length:C16($1)-2; 1)#"F")
		$3->:=Num:C11(Substring:C12($1; Length:C16($1)-2; 1)="F")
	End if 
End if 