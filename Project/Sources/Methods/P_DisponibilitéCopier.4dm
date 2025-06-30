//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure:  P_DisponibilitéCopier
//{
//{          Lundi 20 décembre 2004 à 17:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (vl_LC_sDpJ>0)
	ALERT:C41("Les quantités 'Dispo' sont déjà renseignées !")
Else 
	CONFIRM:C162("Voulez-vous copier les valeurs 'Capacité' vers 'Dispo' ?")
	
	
	
	If (OK=1)
		If (Records in selection:C76([CentresLits:16])>0)
			i_Message("Copier en cours …")
			UNLOAD RECORD:C212([CentresLits:16])
			FIRST RECORD:C50([CentresLits:16])
			
			
			
			Repeat 
				Repeat 
					LOAD RECORD:C52([CentresLits:16])
				Until (Not:C34(Locked:C147([CentresLits:16])))
				//28/10/2009        
				//Si ([CentresLits]CL_Niveau=1)
				
				$va_LibCTRE:=""
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[CentresLits:16]CL_LC_ID:2)
				MultiSoc_Filter(->[LesCentres:9])
				$va_LibCTRE:=[LesCentres:9]LC_Nom:4
				$vb_OK:=True:C214
				If (Size of array:C274(<>ta_EXCLUS)>0)
					For ($ii; 1; Size of array:C274(<>ta_EXCLUS))
						If ($va_LibCTRE[[Num:C11(Substring:C12(<>ta_EXCLUS{$ii}; 3; 1))]]=Substring:C12(<>ta_EXCLUS{$ii}; 1; 1))
							$vb_OK:=False:C215
						End if 
					End for 
				End if 
				
				If ($vb_OK)
					
					[CentresLits:16]CL_DispoDuJour:12:=[CentresLits:16]CL_Capacité:4-[CentresLits:16]CL_Report:11  //-[CentresLits]CL_Excusés  `-[CentresLits]CL_Sortants
					
					
					If (<>vb_CentreEXClits)
						[CentresLits:16]CL_DispoTotal:5:=[CentresLits:16]CL_Report:11\
							+[CentresLits:16]CL_DispoDuJour:12\
							+[CentresLits:16]CL_Absents:13\
							+[CentresLits:16]CL_RestantsVeille:16
					Else 
						[CentresLits:16]CL_DispoTotal:5:=[CentresLits:16]CL_Report:11+[CentresLits:16]CL_DispoDuJour:12+[CentresLits:16]CL_Absents:13
					End if 
					[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_DispoTotal:5-[CentresLits:16]CL_Distribué:6  // [CentresLits]CL_Restant
					
					
					
					SAVE RECORD:C53([CentresLits:16])
				End if 
				//Fin de si 
				UNLOAD RECORD:C212([CentresLits:16])
				NEXT RECORD:C51([CentresLits:16])
			Until (End selection:C36([CentresLits:16]))
			REDRAW:C174([CentresLits:16])
			CLOSE WINDOW:C154
			
		End if 
	End if 
	
End if 