//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_Conso_Transfert
//{          Mercredi 16 mai 2012 à 12:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii; $vl_taille)

Case of 
	: ($1="DeclarerParam")
		C_TEXT:C284(vt_ConsoTransfertTXT)
		C_LONGINT:C283(vl_ConsoTransfert; ve_ConsoTransfertMinutes; vl_ConsoTransfertTicks)
		C_BOOLEAN:C305(vb_ConsoTransfert; vb_ConsoTransfertServeur)
		C_TIME:C306(vh_ConsoTransfert1; vh_ConsoTransfert2; vh_ConsoTransfertPeriode; vh_ConsoTransfertTicks)
	: ($1="Declarer")
		C_TEXT:C284(vt_ConsoTransfertOrigine; vt_ConsoTransfertDestination)
		C_BOOLEAN:C305(vb_ConsoTransfertOK)
		
		ARRAY TEXT:C222(tt_ConsoDocu; 0)
		ARRAY TEXT:C222(ta_ConsoDocuFichier; 0)
		
		ARRAY INTEGER:C220(te_ConsoDocuCheck; 0)
	: ($1="Initialiser")
		vb_ConsoTransfertOK:=True:C214
		
		ARRAY TEXT:C222(tt_ConsoDocu; 0)
		ARRAY TEXT:C222(ta_ConsoDocuFichier; 0)
		
		ARRAY INTEGER:C220(te_ConsoDocuCheck; 0)
	: ($1="Actualiser")
		P_Conso_Transfert("Initialiser")
		vb_ConsoTransfertOK:=True:C214
		
		If (F_Dossier("DocuSSP"; ->vt_ConsoTransfertOrigine))
			$vb_OK:=F_Dossier("DocuChemin"; ->vt_ConsoTransfertOrigine)
		End if 
		
	: ($1="VoirTransfert")
		P_Conso_Transfert("Initialiser")
		vb_ConsoTransfertOK:=False:C215
		
		If (F_Dossier("DocuSSP"; ->vt_ConsoTransfertDestination))
			$vb_OK:=F_Dossier("DocuChemin"; ->vt_ConsoTransfertDestination)
		End if 
		
	: ($1="Transferer")
		$vb_OK:=vb_ConsoTransfertOK
		$vb_OK:=$vb_OK & (Size of array:C274(ta_ConsoDocuFichier)>0)
		
		If ($vb_OK)
			$vl_taille:=Size of array:C274(ta_ConsoDocuFichier)
			
			For ($ii; 1; $vl_Taille)
				
				If (te_ConsoDocuCheck{$ii}=0)
					MOVE DOCUMENT:C540(F_FichierSuffixe(vt_ConsoTransfertOrigine+<>va_Rép_TransReport+Séparateur dossier:K24:12+ta_ConsoDocuFichier{$ii}); F_FichierSuffixe(vt_ConsoTransfertDestination+<>va_Rép_TransReport+Séparateur dossier:K24:12+ta_ConsoDocuFichier{$ii}))
					
					If (OK=1)
						te_ConsoDocuCheck{$ii}:=1
					End if 
					
				End if 
				
			End for 
			
			P_Conso_Transfert("Actualiser")
		End if 
		
End case 