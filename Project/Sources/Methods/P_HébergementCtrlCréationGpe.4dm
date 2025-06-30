//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : P_HébergementCtrlCréationGpe
//{
//{          Mardi 16 mars 2004 à 12:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($vl_Nb_J; $vl_Nb_N; $kk)
C_BOOLEAN:C305($vb_OK; $vb_Nuit)
C_DATE:C307($vd_Date)

$vd_Date:=Current date:C33

vb_PasseR:=True:C214
vl_NbHéberGements:=0

<>ta_GpEtat{$2}:=""
<>te_GpEtat{$2}:=0

QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=<>tl_GpHBID{$2})
MultiSoc_Filter(->[HeBerge:4])

If ([HeBerge:4]HB_Status:18)
	vb_PasseR:=False:C215
	
	<>te_GpEtat{$2}:=-1
	<>ta_GpEtat{$2}:="P.non grata"
Else 
	$kk:=Num:C11([HeBerge:4]HB_Cas1:7)+Num:C11([HeBerge:4]HB_Cas2:8)+Num:C11([HeBerge:4]HB_Cas3:9)+Num:C11([HeBerge:4]HB_Cas4:10)+Num:C11([HeBerge:4]HB_Cas5:11)
	$kk:=$kk+Num:C11([HeBerge:4]HB_Cas6:12)+Num:C11([HeBerge:4]HB_Cas7:13)+Num:C11([HeBerge:4]HB_Cas8:14)+Num:C11([HeBerge:4]HB_Cas9:15)+Num:C11([HeBerge:4]HB_Cas10:16)
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=<>tl_GpHBID{$2}; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4=$vd_Date)
	MultiSoc_Filter(->[HeberGement:5])
	
	vl_NbHéberGements:=Records in selection:C76([HeberGement:5])
	
	If (<>vb_MaxFichesHG)
		
		Case of 
			: (vl_NbHéberGements=0)
				$vl_Nb_J:=0
				$vl_Nb_N:=0
			: (vl_NbHéberGements=1)
				
				If ([HeberGement:5]HG_Nuit:2)  //C'est la nuit
					$vl_Nb_N:=1
					$vl_Nb_J:=0
				Else 
					$vl_Nb_N:=0
					$vl_Nb_J:=1
				End if 
				
			: (vl_NbHéberGements>1)
				FIRST RECORD:C50([HeberGement:5])
				
				Repeat 
					
					If ([HeberGement:5]HG_Nuit:2)  //C'est la nuit
						$vl_Nb_N:=$vl_Nb_N+1
					Else 
						$vl_Nb_J:=$vl_Nb_J+1
					End if 
					
					NEXT RECORD:C51([HeberGement:5])
				Until (End selection:C36([HeberGement:5]))
				
		End case 
		
		$vb_OK:=(($1="J") & (<>vl_MaxFichesHG_J>$vl_Nb_J)) | (($1="N") & (<>vl_MaxFichesHG_N>$vl_Nb_N))
		
		If ($vb_OK)
			
			If ($kk>0)
				<>ta_GpEtat{$2}:="SP"
			Else 
				<>ta_GpEtat{$2}:=""
			End if 
			
			<>te_GpEtat{$2}:=0
		Else 
			vb_PasseR:=False:C215
			
			<>te_GpEtat{$2}:=-2
			<>ta_GpEtat{$2}:="J&N: "+String:C10([HeberGement:5]HG_Date:4; 1)  //"F.Double"      
		End if 
		
	Else 
		
		If (vl_NbHéberGements>0)
			
			If (vl_NbHéberGements>=2)
				vb_PasseR:=False:C215
				
				<>te_GpEtat{$2}:=-2
				<>ta_GpEtat{$2}:="J&N: "+String:C10([HeberGement:5]HG_Date:4; 1)  //"F.Double"      
			Else 
				$vb_Nuit:=($1="N")
				
				If ([HeberGement:5]HG_Nuit:2=$vb_Nuit)
					vb_PasseR:=False:C215
					
					<>te_GpEtat{$2}:=-1
					<>ta_GpEtat{$2}:=$1+": "+String:C10([HeberGement:5]HG_Date:4; 1)  //"F.Double"              
				Else 
					
					If ([HeberGement:5]HG_Nuit:2)
						vb_PasseR:=False:C215
						
						<>te_GpEtat{$2}:=-1
						<>ta_GpEtat{$2}:="N: "+String:C10([HeberGement:5]HG_Date:4; 1)
					Else 
						$kk:=Num:C11([HeBerge:4]HB_Cas1:7)+Num:C11([HeBerge:4]HB_Cas2:8)+Num:C11([HeBerge:4]HB_Cas3:9)+Num:C11([HeBerge:4]HB_Cas4:10)+Num:C11([HeBerge:4]HB_Cas5:11)
						$kk:=$kk+Num:C11([HeBerge:4]HB_Cas6:12)+Num:C11([HeBerge:4]HB_Cas7:13)+Num:C11([HeBerge:4]HB_Cas8:14)+Num:C11([HeBerge:4]HB_Cas9:15)+Num:C11([HeBerge:4]HB_Cas10:16)
						
						If ($kk>0)
							<>ta_GpEtat{$2}:="SP"+"J: "+String:C10([HeberGement:5]HG_Date:4; 1)
						Else 
							<>ta_GpEtat{$2}:="J: "+String:C10([HeberGement:5]HG_Date:4; 1)
						End if 
						
						<>te_GpEtat{$2}:=0
					End if 
					
				End if 
				
			End if 
			
		Else 
			$kk:=Num:C11([HeBerge:4]HB_Cas1:7)+Num:C11([HeBerge:4]HB_Cas2:8)+Num:C11([HeBerge:4]HB_Cas3:9)+Num:C11([HeBerge:4]HB_Cas4:10)+Num:C11([HeBerge:4]HB_Cas5:11)
			$kk:=$kk+Num:C11([HeBerge:4]HB_Cas6:12)+Num:C11([HeBerge:4]HB_Cas7:13)+Num:C11([HeBerge:4]HB_Cas8:14)+Num:C11([HeBerge:4]HB_Cas9:15)+Num:C11([HeBerge:4]HB_Cas10:16)
			
			If ($kk>0)
				<>ta_GpEtat{$2}:="SP"
			Else 
				<>ta_GpEtat{$2}:=""
			End if 
			
			<>te_GpEtat{$2}:=0
		End if 
		
	End if 
	
End if 

$0:=vb_PasseR