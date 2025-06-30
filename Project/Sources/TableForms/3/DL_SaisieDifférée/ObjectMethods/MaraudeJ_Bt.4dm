C_TEXT:C284($T_File)
$T_File:="debug_"+"saisieDiff"+"_.txt"  // #20180504-1

Log_mensuel(True:C214; "form event : "+String:C10(Form event code:C388); $T_File)

If (Accès_Groupe(<>Groupe_Maraude))
	<>vb_MarNuit:=False:C215
	Process_Go(-><>PR_Maraude; "Go_Maraude"; "Maraude"; 64)
End if 