C_TEXT:C284($T_File)
$T_File:="debug_"+"saisieDiff"+"_.txt"  // #20180504-1

Log_mensuel(True:C214; "form event : "+String:C10(Form event code:C388); $T_File)

If (Accès_Groupe(<>Groupe_Jour))
	
	If (<>PR_Hébergement=0)
		<>PR_Hébergement:=New process:C317("Go_Hébergement"; 0; "FicheSignal"; "J"; "")
	Else 
		Process_Show(<>PR_Hébergement)
	End if 
End if 