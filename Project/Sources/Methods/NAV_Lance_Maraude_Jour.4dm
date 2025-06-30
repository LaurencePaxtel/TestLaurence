//%attributes = {}
If (Accès_Groupe(<>Groupe_Maraude))
	<>vb_MarNuit:=False:C215
	Process_Go(-><>PR_Maraude; "Go_Maraude"; "Maraude"; 64)
End if 