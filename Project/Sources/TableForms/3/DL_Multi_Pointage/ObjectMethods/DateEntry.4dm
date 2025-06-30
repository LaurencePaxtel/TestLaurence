C_TEXT:C284($formName_t)
C_BOOLEAN:C305($customise_b)

ARRAY BOOLEAN:C223($weekDaysOff_ab; 7)
ARRAY DATE:C224($daysOff_ad; 0)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		$formName_t:=OBJECT Get name:C1087(Objet courant:K67:2)
		
		If ($customise_b)
			$weekDaysOff_ab{Mercredi:K10:15}:=True:C214
			$weekDaysOff_ab{Dimanche:K10:19}:=True:C214
			
			DatePicker SET DAYS OFF($formName_t; 0; ->$weekDaysOff_ab)
		End if 
		
		If ($customise_b)
			DatePicker SET MIN DATE($formName_t; Add to date:C393(Current date:C33; 0; 0; -15))
			DatePicker SET MAX DATE($formName_t; Add to date:C393(Current date:C33; 1; 0; 0))
		End if 
		
		If ($customise_b)
			APPEND TO ARRAY:C911($daysOff_ad; Add to date:C393(!00-00-00!; 2000; 1; 1))
			APPEND TO ARRAY:C911($daysOff_ad; Add to date:C393(!00-00-00!; 2000; 5; 1))
			APPEND TO ARRAY:C911($daysOff_ad; Add to date:C393(!00-00-00!; 2000; 5; 8))
			APPEND TO ARRAY:C911($daysOff_ad; Add to date:C393(!00-00-00!; 2000; 7; 14))
			APPEND TO ARRAY:C911($daysOff_ad; Add to date:C393(!00-00-00!; 2000; 8; 15))
			APPEND TO ARRAY:C911($daysOff_ad; Add to date:C393(!00-00-00!; 2000; 11; 1))
			APPEND TO ARRAY:C911($daysOff_ad; Add to date:C393(!00-00-00!; 2000; 11; 11))
			APPEND TO ARRAY:C911($daysOff_ad; Add to date:C393(!00-00-00!; 2000; 12; 25))
			
			DatePicker SET DAYS OFF($formName_t; 1; ->$daysOff_ad)
		End if 
		
		If ($customise_b)
			APPEND TO ARRAY:C911($daysOff_ad; Add to date:C393(!00-00-00!; 2009; 6; 27))
			
			DatePicker SET DAYS OFF($formName_t; 2; ->$daysOff_ad)
		End if 
		
		If ($customise_b)
			DatePicker SET WEEK FIRST DAY($formName_t; Mercredi:K10:15)
		End if 
		
		If (dateCreationFiche_d=!00-00-00!)
			dateCreationFiche_d:=Current date:C33
		End if 
		
End case 