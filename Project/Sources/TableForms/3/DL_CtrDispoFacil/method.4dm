C_LONGINT:C283($vl_eventFF)

$vl_eventFF:=Form event code:C388

Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		va_dem:=""
		
		vl_dem:=0
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		If (vd_DateEnCours>!00-00-00!)
			<>vd_DtJour:=vd_DateEnCours
		Else 
			<>vd_DtJour:=Current date:C33
		End if 
		
		[DiaLogues:3]DL_Date:2:=<>vd_DtJour
		
		If (Current time:C178(*)<=?20:00:00?)
			rJourNuit1:=1
			rJourNuit2:=0
		Else 
			rJourNuit1:=0
			rJourNuit2:=1
		End if 
		
		Rec_CL_DispoFacil
	: ($vl_eventFF=Sur double clic:K2:5)
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP)) | (User in group:C338(Current user:C182; <>Groupe_ADMIN)) | (User in group:C338(Current user:C182; <>Groupe_Coordinateur)) | (User in group:C338(Current user:C182; <>Groupe_Régulateur))
			GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
			
			If ((vl_SourisX>6) & (vl_SourisX<765)) & ((vl_SourisY>147) & (vl_SourisY<468))
				
				If ([CentresLits:16]CL_LC_ID_date:1>"")
					READ WRITE:C146([CentresLits:16])
					LOAD RECORD:C52([CentresLits:16])
					
					If (Not:C34(Locked:C147([CentresLits:16])))
						va_dem:=Request:C163("Lits supplémentaires: "+[LesCentres:9]LC_Nom:4; "0")
						
						If (OK=1)
							vl_dem:=Num:C11(va_dem)
							
							If (vl_dem#0)
								[CentresLits:16]CL_DispoDuJour:12:=[CentresLits:16]CL_DispoDuJour:12+vl_dem
								
								If (<>vb_CentreEXClits)
									[CentresLits:16]CL_DispoTotal:5:=[CentresLits:16]CL_Report:11+[CentresLits:16]CL_DispoDuJour:12+[CentresLits:16]CL_Absents:13+[CentresLits:16]CL_RestantsVeille:16
								Else 
									[CentresLits:16]CL_DispoTotal:5:=[CentresLits:16]CL_Report:11+[CentresLits:16]CL_DispoDuJour:12+[CentresLits:16]CL_Absents:13
								End if 
								
								[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_DispoTotal:5-[CentresLits:16]CL_Distribué:6  // [CentresLits]CL_Restant
								
								SAVE RECORD:C53([CentresLits:16])
								UNLOAD RECORD:C212([CentresLits:16])
								
								vl_LC_sCapa:=Sum:C1([CentresLits:16]CL_Capacité:4)
								vl_LC_sRep:=Sum:C1([CentresLits:16]CL_Report:11)
								vl_LC_sDpJ:=Sum:C1([CentresLits:16]CL_DispoDuJour:12)
								vl_LC_sDpT:=Sum:C1([CentresLits:16]CL_DispoTotal:5)
								vl_LC_sDist:=Sum:C1([CentresLits:16]CL_Distribué:6)
								vl_LC_sRest:=Sum:C1([CentresLits:16]CL_Restant:7)
							End if 
							
						End if 
						
					Else 
						StrAlerte(4; "")
					End if 
					
					UNLOAD RECORD:C212([CentresLits:16])
					READ ONLY:C145([CentresLits:16])
				End if 
				
			End if 
			
		End if 
		
End case 