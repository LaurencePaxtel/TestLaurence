// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 25/06/2020, 08:18:26
// ----------------------------------------------------
// Method: [DiaLogues].DL_HébergementChercher.btn_participations
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; True:C214)
		OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; False:C215)
	: (Form event code:C388=Sur clic:K2:4)
		READ ONLY:C145([HeBerge:4])
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=tb_hb_reference_id{tb_hb_reference_id})
		MultiSoc_Filter(->[HeBerge:4])
		
		CLEAR VARIABLE:C89(<>PR_Participations)
		
		If ([HeBerge:4]HB_ReferenceID:1>0)
			Process_Go2(-><>PR_Participations; "Go_Participations"; "Tableau des participations"; 32; [HeBerge:4]HB_ReferenceID:1; "")
		Else 
			StrAlerte(3; "")
		End if 
		
End case 