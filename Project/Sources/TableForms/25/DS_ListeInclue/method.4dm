If (Form event code:C388=Sur affichage corps:K2:22)
	
	va_MRJ:=("Sortie"*Num:C11([DossierSocial:25]DS_Sortie:72=True:C214))+(""*Num:C11([DossierSocial:25]DS_Sortie:72=False:C215))
	
End if 