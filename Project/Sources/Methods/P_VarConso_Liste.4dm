//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_VarConso_Liste
//{
//{          Mardi 17 février 2009 à 13:35:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_LONGINT:C283($ii; $jj; $kk)
C_TEXT:C284($vt_Temp)
C_BOOLEAN:C305($vb_OK)

Case of 
	: ($1=0)
		C_LONGINT:C283(vl_ConsoB_DocumentLignes)
		C_TEXT:C284(va_ConsoB_Document)
		C_LONGINT:C283(vl_ConsoB_DocumentLignes)
		
		C_TEXT:C284(vt_ConsoB_Chemin)
		C_TEXT:C284(vt_ConsoB_CheminDossier)
		C_TEXT:C284(vt_ConsoB_Dossier)
		C_TEXT:C284(vt_ConsoB_Document)
		C_TEXT:C284(vt_ConsoB_Titre)
		
		C_TEXT:C284(vt_ConsoB_Buffer)
		
	: ($1=1)
		vl_ConsoB_DocumentLignes:=0
		va_ConsoB_Document:=""
		ARRAY TEXT:C222(ta_ConsoB_Document; 0)
		vt_ConsoB_Chemin:=""
		vt_ConsoB_CheminDossier:=""
		vt_ConsoB_Dossier:=""
		
		
	: ($1=2)
		
	: ($1=3)
		vt_ConsoB_Chemin:=""
		vt_ConsoB_CheminDossier:=""
		vt_ConsoB_Dossier:=""
		
	: ($1=4)
		t_ConsoB_Document:=""
		vt_ConsoB_Titre:=""
		
		
	: ($1=5)
		
		P_VarConso_Liste(1)
		$vb_OK:=F_Report_FullDuplexDossier(11; <>vt_T_CheminRép)
		If ($vb_OK=False:C215)
			// ALERTE("Absence de repertoire TRANS")
		End if 
		
		If ($vb_OK)
			// on cherche le répertoire on l'on RÉCUPÈRE les fiches
			vt_FullDuplexDossier:=<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12
			$vb_OK:=F_Report_FullDuplexDossier(11; vt_FullDuplexDossier)
			If ($vb_OK)
				<>va_ConsoB_115:=True:C214
			Else 
				//  ALERTE("Absence de repertoire")
			End if 
		End if 
		
		If ($vb_OK)  //•y a t il des fiches
			i_Message("     Mise à jour…")
			$jj:=0
			$kk:=0
			vt_ConsoB_CheminDossier:=vt_FullDuplexDossier
			DOCUMENT LIST:C474(vt_FullDuplexDossier; ta_ConsoB_Document)
			If (Size of array:C274(ta_ConsoB_Document)>0)
				
				$jj:=0
				$kk:=Size of array:C274(ta_ConsoB_Document)
				
				$ii:=1
				Repeat 
					$jj:=$jj+1
					i_MessageSeul("     Mise à jour : "+String:C10($kk)+"/"+String:C10($jj))
					
					If (Substring:C12(ta_ConsoB_Document{$ii}; Length:C16(ta_ConsoB_Document{$ii})-3; 4)=".TXT")
						$vt_Temp:=Substring:C12(ta_ConsoB_Document{$ii}; 1; Length:C16(ta_ConsoB_Document{$ii})-4)
					Else 
						$vt_Temp:=ta_ConsoB_Document{$ii}
					End if 
					$vb_OK:=(Length:C16($vt_Temp)>=25)
					$vb_OK:=$vb_OK & (Length:C16($vt_Temp)<=32)
					$vb_OK:=$vb_OK & ($vt_Temp[[12]]="h")  //Heure
					$vb_OK:=$vb_OK & (($vt_Temp[[22]]="H") | ($vt_Temp[[23]]="H") | ($vt_Temp[[22]]="F") | ($vt_Temp[[23]]="F"))  //Homme ou femme        
					If ($vb_OK)
						$ii:=$ii+1
					Else 
						DELETE FROM ARRAY:C228(ta_ConsoB_Document; $ii; 1)
					End if 
				Until ($ii>Size of array:C274(ta_ConsoB_Document))
				ta_ConsoB_Document:=1
			End if 
			CLOSE WINDOW:C154
		End if 
		vl_ConsoB_DocumentLignes:=Size of array:C274(ta_ConsoB_Document)
		va_ConsoB_DocumentLignes:=String:C10(vl_ConsoB_DocumentLignes)+" fiche"+("s"*Num:C11(vl_ConsoB_DocumentLignes>1))+" trouvée"+("s"*Num:C11(vl_ConsoB_DocumentLignes>1))+" le "+String:C10(Current date:C33; Système date court:K1:1)+" à "+String:C10(Current time:C178; h mn:K7:2)
		
		
	: ($1=10)
		$ii:=1
		Repeat 
			If ((Length:C16(ta_ConsoB_Document{$ii})>=25) & (Length:C16(ta_ConsoB_Document{$ii})<=32))
				$ii:=$ii+1
			Else 
				DELETE FROM ARRAY:C228(ta_ConsoB_Document; $ii; 1)
			End if 
		Until ($ii>Size of array:C274(ta_ConsoB_Document))
End case 

