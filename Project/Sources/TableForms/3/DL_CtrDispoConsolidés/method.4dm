//Formule Format : "DL_CentresLitsTotal"
C_LONGINT:C283($vl_eventFF)
C_BOOLEAN:C305($vb_OK)

$vl_eventFF:=Form event code:C388
Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		<>vd_DtJour:=!00-00-00!
		<>vd_DtJour:=vd_DateEnCours
		[DiaLogues:3]DL_Date:2:=<>vd_DtJour
		rJourNuit1:=1
		rJourNuit2:=0
		OBJECT SET ENABLED:C1123(rJourNuit1; False:C215)
		OBJECT SET ENABLED:C1123(rJourNuit2; False:C215)
		Rec_CentreLitsConso
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
	: ($vl_eventFF=Sur données modifiées:K2:15)
		If (Modified:C32([CentresLits:16]CL_Capacité:4) | Modified:C32([CentresLits:16]CL_NbPersonnes:18))
			
			
			
			[CentresLits:16]CL_Niveau:17:=[CentresLits:16]CL_Capacité:4-[CentresLits:16]CL_DispoTotal:5
			[CentresLits:16]CL_NbPersonnesNouvelles:19:=[CentresLits:16]CL_Niveau:17-[CentresLits:16]CL_NbPersonnes:18
			[CentresLits:16]CL_NbFamilles:20:=[CentresLits:16]CL_DispoTotal:5+[CentresLits:16]CL_Niveau:17
			[CentresLits:16]CL_NbAdultes:21:=[CentresLits:16]CL_Distribué:6+[CentresLits:16]CL_NbPersonnes:18
			[CentresLits:16]CL_NbEnfants:22:=[CentresLits:16]CL_Restant:7+[CentresLits:16]CL_NbPersonnesNouvelles:19
			REDRAW:C174([CentresLits:16])
		End if 
		
	: ($vl_eventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>7) & (vl_SourisX<764)) & ((vl_SourisY>147) & (vl_SourisY<469))
			If ([CentresLits:16]CL_DateTypeIDLC:10>"")
				READ WRITE:C146([CentresLits:16])
				If (i_NonVerrou(->[CentresLits:16]))
					FORM SET INPUT:C55([CentresLits:16]; "CL_EcranSaisieConso")
					$vl_Fenetre:=i_FenêtreNo(589; 378; 4; "Situation du Centre : modifier"; 4; "")
					MODIFY RECORD:C57([CentresLits:16]; *)
					$vb_OK:=(OK=1)
					UNLOAD RECORD:C212([CentresLits:16])
					CLOSE WINDOW:C154($vl_Fenetre)
				End if 
				READ ONLY:C145([CentresLits:16])
				If ($vb_OK)
					P_SommeLit(3)
					REDRAW:C174([CentresLits:16])
				End if 
			End if 
		End if 
		
	: ($vl_eventFF=Sur appel extérieur:K2:11)
		
End case 