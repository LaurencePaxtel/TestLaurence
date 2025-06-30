If (Form event code:C388=Sur affichage corps:K2:22)
	va_NJ:=("J"*Num:C11([RenseiGnements:20]RG_Nuit:5=False:C215))+("N"*Num:C11([RenseiGnements:20]RG_Nuit:5=True:C214))
End if 