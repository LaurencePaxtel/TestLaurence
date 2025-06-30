$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		
		If ([HeberGement:5]HG_ER_NuitEnCours:127>1)
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_ER_Excuse:124; False:C215)
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_ER_DateDébut:125; False:C215)
		Else 
			[HeberGement:5]HG_AutreSolutio:88:=<>va_HG_AutreSolExc
			If ([HeberGement:5]HG_ER_Excuse:124)
			Else 
				OBJECT SET VISIBLE:C603(*; "OuiExc_@"; False:C215)
				OBJECT SET ENABLED:C1123(b_ValExc; False:C215)
			End if 
		End if 
		
		
		
	: ($vl_EventFF=Sur données modifiées:K2:15)
		If ([HeberGement:5]HG_ER_Excuse:124)
			If (Modified:C32([HeberGement:5]HG_ER_DateFin:126))
				
				$vb_OK:=([HeberGement:5]HG_ER_DateFin:126<[HeberGement:5]HG_ER_DateDébut:125)
				$vb_OK:=(($vb_OK) | ([HeberGement:5]HG_ER_DateFin:126>([HeberGement:5]HG_Date:4+[HeberGement:5]HG_NuitReste:95)))
				
				If ($vb_OK)
					ALERT:C41("La date de fin est incorrecte!")
					OBJECT SET ENABLED:C1123(b_ValExc; False:C215)
				Else 
					[HeberGement:5]HG_ER_NuitTotal:128:=[HeberGement:5]HG_ER_DateFin:126-[HeberGement:5]HG_ER_DateDébut:125+1
					[HeberGement:5]HG_ER_NuitReste:129:=[HeberGement:5]HG_ER_NuitTotal:128-[HeberGement:5]HG_ER_NuitEnCours:127
					OBJECT SET ENABLED:C1123(b_ValExc; True:C214)
					
				End if 
			End if 
			
		End if 
		
End case 