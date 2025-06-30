//vPos1:=0
//vPos2:=0
//GET HIGHLIGHT([HeBerge]Notes;vPos1;vPos2)
//$Temp:=""
//$Temp:=String(Current date)+" - "+String(Current time)+" - "+<>va_User+" - "+<>va_CR
//[HeBerge]Notes:=Insert string([HeBerge]Notes;$Temp;vPos1)
//vPos2:=vPos1+24+Length(<>va_User)+4
//HIGHLIGHT TEXT([HeBerge]Notes;vPos2;vPos2)
//vl_Note_LG_1:=Length([HeBerge]Notes)
//OBJECT SET VISIBLE(*;"TropPage_1";(vl_Note_LG_1>vl_Note_LG_MAX))


Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		Handle saisie note hebergement("timestamp")
		
		
End case 