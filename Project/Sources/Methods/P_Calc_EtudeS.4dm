//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_EtudeS
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
	i_Stop
	ON EVENT CALL:C190("i_Stop_ESC")
	i_MessageSeul("Sélection des fiches…")
	V_Stat_Etude(1)
	If (<>vb_StopEven=False:C215)
		If (vd_Date1=vd_Date2)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2; *)
		End if 
		If (rJourNuit1=1) & (rJourNuit2=1)  //Jour et nuit
		Else 
			If (rJourNuit1=1)  //Jour
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
			End if 
			If (rJourNuit2=1)  //nuit
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
			End if 
		End if 
		
		If (rReport=0)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
		End if 
		
		If (w1=1)  //Que les fiches cloturées
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
		Else 
			QUERY:C277([HeberGement:5])
		End if 
		
		MultiSoc_Filter(->[HeberGement:5])
		
		If (Records in selection:C76([HeberGement:5])>0)
			$vbOK:=False:C215
			$ij:=0
			For ($ii; 1; Size of array:C274(ta_xCentre))
				$ij:=$ij+te_xCentre{$ii}
			End for 
			If (($ij=0) | ($ij=Size of array:C274(ta_xCentre)))
			Else 
				For ($ii; 1; Size of array:C274(ta_xCentre))
					If (te_xCentre{$ii}=1)
						If ($vbOK)
							QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_LC_ID:61=tl_xCentre{$ii}; *)
						Else 
							QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=tl_xCentre{$ii}; *)
							$vbOK:=True:C214
						End if 
					End if 
				End for 
				QUERY SELECTION:C341([HeberGement:5])
			End if 
		End if 
		
		
		
		vl_NbHB:=Records in selection:C76([HeberGement:5])
		If (vl_NbHB>0)
			CREATE SET:C116([HeberGement:5]; "E_encours")
		Else 
			CREATE EMPTY SET:C140([HeberGement:5]; "E_encours")
		End if 
	End if 
	vl_NbHBd:=0
	vl_NbHom:=0
	vl_NbFem:=0
	If (sDif=1)
		If (<>vb_StopEven=False:C215)
			i_MessageSeul("Nombre de personnes différentes…")
			USE SET:C118("E_encours")
			RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
			MultiSoc_Filter(->[HeBerge:4])
			vl_NbHBd:=Records in selection:C76([HeBerge:4])
			QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HG_Genre:39=False:C215)
			vl_NbHom:=Records in selection:C76([HeBerge:4])
			vl_NbFem:=vl_NbHBd-vl_NbHom
			<>tl_TBGenre{1}:=vl_NbHom
			<>tl_TBGenre{2}:=vl_NbFem
		End if 
	End if 
	P_Calc_EtudeS1
	ON EVENT CALL:C190("")
	CLOSE WINDOW:C154
	P_Print_EtudeS1
End if 
BEEP:C151
ALERT:C41("Statistiques Etude S: Terminé")
