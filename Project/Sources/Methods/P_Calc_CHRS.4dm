//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_CHRS
//{
//{          Dimanche 15 février 2009 à 18:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii; $pos; $kk; $nbJour_el; $pos_el)
C_BOOLEAN:C305($ajouter_b)
C_OBJECT:C1216($O_Objet; $table_o; $enregistrement_o)

If (vd_Date1>!00-00-00!)
	MESSAGES OFF:C175
	i_Stop
	
	ON EVENT CALL:C190("i_Stop_ESC")
	
	i_Message("Calcul en cours...")
	i_MessageSeul("Calcul en cours  1/4: Paramètres")
	
	//••••••••••     Etat civil
	If (<>vb_StopEven=False:C215)
		ARRAY TEXT:C222(ta_ET_EtcivLienGroupe; 0)
		ARRAY TEXT:C222(ta_ET_EtcivLienOrigine; 0)
		
		vb_EtCivRegroupé:=False:C215
		
		QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{1}; *)
		QUERY:C277([ItemGroupe:43];  & ; [ItemGroupe:43]IT_LibelléOrigneID:5=0)
		MultiSoc_Filter(->[ItemGroupe:43])
		
		If (Records in selection:C76([ItemGroupe:43])>0)
			ORDER BY:C49([ItemGroupe:43]; [ItemGroupe:43]IT_Libellé:3; >)
			SELECTION TO ARRAY:C260([ItemGroupe:43]IT_Libellé:3; ta_ET_EtcivGroupe)
			
			QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{1}; *)
			QUERY:C277([ItemGroupe:43];  & ; [ItemGroupe:43]IT_LibelléOrigneID:5>0)
			MultiSoc_Filter(->[ItemGroupe:43])
			
			If (Records in selection:C76([ItemGroupe:43])>0)
				SELECTION TO ARRAY:C260([ItemGroupe:43]IT_Libellé:3; ta_ET_EtcivLienGroupe; [ItemGroupe:43]IT_LibelléOrigine:4; ta_ET_EtcivLienOrigine)
				
				vb_EtCivRegroupé:=True:C214
				
				// Ici tester pour ne pas oubliér les états civil sans regroupement
				For ($ii; 1; Size of array:C274(<>ta_TBEtCiv))
					$pos:=Find in array:C230(ta_ET_EtcivLienOrigine; <>ta_TBEtCiv{$ii})
					
					If ($pos>0)
					Else 
						$kk:=Size of array:C274(ta_ET_EtcivGroupe)+1
						INSERT IN ARRAY:C227(ta_ET_EtcivGroupe; $kk)
						
						ta_ET_EtcivGroupe{$kk}:=<>ta_TBEtCiv{$ii}
						
						$kk:=Size of array:C274(ta_ET_EtcivLienGroupe)+1
						INSERT IN ARRAY:C227(ta_ET_EtcivLienGroupe; $kk)
						INSERT IN ARRAY:C227(ta_ET_EtcivLienOrigine; $kk)
						
						ta_ET_EtcivLienGroupe{$kk}:=<>ta_TBEtCiv{$ii}
						ta_ET_EtcivLienOrigine{$kk}:=<>ta_TBEtCiv{$ii}
					End if 
					
				End for 
				
			End if 
			
		End if 
		
		If (vb_EtCivRegroupé=False:C215)
			$pos:=Size of array:C274(<>ta_TBEtCiv)
			
			ARRAY TEXT:C222(ta_ET_EtcivGroupe; $pos)
			
			If ($pos>0)
				
				For ($ii; 1; $pos)
					ta_ET_EtcivGroupe{$ii}:=<>ta_TBEtCiv{$ii}
				End for 
				
			End if 
			
		End if 
		
		vl_Tab1:=Size of array:C274(ta_ET_EtcivGroupe)
	End if 
	
	//••••••••••     Centres
	If (<>vb_StopEven=False:C215)
		ARRAY TEXT:C222(ta_LC_CentreLien; 0)
		ARRAY LONGINT:C221(tl_LC_CentreLien; 0)
		
		vb_CentreRegroupé:=False:C215
		
		QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{2}; *)
		QUERY:C277([ItemGroupe:43];  & ; [ItemGroupe:43]IT_LibelléOrigneID:5=0)
		MultiSoc_Filter(->[ItemGroupe:43])
		
		If (Records in selection:C76([ItemGroupe:43])>0)
			ORDER BY:C49([ItemGroupe:43]; [ItemGroupe:43]IT_Libellé:3; >)
			SELECTION TO ARRAY:C260([ItemGroupe:43]IT_Libellé:3; ta_LC_Centre)
			
			ARRAY BOOLEAN:C223(tb_LC_CentreR; Size of array:C274(ta_LC_Centre))
			
			For ($ii; 1; Size of array:C274(tb_LC_CentreR))
				tb_LC_CentreR{$ii}:=True:C214
			End for 
			
			QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{2}; *)
			QUERY:C277([ItemGroupe:43];  & ; [ItemGroupe:43]IT_LibelléOrigneID:5>0)
			MultiSoc_Filter(->[ItemGroupe:43])
			
			If (Records in selection:C76([ItemGroupe:43])>0)
				ORDER BY:C49([ItemGroupe:43]; [ItemGroupe:43]IT_Libellé:3; >)
				SELECTION TO ARRAY:C260([ItemGroupe:43]IT_Libellé:3; ta_LC_CentreLien; [ItemGroupe:43]IT_LibelléOrigneID:5; tl_LC_CentreLien)
				
				vb_CentreRegroupé:=True:C214
			End if 
			
		End if 
		
		If (vb_CentreRegroupé=False:C215)
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Prestation:55=False:C215; *)
			QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Nom:4>"")
			MultiSoc_Filter(->[LesCentres:9])
			
			ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
			SELECTION TO ARRAY:C260([LesCentres:9]LC_Nom:4; ta_LC_Centre; [LesCentres:9]LC_RéférenceID:1; tl_LC_Centre)
			
			ARRAY BOOLEAN:C223(tb_LC_CentreR; Size of array:C274(ta_LC_Centre))
			
			For ($ii; 1; Size of array:C274(tb_LC_CentreR))
				tb_LC_CentreR{$ii}:=False:C215
			End for 
			
		End if 
		
		vl_Tab2:=Size of array:C274(ta_LC_Centre)
	End if 
	
	//••••••••••     Prestations
	If (<>vb_StopEven=False:C215)
		ARRAY TEXT:C222(ta_LC_PrestaLien; 0)
		ARRAY LONGINT:C221(tl_LC_PrestaLien; 0)
		
		vb_PrestaRegroupé:=False:C215
		
		QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{3}; *)
		QUERY:C277([ItemGroupe:43];  & ; [ItemGroupe:43]IT_LibelléOrigneID:5=0)
		MultiSoc_Filter(->[ItemGroupe:43])
		
		If (Records in selection:C76([ItemGroupe:43])>0)
			ORDER BY:C49([ItemGroupe:43]; [ItemGroupe:43]IT_Libellé:3; >)
			SELECTION TO ARRAY:C260([ItemGroupe:43]IT_Libellé:3; ta_LC_Presta)
			
			QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{3}; *)
			QUERY:C277([ItemGroupe:43];  & ; [ItemGroupe:43]IT_LibelléOrigneID:5>0)
			MultiSoc_Filter(->[ItemGroupe:43])
			
			If (Records in selection:C76([ItemGroupe:43])>0)
				ORDER BY:C49([ItemGroupe:43]; [ItemGroupe:43]IT_Libellé:3; >)
				SELECTION TO ARRAY:C260([ItemGroupe:43]IT_Libellé:3; ta_LC_PrestaLien; [ItemGroupe:43]IT_LibelléOrigneID:5; tl_LC_PrestaLien)
				
				vb_PrestaRegroupé:=True:C214
				
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Prestation:55=True:C214; *)
				QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Nom:4>"")
				MultiSoc_Filter(->[LesCentres:9])
				
				ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
				
				If (Records in selection:C76([LesCentres:9])>0)
					DISTINCT VALUES:C339([LesCentres:9]LC_RéférenceID:1; tl_PrestaUtilisé)
				Else 
					ARRAY LONGINT:C221(tl_PrestaUtilisé; 0)
				End if 
				
				For ($ii; 1; Size of array:C274(tl_PrestaUtilisé))
					$pos:=Find in array:C230(tl_LC_PrestaLien; tl_PrestaUtilisé{$ii})
					
					If ($pos>0)
					Else 
						QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tl_PrestaUtilisé{$ii})
						MultiSoc_Filter(->[LesCentres:9])
						
						If (Records in selection:C76([LesCentres:9])=1)
							$kk:=Size of array:C274(ta_LC_Presta)+1
							INSERT IN ARRAY:C227(ta_LC_Presta; $kk)
							
							ta_LC_Presta{$kk}:=""
							
							If (Length:C16([LesCentres:9]LC_Nom:4)>45)
								ta_LC_Presta{$kk}:=Substring:C12([LesCentres:9]LC_Nom:4; 1; 42)+"..."
							Else 
								ta_LC_Presta{$kk}:=[LesCentres:9]LC_Nom:4
							End if 
							
							$kk:=Size of array:C274(ta_LC_PrestaLien)+1
							INSERT IN ARRAY:C227(ta_LC_PrestaLien; $kk)
							INSERT IN ARRAY:C227(tl_LC_PrestaLien; $kk)
							
							ta_LC_PrestaLien{$kk}:=""
							tl_LC_PrestaLien{$kk}:=tl_PrestaUtilisé{$ii}
							
							If (Length:C16([LesCentres:9]LC_Nom:4)>45)
								ta_LC_PrestaLien{$kk}:=Substring:C12([LesCentres:9]LC_Nom:4; 1; 42)+"..."
							Else 
								ta_LC_PrestaLien{$kk}:=[LesCentres:9]LC_Nom:4
							End if 
							
						End if 
						
					End if 
					
				End for 
				
			End if 
			
		End if 
		
		If (vb_PrestaRegroupé=False:C215)
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Prestation:55=True:C214; *)
			QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Fermé:53=False:C215; *)
			QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Nom:4>"")
			MultiSoc_Filter(->[LesCentres:9])
			
			ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
			SELECTION TO ARRAY:C260([LesCentres:9]LC_Nom:4; ta_LC_Presta; [LesCentres:9]LC_RéférenceID:1; tl_LC_Presta)
		End if 
		
		vl_Tab3:=Size of array:C274(ta_LC_Presta)
	End if 
	
	//••••••••••     Signalement
	If (<>vb_StopEven=False:C215)
		COPY ARRAY:C226(<>ta_TBSglt; ta_xTBSglt)
	End if 
	
	//••••••••••     Pièce d'identité 1
	If (<>vb_StopEven=False:C215)
		COPY ARRAY:C226(<>ta_TBPIdté; ta_xTBPIdté)
	End if 
	
	If (<>vb_StopEven=False:C215)
		V_Stat_CHRS(1)  //Dimensionner Initialiser à zéro les autres tableaux et variables
	End if 
	
	i_MessageSeul("Calcul en cours  2/4: Centres nombre de lits")
	
	If (<>vb_StopEven=False:C215)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (30/06/2021)
		// On ne travaille plus sur la table [CentresLits] mais sur la table [LesCentres] pour connaitre le nombre de disponibilité de lits
		If (vb_CentreRegroupé=True:C214)
			QUERY WITH ARRAY:C644([LesCentres:9]LC_RéférenceID:1; tl_LC_CentreLien)
		Else 
			QUERY WITH ARRAY:C644([LesCentres:9]LC_RéférenceID:1; tl_LC_Centre)
		End if 
		
		$table_o:=Create entity selection:C1512([LesCentres:9])
		
		If (vd_Date1>!00-00-00!) & (vd_Date2>!00-00-00!)
			$nbJour_el:=outilsGetNbJour(vd_Date1; vd_Date2)
		Else 
			$nbJour_el:=outilsGetNbJour(vd_Date1; Current date:C33)
		End if 
		
		// Je rajoute un jour car on ne prends pas en compte le jour de début dans le calcul
		$nbJour_el:=$nbJour_el+1
		
		For each ($enregistrement_o; $table_o)
			
			If (vb_CentreRegroupé)
				$pos:=Find in array:C230(tl_LC_CentreLien; $enregistrement_o.LC_RéférenceID)
				
				If ($pos>0)
					$pos:=Find in array:C230(ta_LC_Centre; ta_LC_CentreLien{$pos})
				End if 
				
			Else 
				$pos:=Find in array:C230(tl_LC_Centre; $enregistrement_o.LC_RéférenceID)
			End if 
			
			If ($pos>0)
				
				// Modifié par : Scanu Rémy (27/09/2023) et Re-modifié par : Scanu Rémy (10/10/2023)
				If (vb_CentreRegroupé)
					$ajouter_b:=True:C214
				Else 
					$pos_el:=Find in array:C230(ta_xGroupe; ta_LC_Centre{$pos})
					
					If ($pos_el>0)
						$ajouter_b:=(te_xGroupe{$pos_el}=1)
					End if 
					
				End if 
				
			End if 
			
			If ($ajouter_b=True:C214)
				tl_LC_Dis{$pos}:=tl_LC_Dis{$pos}+($enregistrement_o.LC_DispoJour*$nbJour_el)
				vl_LC_Dis:=vl_LC_Dis+($enregistrement_o.LC_DispoJour*$nbJour_el)
			End if 
			
			CLEAR VARIABLE:C89($ajouter_b)
		End for each 
		
	End if 
	
	i_MessageSeul("Calcul en cours  3/4: Hébergements")
	
	If (True:C214)
		C_LONGINT:C283(vl_ET_Dem)
		C_LONGINT:C283(vl_ET_Dis)
		C_LONGINT:C283(vl_HG_Appels)
		C_LONGINT:C283(vl_HG_AppelsJour)
		C_LONGINT:C283(vl_HG_AppelsJourClo)
		C_LONGINT:C283(vl_LC_PrestaNb)
		C_LONGINT:C283(vl_LC_Total)
		C_LONGINT:C283(vl_Tab1)
		C_LONGINT:C283(vl_Tab2)
		C_LONGINT:C283(vl_Tab3)
		C_LONGINT:C283(vl_Tab4)
		C_LONGINT:C283(vl_Tab5)
		C_LONGINT:C283(vl_xNbIdtéJ)
		C_LONGINT:C283(vl_xNbIdtéJC)
		C_LONGINT:C283(vl_xNbIdtéN)
		C_LONGINT:C283(vl_xNbIdtéT)
		C_LONGINT:C283(vl_xNbSgltJ)
		C_LONGINT:C283(vl_xNbSgltJC)
		C_LONGINT:C283(vl_xNbSgltN)
		C_LONGINT:C283(vl_xNbSgltT)
		
		C_REAL:C285(E_HG_Presta)
		
		C_BOOLEAN:C305(vb_CentreRegroupé)
		C_BOOLEAN:C305(vb_EtCivRegroupé)
		C_BOOLEAN:C305(vb_PrestaRegroupé)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (30/06/2021)
		//C_DATE(vd_Date1)
		
		OB SET:C1220($O_Objet; "<>vb_StopEven"; <>vb_StopEven)
		
		OB SET:C1220($O_Objet; "E_HG_Presta"; E_HG_Presta)
		
		OB SET:C1220($O_Objet; "vb_CentreRegroupé"; vb_CentreRegroupé)
		OB SET:C1220($O_Objet; "vb_EtCivRegroupé"; vb_EtCivRegroupé)
		OB SET:C1220($O_Objet; "vb_PrestaRegroupé"; vb_PrestaRegroupé)
		
		OB SET:C1220($O_Objet; "vd_Date1"; vd_Date1)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (30/06/2021)
		OB SET:C1220($O_Objet; "vd_Date2"; vd_Date2)
		
		OB SET:C1220($O_Objet; "vl_ET_Dem"; vl_ET_Dem)
		OB SET:C1220($O_Objet; "vl_ET_Dis"; vl_ET_Dis)
		
		OB SET:C1220($O_Objet; "vl_HG_Appels"; vl_HG_Appels)
		OB SET:C1220($O_Objet; "vl_HG_AppelsJour"; vl_HG_AppelsJour)
		OB SET:C1220($O_Objet; "vl_HG_AppelsJourClo"; vl_HG_AppelsJourClo)
		
		OB SET:C1220($O_Objet; "vl_LC_PrestaNb"; vl_LC_PrestaNb)
		OB SET:C1220($O_Objet; "vl_LC_Total"; vl_LC_Total)
		
		OB SET:C1220($O_Objet; "vl_Tab1"; vl_Tab1)
		OB SET:C1220($O_Objet; "vl_Tab2"; vl_Tab2)
		OB SET:C1220($O_Objet; "vl_Tab3"; vl_Tab3)
		OB SET:C1220($O_Objet; "vl_Tab4"; vl_Tab4)
		OB SET:C1220($O_Objet; "vl_Tab5"; vl_Tab5)
		
		OB SET:C1220($O_Objet; "vl_xNbIdtéJ"; vl_xNbIdtéJ)
		OB SET:C1220($O_Objet; "vl_xNbIdtéJC"; vl_xNbIdtéJC)
		OB SET:C1220($O_Objet; "vl_xNbIdtéN"; vl_xNbIdtéN)
		OB SET:C1220($O_Objet; "vl_xNbIdtéT"; vl_xNbIdtéT)
		OB SET:C1220($O_Objet; "vl_xNbSgltJ"; vl_xNbSgltJ)
		OB SET:C1220($O_Objet; "vl_xNbSgltJC"; vl_xNbSgltJC)
		OB SET:C1220($O_Objet; "vl_xNbSgltN"; vl_xNbSgltN)
		OB SET:C1220($O_Objet; "vl_xNbSgltT"; vl_xNbSgltT)
		
		// Modifié par : Scanu Rémy (05/10/2023)
		OB SET:C1220($O_Objet; "avecInconnu"; OBJECT Get pointer:C1124(Objet nommé:K67:5; "avecInconnu")->)
		OB SET:C1220($O_Objet; "sansInconnu"; OBJECT Get pointer:C1124(Objet nommé:K67:5; "sansInconnu")->)
		
		OB SET:C1220($O_Objet; "hebergement"; OBJECT Get pointer:C1124(Objet nommé:K67:5; "hebergement")->)
		OB SET:C1220($O_Objet; "prestation"; OBJECT Get pointer:C1124(Objet nommé:K67:5; "prestation")->)
		
		OB SET ARRAY:C1227($O_Objet; "<>ta_TBEtCiv"; <>ta_TBEtCiv)
		
		OB SET ARRAY:C1227($O_Objet; "ta_ET_EtcivGroupe"; ta_ET_EtcivGroupe)
		OB SET ARRAY:C1227($O_Objet; "ta_ET_EtcivLienGroupe"; ta_ET_EtcivLienGroupe)
		OB SET ARRAY:C1227($O_Objet; "ta_ET_EtcivLienOrigine"; ta_ET_EtcivLienOrigine)
		
		OB SET ARRAY:C1227($O_Objet; "ta_LC_Centre"; ta_LC_Centre)
		OB SET ARRAY:C1227($O_Objet; "ta_LC_CentreLien"; ta_LC_CentreLien)
		OB SET ARRAY:C1227($O_Objet; "ta_LC_Presta"; ta_LC_Presta)
		OB SET ARRAY:C1227($O_Objet; "ta_LC_PrestaLien"; ta_LC_PrestaLien)
		
		OB SET ARRAY:C1227($O_Objet; "ta_xGroupe"; ta_xGroupe)
		OB SET ARRAY:C1227($O_Objet; "ta_xTBPIdté"; ta_xTBPIdté)
		OB SET ARRAY:C1227($O_Objet; "ta_xTBSglt"; ta_xTBSglt)
		OB SET ARRAY:C1227($O_Objet; "te_xGroupe"; te_xGroupe)
		
		OB SET ARRAY:C1227($O_Objet; "tl_ET_Dem"; tl_ET_Dem)
		OB SET ARRAY:C1227($O_Objet; "tl_ET_Dis"; tl_ET_Dis)
		
		OB SET ARRAY:C1227($O_Objet; "tl_LC_Centre"; tl_LC_Centre)
		OB SET ARRAY:C1227($O_Objet; "tl_LC_CentreLien"; tl_LC_CentreLien)
		OB SET ARRAY:C1227($O_Objet; "tl_LC_Presta"; tl_LC_Presta)
		OB SET ARRAY:C1227($O_Objet; "tl_LC_PrestaLien"; tl_LC_PrestaLien)
		OB SET ARRAY:C1227($O_Objet; "tl_LC_PrestaNb"; tl_LC_PrestaNb)
		OB SET ARRAY:C1227($O_Objet; "tl_LC_Total"; tl_LC_Total)
		
		OB SET ARRAY:C1227($O_Objet; "tl_xNbIdtéJ"; tl_xNbIdtéJ)
		OB SET ARRAY:C1227($O_Objet; "tl_xNbIdtéJC"; tl_xNbIdtéJC)
		OB SET ARRAY:C1227($O_Objet; "tl_xNbIdtéN"; tl_xNbIdtéN)
		OB SET ARRAY:C1227($O_Objet; "tl_xNbIdtéT"; tl_xNbIdtéT)
		OB SET ARRAY:C1227($O_Objet; "tl_xNbSgltJ"; tl_xNbSgltJ)
		OB SET ARRAY:C1227($O_Objet; "tl_xNbSgltJC"; tl_xNbSgltJC)
		OB SET ARRAY:C1227($O_Objet; "tl_xNbSgltN"; tl_xNbSgltN)
		OB SET ARRAY:C1227($O_Objet; "tl_xNbSgltT"; tl_xNbSgltT)
	End if 
	
	// Modifié par : Kevin HASSAL (06/12/2018)
	// On passe la valeur de la variable <>ref_soc_active
	// pour les méhodes qui s'exécutent côté serveur
	P_CalStat_CHRS_etape3(->$O_Objet; <>ref_soc_active)
	
	If (True:C214)
		E_HG_Presta:=OB Get:C1224($O_Objet; "E_HG_Presta"; Est un numérique:K8:4)
		
		vb_CentreRegroupé:=OB Get:C1224($O_Objet; "vb_CentreRegroupé"; Est un booléen:K8:9)
		vb_EtCivRegroupé:=OB Get:C1224($O_Objet; "vb_EtCivRegroupé"; Est un booléen:K8:9)
		vb_PrestaRegroupé:=OB Get:C1224($O_Objet; "vb_PrestaRegroupé"; Est un booléen:K8:9)
		
		//vd_Date1:=OB Lire($O_Objet;"vd_Date1";Est une date)
		
		vl_ET_Dem:=OB Get:C1224($O_Objet; "vl_ET_Dem"; Est un entier long:K8:6)
		vl_ET_Dis:=OB Get:C1224($O_Objet; "vl_ET_Dis"; Est un entier long:K8:6)
		
		vl_HG_Appels:=OB Get:C1224($O_Objet; "vl_HG_Appels"; Est un entier long:K8:6)
		vl_HG_AppelsJour:=OB Get:C1224($O_Objet; "vl_HG_AppelsJour"; Est un entier long:K8:6)
		vl_HG_AppelsJourClo:=OB Get:C1224($O_Objet; "vl_HG_AppelsJourClo"; Est un entier long:K8:6)
		
		vl_LC_PrestaNb:=OB Get:C1224($O_Objet; "vl_LC_PrestaNb"; Est un entier long:K8:6)
		vl_LC_Total:=OB Get:C1224($O_Objet; "vl_LC_Total"; Est un entier long:K8:6)
		
		vl_xNbIdtéJ:=OB Get:C1224($O_Objet; "vl_xNbIdtéJ"; Est un entier long:K8:6)
		vl_xNbIdtéJC:=OB Get:C1224($O_Objet; "vl_xNbIdtéJC"; Est un entier long:K8:6)
		vl_xNbIdtéN:=OB Get:C1224($O_Objet; "vl_xNbIdtéN"; Est un entier long:K8:6)
		vl_xNbIdtéT:=OB Get:C1224($O_Objet; "vl_xNbIdtéT"; Est un entier long:K8:6)
		vl_xNbSgltJ:=OB Get:C1224($O_Objet; "vl_xNbSgltJ"; Est un entier long:K8:6)
		vl_xNbSgltJC:=OB Get:C1224($O_Objet; "vl_xNbSgltJC"; Est un entier long:K8:6)
		vl_xNbSgltN:=OB Get:C1224($O_Objet; "vl_xNbSgltN"; Est un entier long:K8:6)
		vl_xNbSgltT:=OB Get:C1224($O_Objet; "vl_xNbSgltT"; Est un entier long:K8:6)
		
		OB GET ARRAY:C1229($O_Objet; "<>ta_TBEtCiv"; <>ta_TBEtCiv)
		
		OB GET ARRAY:C1229($O_Objet; "ta_ET_EtcivGroupe"; ta_ET_EtcivGroupe)
		OB GET ARRAY:C1229($O_Objet; "ta_ET_EtcivLienGroupe"; ta_ET_EtcivLienGroupe)
		OB GET ARRAY:C1229($O_Objet; "ta_ET_EtcivLienOrigine"; ta_ET_EtcivLienOrigine)
		
		OB GET ARRAY:C1229($O_Objet; "ta_LC_Centre"; ta_LC_Centre)
		OB GET ARRAY:C1229($O_Objet; "ta_LC_CentreLien"; ta_LC_CentreLien)
		OB GET ARRAY:C1229($O_Objet; "ta_LC_Presta"; ta_LC_Presta)
		OB GET ARRAY:C1229($O_Objet; "ta_LC_PrestaLien"; ta_LC_PrestaLien)
		
		OB GET ARRAY:C1229($O_Objet; "ta_xGroupe"; ta_xGroupe)
		OB GET ARRAY:C1229($O_Objet; "ta_xTBPIdté"; ta_xTBPIdté)
		OB GET ARRAY:C1229($O_Objet; "ta_xTBSglt"; ta_xTBSglt)
		
		OB GET ARRAY:C1229($O_Objet; "te_xGroupe"; te_xGroupe)
		
		OB GET ARRAY:C1229($O_Objet; "tl_ET_Dem"; tl_ET_Dem)
		OB GET ARRAY:C1229($O_Objet; "tl_ET_Dis"; tl_ET_Dis)
		
		OB GET ARRAY:C1229($O_Objet; "tl_LC_Centre"; tl_LC_Centre)
		OB GET ARRAY:C1229($O_Objet; "tl_LC_CentreLien"; tl_LC_CentreLien)
		OB GET ARRAY:C1229($O_Objet; "tl_LC_Presta"; tl_LC_Presta)
		OB GET ARRAY:C1229($O_Objet; "tl_LC_PrestaLien"; tl_LC_PrestaLien)
		OB GET ARRAY:C1229($O_Objet; "tl_LC_PrestaNb"; tl_LC_PrestaNb)
		OB GET ARRAY:C1229($O_Objet; "tl_LC_Total"; tl_LC_Total)
		
		OB GET ARRAY:C1229($O_Objet; "tl_xNbIdtéJ"; tl_xNbIdtéJ)
		OB GET ARRAY:C1229($O_Objet; "tl_xNbIdtéJC"; tl_xNbIdtéJC)
		OB GET ARRAY:C1229($O_Objet; "tl_xNbIdtéN"; tl_xNbIdtéN)
		OB GET ARRAY:C1229($O_Objet; "tl_xNbIdtéT"; tl_xNbIdtéT)
		OB GET ARRAY:C1229($O_Objet; "tl_xNbSgltJ"; tl_xNbSgltJ)
		OB GET ARRAY:C1229($O_Objet; "tl_xNbSgltJC"; tl_xNbSgltJC)
		OB GET ARRAY:C1229($O_Objet; "tl_xNbSgltN"; tl_xNbSgltN)
		OB GET ARRAY:C1229($O_Objet; "tl_xNbSgltT"; tl_xNbSgltT)
	End if 
	
	CLEAR VARIABLE:C89($O_Objet)
	
	i_MessageSeul("Calcul en cours  4/4: Les totaux")
	
	If (<>vb_StopEven=False:C215)
		
		If (vl_Tab1>0)  // Etat civil
			
			For ($ii; 1; vl_Tab1)
				tl_ET_Med{$ii}:=tl_ET_Dem{$ii}-tl_ET_Dis{$ii}
			End for 
			
			vl_ET_Med:=0
			
			For ($ii; 1; vl_Tab1)
				vl_ET_Med:=vl_ET_Med+tl_ET_Med{$ii}
			End for 
			
			For ($ii; 1; vl_Tab1)
				
				If (vl_ET_Dem>0)
					tr_ET_DemPc{$ii}:=Round:C94((tl_ET_Dem{$ii}/vl_ET_Dem)*100; 0)
					tr_ET_DisPc{$ii}:=Round:C94(((tl_ET_Dis{$ii}/vl_ET_Dem)*100); 0)
					tr_ET_MedPc{$ii}:=Round:C94((tl_ET_Med{$ii}/vl_ET_Dem)*100; 0)
				Else 
					tr_ET_DemPc{$ii}:=0
					tr_ET_DisPc{$ii}:=0
					tr_ET_MedPc{$ii}:=0
				End if 
				
				vr_ET_DemPc:=vr_ET_DemPc+tr_ET_DemPc{$ii}
				vr_ET_DisPc:=vr_ET_DisPc+tr_ET_DisPc{$ii}
				vr_ET_MedPc:=vr_ET_MedPc+tr_ET_MedPc{$ii}
			End for 
			
		End if 
		
		If (vl_Tab2>0)  // Centres
			
			For ($ii; 1; vl_Tab2)
				
				If (tl_LC_Dis{$ii}>0)
					tr_LC_TauxOccup{$ii}:=(tl_LC_Total{$ii}/tl_LC_Dis{$ii})*100
				Else 
					tr_LC_TauxOccup{$ii}:=0
				End if 
				
			End for 
			
			vr_LC_TauxOccup:=0
			
			If (vl_LC_Dis>0)
				vr_LC_TauxOccup:=(vl_LC_Total/vl_LC_Dis)*100
			End if 
			
			If (7=7)
				$ii:=1
				
				Repeat 
					
					If ((tb_LC_CentreR{$ii}=False:C215) & ((tl_LC_Total{$ii}+tl_LC_Dis{$ii})=0))
						DELETE FROM ARRAY:C228(ta_LC_Centre; $ii; 1)
						DELETE FROM ARRAY:C228(tb_LC_CentreR; $ii; 1)
						DELETE FROM ARRAY:C228(tl_LC_Total; $ii; 1)
						DELETE FROM ARRAY:C228(tl_LC_Dis; $ii; 1)
						DELETE FROM ARRAY:C228(tl_LC_Rest; $ii; 1)
						DELETE FROM ARRAY:C228(tr_LC_TauxOccup; $ii; 1)
					Else 
						$ii:=$ii+1
					End if 
					
				Until ($ii>Size of array:C274(ta_LC_Centre))
				
			End if 
			
			vl_Tab2:=Size of array:C274(ta_LC_Centre)
		End if 
		
		// Modifié par : Scanu Rémy (21/07/2023)
		// Ajout tableau contrôle des lignes des différentes ListBox
		ARRAY BOOLEAN:C223(tb_Sel1; Size of array:C274(tl_ET_Dem))
		ARRAY BOOLEAN:C223(tb_Sel2; Size of array:C274(tl_LC_Dis))
		ARRAY BOOLEAN:C223(tb_Sel3; Size of array:C274(tl_LC_PrestaNb))
		ARRAY BOOLEAN:C223(tb_Sel4; Size of array:C274(tl_xNbSgltJ))
		ARRAY BOOLEAN:C223(tb_Sel5; Size of array:C274(tl_xNbIdtéJ))
		
		// Modifié par : Scanu Rémy (21/07/2023)
		If (Bool:C1537(Form:C1466.maskedEmptyRow)=True:C214)
			outilsArrayVisibility(->tb_Sel1; ->tl_ET_Dem; ->tb_Sel2; ->tl_LC_Dis; ->tb_Sel3; ->tl_LC_PrestaNb; ->tb_Sel4; ->tl_xNbSgltJ; ->tb_Sel5; ->tl_xNbIdtéJ)
		Else 
			outilsArrayVisibility(->tb_Sel1; False:C215; ->tb_Sel2; False:C215; ->tb_Sel3; False:C215; ->tb_Sel4; False:C215; ->tb_Sel5; False:C215)
		End if 
		
	End if 
	
	vl_Tab1:=Size of array:C274(ta_ET_EtcivGroupe)
	vl_Tab2:=Size of array:C274(ta_LC_Centre)
	vl_Tab3:=Size of array:C274(ta_LC_Presta)
	vl_Tab4:=Size of array:C274(ta_xTBSglt)
	vl_Tab5:=Size of array:C274(ta_xTBPIdté)
	
	ON EVENT CALL:C190("")
	CLOSE WINDOW:C154
Else 
	StrAlerte(60; "")
End if 