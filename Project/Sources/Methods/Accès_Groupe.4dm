//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Accès_Groupe
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284(${1})

C_LONGINT:C283($i_el)

For ($i_el; 1; Count parameters:C259)
	
	If (User in group:C338(Current user:C182; ${$i_el}))
		$i_el:=Count parameters:C259  // Fin de boucle
		$0:=True:C214
	End if 
	
End for 

If ($0=False:C215)
	StrAlerte(6; "")
End if 