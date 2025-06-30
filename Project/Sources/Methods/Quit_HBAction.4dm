//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Quit_HBAction
//{
//{          Lundi 28 Juillet 1997 à 17:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)

If (Count parameters:C259=0)
	CONFIRM:C162("Voulez-vous enregistrer les modifications ?")
End if 

If (Ok=1)
	
	If (vt_TempActi>"")
		[HeBerge:4]HG_Actions:40:=[HeBerge:4]HG_Actions:40+<>va_CR+vt_TempActi
	End if 
	
	ACCEPT:C269
Else 
	CANCEL:C270
End if 

vt_TempActi:=""