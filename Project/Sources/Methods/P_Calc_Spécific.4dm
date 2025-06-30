//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_Spécific
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
var $ii; $kk : Integer
var $O_Objet : Object

If (vl_NbJ>366) | (vl_NbJ<1)
	ALERT:C41("Vous ne pouvez pas excéder une année !")
Else 
	vb_OK:=False:C215
	
	For ($ii; 1; Size of array:C274(te_Sel1))
		
		If (te_Sel1{$ii}=1)
			vb_OK:=True:C214
		End if 
		
	End for 
	
	If (vb_OK=False:C215)
		ALERT:C41("Vous devez faire votre choix dans le premier tableau !")
	End if 
	
	If (vb_OK)
		i_Stop
		ON EVENT CALL:C190("i_Stop_ESC")
		
		If (<>vb_StopEven=False:C215)
			
			If (vd_Date1=vd_Date2)
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
			Else 
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2; *)
			End if 
			
			//6/12/011
			If (<>ve_ConsoRegion_Mode=2)  // Base régionale
				
				If (va_Dept>"")
					QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Regional_Departement:154=va_Dept; *)
				End if 
				
			End if 
			//FIN 6/12/011      
			
			If (rJourNuit1#1) | (rJourNuit2#1)  // Jour et nuit
				
				If (rJourNuit1=1)  // Jour
					QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
				End if 
				
				If (rJourNuit2=1)  // Nuit
					QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
				End if 
				
			End if 
			
			If (rReport=0)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
			End if 
			
			// Sans les inconnus
			If (u2=1)
				// Modifié par : Scanu Rémy (18/02/2022)
				//CHERCHER([HeberGement]; & ;[HeberGement]HG_Nom#"X0@";*)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nom:21#"Z0@"; *)
			End if 
			
			If (w1=1)  //Que les fiches cloturées
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
			Else 
				QUERY:C277([HeberGement:5])
			End if 
			
			MultiSoc_Filter(->[HeberGement:5])
			
			vl_NbHB:=Records in selection:C76([HeberGement:5])
			
			If (vl_NbHB>0)
				CREATE SET:C116([HeberGement:5]; "E_encours")
				CREATE EMPTY SET:C140([HeberGement:5]; "E_HParCentres")
				
				//Par sélection de centres
				ARRAY TEXT:C222(ta_xPopCT_Centre; 0)
				ARRAY LONGINT:C221(tl_xPopCT_ID; 0)
				
				If (Size of array:C274(ta_xCentre)>0)
					
					For ($ii; 1; Size of array:C274(ta_xCentre))
						
						If (te_xCentre{$ii}=1)
							$kk:=Size of array:C274(ta_xPopCT_Centre)+1
							
							INSERT IN ARRAY:C227(ta_xPopCT_Centre; $kk)
							INSERT IN ARRAY:C227(tl_xPopCT_ID; $kk)
							
							ta_xPopCT_Centre{$kk}:=ta_xCentre{$ii}
							tl_xPopCT_ID{$kk}:=tl_xCentre{$ii}
						End if 
						
					End for 
					
				End if 
				
				If (Size of array:C274(ta_xPopCT_Centre)>0)
					
					If (Size of array:C274(ta_xPopCT_Centre)<Size of array:C274(ta_xCentre))
						QUERY WITH ARRAY:C644([HeberGement:5]HG_LC_ID:61; tl_xPopCT_ID)
						
						CREATE SET:C116([HeberGement:5]; "E_HParCentres")
						INTERSECTION:C121("E_encours"; "E_HParCentres"; "E_encours")
					End if 
					
				End if 
				
				CLEAR SET:C117("E_HParCentres")
			Else 
				CREATE EMPTY SET:C140([HeberGement:5]; "E_encours")
			End if 
			
		End if 
		
		If (True:C214)
			C_TEXT:C284(va_TempA1)
			C_LONGINT:C283(vl_TempA1; vl_TempA2)
			
			OB SET:C1220($O_Objet; "<>vb_StopEven"; <>vb_StopEven)
			
			OB SET ARRAY:C1227($O_Objet; "tp_Rub1"; tp_Rub1)
			OB SET ARRAY:C1227($O_Objet; "tp_Rub2"; tp_Rub2)
			OB SET ARRAY:C1227($O_Objet; "tp_Rub3"; tp_Rub3)
			OB SET ARRAY:C1227($O_Objet; "tp_Rub4"; tp_Rub4)
			
			OB SET ARRAY:C1227($O_Objet; "te_Rub1"; te_Rub1)
			OB SET ARRAY:C1227($O_Objet; "te_Rub2"; te_Rub1)
			OB SET ARRAY:C1227($O_Objet; "te_Rub3"; te_Rub1)
			OB SET ARRAY:C1227($O_Objet; "te_Rub4"; te_Rub1)
			
			OB SET ARRAY:C1227($O_Objet; "ta_it1"; ta_it1)
			OB SET ARRAY:C1227($O_Objet; "ta_it2"; ta_it2)
			OB SET ARRAY:C1227($O_Objet; "ta_it3"; ta_it3)
			OB SET ARRAY:C1227($O_Objet; "ta_it4"; ta_it4)
			
			OB SET ARRAY:C1227($O_Objet; "te_Sel1"; te_Sel1)
			OB SET ARRAY:C1227($O_Objet; "te_Sel2"; te_Sel2)
			OB SET ARRAY:C1227($O_Objet; "te_Sel3"; te_Sel3)
			OB SET ARRAY:C1227($O_Objet; "te_Sel4"; te_Sel4)
			
			OB SET ARRAY:C1227($O_Objet; "tl_Nb1"; tl_Nb1)
			OB SET ARRAY:C1227($O_Objet; "tl_Nb1_1"; tl_Nb1_1)
			OB SET ARRAY:C1227($O_Objet; "tl_Nb2"; tl_Nb2)
			OB SET ARRAY:C1227($O_Objet; "tl_Nb2_2"; tl_Nb2_2)
			OB SET ARRAY:C1227($O_Objet; "tl_Nb3"; tl_Nb3)
			OB SET ARRAY:C1227($O_Objet; "tl_Nb3_3"; tl_Nb3_3)
			OB SET ARRAY:C1227($O_Objet; "tl_Nb4"; tl_Nb4)
			OB SET ARRAY:C1227($O_Objet; "tl_Nb4_4"; tl_Nb4_4)
			
			OB SET:C1220($O_Objet; "va_TempA1"; va_TempA1)
			
			OB SET:C1220($O_Objet; "vd_Date1"; vd_Date1)
			OB SET:C1220($O_Objet; "vd_Date2"; vd_Date2)
			
			OB SET:C1220($O_Objet; "vl_HBdif"; vl_HBdif)
			OB SET:C1220($O_Objet; "vl_NbHBd"; vl_NbHBd)
			
			OB SET:C1220($O_Objet; "vl_TempA1"; vl_TempA1)
			OB SET:C1220($O_Objet; "vl_TempA2"; vl_TempA2)
			
			OB SET:C1220($O_Objet; "vl_Tot1"; vl_Tot1)
			OB SET:C1220($O_Objet; "vl_Tot1_1"; vl_Tot1_1)
			OB SET:C1220($O_Objet; "vl_Tot2"; vl_Tot2)
			OB SET:C1220($O_Objet; "vl_Tot2_2"; vl_Tot2_2)
			OB SET:C1220($O_Objet; "vl_Tot3"; vl_Tot3)
			OB SET:C1220($O_Objet; "vl_Tot3_3"; vl_Tot3_3)
			OB SET:C1220($O_Objet; "vl_Tot4"; vl_Tot4)
			OB SET:C1220($O_Objet; "vl_Tot4_4"; vl_Tot4_4)
		End if 
		
		P_Calc_Spécific1_Nv(->$O_Objet)
		
		If (True:C214)
			<>vb_StopEven:=OB Get:C1224($O_Objet; "<>vb_StopEven")
			
			OB GET ARRAY:C1229($O_Objet; "tp_Rub1"; tp_Rub1)
			OB GET ARRAY:C1229($O_Objet; "tp_Rub2"; tp_Rub2)
			OB GET ARRAY:C1229($O_Objet; "tp_Rub3"; tp_Rub3)
			OB GET ARRAY:C1229($O_Objet; "tp_Rub4"; tp_Rub4)
			
			OB GET ARRAY:C1229($O_Objet; "ta_it1"; ta_it1)
			OB GET ARRAY:C1229($O_Objet; "ta_it2"; ta_it2)
			OB GET ARRAY:C1229($O_Objet; "ta_it3"; ta_it3)
			OB GET ARRAY:C1229($O_Objet; "ta_it4"; ta_it4)
			
			OB GET ARRAY:C1229($O_Objet; "te_Sel1"; te_Sel1)
			OB GET ARRAY:C1229($O_Objet; "te_Sel2"; te_Sel2)
			OB GET ARRAY:C1229($O_Objet; "te_Sel3"; te_Sel3)
			OB GET ARRAY:C1229($O_Objet; "te_Sel4"; te_Sel4)
			
			OB GET ARRAY:C1229($O_Objet; "tl_Nb1"; tl_Nb1)
			OB GET ARRAY:C1229($O_Objet; "tl_Nb1_1"; tl_Nb1_1)
			OB GET ARRAY:C1229($O_Objet; "tl_Nb2"; tl_Nb2)
			OB GET ARRAY:C1229($O_Objet; "tl_Nb2_2"; tl_Nb2_2)
			OB GET ARRAY:C1229($O_Objet; "tl_Nb3"; tl_Nb3)
			OB GET ARRAY:C1229($O_Objet; "tl_Nb3_3"; tl_Nb3_3)
			OB GET ARRAY:C1229($O_Objet; "tl_Nb4"; tl_Nb4)
			OB GET ARRAY:C1229($O_Objet; "tl_Nb4_4"; tl_Nb4_4)
			
			va_TempA1:=OB Get:C1224($O_Objet; "va_TempA1")
			
			vd_Date1:=OB Get:C1224($O_Objet; "vd_Date1"; Est une date:K8:7)
			vd_Date2:=OB Get:C1224($O_Objet; "vd_Date2"; Est une date:K8:7)
			
			vl_HBdif:=OB Get:C1224($O_Objet; "vl_HBdif")
			vl_NbHBd:=OB Get:C1224($O_Objet; "vl_NbHBd")
			
			vl_TempA1:=OB Get:C1224($O_Objet; "vl_TempA1")
			vl_TempA2:=OB Get:C1224($O_Objet; "vl_TempA2")
			
			vl_Tot1:=OB Get:C1224($O_Objet; "vl_Tot1")
			vl_Tot1_1:=OB Get:C1224($O_Objet; "vl_Tot1_1")
			vl_Tot2:=OB Get:C1224($O_Objet; "vl_Tot2")
			vl_Tot2_2:=OB Get:C1224($O_Objet; "vl_Tot2_2")
			vl_Tot3:=OB Get:C1224($O_Objet; "vl_Tot3")
			vl_Tot3_3:=OB Get:C1224($O_Objet; "vl_Tot3_3")
			vl_Tot4:=OB Get:C1224($O_Objet; "vl_Tot4")
			vl_Tot4_4:=OB Get:C1224($O_Objet; "vl_Tot4_4")
			
			// Modifié par : Scanu Rémy (21/07/2023)
			// Ajout tableau contrôle des lignes des différentes ListBox
			ARRAY BOOLEAN:C223(tb_Sel1; Size of array:C274(tl_Nb1))
			ARRAY BOOLEAN:C223(tb_Sel2; Size of array:C274(tl_Nb2))
			ARRAY BOOLEAN:C223(tb_Sel3; Size of array:C274(tl_Nb3))
			ARRAY BOOLEAN:C223(tb_Sel4; Size of array:C274(tl_Nb4))
			
			// Modifié par : Scanu Rémy (21/07/2023)
			If (Bool:C1537(Form:C1466.maskedEmptyRow)=True:C214)
				outilsArrayVisibility(->tb_Sel1; ->tl_Nb1; ->tb_Sel2; ->tl_Nb2; ->tb_Sel3; ->tl_Nb3; ->tb_Sel4; ->tl_Nb4)
			Else 
				outilsArrayVisibility(->tb_Sel1; False:C215; ->tb_Sel2; False:C215; ->tb_Sel3; False:C215; ->tb_Sel4; False:C215)
			End if 
			
		End if 
		
		ON EVENT CALL:C190("")
	End if 
	
	CLOSE WINDOW:C154
End if 

ALERT:C41("Statistiques Spécifiques: Terminé")