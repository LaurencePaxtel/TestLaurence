If (Accès_Groupe(<>Groupe_Disponibilité))
	LOAD RECORD:C52([LesCentres:9])  // BS 200516 Passage en v15 : le centre choisi n'était plus chargé
	
	If ([LesCentres:9]LC_RéférenceID:1>0)
		$JN:=("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215))+("N"*Num:C11([HeberGement:5]HG_Nuit:2=True:C214))
		$va_CléL:=Uut_NumeroteLitsType(vd_DateRecherche; $JN)+Uut_NumeroteLitsID([LesCentres:9]LC_RéférenceID:1)
		
		READ WRITE:C146([CentresLits:16])
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateTypeIDLC:10=$va_CléL)
		
		If (Records in selection:C76([CentresLits:16])=1)
			LOAD RECORD:C52([CentresLits:16])
			
			If (Locked:C147([CentresLits:16]))
				StrAlerte(4; "")
			Else 
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
					End if 
					
				End if 
				
			End if 
			UNLOAD RECORD:C212([CentresLits:16])
			
		Else 
			ALERT:C41("Pas de disponibilité !")
		End if 
		
		UNLOAD RECORD:C212([CentresLits:16])
		READ ONLY:C145([CentresLits:16])
		
		REDRAW:C174([CentresLits:16])
	Else 
		StrAlerte(22; "")
	End if 
	
End if 
