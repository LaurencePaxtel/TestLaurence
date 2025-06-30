//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementGpeExterne
//{
//{          Mardi 11 Mai 2004 à 10:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)

Case of 
	: ($1=0)  //Chargement
		
		If ($2)  //(Appartient au groupe(Utilisateur courant;◊Groupe_Externe))
			OBJECT SET VISIBLE:C603(*; "Prest_1"; False:C215)  //Prestations
			OBJECT SET VISIBLE:C603(*; "ActionPrt_1"; False:C215)  //Imprimer actions   
			
			If ([HeberGement:5]HG_Permanencier:9=Current user:C182)
				P_HG_Clôturé
				
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; ([HeberGement:5]HG_Réservation:91=True:C214))
			Else 
				OBJECT SET VISIBLE:C603(*; "Notes_@"; False:C215)  //Notes, Action,SP,NR
				OBJECT SET VISIBLE:C603(*; "Valider_1"; False:C215)  //Bouton de validation        
			End if 
			
		Else 
			P_HG_Clôturé
			
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; ([HeberGement:5]HG_Réservation:91=True:C214))
		End if 
		
	: ($1=1)  //Nouvel enregistrement
	: ($1=2)  //Modification de fiche
End case 