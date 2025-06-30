$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur entête:K2:17)
		ve_LC_Pg:=Printing page:C275
	: ($vl_EventFF=Sur impression corps:K2:18)
		va_MRsexe:=("F"*Num:C11([DossierSante:33]DE_Genre:19=True:C214))+("M"*Num:C11([DossierSante:33]DE_Genre:19=False:C215))
		vt_Texte:=[HeBerge:4]HB_Santé:48
End case 
