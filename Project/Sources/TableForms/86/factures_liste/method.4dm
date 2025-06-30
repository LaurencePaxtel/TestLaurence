// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 27/01/20, 18:02:45
// ----------------------------------------------------
// Method: [Factures].factures_liste
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		C_BOOLEAN:C305(Chk_regle; Chk_non_regle; Chk_tous; Chk_fac_tout_selectionner; Chk_factures_seule; Chk_avoirs_seule; Chk_reglements_seule)
		
		OBJECT SET ENTERABLE:C238(*; "txt_titre_fenetre"; False:C215)
		
		QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=<>ref_soc_active)
		QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
		
		If (Not:C34([SOciete:18]SO_Activer_Envoi_Mail:101))
			OBJECT SET VISIBLE:C603(*; "btn_envoi_mail"; False:C215)
		End if 
		
		txt_titre_fenetre:="Liste des factures"
		
		Chk_regle:=False:C215
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (14/06/2021)
		Chk_non_regle:=False:C215
		
		Chk_tous:=True:C214
		Chk_fac_tout_selectionner:=False:C215
		
		Chk_factures_seule:=False:C215
		Chk_avoirs_seule:=False:C215
		
		// Modifié par : Scanu Rémy (24/08/2023)
		Chk_reglements_seule:=False:C215
		
		// Modifié par : Scanu Rémy (24/08/2023)
		// Gestion du clic sur les entêtes
		Form:C1466.clicEntete:=New object:C1471
		Form:C1466.clicEntete.dateFacture:=0
		
		FAC_Get_Liste_Factures
End case 