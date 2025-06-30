//%attributes = {}

Case of 
	: ($1=0)
		REDUCE SELECTION:C351([HeberGement:5]; 0)
	: ($1=1)
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_ReportPurgeDt; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92>1)
		MultiSoc_Filter(->[HeberGement:5])
		CREATE SET:C116([HeberGement:5]; "E_Encours")
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=(vd_ReportPurgeDt-1); *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94="RP")
		MultiSoc_Filter(->[HeberGement:5])
		
		If (Records in selection:C76([HeberGement:5])>0)
			SELECTION TO ARRAY:C260([HeberGement:5]HG_HB_ID:19; $tl_Temp)
			For ($ii; 1; Size of array:C274($tl_Temp))
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_ReportPurgeDt; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_HB_ID:19=$tl_Temp{$ii})
				MultiSoc_Filter(->[HeberGement:5])
				If (Records in selection:C76([HeberGement:5])=1)
					ADD TO SET:C119([HeberGement:5]; "E_Encours")
				End if 
			End for 
		End if 
		USE SET:C118("E_Encours")
		CLEAR SET:C117("E_Encours")
		
	: ($1=2)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_ReportPurgeDt; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94="R@")
		MultiSoc_Filter(->[HeberGement:5])
		
	: ($1=3)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_ReportPurgeDt)
		MultiSoc_Filter(->[HeberGement:5])
End case 



vl_ReportPurgeNb:=Records in selection:C76([HeberGement:5])
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >)







