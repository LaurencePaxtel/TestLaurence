var $dateDu_d; $dateAu_d : Date

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		outilsManagePopupDate(1)
	: (Form event code:C388=Sur clic:K2:4)
		outilsManagePopupDate(2; ->$dateDu_d; ->$dateAu_d)
		
		Form:C1466.dateDu:=$dateDu_d
		Form:C1466.dateAu:=$dateAu_d
		
		POST OUTSIDE CALL:C329(Current process:C322)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 