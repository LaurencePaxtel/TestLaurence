//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          P_MasqueEtatCivil
//{
//{          Mardi 22 avril 2008 à 13:19
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TEXT:C284($1)
C_BOOLEAN:C305($vb_OK)


If (<>vb_T_MasqueETCV)
	<>ve_Quel_MasqueETCV:=0
	
	Case of 
		: ($1="Enfant F avec parents (FM)")
			<>ve_Quel_MasqueETCV:=1
		: ($1="Enfant M avec parents (MM)")
			<>ve_Quel_MasqueETCV:=1
		: ($1="Majeur F avec parents (FF)")
			<>ve_Quel_MasqueETCV:=1
		: ($1="Majeur M avec parents (HF)")
			<>ve_Quel_MasqueETCV:=1
		: ($1="Femme seule (FS)")
			<>ve_Quel_MasqueETCV:=2
		: ($1="Homme seul (HS)")
			<>ve_Quel_MasqueETCV:=2
		: ($1="Mineur F (FM)")
			<>ve_Quel_MasqueETCV:=2
		: ($1="Mineur M (HM)")
			<>ve_Quel_MasqueETCV:=2
		: ($1="XXAFFICHERXX")
			<>ve_Quel_MasqueETCV:=3
		: ($1="XXCACHERXX")
			<>ve_Quel_MasqueETCV:=4
	End case 
	
	Case of 
		: (<>ve_Quel_MasqueETCV=0)
			$vb_OK:=False:C215
			
			If (Is new record:C668([HeberGement:5]))
				MultiSoc_Init_Structure(->[HeberGement:5])
				CONFIRM:C162("Cette personne est-elle Chef de Famille et le Payeur ?"; "Oui"; "Non")
				
				If (OK=1)
					x1:=1
					x2:=0
					
					[HeberGement:5]HG_FamChef:103:=True:C214
					P_HG_FamilleChef(1)
				Else 
					x1:=0
					x2:=1
					
					[HeberGement:5]HG_FamChef:103:=False:C215
					P_HG_FamilleChef2  //21/09/2009
					
					$vb_OK:=True:C214
				End if 
				
				
			Else 
				
				If ([HeberGement:5]HG_FamChef:103=False:C215)
					$vb_OK:=True:C214
				End if 
				
			End if 
			
			If ($vb_OK)
				OBJECT SET VISIBLE:C603(*; "103_@"; False:C215)  //Chef de famille 
				
				OBJECT SET VISIBLE:C603(*; "105_@"; False:C215)  //Composition familiale
				OBJECT SET VISIBLE:C603(*; "106_@"; False:C215)  //Nombre de personnes
				OBJECT SET VISIBLE:C603(*; "107_@"; False:C215)  //Nb de Jours
				OBJECT SET VISIBLE:C603(*; "108_@"; False:C215)  //Nb de Chambres
				OBJECT SET VISIBLE:C603(*; "109_@"; False:C215)  //Prix par Jour
				OBJECT SET VISIBLE:C603(*; "110_@"; False:C215)  //Prix total
				
				OBJECT SET VISIBLE:C603(*; "136_@"; False:C215)  //N° de Bon
				
				OBJECT SET VISIBLE:C603(*; "138_@"; False:C215)  //Participation (Boîte à cocher)
				
				OBJECT SET VISIBLE:C603(*; "112_@"; False:C215)  //Distribution : ligne 1
				OBJECT SET VISIBLE:C603(*; "118_@"; False:C215)
				
				OBJECT SET VISIBLE:C603(*; "113_@"; False:C215)  //Distribution : ligne 2
				OBJECT SET VISIBLE:C603(*; "119_@"; False:C215)
				
				OBJECT SET VISIBLE:C603(*; "114_@"; False:C215)  //Distribution : ligne 3
				OBJECT SET VISIBLE:C603(*; "120_@"; False:C215)
				
				OBJECT SET VISIBLE:C603(*; "115_@"; False:C215)  //Distribution : ligne 4
				OBJECT SET VISIBLE:C603(*; "121_@"; False:C215)
				
				OBJECT SET VISIBLE:C603(*; "116_@"; False:C215)  //Distribution : ligne 5
				OBJECT SET VISIBLE:C603(*; "122_@"; False:C215)
			End if 
			
		: (<>ve_Quel_MasqueETCV=1)
			OBJECT SET VISIBLE:C603(*; "103_@"; False:C215)  //Chef de famille 
			
			OBJECT SET VISIBLE:C603(*; "105_@"; False:C215)  //Composition familiale
			OBJECT SET VISIBLE:C603(*; "106_@"; False:C215)  //Nombre de personnes
			OBJECT SET VISIBLE:C603(*; "107_@"; False:C215)  //Nb de Jours
			OBJECT SET VISIBLE:C603(*; "108_@"; False:C215)  //Nb de Chambres
			OBJECT SET VISIBLE:C603(*; "109_@"; False:C215)  //Prix par Jour
			OBJECT SET VISIBLE:C603(*; "110_@"; False:C215)  //Prix total
			
			OBJECT SET VISIBLE:C603(*; "136_@"; False:C215)  //N° de Bon
			
			OBJECT SET VISIBLE:C603(*; "138_@"; False:C215)  //Participation (Boîte à cocher)
			
			OBJECT SET VISIBLE:C603(*; "112_@"; False:C215)  //Distribution : ligne 1
			OBJECT SET VISIBLE:C603(*; "118_@"; False:C215)
			
			OBJECT SET VISIBLE:C603(*; "113_@"; False:C215)  //Distribution : ligne 2
			OBJECT SET VISIBLE:C603(*; "119_@"; False:C215)
			
			OBJECT SET VISIBLE:C603(*; "114_@"; False:C215)  //Distribution : ligne 3
			OBJECT SET VISIBLE:C603(*; "120_@"; False:C215)
			
			OBJECT SET VISIBLE:C603(*; "115_@"; False:C215)  //Distribution : ligne 4
			OBJECT SET VISIBLE:C603(*; "121_@"; False:C215)
			
			OBJECT SET VISIBLE:C603(*; "116_@"; False:C215)  //Distribution : ligne 5
			OBJECT SET VISIBLE:C603(*; "122_@"; False:C215)
		: (<>ve_Quel_MasqueETCV=2)
			OBJECT SET VISIBLE:C603(*; "103_@"; False:C215)  //Chef de famille
			OBJECT SET VISIBLE:C603(*; "104_@"; False:C215)  //Clé de lien familiale
			
			OBJECT SET VISIBLE:C603(*; "105_@"; False:C215)  //Composition familiale
			OBJECT SET VISIBLE:C603(*; "106_@"; False:C215)  //Nombre de personnes
			OBJECT SET VISIBLE:C603(*; "107_@"; False:C215)  //Nb de Jours
			OBJECT SET VISIBLE:C603(*; "108_@"; False:C215)  //Nb de Chambres
			OBJECT SET VISIBLE:C603(*; "109_@"; False:C215)  //Prix par Jour
			OBJECT SET VISIBLE:C603(*; "110_@"; False:C215)  //Prix total
			
			OBJECT SET VISIBLE:C603(*; "136_@"; False:C215)  //N° de Bon
	End case 
	
End if 