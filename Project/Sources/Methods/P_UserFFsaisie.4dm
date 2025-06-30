//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_UserFFsaisie
//{          Mardi 12 avril 2011 à 11:55:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_BOOLEAN:C305($B_Dummy)

Case of 
	: ($1=Sur chargement:K2:1)
		ARRAY TEXT:C222(ta_UserGroupe; 0)
		ARRAY TEXT:C222(ta_LesPlatefomes; 0)
		
		ARRAY LONGINT:C221(tl_UserGroupe; 0)
		
		If (Is new record:C668([INtervenants:10]))
			MultiSoc_Init_Structure(->[INtervenants:10])
			SET WINDOW TITLE:C213("Utilisateur : nouveau")
			
			[INtervenants:10]IN_RéférenceID:1:=Uut_Numerote(->[INtervenants:10])
			
			OBJECT SET VISIBLE:C603(*; "IN_MP@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Bt_INsup"; False:C215)
		Else 
			SET WINDOW TITLE:C213("Utilisateur : modifier")
			
			If ([INtervenants:10]IN_RéfUser:11#0)
				va_Login:=""
				va_Proc:=""
				va_MTP:=""
				
				vl_Utilisations:=0
				gError:=0
				
				vd_Date:=!00-00-00!
				
				ON ERR CALL:C155("i_Error")
				$pos_el:=Find in array:C230(ta_UserLog; [INtervenants:10]IN_Login:3)
				
				If ($pos_el#-1)
					
					If ([INtervenants:10]IN_RéfUser:11#tl_UserNo{$pos_el})
						[INtervenants:10]IN_RéfUser:11:=tl_UserNo{$pos_el}
						SAVE RECORD:C53([INtervenants:10])
					End if 
					
					GET USER PROPERTIES:C611([INtervenants:10]IN_RéfUser:11; va_Login; va_Proc; va_MTP; vl_Utilisations; vd_Date; tl_UserGroupe)
					ON ERR CALL:C155("")
					
					If (Size of array:C274(tl_UserGroupe)>0)
						ARRAY TEXT:C222(ta_UserGroupe; Size of array:C274(tl_UserGroupe))
						
						For ($ii; 1; Size of array:C274(tl_UserGroupe))
							$Position:=Find in array:C230(tl_LesGroupes; tl_UserGroupe{$ii})
							
							If ($Position>0)
								ta_UserGroupe{$ii}:=ta_LesGroupes{$Position}
							Else 
								ta_UserGroupe{$ii}:="???"
							End if 
							
						End for 
						
					End if 
					
					$B_Dummy:=Acces_Plateforme(2; [INtervenants:10]IN_Notes:6)
				Else 
					ALERT:C41("L'utilisateur n'est pas référencé, il ne peut donc pas être modifié. !")
					CANCEL:C270
				End if 
				
			End if 
			
		End if 
		
		va_Type:=""
		
		If ([INtervenants:10]IN_Type:2#0)
			va_Type:=Substring:C12(<>ta_Types{[INtervenants:10]IN_Type:2}; 5)
			va_TypeN:=String:C10([INtervenants:10]IN_Type:2)
		Else 
			[INtervenants:10]IN_Type:2:=1
			
			va_TypeN:=String:C10([INtervenants:10]IN_Type:2)
			va_Type:=Substring:C12(<>ta_Types{[INtervenants:10]IN_Type:2}; 5)
		End if 
		
		// Modifié par : Scanu Rémy (18/01/2024)
		If ([INtervenants:10]IN_LDAP:21=Null:C1517)
			[INtervenants:10]IN_LDAP:21:=New object:C1471("login"; [INtervenants:10]IN_Email:20; "password"; ""; "group"; New object:C1471("connection"; ""))
		End if 
		
		MULTI SORT ARRAY:C718(ta_UserGroupe; >; tl_UserGroupe)
	: ($1=Sur données modifiées:K2:15)
		
		If (Modified:C32([INtervenants:10]IN_Nom:4) | Modified:C32([INtervenants:10]IN_Prénom:5))
			[INtervenants:10]IN_NomPrénom:8:=[INtervenants:10]IN_Nom:4+" "+[INtervenants:10]IN_Prénom:5
			[INtervenants:10]IN_Login:3:=[INtervenants:10]IN_Nom:4+" "+[INtervenants:10]IN_Prénom:5
			
			If (Find in array:C230(ta_UserLog; [INtervenants:10]IN_Login:3)>0)
				[INtervenants:10]IN_RéfUser:11:=tl_UserNo{Find in array:C230(ta_UserLog; [INtervenants:10]IN_Login:3)}
			Else 
				[INtervenants:10]IN_RéfUser:11:=0
			End if 
			
		End if 
		
		If (Modified:C32([INtervenants:10]IN_Login:3))
			
			If (Find in array:C230(ta_UserLog; [INtervenants:10]IN_Login:3)>0)
				[INtervenants:10]IN_RéfUser:11:=tl_UserNo{Find in array:C230(ta_UserLog; [INtervenants:10]IN_Login:3)}
			Else 
				[INtervenants:10]IN_RéfUser:11:=0
			End if 
			
		End if 
		
End case 