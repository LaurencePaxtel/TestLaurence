//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementExcuser
//{
//{          Mardi 11 Mai 2004 à 10:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)
C_LONGINT:C283($2)

C_DATE:C307($vd_Date)

If ($1)
	
	Case of 
		: ($2=0)
			
			If ([HeberGement:5]HG_ER_Excuse:124)
				OBJECT SET VISIBLE:C603(*; "Exc_@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "Remp_@"; False:C215)
				
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Réservation:91; False:C215)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitenCours:92; False:C215)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; False:C215)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_AutreSolutio:88; False:C215)
				
				OBJECT SET VISIBLE:C603(*; "088_Bt"; False:C215)
				OBJECT SET VISIBLE:C603(*; "062_Bt"; False:C215)
				OBJECT SET VISIBLE:C603(*; "062_ico1"; False:C215)
				OBJECT SET VISIBLE:C603(*; "062_ico2"; False:C215)
				OBJECT SET VISIBLE:C603(*; "062_Chp1"; False:C215)
				
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_CentreNom:62; False:C215)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_CentreARR:63; False:C215)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Priorité:57; False:C215)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_DispoSpé:90; False:C215)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_EnAttente:64; False:C215)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Transmis:65; False:C215)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_PriseCharge:66; False:C215)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Cloturée:67; False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*; "Exc_@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "Remp_@"; False:C215)
				
				If ([HeberGement:5]HG_ER_Remplaçant:130)
					OBJECT SET VISIBLE:C603(*; "Remp_@"; True:C214)
				Else 
					
					If ([HeberGement:5]HG_Date:4#!00-00-00!)
						$vd_Date:=[HeberGement:5]HG_Date:4
					Else 
						$vd_Date:=Current date:C33
					End if 
					
					
					If ([HeberGement:5]HG_Cloturée:67=False:C215) & ([HeberGement:5]HG_DateDuJour:82=$vd_Date)
						OBJECT SET VISIBLE:C603(*; "Remp_@"; True:C214)
						
						P_HébergementExcuser(True:C214; 2)
					End if 
					
				End if 
				
			End if 
			
		: ($2=1)
			OBJECT SET VISIBLE:C603(*; "Remp_T2"; True:C214)  //Titre : Clé
			OBJECT SET VISIBLE:C603(*; "Remp_C2"; True:C214)  //Champ : Clé
			OBJECT SET VISIBLE:C603(*; "Remp_Rec2"; True:C214)  //Rectangle Champ : Clé      
			OBJECT SET VISIBLE:C603(*; "Remp_BT"; True:C214)  //Bt Champ : Clé      
			OBJECT SET VISIBLE:C603(*; "Remp_ico1"; True:C214)  //Icone Champ : Clé     
		: ($2=2)
			OBJECT SET VISIBLE:C603(*; "Remp_T2"; False:C215)  //Titre : Clé
			OBJECT SET VISIBLE:C603(*; "Remp_C2"; False:C215)  //Champ : Clé
			OBJECT SET VISIBLE:C603(*; "Remp_Rec2"; False:C215)  //Rectangle Champ : Clé      
			OBJECT SET VISIBLE:C603(*; "Remp_BT"; False:C215)  //Bt Champ : Clé      
			OBJECT SET VISIBLE:C603(*; "Remp_ico1"; False:C215)  //Icone Champ : Clé      
			
			If ([HeberGement:5]HG_ER_RemplaceQuiRéf:131>0)
				[HeberGement:5]HG_ER_RemplaceQuiRéf:131:=0
				[HeberGement:5]HG_ER_RemplaceQui:132:=""
				[HeberGement:5]HG_AutreSolutio:88:=""
			End if 
			
	End case 
	
Else 
	OBJECT SET VISIBLE:C603(*; "Exc_@"; $1)
	OBJECT SET VISIBLE:C603(*; "Remp_@"; $1)
End if 