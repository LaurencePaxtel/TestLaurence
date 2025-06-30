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
var $facture_c : Collection

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; True:C214)
		OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; False:C215)
		
	: (Form event code:C388=Sur clic:K2:4)
		<>PR_Participations:=0
		
		$facture_c:=New collection:C1472
		ARRAY TO COLLECTION:C1563($facture_c; tb_fac_choix; "checked"; tb_fac_destinataire_id; "destinataireID")
		
		// On vérifie qu'il y a bien une facture de sélectionner
		$facture_c:=$facture_c.query("checked = :1"; True:C214)
		
		If ($facture_c.length#1)
			ALERT:C41("Veuillez sélectionner une seule facture")
		Else 
			Process_Go(-><>PR_Participations; "Go_Participations"; "Tableau des participations"; 0; $facture_c[0].destinataireID)
		End if 
		
End case 