C_LONGINT:C283($vl_eventFF)
$vl_eventFF:=Form event code:C388
Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		
		vPos1:=0
		vPos2:=0
		vPos2:=Length:C16([HeBerge:4]Notes:6)+1
		
		HIGHLIGHT TEXT:C210([HeBerge:4]Notes:6; vPos2; vPos2)
		
		OBJECT SET VISIBLE:C603(*; "TropPage_1"; (vl_Note_LG_1>vl_Note_LG_MAX))
		OBJECT SET VISIBLE:C603(*; "TropPage_2"; (vl_Note_LG_2>vl_Note_LG_MAX))
		OBJECT SET VISIBLE:C603(*; "TropPage_3"; (vl_Note_LG_3>vl_Note_LG_MAX))
		OBJECT SET VISIBLE:C603(*; "TropPage_4"; (vl_Note_LG_4>vl_Note_LG_MAX))
		OBJECT SET VISIBLE:C603(*; "TropPage_5"; (vl_Note_LG_5>vl_Note_LG_MAX))  // #20170713-2
		OBJECT SET VISIBLE:C603(*; "TropPage_6"; (vl_Note_LG_6>vl_Note_LG_MAX))  // #20170713-2
		
		OBJECT SET VISIBLE:C603(va_Note_LG_1; (vl_Note_LG_1>vl_Note_LG_MAX))
		OBJECT SET VISIBLE:C603(va_Note_LG_2; (vl_Note_LG_2>vl_Note_LG_MAX))
		OBJECT SET VISIBLE:C603(va_Note_LG_3; (vl_Note_LG_3>vl_Note_LG_MAX))
		OBJECT SET VISIBLE:C603(va_Note_LG_4; (vl_Note_LG_4>vl_Note_LG_MAX))
		OBJECT SET VISIBLE:C603(va_Note_LG_3; (vl_Note_LG_5>vl_Note_LG_MAX))  // #20170713-2
		OBJECT SET VISIBLE:C603(va_Note_LG_4; (vl_Note_LG_6>vl_Note_LG_MAX))  // #20170713-2
		
		vt_TempNOTE:=""
		vt_TempNOTE2:=""
		vt_TempNOTE3:=""
		vt_TempNOTETRANS:=""
		vt_TempNOTEMARAUDE:=""
		vt_TempNOTEMARAUDE2:=""
		vt_TempNOTEFFV:=""
		vt_TempNOTEComptable:=""
		
	: ($vl_eventFF=Sur appel extérieur:K2:11)
		
		CANCEL:C270
End case 
