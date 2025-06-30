//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : F_Joker
//{          Mardi 6 Février 2012 à 17:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($va_Temp)

$0:=$2

Case of 
	: ($1="D+F+")
		
		If ($2>"")
			$va_Temp:=$2
			
			Repeat 
				
				If (Length:C16($va_Temp)>0)
					
					If (Character code:C91($va_Temp[[1]])=<>vl_ArrowBase)
						$va_Temp:=Substring:C12($va_Temp; 2)
					End if 
					
					If (Length:C16($va_Temp)>0)
						
						If (Character code:C91($va_Temp[[Length:C16($va_Temp)]])=<>vl_ArrowBase)
							$va_Temp:=Substring:C12($va_Temp; 1; Length:C16($va_Temp)-1)
						End if 
						
						If (Length:C16($va_Temp)>0)
							$vb_OK:=((Character code:C91($va_Temp[[1]])#<>vl_ArrowBase) & (Character code:C91($va_Temp[[Length:C16($va_Temp)]])#<>vl_ArrowBase))
						Else 
							$vb_OK:=True:C214
						End if 
						
					Else 
						$vb_OK:=True:C214
					End if 
					
				Else 
					$vb_OK:=True:C214
				End if 
				
			Until ($vb_OK)
			
			// Modifié par : Scanu Rémy (20/10/2022)
			Case of 
				: (Length:C16($2)=2) & (outilsCheckCharacterIsNumber(Substring:C12($va_Temp; 1; 1))=True:C214) & (outilsCheckCharacterIsNumber(Substring:C12($va_Temp; 2; 1))=True:C214)
					$0:=$va_Temp+"@"
				: (Length:C16($va_Temp)>0)
					$0:="@"+$va_Temp+"@"
				Else 
					$0:="@"
			End case 
			
		Else 
			$0:="@"
		End if 
		
	: ($1="DF")
		
		If ($2>"")
			$va_Temp:=$2
			
			Repeat 
				
				If (Length:C16($va_temp)>0)
					
					If (Character code:C91($va_Temp[[1]])=<>vl_ArrowBase)
						$va_Temp:=Substring:C12($va_Temp; 2)
					End if 
					
					If (Length:C16($va_temp)>0)
						
						If (Character code:C91($va_Temp[[Length:C16($va_Temp)]])=<>vl_ArrowBase)
							$va_Temp:=Substring:C12($va_Temp; 1; Length:C16($va_Temp)-1)
						End if 
						
						If (Length:C16($va_temp)>0)
							$vb_OK:=((Character code:C91($va_Temp[[1]])#<>vl_ArrowBase) & (Character code:C91($va_Temp[[Length:C16($va_Temp)]])#<>vl_ArrowBase))
						Else 
							$vb_OK:=True:C214
						End if 
						
					Else 
						$vb_OK:=True:C214
					End if 
					
				Else 
					$vb_OK:=True:C214
				End if 
				
			Until ($vb_OK)
			
			// Modifié par : Scanu Rémy (20/10/2022)
			Case of 
				: (Length:C16($2)=2) & (outilsCheckCharacterIsNumber(Substring:C12($va_Temp; 1; 1))=True:C214) & (outilsCheckCharacterIsNumber(Substring:C12($va_Temp; 2; 1))=True:C214)
					$0:=$va_Temp+"@"
				: (Length:C16($va_Temp)>0)
					$0:="@"+$va_Temp+"@"
				Else 
					$0:="@"
			End case 
			
		Else 
			$0:="@"
		End if 
		
	: ($1="D+")
		
		If ($2>"")
			$va_Temp:=$2
			
			Repeat 
				
				If (Length:C16($va_temp)>0)
					
					If (Character code:C91($va_Temp[[1]])=<>vl_ArrowBase)
						$va_Temp:=Substring:C12($va_Temp; 2)
					End if 
					
					If (Length:C16($va_temp)>0)
						
						If (Character code:C91($va_Temp[[Length:C16($va_Temp)]])=<>vl_ArrowBase)
							$va_Temp:=Substring:C12($va_Temp; 1; Length:C16($va_Temp)-1)
						End if 
						
						If (Length:C16($va_temp)>0)
							$vb_OK:=((Character code:C91($va_Temp[[1]])#<>vl_ArrowBase) & (Character code:C91($va_Temp[[Length:C16($va_Temp)]])#<>vl_ArrowBase))
						Else 
							$vb_OK:=True:C214
						End if 
						
					Else 
						$vb_OK:=True:C214
					End if 
					
				Else 
					$vb_OK:=True:C214
				End if 
				
			Until ($vb_OK)
			
			If (Length:C16($va_Temp)>0)
				$0:="@"+$va_Temp+"@"
			Else 
				$0:="@"
			End if 
			
		Else 
			$0:="@"
		End if 
		
End case 