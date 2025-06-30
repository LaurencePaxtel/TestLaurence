// ----------------------------------------------------
// User name (OS): Kevin  HASSAL
// Date and time: 07/11/19, 13:50:22
// ----------------------------------------------------
// Method: [DiaLogues].DL_Multi_Pointage.btn_valider
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		CANCEL:C270
		
		ARRAY OBJECT:C1221($tb_reports_config; 7)
		
		OB SET:C1220($tb_reports_config{1}; "Jour"; "Lundi"; "checked"; chk_lundi)
		OB SET:C1220($tb_reports_config{2}; "Jour"; "Mardi"; "checked"; chk_mardi)
		OB SET:C1220($tb_reports_config{3}; "Jour"; "Mercredi"; "checked"; chk_mercredi)
		OB SET:C1220($tb_reports_config{4}; "Jour"; "Jeudi"; "checked"; chk_jeudi)
		OB SET:C1220($tb_reports_config{5}; "Jour"; "Vendredi"; "checked"; chk_vendredi)
		OB SET:C1220($tb_reports_config{6}; "Jour"; "Samedi"; "checked"; chk_samedi)
		OB SET:C1220($tb_reports_config{7}; "Jour"; "Dimanche"; "checked"; chk_dimanche)
		
		OB SET ARRAY:C1227([HeberGement:5]HG_Reports_Config:174; "reports"; $tb_reports_config)
		
		[HeberGement:5]HG_Reports_Semaine:176:=False:C215
		
		If ((chk_lundi=True:C214) | (chk_mardi=True:C214) | (chk_mercredi=True:C214) | (chk_jeudi=True:C214) | (chk_vendredi=True:C214) | (chk_samedi=True:C214) | (chk_dimanche=True:C214))
			[HeberGement:5]HG_Reports_Semaine:176:=True:C214
		End if 
		
End case 

