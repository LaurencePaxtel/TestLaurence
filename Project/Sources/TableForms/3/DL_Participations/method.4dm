// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02/03/20, 03:30:14
// ----------------------------------------------------
// Method: [DiaLogues].DL_Dossiers_Encours
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $i_el; $pos_el : Integer


Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		var txt_titre_fenetre; txt_titre_fenetre_bas : Text
		var par_selected_year : Integer
		
		ARRAY LONGINT:C221(tb_par_annees; 0)
		
		txt_titre_fenetre:="Participation(s) : "+[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4
		txt_titre_fenetre_bas:=""
		
		If ([HeBerge:4]HB_FAC_Mode_Facturation:80#"Participations")
			txt_titre_fenetre_bas:="Attention, le mode de facturation paramétré pour cet hébergé est par « Participation »."
		End if 
		
		If ([HeBerge:4]HB_FAC_Mode_Facturation:80="")
			txt_titre_fenetre_bas:="Attention, aucun mode de facturation n'est paramétré pour cet hébergé."
		End if 
		
		// Modifié par : Scanu Rémy (16/01/2023)
		// Correction bug affichage message d'erreur
		If (txt_titre_fenetre_bas#"")
			OBJECT SET RGB COLORS:C628(*; "txt_titre_fenetre_bas"; "white"; "red")
		End if 
		
		// Génération du Popup des années
		For ($i_el; 1; Size of array:C274(<>ta_GP_Annees))
			APPEND TO ARRAY:C911(tb_par_annees; Num:C11(<>ta_GP_Annees{$i_el}))
		End for 
		
		// Si parmi les valeurs du popup des années généré juste en haut, il n'y a pas l'année de la date du jour on la rajoute
		$pos_el:=Find in array:C230(tb_par_annees; Year of:C25(Current date:C33))
		
		If ($pos_el<0)
			APPEND TO ARRAY:C911(tb_par_annees; Year of:C25(Current date:C33))
		End if 
		
		// Et on la sélectionne par défaut
		tb_par_annees{tb_par_annees}:=Year of:C25(Current date:C33)
		par_selected_year:=Year of:C25(Current date:C33)
		
		START TRANSACTION:C239
		PAR_Chargement
	: (Form event code:C388=Sur clic:K2:4) | (Form event code:C388=Sur données modifiées:K2:15)
		POST OUTSIDE CALL:C329(Current process:C322)
	: (Form event code:C388=Sur appel extérieur:K2:11)
		Form:C1466.apl.total:=0
		
		For ($i_el; 1; 12)
			$date_d:=Date:C102("01/"+String:C10($i_el; "00")+"/"+String:C10(Year of:C25(Current date:C33)))
			Form:C1466.apl.total:=Form:C1466.apl.total+Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].solde
		End for 
		
		If (Form:C1466.apl.total<0)
			OBJECT SET RGB COLORS:C628(*; "Variable76"; "white"; "red")
		Else 
			OBJECT SET RGB COLORS:C628(*; "Variable76"; "black"; "transparent")
		End if 
		
End case 