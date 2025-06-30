//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Fonction : F_SIAOStatDonnees
//{          Mercredi 6 aril 2011 à 16:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_LONGINT:C283($1)
Case of 
		
	: ($1=0)
		$vb_OK:=False:C215
		If ([DiaLogues:3]DL_Date:2>!00-00-00!)
			If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
				QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Date:2=[DiaLogues:3]DL_Date:2; *)
			Else 
				QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Date:2>=[DiaLogues:3]DL_Date:2; *)
				QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Date:2<=[DiaLogues:3]DL_Date2:8; *)
			End if 
			$vb_OK:=True:C214
		End if 
		
		
		Case of 
			: (rAn1=1) & (rAn2=1)
			: (rAn1=0) & (rAn2=0)
			: (rAn1=0) & (rAn2=1)
				If ($vb_OK)
					QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_DemandeAnnulee_Date:30=!00-00-00!; *)
				Else 
					QUERY:C277([SIAO:50]; [SIAO:50]Si_DemandeAnnulee_Date:30=!00-00-00!; *)
				End if 
				$vb_OK:=True:C214
			: (rAn1=1) & (rAn2=0)
				If ($vb_OK)
					QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_DemandeAnnulee_Date:30>!00-00-00!; *)
				Else 
					QUERY:C277([SIAO:50]; [SIAO:50]Si_DemandeAnnulee_Date:30>!00-00-00!; *)
				End if 
				$vb_OK:=True:C214
		End case 
		
		Case of 
			: (trans1=1) & (trans2=1)
			: (trans1=0) & (trans2=0)
			: (trans1=1) & (trans2=0)
				If ($vb_OK)
					QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Trans_Type:34=True:C214; *)
				Else 
					QUERY:C277([SIAO:50]; [SIAO:50]Si_Trans_Type:34=True:C214; *)
				End if 
				$vb_OK:=True:C214
			: (trans1=0) & (trans2=1)
				If ($vb_OK)
					QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Trans_Type:34=False:C215; *)
				Else 
					QUERY:C277([SIAO:50]; [SIAO:50]Si_Trans_Type:34=False:C215; *)
				End if 
				$vb_OK:=True:C214
		End case 
		
		
		If (Ferm1=0)
			If ($vb_OK)
				QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Fermeture:46=!00-00-00!; *)
			Else 
				QUERY:C277([SIAO:50]; [SIAO:50]Si_Fermeture:46=!00-00-00!; *)
			End if 
			$vb_OK:=True:C214
		End if 
		
		
		Case of 
			: (Dem1=1) & (Dem2=1) & (Dem3=3)
			: (Dem1=0) & (Dem2=0) & (Dem3=0)
			: (Dem1=1) & (Dem2=0) & (Dem3=0)
				If ($vb_OK)
					QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=1; *)
				Else 
					QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=1; *)
				End if 
				$vb_OK:=True:C214
			: (Dem1=0) & (Dem2=1) & (Dem3=0)
				If ($vb_OK)
					QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=2; *)
				Else 
					QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=2; *)
				End if 
				$vb_OK:=True:C214
			: (Dem1=0) & (Dem2=0) & (Dem3=1)
				If ($vb_OK)
					QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=3; *)
				Else 
					QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=3; *)
				End if 
				$vb_OK:=True:C214
				
			: (Dem1=1) & (Dem2=1) & (Dem3=0)
				If ($vb_OK)
					QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=1; *)
					QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=2; *)
				Else 
					QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=1; *)
					QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=2; *)
				End if 
				$vb_OK:=True:C214
			: (Dem1=1) & (Dem2=0) & (Dem3=1)
				If ($vb_OK)
					QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=1; *)
					QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=3; *)
				Else 
					QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=1; *)
					QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=3; *)
				End if 
				$vb_OK:=True:C214
				
			: (Dem1=0) & (Dem2=1) & (Dem3=1)
				If ($vb_OK)
					QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Type:5=2; *)
					QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=3; *)
				Else 
					QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Type:5=2; *)
					QUERY:C277([SIAO:50];  | ; [SIAO:50]Si_Demande_Type:5=3; *)
				End if 
				$vb_OK:=True:C214
				
		End case 
		
		
		If ($vb_OK)
			QUERY:C277([SIAO:50])
		End if 
		vL_NbFiches:=Records in selection:C76([SIAO:50])
		$0:=(vL_NbFiches>0)
		
	: ($1=1)
		
End case 