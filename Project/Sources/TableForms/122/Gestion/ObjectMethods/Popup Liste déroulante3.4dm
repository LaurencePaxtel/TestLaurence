Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(reference_at; 0)
		
		OBJECT SET ENABLED:C1123(*; "Popup Liste déroulante3"; False:C215)
	: (Form event code:C388=Sur données modifiées:K2:15)
		POST OUTSIDE CALL:C329(Current process:C322)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 