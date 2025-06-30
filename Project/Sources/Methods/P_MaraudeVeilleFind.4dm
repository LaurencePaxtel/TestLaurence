//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_MaraudeVeilleFind
//{
//{          Vendredi 1 juillet 2004 à 11:04
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
		QUERY:C277([Maraude:24]; [Maraude:24]MR_Date:4=[DiaLogues:3]DL_Date:2; *)
	Else 
		QUERY:C277([Maraude:24]; [Maraude:24]MR_Date:4>=[DiaLogues:3]DL_Date:2; *)
		QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Date:4<=[DiaLogues:3]DL_Date2:8; *)
	End if 
	Case of 
		: (rJourNuit1=1) & (rJourNuit2=0)
			QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nuit:2=False:C215; *)
		: (rJourNuit1=0) & (rJourNuit2=1)
			QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nuit:2=True:C214; *)
	End case 
	
	If ([DiaLogues:3]DL_Libellé:3>"")
		QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_EMA:11=([DiaLogues:3]DL_Libellé:3+"@"); *)
	End if 
	If ([DiaLogues:3]DL_LibelAutre:5>"")
		QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_ArrondCP:15=[DiaLogues:3]DL_LibelAutre:5; *)
	End if 
	If ([DiaLogues:3]DL_LibelPlus:6>"")
		QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nom:17=([DiaLogues:3]DL_LibelPlus:6+"@"); *)
	End if 
	QUERY:C277([Maraude:24])
	MultiSoc_Filter(->[Maraude:24])
	//Etat civil  
	If (Size of array:C274(ta_xEtCiv)>0)
		If (Records in selection:C76([Maraude:24])>0)
			$ij:=0
			$vbOK:=False:C215
			For ($ii; 1; Size of array:C274(ta_xEtCiv))
				$ij:=$ij+te_xEtCiv{$ii}
			End for 
			If ($ij>0) & ($ij<Size of array:C274(ta_xEtCiv))
				For ($ii; 1; Size of array:C274(ta_xEtCiv))
					If (te_xEtCiv{$ii}=1)
						If ($vbOK)
							QUERY SELECTION:C341([Maraude:24];  | ; [Maraude:24]MR_EtatCivil:16=ta_xEtCiv{$ii}; *)
						Else 
							QUERY SELECTION:C341([Maraude:24]; [Maraude:24]MR_EtatCivil:16=ta_xEtCiv{$ii}; *)
						End if 
						$vbOK:=True:C214
					End if 
				End for 
				QUERY SELECTION:C341([Maraude:24])
			End if 
		End if 
	End if 
	//Signalement  
	If (Size of array:C274(ta_xSglt)>0)
		If (Records in selection:C76([Maraude:24])>0)
			$ij:=0
			$vbOK:=False:C215
			For ($ii; 1; Size of array:C274(ta_xSglt))
				$ij:=$ij+te_xSglt{$ii}
			End for 
			If ($ij>0) & ($ij<Size of array:C274(ta_xSglt))
				For ($ii; 1; Size of array:C274(ta_xSglt))
					If (te_xSglt{$ii}=1)
						If ($vbOK)
							QUERY SELECTION:C341([Maraude:24];  | ; [Maraude:24]MR_Signalt:12=ta_xSglt{$ii}; *)
						Else 
							QUERY SELECTION:C341([Maraude:24]; [Maraude:24]MR_Signalt:12=ta_xSglt{$ii}; *)
						End if 
						$vbOK:=True:C214
					End if 
				End for 
				QUERY SELECTION:C341([Maraude:24])
			End if 
		End if 
	End if 
End if 

vL_NbFiches:=Records in selection:C76([Maraude:24])
If (vL_NbFiches>0)
	P_MaraudeVeilleSort(2)
End if 