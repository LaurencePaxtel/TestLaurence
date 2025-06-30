If (Form event code:C388=Sur affichage corps:K2:22)
	va_RésaEffectuée:=("Prorogé"*Num:C11([Prolongation:38]PR_ProlongationEffectuée:11=True:C214))+(""*Num:C11([Prolongation:38]PR_ProlongationEffectuée:11=False:C215))
End if 