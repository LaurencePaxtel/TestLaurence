If (Form event code:C388=Sur affichage corps:K2:22)
	va_MRJ:=("J"*Num:C11([Maraude:24]MR_Nuit:2=False:C215))+("N"*Num:C11([Maraude:24]MR_Nuit:2=True:C214))
End if 