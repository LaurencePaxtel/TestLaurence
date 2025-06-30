//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbAppelsTypes
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_TailTab)
C_LONGINT:C283($vl_TempJ; $vl_TempN; $ii)

vl_Prest:=0
vr_PrestPc:=0

$vl_TailTab:=0
$vl_TempJ:=0
$vl_TempN:=0

If (vd_Date1=vd_Date2)
	QUERY:C277([APpels:19]; [APpels:19]AP_Date:2=vd_Date1)
Else 
	QUERY:C277([APpels:19]; [APpels:19]AP_Date:2>=vd_Date1; *)
	QUERY:C277([APpels:19];  & ; [APpels:19]AP_Date:2<=vd_Date2)
	MultiSoc_Filter(->[APpels:19])
End if 
If (Records in selection:C76([APpels:19])>0)
	CREATE SET:C116([APpels:19]; "E_TTabAppel")
Else 
	CREATE EMPTY SET:C140([APpels:19]; "E_TTabAppel")
End if 
If (Records in set:C195("E_TTabAppel")>0)
	DISTINCT VALUES:C339([APpels:19]AP_Libellé:5; ta_PrestDem)
	ARRAY LONGINT:C221(t_Prest; Size of array:C274(ta_PrestDem))
	For ($ii; 1; Size of array:C274(t_Prest))
		t_Prest{$ii}:=0
	End for 
Else 
	ARRAY TEXT:C222(ta_PrestDem; 0)
	ARRAY LONGINT:C221(t_Prest; 0)
	vl_Prest:=0
	vr_PrestPc:=0
End if 

$vl_TailTab:=Size of array:C274(ta_PrestDem)
If ($vl_TailTab>0)
	For ($ii; 1; $vl_TailTab)
		USE SET:C118("E_TTabAppel")
		QUERY SELECTION:C341([APpels:19]; [APpels:19]AP_Libellé:5=ta_PrestDem{$ii})
		If (Records in selection:C76([APpels:19])>0)
			//FIRST RECORD([APpels])
			Repeat 
				Case of 
					: (rJourNuit1=1) & (rJourNuit2=1)
						t_Prest{$ii}:=t_Prest{$ii}+1
						vl_Prest:=vl_Prest+1
					: (rJourNuit1=1) & (rJourNuit2=0)
						If ([APpels:19]AP_Nuit:4=False:C215)
							t_Prest{$ii}:=t_Prest{$ii}+1
							vl_Prest:=vl_Prest+1
						End if 
					: (rJourNuit1=0) & (rJourNuit2=1)
						If ([APpels:19]AP_Nuit:4=True:C214)
							t_Prest{$ii}:=t_Prest{$ii}+1
							vl_Prest:=vl_Prest+1
						End if 
					: (rJourNuit1=0) & (rJourNuit2=0)
				End case 
				NEXT RECORD:C51([APpels:19])
			Until (End selection:C36([APpels:19]))
		End if 
	End for 
End if 