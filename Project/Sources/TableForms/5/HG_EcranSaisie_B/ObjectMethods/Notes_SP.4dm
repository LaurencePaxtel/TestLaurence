Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		
		// annulation de la bidouille  #20170705-2
		// #20170720-3
		
		//C_TEXT($T_Memo)  // #20170705-2
		//$T_Memo:=[HeBerge]HB_Telephone
		//UNLOAD RECORD([HeBerge])
		
		Process_Go2(-><>PR_HBST; "Go_HébergementSPPLUS"; "ST"; 32; [HeberGement:5]HG_HB_ID:19; "N")
		
		//LOAD RECORD([HeBerge]) // #20170720-3
		//[HeBerge]HB_Telephone:=$T_Memo // #20170720-3
		
		Repeat 
			IDLE:C311
		Until (<>PR_HBST=0)
		
		vl_CasSP:=F_CasSP([HeberGement:5]HG_HB_ID:19; 1)
		
		SET TIMER:C645(0)
		Case of 
			: (vl_CasSP=-1)
				OBJECT SET VISIBLE:C603(*; "Cligne_SP"; True:C214)
				vb_CasSP:=True:C214
			: (vl_CasSP=0)
				OBJECT SET VISIBLE:C603(*; "Cligne_SP"; False:C215)
				vb_CasSP:=False:C215
			: (vl_CasSP>0)
				OBJECT SET VISIBLE:C603(*; "Cligne_SP"; True:C214)
				vb_CasSP:=True:C214
				SET TIMER:C645(45)
		End case 
		
		
End case 



