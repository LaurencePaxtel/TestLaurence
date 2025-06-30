//%attributes = {}
C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($1)
C_LONGINT:C283($vl_Position)
C_TEXT:C284($va_Temp)
C_TEXT:C284($va_Nom)
C_TEXT:C284($va_Prenom)
C_DATE:C307($va_Date)

$va_Nom:=""
$va_Prenom:=""
$va_Date:=!00-00-00!

If ($1>"")
	$va_Temp:=$1
	$vl_Position:=Position:C15(" "; $va_Temp)
	If ($vl_Position>0)
		//NOM
		$va_Nom:=Substring:C12($va_Temp; 1; $vl_Position-1)
		$va_Temp:=Substring:C12($va_Temp; $vl_Position+1)
		
		//DATE
		$vl_Position:=Position:C15("/"; $va_Temp)
		If ($vl_Position>0)
			$va_Date:=Date:C102(Substring:C12($va_Temp; $vl_Position-2))
			$va_Temp:=Substring:C12($va_Temp; 1; $vl_Position-3)
			If ($va_Temp>"")
				//BLANCS DU DEBUT
				Repeat 
					If ($va_Temp[[1]]=" ")
						$va_Temp:=Substring:C12($va_Temp; 2)
					End if 
				Until ($va_Temp="") | ($va_Temp[[1]]#" ")
				//BLANCS DE FIN
				Repeat 
					If ($va_Temp[[Length:C16($va_Temp)]]=" ")
						$va_Temp:=Substring:C12($va_Temp; 1; Length:C16($va_Temp)-1)
					End if 
				Until ($va_Temp="") | ($va_Temp[[Length:C16($va_Temp)]]#" ")
				
				If (Length:C16($va_Temp)>20)
					$vl_Position:=Position:C15(" "; $va_Temp)
					If ($vl_Position>0)
						$va_Nom:=$va_Nom+" "+Substring:C12($va_Temp; 1; $vl_Position-1)
						$va_Temp:=Substring:C12($va_Temp; $vl_Position+1)
						$va_Prenom:=$va_Temp
					End if 
				Else 
					$va_Prenom:=$va_Temp
				End if 
				If ($va_Prenom>"")
					Repeat 
						If ($va_Prenom[[1]]=" ")
							$va_Prenom:=Substring:C12($va_Prenom; 2)
						End if 
					Until ($va_Prenom="") | ($va_Prenom[[1]]#" ")
					Repeat 
						If ($va_Prenom[[Length:C16($va_Prenom)]]=" ")
						End if 
					Until ($va_Prenom="") | ($va_Prenom[[Length:C16($va_Prenom)]]#" ")
					
				End if 
				
			End if 
		End if 
	End if 
End if 

$va_Temp:=(($va_Nom+" ")*(Num:C11(($va_Nom)>"")))
$va_Temp:=$va_Temp+(($va_Prenom+" ")*(Num:C11(($va_Prenom)>"")))
If (($va_Date)<!2000-01-01!)
	$va_Temp:=$va_Temp+(String:C10($va_Date; 4)*(Num:C11(($va_Date)>!00-00-00!)))
Else 
	$va_Temp:=$va_Temp+(String:C10($va_Date; 7)*(Num:C11(($va_Date)>!00-00-00!)))
End if 



$0:=($1=$va_Temp)
If ($0)
	[HeBerge:4]HB_Nom:3:=$va_Nom
	[HeBerge:4]HB_Prénom:4:=$va_Prenom
	[HeBerge:4]HB_DateNéLe:5:=$va_Date
	
End if 