var $service_t : Text
var $modif_b : Boolean

ARRAY TEXT:C222($serviceDistinct_at; 0)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		COLLECTION TO ARRAY:C1562(Form:C1466.serviceDistinct_c; $serviceDistinct_at)
		
		$service_t:=(Form:C1466.service)
		Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{62}; ->$serviceDistinct_at; ->$service_t; True:C214)
		
		$modif_b:=(String:C10(Form:C1466.service)#$service_t)
		
		If ($modif_b=True:C214)
			Form:C1466.service:=$service_t
			//GÉNÉRER APPEL EXTÉRIEUR(Numéro du process courant)
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 