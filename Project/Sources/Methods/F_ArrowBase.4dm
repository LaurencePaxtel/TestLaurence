//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : F_ArrowBase
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

Case of 
	: ($1=0)
		If ($2>"")
			If (Character code:C91($2[[Length:C16($2)]])=Character code:C91("@"))
			Else 
				$2:=$2+"@"
			End if 
		End if 
	: ($1=1)
	: ($1=2)
End case 