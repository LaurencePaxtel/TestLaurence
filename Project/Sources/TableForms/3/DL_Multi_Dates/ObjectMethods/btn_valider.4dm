// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 06/08/2020, 15:20:05
// ----------------------------------------------------
// Method: [DiaLogues].DL_Multi_Dates.btn_valider
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_TEXT:C284($hb_cle; $txt_centre)
		C_LONGINT:C283($i; $pos; $i_el)
		C_DATE:C307($txt_date)
		
		ARRAY TEXT:C222($centre_at; 0)
		
		$hb_cle:=va_NNN
		var_saisie_differee:=True:C214
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=va_NNN)
		MultiSoc_Filter(->[HeBerge:4])
		
		REDUCE SELECTION:C351([LesCentres:9]; 0)
		
		If (txt_groupe#"")
			
			For ($i; 1; 10)
				EXECUTE FORMULA:C63("$txt_date:=txt_date_"+String:C10($i))
				EXECUTE FORMULA:C63("$txt_centre:=txt_centre_"+String:C10($i))
				
				EXECUTE FORMULA:C63("$ptr_date:=->txt_date_"+String:C10($i))
				EXECUTE FORMULA:C63("$ptr_centre:=->txt_centre_"+String:C10($i))
				
				If ($txt_date#!00-00-00!) & ($txt_centre#"")
					<>vd_SD_Jour:=$txt_date
					
					// Modifié par : Scanu Rémy - remy@connect-io.fr (02/07/2021)
					// On réinitialise le tableau car sinon il s'incrémente avec les données d'avant
					CLEAR VARIABLE:C89($centre_at)
					UTL_Decoupe_texte(->$txt_centre; ->$centre_at; ";")
					
					For ($i_el; 1; Size of array:C274($centre_at))
						$pos:=Find in array:C230(tb_centres_liste_nom; $centre_at{$i_el})
						
						If ($pos>0)
							QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tb_centres_liste_id{$pos})
							MultiSoc_Filter(->[LesCentres:9])
							
							HG_Pointage($hb_cle)
						End if 
						
					End for 
					
				End if 
				
				$ptr_date->:=!00-00-00!
				$ptr_centre->:=""
			End for 
			
			CANCEL:C270
		Else 
			ALERT:C41("Le choix du service est obligatoire")
		End if 
		
End case 