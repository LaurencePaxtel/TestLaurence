C_TEXT:C284($T_File)
$T_File:="debug_"+"saisieDiff"+"_.txt"  // #20180504-1

Log_mensuel(True:C214; "form event : "+String:C10(Form event code:C388); $T_File)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (Current user:C182#"apaxtel")
			OBJECT SET VISIBLE:C603(*; "heureDiff_@"; False:C215)
		End if 
		
	: (Form event code:C388=Sur données modifiées:K2:15)
		
		If (<>vd_SD_Jour>Current date:C33)
			ALERT:C41("Vous êtes en saisie différée : "+<>va_CR+"Vous ne pouvez pas saisir une date supérieure à la date d'aujourd'hui !")
			REJECT:C38
			
			GOTO OBJECT:C206(<>vd_SD_Jour)
			OBJECT SET ENABLED:C1123(b_CE_Ddif; False:C215)
			OBJECT SET ENABLED:C1123(b_FSH_Jdif; False:C215)
			OBJECT SET ENABLED:C1123(b_FSH_Ndif; False:C215)
		Else 
			Log_mensuel(True:C214; "avant methode P_SaisieDifféréeDate"; $T_File)
			P_SaisieDifféréeDate
			
			Log_mensuel(True:C214; "après methode P_SaisieDifféréeDate"; $T_File)
			
			OBJECT SET ENABLED:C1123(b_CE_Ddif; True:C214)
			OBJECT SET ENABLED:C1123(b_FSH_Jdif; True:C214)
			OBJECT SET ENABLED:C1123(b_FSH_Ndif; True:C214)
		End if 
		
End case 