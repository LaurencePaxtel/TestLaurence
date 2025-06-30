//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Rec_Hébergements1
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée : Mardi 18 mars 2008 à 11:25
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)

LOAD RECORD:C52([HeBerge:4])

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
MultiSoc_Filter(->[HeberGement:5])

If (Count parameters:C259=1)
	
	If (Records in selection:C76([HeberGement:5])>0)
		va_IDT_TypTrans:=[HeberGement:5]HG_EtatCivil:20
	Else 
		va_IDT_TypTrans:=""
	End if 
	
	If (<>vb_T_ModeCHRS=True:C214)
		
		Case of 
			: (va_JourNuit="X")
				
				If (wSansFiltre=1)
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
				End if 
				
			: (va_JourNuit#"JN")
				QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=(va_JourNuit="N"))
		End case 
		
		If (va_JourNuit#"X")
			
			If (wSansFiltre=1)
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
			End if 
			
		End if 
		
		Case of 
			: (va_JourNuit="X")
				
				If (wSansFiltre=1)
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
				End if 
				
			: (va_JourNuit#"JN")
				QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=(va_JourNuit="N"))
		End case 
		
		If (va_JourNuit#"X")
			
			If (wSansFiltre=1)
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
			End if 
			
		End if 
		
	End if 
	
	$1->:=Records in selection:C76([HeberGement:5])
End if 

ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)

//ENREGISTREMENT PRÉCEDENT([HeberGement])