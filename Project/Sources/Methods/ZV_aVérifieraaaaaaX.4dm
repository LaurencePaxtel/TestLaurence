//%attributes = {}
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