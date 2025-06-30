//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampHébergement
//{
//{          Vendredi : 6 octobre 2008 à 11:30
//{          Modifiée : 29 septembre 2009 à 11:30
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  // STR #
C_LONGINT:C283($2)  // Nb de champs
C_LONGINT:C283($3)  // Constante : Indice de la ressource

C_LONGINT:C283($ii)

QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$1)
MultiSoc_Filter(->[LesRubriques:21])

$ii:=Records in selection:C76([LesRubriques:21])

If ($ii#$2)
	
	// Modifié par : Scanu Rémy (29/12/2022)
	If (Application type:C494#4D Server:K5:6) & (Application type:C494#4D mode local:K5:1)
		DELAY PROCESS:C323(Current process:C322; 60)
	End if 
	
	Debut_DecVarChampsHGj($1; $ii+1; $2)
	
	// Modifié par : Scanu Rémy (29/12/2022)
	If (Application type:C494#4D Server:K5:6) & (Application type:C494#4D mode local:K5:1)
		
		If (<>PR_Mire>0)
			Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Chargement du lexique "+String:C10($1)+"...")
		End if 
		
	Else 
		MESSAGE:C88("Chargement du lexique "+String:C10($1)+"..."+Char:C90(Retour chariot:K15:38))
	End if 
	
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$1)
	MultiSoc_Filter(->[LesRubriques:21])
End if 

// Modifié par : Scanu Rémy (29/12/2022)
If (Application type:C494#4D Server:K5:6) & (Application type:C494#4D mode local:K5:1)
	
	If (<>PR_Mire>0)
		Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Création des tableaux de lexique "+String:C10($3)+"...")
	End if 
	
Else 
	MESSAGE:C88("Création des tableaux de lexique "+String:C10($3)+"..."+Char:C90(Retour chariot:K15:38))
End if 

// Modifié par : Scanu Rémy (29/12/2022)
If (Application type:C494#4D Server:K5:6) & (Application type:C494#4D mode local:K5:1)
	//ENDORMIR PROCESS(Numéro du process courant; 120)
End if 

TableChampsAttributs(1; $3)

// Modifié par : Scanu Rémy (29/12/2022)
If (Application type:C494#4D Server:K5:6) & (Application type:C494#4D mode local:K5:1)
	
	If (<>PR_Mire>0)
		Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Transfert des tableaux en xliff pour le STR "+String:C10($1)+"...")
	End if 
	
Else 
	MESSAGE:C88("Création des tableaux de lexique "+String:C10($3)+"..."+Char:C90(Retour chariot:K15:38))
End if 

// Modifié par : Scanu Rémy (29/12/2022)
If (Application type:C494#4D Server:K5:6) & (Application type:C494#4D mode local:K5:1)
	//ENDORMIR PROCESS(Numéro du process courant; 120)
End if 

TableChampsAttributs(2; $3; $1)