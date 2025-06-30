// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 05/08/2020, 16:57:41
// ----------------------------------------------------
// Method: [DiaLogues].DL_Multi_Dates
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		C_TEXT:C284(txt_groupe; txt_centre_1; txt_centre_2; txt_centre_3; txt_centre_4; txt_centre_5; txt_centre_6; txt_centre_7; txt_centre_8; txt_centre_9; txt_centre_10)
		C_DATE:C307(txt_date_1; txt_date_2; txt_date_3; txt_date_4; txt_date_5; txt_date_6; txt_date_7; txt_date_8; txt_date_9; txt_date_10)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (28/05/2021)
		outilsCleanVariable(->txt_groupe; ->txt_centre_1; ->txt_centre_2; ->txt_centre_3; ->txt_centre_4; ->txt_centre_5; ->txt_centre_6; ->txt_centre_7; \
			->txt_centre_8; ->txt_centre_9; ->txt_centre_10; ->txt_date_1; ->txt_date_2; ->txt_date_3; ->txt_date_4; ->txt_date_5; ->txt_date_6; ->txt_date_7; ->txt_date_8; \
			->txt_date_9; ->txt_date_10)
		
		READ ONLY:C145([LesCentres:9])
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Prestation:55=True:C214; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Plateforme:56=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
		
		MultiSoc_Filter(->[LesCentres:9])
		
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		
		ARRAY LONGINT:C221(tb_centres_liste_id; 0)
		ARRAY TEXT:C222(tb_centres_liste_nom; 0)
		
		SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tb_centres_liste_id; [LesCentres:9]LC_Nom:4; tb_centres_liste_nom)
End case 