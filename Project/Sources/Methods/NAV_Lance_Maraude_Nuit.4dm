//%attributes = {}
If (Accès_Groupe(<>Groupe_Maraude))
	<>vb_MarNuit:=True:C214
	Process_Go(-><>PR_Maraude; "Go_Maraude"; "Maraude"; 64)
End if 