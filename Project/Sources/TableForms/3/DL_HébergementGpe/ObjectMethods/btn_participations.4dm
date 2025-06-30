Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; False:C215)
		OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; False:C215)
		
	: (Form event code:C388=Sur clic:K2:4)
		If (Storage:C1525.societeDetail.participationWeb)
			ALERT:C41("La gestion de la participation est disponible sur votre interface web.")
			return 
		End if 
		
		<>PR_Participations:=0
		outilsHebergeLoadRecord
		
		If ([HeBerge:4]HB_ReferenceID:1>0)
			Process_Go(-><>PR_Participations; "Go_Participations"; "Tableau des participations"; 0; [HeBerge:4]HB_ReferenceID:1)
		Else 
			StrAlerte(3; "")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 