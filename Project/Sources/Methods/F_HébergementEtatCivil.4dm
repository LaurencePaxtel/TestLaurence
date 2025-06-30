//%attributes = {}
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($vb_OK)

If ($1>"")
	
	If ($2<18)
		
		If ($2=0)
			$vb_OK:=True:C214
		Else 
			
			If (Substring:C12($1; Length:C16($1)-1; 1)="P")
				$vb_OK:=True:C214
			End if 
			
		End if 
		
	Else 
		
		If (Substring:C12($1; Length:C16($1)-1; 1)#"P")
			$vb_OK:=True:C214
		End if 
		
	End if 
	
Else 
	$vb_OK:=True:C214
End if 

If ($vb_OK=False:C215)
	
	If (i_Confirmer(F_HébergementEtCvValider($1; $2)))
		$vb_OK:=True:C214
	End if 
	
End if 

$0:=$vb_OK