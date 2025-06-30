//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : P_TauxPresentation
//{
//{          Lundi 20 juillet 2009 à 11:52:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  //Cas (Déclarations, Calcul,…)
C_LONGINT:C283($2)
C_LONGINT:C283($ii; $ii2; $ii3; $jj; $jj2)
C_BOOLEAN:C305($vb_115)

C_TIME:C306($h_RefDoc)
C_TEXT:C284($vt_Texte; $vt_Texte1; $vt_Texte2; $vt_Texte3; $vt_Texte4)
C_TIME:C306($vh_Heure)
C_TEXT:C284(va_Virgule)
va_Virgule:=","

C_LONGINT:C283($vl_Tableau1; $vl_Tableau2)


Case of 
	: ($1=0)
		C_LONGINT:C283(<>vl_ShowIndice)
		C_LONGINT:C283(<>vl_ShowDemande; <>vl_ShowHébergé; <>vl_ShowHébergéJ; <>vl_ShowNonHébergé)
		C_LONGINT:C283(<>vl_ShowDemandeG; <>vl_ShowHébergéG; <>vl_ShowHébergéJG; <>vl_ShowNonHébergéG)
		C_REAL:C285(<>vr_ShowDemande; <>vr_ShowHébergé; <>vr_ShowHébergéJ; <>vr_ShowNonHébergé)
		
		
		ARRAY DATE:C224(<>td_ShowDate; 0)
		ARRAY LONGINT:C221(<>tl_ShowHeure; 0)
		ARRAY TEXT:C222(<>ta_ShowLibellé; 0)
		ARRAY TEXT:C222(<>ta_ShowGroupé; 0)
		ARRAY TEXT:C222(<>ta_ShowOrigine; 0)
		
		ARRAY LONGINT:C221(<>tl_ShowDemande; 0)
		ARRAY LONGINT:C221(<>tl_ShowHébergé; 0)
		ARRAY LONGINT:C221(<>tl_ShowHébergéJ; 0)
		ARRAY LONGINT:C221(<>tl_ShowNonHébergé; 0)
		
		ARRAY LONGINT:C221(<>tl_ShowDemandeG; 0)
		ARRAY LONGINT:C221(<>tl_ShowHébergéG; 0)
		ARRAY LONGINT:C221(<>tl_ShowHébergéJG; 0)
		ARRAY LONGINT:C221(<>tl_ShowNonHébergéG; 0)
		
		
		ARRAY REAL:C219(<>tr_ShowDemandeS; 0)
		ARRAY REAL:C219(<>tr_ShowHébergéS; 0)
		ARRAY REAL:C219(<>tr_ShowHébergéJS; 0)
		ARRAY REAL:C219(<>tr_ShowNonHébergéS; 0)
		
		ARRAY REAL:C219(<>tr_ShowDemandeT; 0)
		ARRAY REAL:C219(<>tr_ShowHébergéT; 0)
		ARRAY REAL:C219(<>tr_ShowHébergéJT; 0)
		ARRAY REAL:C219(<>tr_ShowNonHébergéT; 0)
		
		ARRAY TEXT:C222(<>ta_ShowAutreSol; 0)
		ARRAY LONGINT:C221(<>tl_ShowAutreSol; 0)
		ARRAY REAL:C219(<>tr_ShowAutreSol; 0)
		C_LONGINT:C283(<>vl_ShowAutreSol)
		C_REAL:C285(<>vr_ShowAutreSol)
		
		
		ARRAY LONGINT:C221(<>tl_ShowCtrRéf; 0)
		ARRAY TEXT:C222(<>ta_ShowCtrCode; 0)
		ARRAY TEXT:C222(<>ta_ShowCtrNom; 0)
		ARRAY TEXT:C222(<>ta_ShowCtrRepertoire; 0)
		ARRAY TEXT:C222(<>ta_ShowCtrPlateforme; 0)
		ARRAY INTEGER:C220(<>tl_ShowCtrCapacité; 0)
		ARRAY LONGINT:C221(<>tl_ShowCtrHébergé; 0)
		
		
		
		
	: ($1=1)
		i_Message("Calcul en cours…")
		
		//Constituer la liste des codes centres pour rechercher les hébergements
		//C'est une Base de Type 115 (consolidation)
		//Ou une base mono site
		//On crée un tableau avec toutes les références centres
		P_TauxPresentation(20; 0)
		
		
		ALL RECORDS:C47([PresentationData:45])
		MultiSoc_Filter(->[PresentationData:45])
		//CHERCHER([PresentationData];[PresentationData]PN_Date=vd_Date1)
		If (Records in selection:C76([PresentationData:45])>0)
			READ WRITE:C146([PresentationData:45])
			DELETE SELECTION:C66([PresentationData:45])
			READ ONLY:C145([PresentationData:45])
		End if 
		
		ALL RECORDS:C47([ShowAutreS:46])
		MultiSoc_Filter(->[ShowAutreS:46])
		//CHERCHER([PresentationAutresS];[PresentationAutresS]PA_Date=vd_Date1)
		If (Records in selection:C76([ShowAutreS:46])>0)
			READ WRITE:C146([ShowAutreS:46])
			DELETE SELECTION:C66([ShowAutreS:46])
			READ ONLY:C145([ShowAutreS:46])
		End if 
		
		$jj:=Size of array:C274(<>ta_TBEtCiv)
		ARRAY LONGINT:C221(<>tl_ShowDemande; $jj)
		ARRAY LONGINT:C221(<>tl_ShowHébergé; $jj)
		ARRAY LONGINT:C221(<>tl_ShowHébergéJ; $jj)
		ARRAY LONGINT:C221(<>tl_ShowNonHébergé; $jj)
		
		For ($ii; 1; $jj)
			<>tl_ShowDemande{$ii}:=0
			<>tl_ShowHébergé{$ii}:=0
			<>tl_ShowHébergéJ{$ii}:=0
			<>tl_ShowNonHébergé{$ii}:=0
		End for 
		
		<>vl_ShowIndice:=0
		ARRAY TEXT:C222(<>ta_ShowAutreSol; 0)
		ARRAY LONGINT:C221(<>tl_ShowAutreSol; 0)
		ARRAY REAL:C219(<>tr_ShowAutreSol; 0)
		
		<>vl_ShowAutreSol:=0
		<>vr_ShowAutreSol:=0
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4=vd_Date1)
		MultiSoc_Filter(->[HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_AutreSolutio:88#"115Double fiche")
			APPLY TO SELECTION:C70([HeberGement:5]; P_TauxPresentationCount)
			//◊ta_ShowAutreSol
			//◊tl_ShowAutreSol
		End if 
		
		$jj:=Size of array:C274(<>ta_ShowAutreSol)
		For ($ii; 1; $jj)
			<>ta_ShowAutreSol{$ii}:=Substring:C12(<>ta_ShowAutreSol{$ii}; 4)
			<>vl_ShowAutreSol:=<>vl_ShowAutreSol+<>tl_ShowAutreSol{$ii}
		End for 
		
		For ($ii; 1; $jj)
			<>tr_ShowAutreSol{$ii}:=<>tl_ShowAutreSol{$ii}/<>vl_ShowAutreSol*100
			<>tr_ShowAutreSol{$ii}:=Round:C94(<>tr_ShowAutreSol{$ii}; 2)
		End for 
		
		
		READ WRITE:C146([ShowAutreS:46])
		ARRAY TO SELECTION:C261(<>ta_ShowAutreSol; [ShowAutreS:46]PA_Libellé:1; <>tl_ShowAutreSol; [ShowAutreS:46]PA_Nombre:5; <>tr_ShowAutreSol; [ShowAutreS:46]PA_Pourcentage:6)
		UNLOAD RECORD:C212([ShowAutreS:46])
		READ ONLY:C145([ShowAutreS:46])
		
		
		$jj:=Size of array:C274(<>ta_TBEtCiv)
		<>vl_ShowIndice:=0
		<>vl_ShowDemande:=0
		<>vl_ShowHébergé:=0
		<>vl_ShowHébergéJ:=0
		<>vl_ShowNonHébergé:=0
		
		<>vr_ShowDemande:=0
		<>vr_ShowHébergé:=0
		<>vr_ShowNonHébergé:=0
		For ($ii; 1; $jj)
			<>vl_ShowDemande:=<>vl_ShowDemande+<>tl_ShowDemande{$ii}
			<>vl_ShowHébergé:=<>vl_ShowHébergé+<>tl_ShowHébergé{$ii}
			<>vl_ShowHébergéJ:=<>vl_ShowHébergéJ+<>tl_ShowHébergéJ{$ii}
			<>vl_ShowNonHébergé:=<>vl_ShowNonHébergé+<>tl_ShowNonHébergé{$ii}
		End for 
		
		
		
		
		If (<>vl_ShowDemande>0)
			QUERY:C277([PreSentation:44]; [PreSentation:44]PS_Scénario:2=<>va_LibScénario; *)
			QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{1}; *)
			QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_LibelléOrigneID:6=0)
			MultiSoc_Filter(->[PreSentation:44])
			If (Records in selection:C76([PreSentation:44])>0)
				SELECTION TO ARRAY:C260([PreSentation:44]PS_Libellé:4; <>ta_ShowLibellé)
			End if 
			ARRAY DATE:C224(<>td_ShowDate; Size of array:C274(<>ta_ShowLibellé))
			ARRAY LONGINT:C221(<>tl_ShowHeure; Size of array:C274(<>ta_ShowLibellé))
			
			QUERY:C277([PreSentation:44]; [PreSentation:44]PS_Scénario:2=<>va_LibScénario; *)
			QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{1}; *)
			QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_LibelléOrigneID:6>0)
			MultiSoc_Filter(->[PreSentation:44])
			If (Records in selection:C76([PreSentation:44])>0)
				SELECTION TO ARRAY:C260([PreSentation:44]PS_Libellé:4; <>ta_ShowGroupé; [PreSentation:44]PS_LibelléOrigine:5; <>ta_ShowOrigine)
			End if 
		End if 
		
		$jj:=Size of array:C274(<>ta_ShowLibellé)
		ARRAY LONGINT:C221(<>tl_ShowDemandeG; $jj)
		ARRAY LONGINT:C221(<>tl_ShowHébergéG; $jj)
		ARRAY LONGINT:C221(<>tl_ShowHébergéJG; $jj)
		ARRAY LONGINT:C221(<>tl_ShowNonHébergéG; $jj)
		
		For ($ii; 1; $jj)
			<>tl_ShowDemandeG{$ii}:=0
			<>tl_ShowHébergéG{$ii}:=0
			<>tl_ShowHébergéJG{$ii}:=0
			<>tl_ShowNonHébergéG{$ii}:=0
			$jj2:=Size of array:C274(<>ta_ShowGroupé)
			For ($ii2; 1; $jj2)
				If (<>ta_ShowGroupé{$ii2}=<>ta_ShowLibellé{$ii})
					$ii3:=Find in array:C230(<>ta_TBEtCiv; <>ta_ShowOrigine{$ii2})
					If ($ii3>0)
						<>tl_ShowDemandeG{$ii}:=<>tl_ShowDemandeG{$ii}+<>tl_ShowDemande{$ii3}
						<>tl_ShowHébergéG{$ii}:=<>tl_ShowHébergéG{$ii}+<>tl_ShowHébergé{$ii3}
						<>tl_ShowHébergéJG{$ii}:=<>tl_ShowHébergéJG{$ii}+<>tl_ShowHébergéJ{$ii3}
						<>tl_ShowNonHébergéG{$ii}:=<>tl_ShowNonHébergéG{$ii}+<>tl_ShowNonHébergé{$ii3}
					End if 
				End if 
			End for 
		End for 
		
		$jj:=Size of array:C274(<>ta_ShowLibellé)
		<>vl_ShowDemandeG:=0
		<>vl_ShowHébergéG:=0
		<>vl_ShowHébergéJG:=0
		<>vl_ShowNonHébergéG:=0
		
		<>vr_ShowDemande:=0
		<>vr_ShowHébergé:=0
		<>vr_ShowHébergéJ:=0
		<>vr_ShowNonHébergé:=0
		
		ARRAY REAL:C219(<>tr_ShowDemandeS; $jj)
		ARRAY REAL:C219(<>tr_ShowHébergéS; $jj)
		ARRAY REAL:C219(<>tr_ShowHébergéJS; $jj)
		ARRAY REAL:C219(<>tr_ShowNonHébergéS; $jj)
		
		
		
		If (vb_SurServeur)
			
		Else 
			vh_Heure1:=Current time:C178
		End if 
		
		
		For ($ii; 1; $jj)
			<>td_ShowDate{$ii}:=vd_Date1
			<>tl_ShowHeure{$ii}:=vh_Heure1+0
			<>vl_ShowDemandeG:=<>vl_ShowDemandeG+<>tl_ShowDemandeG{$ii}
			<>vl_ShowHébergéG:=<>vl_ShowHébergéG+<>tl_ShowHébergéG{$ii}
			<>vl_ShowHébergéJG:=<>vl_ShowHébergéJG+<>tl_ShowHébergéJG{$ii}
			<>vl_ShowNonHébergéG:=<>vl_ShowNonHébergéG+<>tl_ShowNonHébergéG{$ii}
		End for 
		
		For ($ii; 1; $jj)
			<>tr_ShowDemandeS{$ii}:=<>tl_ShowDemandeG{$ii}/<>vl_ShowDemandeG*100
			<>tr_ShowHébergéS{$ii}:=<>tl_ShowHébergéG{$ii}/<>vl_ShowHébergéG*100
			<>tr_ShowHébergéJS{$ii}:=<>tl_ShowHébergéJG{$ii}/<>vl_ShowHébergéJG*100
			<>tr_ShowNonHébergéS{$ii}:=<>tl_ShowNonHébergéG{$ii}/<>vl_ShowNonHébergéG*100
			
			<>tr_ShowDemandeS{$ii}:=Round:C94(<>tr_ShowDemandeS{$ii}; 2)
			<>tr_ShowHébergéS{$ii}:=Round:C94(<>tr_ShowHébergéS{$ii}; 2)
			<>tr_ShowHébergéJS{$ii}:=Round:C94(<>tr_ShowHébergéJS{$ii}; 2)
			<>tr_ShowNonHébergéS{$ii}:=Round:C94(<>tr_ShowNonHébergéS{$ii}; 2)
		End for 
		
		For ($ii; 1; $jj)
			<>vr_ShowDemande:=<>vr_ShowDemande+<>tr_ShowDemandeS{$ii}
			<>vr_ShowHébergé:=<>vr_ShowHébergé+<>tr_ShowHébergéS{$ii}
			<>vr_ShowHébergéJ:=<>vr_ShowHébergéJ+<>tr_ShowHébergéJS{$ii}
			<>vr_ShowNonHébergé:=<>vr_ShowNonHébergé+<>tr_ShowNonHébergéS{$ii}
		End for 
		READ WRITE:C146([PresentationData:45])
		ARRAY TO SELECTION:C261(<>td_ShowDate; [PresentationData:45]PN_Date:1; <>tl_ShowHeure; [PresentationData:45]PN_Heure:11; <>ta_ShowLibellé; [PresentationData:45]PN_Libelle:2; <>tl_ShowDemandeG; [PresentationData:45]PN_Demandes:3; <>tl_ShowNonHébergéG; [PresentationData:45]PN_NonSatisfait:4; <>tl_ShowHébergéG; [PresentationData:45]PN_Heberges:5; <>tl_ShowHébergéJG; [PresentationData:45]PN_HebergesJour:6; <>tr_ShowDemandeS; [PresentationData:45]PN_DemandesPC:7; <>tr_ShowNonHébergéS; [PresentationData:45]PN_NonSatisfaitPC:8; <>tr_ShowHébergéS; [PresentationData:45]PN_HebergesPC:9; <>tr_ShowHébergéJS; [PresentationData:45]PN_HebergesJourPC:10)
		UNLOAD RECORD:C212([PresentationData:45])
		READ ONLY:C145([PresentationData:45])
		
		If ($2=1)
			
			va_DateMaJ:="Mise à jour le  "+String:C10(Current date:C33; Interne date court:K1:7)+" à "+String:C10(vh_Heure1; h mn:K7:2)
			
			
			QUERY:C277([PresentationData:45]; [PresentationData:45]PN_Date:1=vd_Date1)
			MultiSoc_Filter(->[PresentationData:45])
			ORDER BY:C49([PresentationData:45]; [PresentationData:45]PN_Libelle:2; >)
			FORM SET OUTPUT:C54([PresentationData:45]; "Export_Presente")
			EXPORT TEXT:C167([PresentationData:45]; "LesTaux")
		End if 
		If ($2=0)
			If (Size of array:C274(<>ta_ShowLibellé)>0)
				
				
				If (vb_SurServeur)
					$vh_Heure:=vh_Heure1
				Else 
					$vh_Heure:=Current time:C178
				End if 
				
				$vt_Texte:=vt_ws_Répertoire+va_ws_NomDocument
				$vt_Texte:=$vt_Texte+String:C10(Year of:C25(vd_Date1); "0000")
				$vt_Texte:=$vt_Texte+String:C10(Month of:C24(vd_Date1); "00")
				$vt_Texte:=$vt_Texte+String:C10(Day of:C23(vd_Date1); "00")
				$vt_Texte:=$vt_Texte+String:C10(($vh_Heure\3600); "00")
				//  $vt_Texte:=$vt_Texte+Chaine((($vh_Heure\60)%60);"00")
				
				$h_RefDoc:=Create document:C266($vt_Texte)
				If (OK=1)
					USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
					
					$vt_Texte:=""
					For ($ii; 1; 4)
						$vt_Texte1:=""
						Case of 
							: ($ii=1)
								$vt_Texte1:="Répartition des demandes non satisfaites"
							: ($ii=2)
								$vt_Texte1:="Répartition des nouveaux hébergés"  //"Répartition des -arrivants" modifié le 15/9/09
							: ($ii=3)
								$vt_Texte1:="Répartition des demandes satisfaites"
							: ($ii=4)
								$vt_Texte1:="Motif des demandes non satisfaites"
						End case 
						
						$vt_Texte2:=String:C10(Year of:C25(vd_Date1); "0000")+String:C10(Month of:C24(vd_Date1); "00")+String:C10(Day of:C23(vd_Date1); "00")
						
						$vt_Texte3:=String:C10(($vh_Heure\3600); "00")
						$vt_Texte3:=$vt_Texte3+String:C10((($vh_Heure\60)%60); "00")
						$vt_Texte3:=$vt_Texte3+String:C10(($vh_Heure%60); "00")
						
						$vt_Texte4:=""
						$vt_Texte5:=<>va_CR
						
						If ($ii=4)
							If (7=8)
								For ($jj; 1; Size of array:C274(<>ta_ShowAutreSol))
									$vt_Texte4:=<>ta_ShowAutreSol{$jj}
									$vt_Texte5:=String:C10(<>tl_ShowAutreSol{$jj})+<>va_CR
									If (<>vb_CestUnMac)
										SEND PACKET:C103($h_RefDoc; Char:C90(34)+$vt_Texte1+Char:C90(34)+va_Virgule+Char:C90(34)+$vt_Texte2+Char:C90(34)+va_Virgule+Char:C90(34)+$vt_Texte3+Char:C90(34)+va_Virgule+Char:C90(34)+$vt_Texte4+Char:C90(34)+va_Virgule+$vt_Texte5)
									Else 
										SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463($vt_Texte1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($vt_Texte2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($vt_Texte3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($vt_Texte4)+Char:C90(34)+va_Virgule+_O_Mac to Win:C463($vt_Texte5))
									End if 
								End for 
							End if 
						Else 
							For ($jj; 1; Size of array:C274(<>ta_ShowLibellé))
								Case of 
									: ($ii=1)
										$vt_Texte4:=<>ta_ShowLibellé{$jj}
										$vt_Texte5:=String:C10(<>tl_ShowNonHébergéG{$jj})+<>va_CR
									: ($ii=2)
										$vt_Texte4:=<>ta_ShowLibellé{$jj}
										$vt_Texte5:=String:C10(<>tl_ShowHébergéJG{$jj})+<>va_CR
									: ($ii=3)
										$vt_Texte4:=<>ta_ShowLibellé{$jj}
										$vt_Texte5:=String:C10(<>tl_ShowHébergéG{$jj})+<>va_CR
								End case 
								If (<>vb_CestUnMac)
									SEND PACKET:C103($h_RefDoc; Char:C90(34)+$vt_Texte1+Char:C90(34)+va_Virgule+Char:C90(34)+$vt_Texte2+Char:C90(34)+va_Virgule+Char:C90(34)+$vt_Texte3+Char:C90(34)+va_Virgule+Char:C90(34)+$vt_Texte4+Char:C90(34)+va_Virgule+$vt_Texte5)
								Else 
									SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463($vt_Texte1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($vt_Texte2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($vt_Texte3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($vt_Texte4)+Char:C90(34)+va_Virgule+_O_Mac to Win:C463($vt_Texte5))
								End if 
							End for 
						End if 
					End for 
					
					//à la fin les centres
					If (Size of array:C274(<>tl_ShowCtrRéf)>0)
						For ($jj; 1; Size of array:C274(<>tl_ShowCtrRéf))
							$vt_Texte1:="Répartition des hébergements par centre"
							
							//Centre sur 6 caracteres le 21/9/2009
							
							If (Length:C16(<>ta_ShowCtrNom{$jj})>6)
								$vt_Texte4:=Substring:C12(<>ta_ShowCtrNom{$jj}; 1; 6)
							Else 
								$vt_Texte4:=<>ta_ShowCtrNom{$jj}
							End if 
							$vt_Texte5:=String:C10(<>tl_ShowCtrHébergé{$jj})+<>va_CR
							If (<>vb_CestUnMac)
								SEND PACKET:C103($h_RefDoc; Char:C90(34)+$vt_Texte1+Char:C90(34)+va_Virgule+Char:C90(34)+$vt_Texte2+Char:C90(34)+va_Virgule+Char:C90(34)+$vt_Texte3+Char:C90(34)+va_Virgule+Char:C90(34)+$vt_Texte4+Char:C90(34)+va_Virgule+$vt_Texte5)
							Else 
								SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463($vt_Texte1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($vt_Texte2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($vt_Texte3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($vt_Texte4)+Char:C90(34)+va_Virgule+_O_Mac to Win:C463($vt_Texte5))
							End if 
						End for 
					End if 
					
					USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
					CLOSE DOCUMENT:C267($h_RefDoc)
				End if 
			End if 
		End if 
		CLOSE WINDOW:C154
		
	: ($1=10)
		$jj:=Size of array:C274(<>ta_ShowLibellé)
		If ($jj>0)
			For ($ii; 1; $jj)
			End for 
		End if 
		
	: ($1=20)
		//ESt-ce un 115 ou un CHRS
		//115 : numérotation des centres entre 0 et 999 999
		//Les autres sont à partir de 1 000 000
		$vb_115:=(<>ve_T_CentreCode=0)
		ARRAY LONGINT:C221($tl_ShowCtrLiés; 0)
		
		ARRAY LONGINT:C221(<>tl_ShowCtrRéf; 0)
		ARRAY TEXT:C222(<>ta_ShowCtrCode; 0)
		ARRAY TEXT:C222(<>ta_ShowCtrNom; 0)
		ARRAY TEXT:C222(<>ta_ShowCtrRepertoire; 0)
		ARRAY TEXT:C222(<>ta_ShowCtrPlateforme; 0)
		ARRAY INTEGER:C220(<>tl_ShowCtrCapacité; 0)
		ARRAY LONGINT:C221(<>tl_ShowCtrHébergé; 0)
		
		//Recherche N° 1
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Prestation:55=False:C215; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Fermé:53=False:C215)
		MultiSoc_Filter(->[LesCentres:9])
		If (Records in selection:C76([LesCentres:9])>0)
			ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Répertoire:54; >; *)
			ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
			FIRST RECORD:C50([LesCentres:9])
			SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; <>tl_ShowCtrRéf; [LesCentres:9]LC_Code:3; <>ta_ShowCtrCode; [LesCentres:9]LC_Répertoire:54; <>ta_ShowCtrRepertoire; [LesCentres:9]LC_Plateforme:56; <>ta_ShowCtrPlateforme; [LesCentres:9]LC_Nom:4; <>ta_ShowCtrNom; [LesCentres:9]LC_DispoJour:48; <>tl_ShowCtrCapacité)
		End if 
		
		$vl_Tableau1:=Size of array:C274(<>tl_ShowCtrRéf)
		ARRAY LONGINT:C221(<>tl_ShowCtrHébergé; $vl_Tableau1)
		If ($vl_Tableau1>0)
			For ($ii; 1; $vl_Tableau1)
				<>tl_ShowCtrHébergé{$vl_Tableau1}:=0
			End for 
		End if 
		
		If ($vl_Tableau1>0)
			For ($ii; 1; $vl_Tableau1)
				ARRAY LONGINT:C221($tl_ShowCtrLiés; 0)
				//Recherche N° 2
				//Les hébergements des centres du 115 ou des autres centres consolidés
				If ($vb_115)  //Si c'est le 115 il y en a
					If (<>ta_ShowCtrRepertoire{$ii}="115")  //C'est un centre du 115
						$jj:=Size of array:C274($tl_ShowCtrLiés)+1
						INSERT IN ARRAY:C227($tl_ShowCtrLiés; $jj)
						$tl_ShowCtrLiés{$jj}:=<>tl_ShowCtrRéf{$ii}
					Else   //C'est un père des centres d'un site
						If (<>ta_ShowCtrRepertoire{$ii}>"")  //Le répertoire est bien codé et il y a plusieurs centres rattachés
							QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Répertoire:54=<>ta_ShowCtrRepertoire{$ii})
							MultiSoc_Filter(->[LesCentres:9])
							QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1#<>tl_ShowCtrRéf{$ii})
							If (Records in selection:C76([LesCentres:9])>0)
								SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tl_ShowCtrLiés)
							End if 
						End if 
					End if 
				Else   //Ce n'est pas le 115 il n'y en a pas c'est le centre lui même
					$jj:=Size of array:C274($tl_ShowCtrLiés)+1
					INSERT IN ARRAY:C227($tl_ShowCtrLiés; $jj)
					$tl_ShowCtrLiés{$jj}:=<>tl_ShowCtrRéf{$ii}
				End if 
				
				//CALCUL du nombre de  Lits attribués (clôturés)
				$vl_Tableau2:=Size of array:C274($tl_ShowCtrLiés)
				If ($vl_Tableau2>0)
					If (7=8)
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1)
						MultiSoc_Filter(->[HeberGement:5])
						CREATE SET:C116([HeberGement:5]; "$E_Sel")
						For ($ii2; 1; $vl_Tableau2)
							USE SET:C118("$E_Sel")
							QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=$tl_ShowCtrLiés{$ii2}; *)
							QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
							<>tl_ShowCtrHébergé{$ii}:=<>tl_ShowCtrHébergé{$ii}+Records in selection:C76([HeberGement:5])
						End for 
					Else 
						For ($ii2; 1; $vl_Tableau2)
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
							QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61=$tl_ShowCtrLiés{$ii2}; *)
							QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
							MultiSoc_Filter(->[HeberGement:5])
							<>tl_ShowCtrHébergé{$ii}:=<>tl_ShowCtrHébergé{$ii}+Records in selection:C76([HeberGement:5])
						End for 
						
					End if 
					
				End if 
			End for 
		End if 
		
		If ($vl_Tableau1>0)
			$ii:=1
			Repeat 
				If (<>tl_ShowCtrHébergé{$ii}<=0)
					DELETE FROM ARRAY:C228(<>tl_ShowCtrRéf; $ii; 1)
					DELETE FROM ARRAY:C228(<>ta_ShowCtrCode; $ii; 1)
					DELETE FROM ARRAY:C228(<>ta_ShowCtrNom; $ii; 1)
					DELETE FROM ARRAY:C228(<>ta_ShowCtrRepertoire; $ii; 1)
					DELETE FROM ARRAY:C228(<>ta_ShowCtrPlateforme; $ii; 1)
					DELETE FROM ARRAY:C228(<>tl_ShowCtrCapacité; $ii; 1)
					DELETE FROM ARRAY:C228(<>tl_ShowCtrHébergé; $ii; 1)
				Else 
					$ii:=$ii+1
				End if 
			Until ($ii>Size of array:C274(<>tl_ShowCtrRéf))
		End if 
		
		
End case 

