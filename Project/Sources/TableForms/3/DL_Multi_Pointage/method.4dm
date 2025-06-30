// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/11/19, 13:15:00
// ----------------------------------------------------
// Method: [DiaLogues].DL_Multi_Pointage
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $i; $colonne_el; $ligne_el : Integer

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		var txt_centre_nom; txt_groupe : Text
		
		ARRAY TEXT:C222(tb_centre_liste_nom; 0)
		ARRAY LONGINT:C221(tb_centre_liste_id; 0)
		
		READ ONLY:C145([LesCentres:9])
		txt_centre_nom:=""
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Nom:4=txt_centre_nom+"@"; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Prestation:55=True:C214; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Plateforme:56=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
		
		// Modifié par : Scanu Rémy (06/02/2023)
		QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Fermé:53=False:C215)
		MultiSoc_Filter(->[LesCentres:9])
		
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		
		SET QUERY LIMIT:C395(20)
		SELECTION TO ARRAY:C260([LesCentres:9]LC_Nom:4; tb_centre_liste_nom; [LesCentres:9]LC_RéférenceID:1; tb_centre_liste_id)
		SET QUERY LIMIT:C395(0)
		
		ARRAY BOOLEAN:C223(tb_centre_choix; Size of array:C274(tb_centre_liste_id))
		
		// Modifié par : Scanu Rémy (09/12/2022)
		ARRAY LONGINT:C221(tb_centre_liste_quantite; Size of array:C274(tb_centre_liste_id))
		
		// Modifié par : Scanu Rémy (24/03/2023)
		ARRAY REAL:C219(tb_centre_liste_montant; Size of array:C274(tb_centre_liste_id))
		
		// Modifié par : Scanu Rémy (20/12/2022)
		Form:C1466.lineInfo:=New collection:C1472
		
		For ($i; 1; Size of array:C274(tb_centre_choix))
			tb_centre_choix{$i}:=False:C215
			
			tb_centre_liste_quantite{$i}:=0
			tb_centre_liste_montant{$i}:=0
			
			// Modifié par : Scanu Rémy (20/12/2022) et Re-modifié par Scanu Rémy (24/03/2023)
			Form:C1466.lineInfo.push(New object:C1471("id"; tb_centre_liste_id{$i}; "quantite"; 0; "montant"; 0; "checked"; False:C215))
		End for 
		
		// Modifié par : Scanu Rémy (27/03/2023)
		OBJECT SET VISIBLE:C603(*; "montant@"; False:C215)
		
		txt_groupe:=""
		REDRAW:C174(LB_Recherche_appel)
	: (Form event code:C388=Sur clic:K2:4)
		OBJECT SET VISIBLE:C603(*; "montant@"; False:C215)
		LISTBOX GET CELL POSITION:C971(*; "List Box"; $colonne_el; $ligne_el)
		
		If ($ligne_el>0)
			OBJECT SET VISIBLE:C603(*; "montant@"; tb_centre_choix{$ligne_el})
			
			If (tb_centre_choix{$ligne_el}=True:C214)
				Form:C1466.montant:=tb_centre_liste_montant{$ligne_el}
			End if 
			
		End if 
		
	: (Form event code:C388=Sur appel extérieur:K2:11)
		ARRAY TEXT:C222(tb_centre_liste_nom; 0)
		ARRAY LONGINT:C221(tb_centre_liste_id; 0)
		
		READ ONLY:C145([LesCentres:9])
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Nom:4="@"+txt_centre_nom+"@"; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Prestation:55=True:C214; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Plateforme:56=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
		
		// Modifié par : Scanu Rémy (06/02/2023)
		QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Fermé:53=False:C215)
		
		MultiSoc_Filter(->[LesCentres:9])
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		
		SET QUERY LIMIT:C395(20)
		SELECTION TO ARRAY:C260([LesCentres:9]LC_Nom:4; tb_centre_liste_nom; [LesCentres:9]LC_RéférenceID:1; tb_centre_liste_id)
		
		SET QUERY LIMIT:C395(0)
		
		ARRAY BOOLEAN:C223(tb_centre_choix; Size of array:C274(tb_centre_liste_id))
		
		// Modifié par : Scanu Rémy (20/12/2022)
		ARRAY LONGINT:C221(tb_centre_liste_quantite; Size of array:C274(tb_centre_liste_id))
		
		// Modifié par : Scanu Rémy (24/03/2023)
		ARRAY REAL:C219(tb_centre_liste_montant; Size of array:C274(tb_centre_liste_id))
		
		For ($i; 1; Size of array:C274(tb_centre_choix))
			$line_c:=Form:C1466.lineInfo.query("id = :1"; tb_centre_liste_id{$i})
			
			tb_centre_choix{$i}:=$line_c[0].checked
			tb_centre_liste_quantite{$i}:=$line_c[0].quantite
			
			// Modifié par : Scanu Rémy (24/03/2023)
			tb_centre_liste_montant{$i}:=Num:C11($line_c[0].montant)
		End for 
		
		If (Bool:C1537(Form:C1466.validate)=True:C214)
			
			If (txt_groupe#"")
				CONFIRM:C162("Êtes-vous sûr(e) de vouloir continuer ?"; "Oui"; "Non")
				
				If (OK=1)
					CANCEL:C270
					HB_Pointage_Multiple
				End if 
				
			Else 
				ALERT:C41("Le choix du service est obligatoire")
			End if 
			
			OB REMOVE:C1226(Form:C1466; "validate")
		End if 
		
		REDRAW:C174(LB_Recherche_appel)
End case 