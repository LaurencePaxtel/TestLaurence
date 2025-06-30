If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	
	If ([HeberGement:5]HG_FamChef:103=False:C215)
		[HeberGement:5]HG_FamClé:104:=""
		F_SIAO_Dossier("SIAODossierNonChef")
	End if 
	
Else 
	<>va_LeNoFAM:=""
	
	If (<>PR_Lien=0)
		<>PR_Lien:=New process:C317("Go_FamilleLien"; 0; "Lienfamille"; [HeberGement:5]HG_FamChef:103; <>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{64}; [HeberGement:5]HG_FamClé:104)
	Else 
		Process_Show(<>PR_Lien)
	End if 
	
End if 