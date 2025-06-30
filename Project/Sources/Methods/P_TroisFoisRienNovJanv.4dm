//%attributes = {}
//P_TroisFoisRienNovJanv
If (i_Confirmer("Nov-Janv"))
	i_Message("Recherche…")
	
	ARRAY LONGINT:C221($tl_RéfHB; 0)
	ARRAY LONGINT:C221($tl_RéfHB_Nuit1; 0)
	ARRAY LONGINT:C221($tl_LesCentres; 0)
	ARRAY LONGINT:C221($tl_LesCentresSatisf; 0)
	ARRAY LONGINT:C221(tl_3FR_Satisf; 0)
	ARRAY LONGINT:C221(tl_3FR_115; 0)
	
	vl_3FR_Tous:=0
	vl_3FR_TousPers:=0
	vl_3FR_Satisfait:=0
	vl_3FR_Satisfait:=0
	vl_3FR_SatisfaitN1:=0
	vl_3FR_SatisfaitN1Pers:=0
	vl_3FR_SatisfaitNewPers:=0
	vl_3FR_Satisfait115:=0
	vl_3FR_Satisfait115Pers:=0
	
	
	//••  Les centres du 115
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Répertoire:54="115")
	MultiSoc_Filter(->[LesCentres:9])
	If (Records in selection:C76([LesCentres:9])>0)
		SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tl_LesCentres)
	End if 
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=!2009-11-01!; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=!2010-01-31!; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
	MultiSoc_Filter(->[HeberGement:5])
	vl_3FR_Tous:=Records in selection:C76([HeberGement:5])
	DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_RéfHB)
	vl_3FR_TousPers:=Size of array:C274($tl_RéfHB)
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=!2009-11-01!; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=!2010-01-31!; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
	MultiSoc_Filter(->[HeberGement:5])
	vl_3FR_Satisfait:=Records in selection:C76([HeberGement:5])
	SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_3FR_Satisf; [HeberGement:5]HG_LC_ID:61; $tl_LesCentresSatisf)
	DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_RéfHB)
	vl_3FR_SatisfaitPers:=Size of array:C274($tl_RéfHB)
	
	If (Size of array:C274($tl_LesCentresSatisf)>0)
		For ($ii; 1; Size of array:C274($tl_LesCentresSatisf))
			$jj:=Find in array:C230($tl_LesCentres; $tl_LesCentresSatisf{$ii})
			If ($jj>0)
				INSERT IN ARRAY:C227(tl_3FR_115; Size of array:C274(tl_3FR_115)+1)
				tl_3FR_115{Size of array:C274(tl_3FR_115)}:=tl_3FR_Satisf{$ii}
			End if 
		End for 
	End if 
	QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_115)
	vl_3FR_Satisfait115:=Records in selection:C76([HeberGement:5])
	DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_RéfHB)
	vl_3FR_Satisfait115Pers:=Size of array:C274($tl_RéfHB)
	
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=!2009-11-01!; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=!2010-01-31!; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Signalement:12="115"; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1)
	MultiSoc_Filter(->[HeberGement:5])
	vl_3FR_SatisfaitN1:=Records in selection:C76([HeberGement:5])
	DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_RéfHB_Nuit1)
	vl_3FR_SatisfaitN1Pers:=Size of array:C274($tl_RéfHB_Nuit1)
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4<!2009-11-01!; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
	MultiSoc_Filter(->[HeberGement:5])
	DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_RéfHB)
	
	For ($ii; 1; Size of array:C274($tl_RéfHB))
		$jj:=Find in array:C230($tl_RéfHB_Nuit1; $tl_RéfHB{$ii})
		If ($jj>0)
			DELETE FROM ARRAY:C228($tl_RéfHB_Nuit1; $jj; 1)
		End if 
	End for 
	vl_3FR_SatisfaitNewPers:=Size of array:C274($tl_RéfHB_Nuit1)
	
	CLOSE WINDOW:C154
End if 