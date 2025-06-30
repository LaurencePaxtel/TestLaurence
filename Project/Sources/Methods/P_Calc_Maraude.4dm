//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_Maraude
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($ii)
If (vl_NbJ>366) | (vl_NbJ<1)
	ALERT:C41("Vous ne pouvez pas excéder une année !")
Else 
	i_Message("Chargement en cours …")
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
		
		
		
		
		//i_MessageSeul ("Sélection des fiches…")
		If (<>vb_StopEven=False:C215)
			If (vd_Date1=vd_Date2)
				QUERY:C277([Maraude:24]; [Maraude:24]MR_Date:4=vd_Date1; *)
			Else 
				QUERY:C277([Maraude:24]; [Maraude:24]MR_Date:4>=vd_Date1; *)
				QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Date:4<=vd_Date2; *)
			End if 
			If (rJourNuit1=1) & (rJourNuit2=1)  //Jour et nuit
			Else 
				If (rJourNuit1=1)  //Jour
					QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nuit:2=False:C215; *)
				End if 
				If (rJourNuit2=1)  //nuit
					QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nuit:2=True:C214; *)
				End if 
			End if 
			QUERY:C277([Maraude:24])
			MultiSoc_Filter(->[Maraude:24])
			
			//Sans les inconnus
			If (u2=1)
				QUERY SELECTION:C341([Maraude:24]; [Maraude:24]MR_Nom:17#"X0@")
			End if 
			
			vl_NbHB:=Records in selection:C76([Maraude:24])
			If (vl_NbHB>0)
				CREATE SET:C116([Maraude:24]; "E_encours")
			Else 
				CREATE EMPTY SET:C140([Maraude:24]; "E_encours")
			End if 
		End if 
		
		C_LONGINT:C283($L_ref)
		$L_ref:=4D_Progression_Open("")
		C_OBJECT:C1216($O_Progression)
		
		OB SET:C1220($O_Progression; \
			"progress ref"; $L_ref; \
			"progress titel"; "Maraudes"; \
			"progress message"; "Statistique du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2); \
			"progress compteur"; -1; \
			"progress max"; -1; \
			"progress stop"; -1\
			)
		P_Calc_Maraude1
		
		4D_Progression_Close($L_ref)
		
		
		ON EVENT CALL:C190("")
	End if 
	CLOSE WINDOW:C154
End if 
BEEP:C151
ALERT:C41("Statistiques Maraude : Terminé")