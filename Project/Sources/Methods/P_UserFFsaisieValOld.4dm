//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_UserFFsaisieValOld
//{          Mardi 12 avril 2011 à 11:55:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
$vb_OK:=False:C215
gError:=0
$Position:=0
If (Is new record:C668([INtervenants:10]))
	MultiSoc_Init_Structure(->[INtervenants:10])
	ON ERR CALL:C155("i_Error")
	$Position:=Set user properties:C612(-2; [INtervenants:10]IN_Login:3; ""; va_MotPasseOld; 0; Current date:C33; tl_UserGroupe)
	If ($Position<-10)
		[INtervenants:10]IN_RéfUser:11:=$Position
		$vb_OK:=True:C214
	End if 
	ON ERR CALL:C155("")
Else 
	
	For ($ii; 1; Size of array:C274(ta_UserLog))
		If (tl_UserNo{$ii}=[INtervenants:10]IN_RéfUser:11) | (ta_UserLog{$ii}=[INtervenants:10]IN_Login:3)
			$Position:=$Position+1
		End if 
	End for 
	
	Case of 
		: ($Position=0)
			ON ERR CALL:C155("i_Error")
			$Position:=0
			$Position:=Set user properties:C612(-2; [INtervenants:10]IN_Login:3; ""; va_MotPasseOld; 0; Current date:C33; tl_UserGroupe)
			If ($Position<-10)
				$ii:=Size of array:C274(ta_UserLog)+1
				INSERT IN ARRAY:C227(ta_UserLog; $ii; 1)
				INSERT IN ARRAY:C227(tl_UserNo; $ii; 1)
				ta_UserLog{$ii}:=[INtervenants:10]IN_Login:3
				tl_UserNo{$ii}:=$Position
				SORT ARRAY:C229(ta_UserLog; tl_UserNo; >)
				[INtervenants:10]IN_RéfUser:11:=$Position
				$vb_OK:=True:C214
			End if 
			ON ERR CALL:C155("")
		: ($Position=1)
			ON ERR CALL:C155("i_Error")
			$Position:=0
			$Position:=Set user properties:C612([INtervenants:10]IN_RéfUser:11; [INtervenants:10]IN_Login:3; ""; *; 0; Current date:C33; tl_UserGroupe)
			If ($Position<-10)
				$vb_OK:=True:C214
			Else 
				ALERT:C41("Le login : "+[INtervenants:10]IN_Login:3+" n'est pas référencé !")
			End if 
			ON ERR CALL:C155("")
		: ($Position>1)
			ALERT:C41("Le login : "+[INtervenants:10]IN_Login:3+" est déja référencé !")
			
	End case 
End if 
If ($vb_OK)
Else 
	REJECT:C38
End if 