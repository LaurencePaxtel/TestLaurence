Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		var $formName_t : Text
		var $custom_b : Boolean
		
		var date8_d : Date
		
		ARRAY BOOLEAN:C223($jourOff_ab; 7)
		ARRAY DATE:C224($jourFerie_ad; 0)
		
		$formName_t:=OBJECT Get name:C1087(Objet courant:K67:2)
		
		If ($custom_b)
			$jourOff_ab{Mercredi:K10:15}:=True:C214
			$jourOff_ab{Dimanche:K10:19}:=True:C214
			
			DatePicker SET DAYS OFF($formName_t; 0; ->$jourOff_ab)
		End if 
		
		If ($custom_b)
			DatePicker SET MIN DATE($formName_t; Add to date:C393(Current date:C33; 0; 0; -15))
			DatePicker SET MAX DATE($formName_t; Add to date:C393(Current date:C33; 1; 0; 0))
		End if 
		
		If ($custom_b)
			APPEND TO ARRAY:C911($jourFerie_ad; Add to date:C393(!00-00-00!; 2000; 1; 1))
			APPEND TO ARRAY:C911($jourFerie_ad; Add to date:C393(!00-00-00!; 2000; 5; 1))
			APPEND TO ARRAY:C911($jourFerie_ad; Add to date:C393(!00-00-00!; 2000; 5; 8))
			APPEND TO ARRAY:C911($jourFerie_ad; Add to date:C393(!00-00-00!; 2000; 7; 14))
			APPEND TO ARRAY:C911($jourFerie_ad; Add to date:C393(!00-00-00!; 2000; 8; 15))
			APPEND TO ARRAY:C911($jourFerie_ad; Add to date:C393(!00-00-00!; 2000; 11; 1))
			APPEND TO ARRAY:C911($jourFerie_ad; Add to date:C393(!00-00-00!; 2000; 11; 11))
			APPEND TO ARRAY:C911($jourFerie_ad; Add to date:C393(!00-00-00!; 2000; 12; 25))
			
			DatePicker SET DAYS OFF($formName_t; 1; ->$jourFerie_ad)  // 1 stands for every year
		End if 
		
		If ($custom_b)
			CLEAR VARIABLE:C89($jourFerie_ad)
			APPEND TO ARRAY:C911($jourFerie_ad; Add to date:C393(!00-00-00!; 2009; 6; 27))
			
			DatePicker SET DAYS OFF($formName_t; 2; ->$jourFerie_ad)
		End if 
		
		If ($custom_b)
			DatePicker SET WEEK FIRST DAY($formName_t; Mercredi:K10:15)  // lets start the week on wednesday (why not)
		End if 
		
	: (Form event code:C388=Sur données modifiées:K2:15)
		
		If (Bool:C1537(Form:C1466.loadForm)=True:C214)
			Form:C1466.apl["aout"].dateReception:=OBJECT Get pointer:C1124(Objet courant:K67:2)->
		End if 
		
End case 