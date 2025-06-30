//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementExcuserRec
//{
//{          Mardi 11 Mai 2004 à 10:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

ARRAY LONGINT:C221($tl_ExcRefOK; 0)
ARRAY LONGINT:C221($tl_ExcRef; 0)
ARRAY LONGINT:C221($tl_ExcRefHB; 0)
ARRAY LONGINT:C221($tl_RempRefHBREP; 0)
C_DATE:C307($vd_Date)

If ([HeberGement:5]HG_Date:4#!00-00-00!)
	$vd_Date:=[HeberGement:5]HG_Date:4
Else 
	$vd_Date:=Current date:C33
End if 

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_ER_Excuse:124=True:C214)
MultiSoc_Filter(->[HeberGement:5])
SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_ExcRef; [HeberGement:5]HG_HB_ID:19; $tl_ExcRefHB)

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_Date; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_ER_Remplaçant:130=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
If (7=8)
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_ER_Remplaçant:130=True:C214; *)
	QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
End if 

MultiSoc_Filter(->[HeberGement:5])

SELECTION TO ARRAY:C260([HeberGement:5]HG_ER_RemplaceQuiRéf:131; $tl_RempRefHBREP)


If (Size of array:C274($tl_ExcRef)>0)
	If (Size of array:C274($tl_RempRefHBREP)>0)
		For ($ii; 1; Size of array:C274($tl_ExcRef))
			$Pos:=Find in array:C230($tl_RempRefHBREP; $tl_ExcRefHB{$ii})
			If ($Pos>0)
			Else 
				INSERT IN ARRAY:C227($tl_ExcRefOK; Size of array:C274($tl_ExcRefOK)+1)
				$tl_ExcRefOK{Size of array:C274($tl_ExcRefOK)}:=$tl_ExcRef{$ii}
			End if 
		End for 
	Else 
		COPY ARRAY:C226($tl_ExcRef; $tl_ExcRefOK)
	End if 
Else 
	ARRAY LONGINT:C221($tl_ExcRefOK; 0)
End if 


If (Size of array:C274($tl_ExcRefOK)>0)
	QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tl_ExcRefOK)
Else 
	REDUCE SELECTION:C351([HeberGement:5]; 0)
End if 

MultiSoc_Filter(->[HeberGement:5])

ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_CentreNom:62; >)
vl_NbHéberGements:=Records in selection:C76([HeberGement:5])