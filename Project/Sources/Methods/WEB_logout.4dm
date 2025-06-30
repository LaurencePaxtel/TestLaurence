//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 01:15:53
// ----------------------------------------------------
// Méthode : WEB_logout
// Description
// 
//
// Paramètres
// ----------------------------------------------------
READ WRITE:C146([INtervenants:10])
QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=Session:C1714.storage.intervenant.ID)

If (WEB_UTL_silentLoad(->[INtervenants:10]; 60))
	
	[INtervenants:10]IN_Cookie:18:=""
	SAVE RECORD:C53([INtervenants:10])
	
	Use (Session:C1714.storage)
		Session:C1714.storage.intervenant:=New shared object:C1526()
	End use 
	UTL_NoCache
	
	WEB SEND HTTP REDIRECT:C659("/login")
	
	
Else 
	WEB SEND HTTP REDIRECT:C659("/login")
End if 

UNLOAD RECORD:C212([INtervenants:10])
READ ONLY:C145([INtervenants:10])