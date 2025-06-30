//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_EtatCivilGenre
//{
//{          Mercredi 25 mai 2005 à 12:12:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_LONGINT:C283($ii)

If (7=8)
	
	If ($1>"")
		$0:=(Substring:C12($1; Length:C16($1)-2; 1)="F")
	End if 
	
Else 
	
	If ($1>"")
		$ii:=Position:C15("("; $1)
		
		If ($ii>0)
			$ii:=$ii+1
			$0:=($1[[$ii]]="F")
		End if 
		
	End if 
	
End if 