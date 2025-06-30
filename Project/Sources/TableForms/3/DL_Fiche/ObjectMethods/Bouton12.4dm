C_BOOLEAN:C305($vb_OK)

If (Size of array:C274(<>ta_ConsoB_Document)>0)
	If (<>ta_ConsoB_Document>0)
		//Condition
		$vb_OK:=False:C215
		If (Substring:C12(<>ta_ConsoB_Document{<>ta_ConsoB_Document}; Length:C16(<>ta_ConsoB_Document{<>ta_ConsoB_Document})-3; 4)=".TXT")
			$vb_OK:=(Length:C16(<>ta_ConsoB_Document{<>ta_ConsoB_Document})>=29)
			$vb_OK:=$vb_OK & (Length:C16(<>ta_ConsoB_Document{<>ta_ConsoB_Document})<=32)
			$vb_OK:=$vb_OK & (Substring:C12(<>ta_ConsoB_Document{<>ta_ConsoB_Document}; Length:C16(<>ta_ConsoB_Document{<>ta_ConsoB_Document})-5; 2)#"LU")
		Else 
			$vb_OK:=(Length:C16(<>ta_ConsoB_Document{<>ta_ConsoB_Document})>=25)
			$vb_OK:=$vb_OK & (Length:C16(<>ta_ConsoB_Document{<>ta_ConsoB_Document})<=28)
			$vb_OK:=$vb_OK & (Substring:C12(<>ta_ConsoB_Document{<>ta_ConsoB_Document}; Length:C16(<>ta_ConsoB_Document{<>ta_ConsoB_Document})-1; 2)#"LU")
		End if 
		$vb_OK:=$vb_OK & (<>ta_ConsoB_Document{<>ta_ConsoB_Document}[[12]]="h")  //Heure
		$vb_OK:=$vb_OK & ((<>ta_ConsoB_Document{<>ta_ConsoB_Document}[[22]]="H") | (<>ta_ConsoB_Document{<>ta_ConsoB_Document}[[22]]="F"))  //Homme ou femme
		
		If ($vb_OK)
			If (i_Confirmer("Document :"+<>ta_ConsoB_Document{<>ta_ConsoB_Document}+<>va_CR+"Signaler comme lu et dépalcer"))
				ALERT:C41("Déplacement du document : "+<>ta_ConsoB_Document{<>ta_ConsoB_Document}+" réalisé.")
				vt_DTitreDocument:=""
				vt_DTitreDocumentLu:=""
				
				vt_DTitreDocument:=<>vt_ConsoB_CheminDossier+<>ta_ConsoB_Document{<>ta_ConsoB_Document}
				vt_DTitreDocument:=F_FichierSuffixe(vt_DTitreDocument)
				
				//• On teste l'existence du dossier  115 Lu
				vt_DTitreDocumentLu:=<>vt_ConsoB_CheminDossier+<>va_Rép_TransReportLU+Séparateur dossier:K24:12
				$vb_OK:=F_Report_FullDuplexDossier(12; vt_DTitreDocumentLu)
				
				If ($vb_OK)
					//• On teste l'existence dans dossier lu du dossier site
					vt_DTitreDocumentLu:=vt_DTitreDocumentLu+Substring:C12(<>ta_ConsoB_Document{<>ta_ConsoB_Document}; 1; 3)+Séparateur dossier:K24:12
					$vb_OK:=F_Report_FullDuplexDossier(12; vt_DTitreDocumentLu)
					If ($vb_OK)
						//• On teste l'existence dans dossier lu et dossier site le mois (AAAAMM
						vt_DTitreDocumentLu:=vt_DTitreDocumentLu+Substring:C12(<>ta_ConsoB_Document{<>ta_ConsoB_Document}; 1; 3)
						vt_DTitreDocumentLu:=vt_DTitreDocumentLu+"20"+Substring:C12(<>ta_ConsoB_Document{<>ta_ConsoB_Document}; 4; 2)
						vt_DTitreDocumentLu:=vt_DTitreDocumentLu+Substring:C12(<>ta_ConsoB_Document{<>ta_ConsoB_Document}; 6; 2)
						vt_DTitreDocumentLu:=vt_DTitreDocumentLu+Séparateur dossier:K24:12
						$vb_OK:=F_Report_FullDuplexDossier(12; vt_DTitreDocumentLu)
					End if 
				End if 
				
				If ($vb_OK)
					vt_DTitreDocumentLu:=vt_DTitreDocumentLu+<>ta_ConsoB_Document{<>ta_ConsoB_Document}
					If (Substring:C12(vt_DTitreDocumentLu; Length:C16(vt_DTitreDocumentLu)-3; 4)=".TXT")
						vt_DTitreDocumentLu:=Substring:C12(vt_DTitreDocumentLu; 1; Length:C16(vt_DTitreDocumentLu)-4)
					End if 
					vt_DTitreDocumentLu:=vt_DTitreDocumentLu+" LU"
					vt_DTitreDocumentLu:=F_FichierSuffixe(vt_DTitreDocumentLu)
					
					
					COPY DOCUMENT:C541(vt_DTitreDocument; vt_DTitreDocumentLu)
					DELETE DOCUMENT:C159(vt_DTitreDocument)
					//    DEPLACER DOCUMENT(vt_DTitreDocument;vt_DTitreDocumentLu)
					If (OK=1)
						BEEP:C151
						ALERT:C41("Déplacement du document : "+<>ta_ConsoB_Document{<>ta_ConsoB_Document}+" réalisé.")
						DELETE FROM ARRAY:C228(<>ta_ConsoB_Document; <>ta_ConsoB_Document; 1)
						If (<>ta_ConsoB_Document>Size of array:C274(<>ta_ConsoB_Document))
							<>ta_ConsoB_Document:=Size of array:C274(<>ta_ConsoB_Document)
						End if 
						If (<>ta_ConsoB_Document>0)
							P_ConsoVoir(<>ta_ConsoB_Document)
						End if 
					End if 
				End if 
				
			End if 
		Else 
			ALERT:C41("Document déja lu !")
		End if 
	End if 
End if 