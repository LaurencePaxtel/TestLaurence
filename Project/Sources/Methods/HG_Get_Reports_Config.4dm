//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 18/02/20, 19:13:30
// ----------------------------------------------------
// Method: HG_Get_Reports_Config
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($get_real_date; $result)
C_DATE:C307($date_RAP)

C_BOOLEAN:C305(chk_lundi; chk_mardi; chk_mercredi; chk_jeudi; chk_vendredi; chk_samedi; chk_dimanche)

ARRAY OBJECT:C1221($tb_reports_config; 0)

If (Count parameters:C259>0)
	$get_real_date:=$1
End if 

If (Count parameters:C259>1)
	$date_RAP:=$2
End if 

chk_lundi:=False:C215
chk_mardi:=False:C215
chk_mercredi:=False:C215
chk_jeudi:=False:C215
chk_vendredi:=False:C215
chk_samedi:=False:C215
chk_dimanche:=False:C215

If ([HeberGement:5]HG_Reports_Semaine:176)
	$result:=True:C214
	
	If (OB Is defined:C1231([HeberGement:5]HG_Reports_Config:174; "reports"))
		OB GET ARRAY:C1229([HeberGement:5]HG_Reports_Config:174; "reports"; $tb_reports_config)
		
		chk_lundi:=$tb_reports_config{1}.checked
		chk_mardi:=$tb_reports_config{2}.checked
		chk_mercredi:=$tb_reports_config{3}.checked
		chk_jeudi:=$tb_reports_config{4}.checked
		chk_vendredi:=$tb_reports_config{5}.checked
		chk_samedi:=$tb_reports_config{6}.checked
		chk_dimanche:=$tb_reports_config{7}.checked
		
		If ($get_real_date)
			
			If ($date_RAP=!00-00-00!)
				
				If (vb_Serveur)
					vd_DateServeur:=Current date:C33(*)
					vd_HeureServeur:=Current time:C178(*)
					vd_DateRéelle:=vd_DateServeur
					vd_HeureRéelle:=vd_HeureServeur+(8*3600)
					
					If (vd_HeureRéelle>?23:59:59?)
						vd_DateRéelle:=vd_DateRéelle+1
						vd_HeureRéelle:=vd_HeureRéelle-(24*3600)
					End if 
					
				Else 
					vd_DateRéelle:=Current date:C33
					vd_HeureRéelle:=Current time:C178
					vd_DateServeur:=vd_DateRéelle
					vd_HeureServeur:=vd_HeureRéelle-(8*3600)
					
					If (vd_HeureServeur<?00:00:00?)
						vd_DateServeur:=vd_DateServeur-1
						vd_HeureServeur:=(24*3600)+vd_HeureServeur
					End if 
					
				End if 
				
				vl_ii:=Day number:C114(vd_DateRéelle)
			Else 
				vl_ii:=Day number:C114($date_RAP)
			End if 
			
		End if 
		
	End if 
	
End if 

$0:=$result