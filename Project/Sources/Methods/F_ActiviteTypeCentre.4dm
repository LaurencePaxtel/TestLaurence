//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_ActiviteTypeCentre
//{          Lundi 6 février 2012 à 14:40:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($1)
C_TEXT:C284($2)  //Centre nom

C_TEXT:C284($va_TypeCentre)

Case of 
	: ($1="0a49+115")
		If ($2>"")
			If (Substring:C12($2; 1; 3)="115")
				$0:=True:C214
			Else 
				$va_TypeCentre:=Substring:C12($2; 1; 2)
				If ((Num:C11($va_TypeCentre)>=0) & (Num:C11($va_TypeCentre)<=49))
					$0:=True:C214
				End if 
			End if 
		End if 
		
	: ($1="0a49-40")
		If ($2>"")
			If (Substring:C12($2; 1; 3)="115")
			Else 
				$va_TypeCentre:=Substring:C12($2; 1; 2)
				If ((Num:C11($va_TypeCentre)>=0) & (Num:C11($va_TypeCentre)<=49) & (Num:C11($va_TypeCentre)#40))
					$0:=True:C214
				End if 
			End if 
		End if 
		
		
	: ($1="0a49-40+115")
		If ($2>"")
			If (Substring:C12($2; 1; 3)="115")
				$0:=True:C214
			Else 
				$va_TypeCentre:=Substring:C12($2; 1; 2)
				If ((Num:C11($va_TypeCentre)>=0) & (Num:C11($va_TypeCentre)<=49) & (Num:C11($va_TypeCentre)#40))
					$0:=True:C214
				End if 
			End if 
		End if 
		
		
	: ($1="40+115")
		If ($2>"")
			If (Substring:C12($2; 1; 3)="115")
				$0:=True:C214
			Else 
				If (Substring:C12($2; 1; 2)="40")
					$0:=True:C214
				End if 
			End if 
		End if 
		
		
		
End case 