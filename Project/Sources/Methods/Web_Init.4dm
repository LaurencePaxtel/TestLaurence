//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 10/11/18, 15:51:09
// ----------------------------------------------------
// Méthode : Web_Init
// Description
// 
//
// Paramètres
// ----------------------------------------------------



If (Session:C1714.storage.enumeration=Null:C1517)
	Use (Session:C1714.storage)
		Session:C1714.storage.enumeration:=New shared collection:C1527()
	End use 
	//DébutAccèsTable
	//DébutDécTable
	Web_debutInitTable
End if 


// DebutDécGroupes
