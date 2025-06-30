$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		va_TypeNo:=""
		If (Is new record:C668([GrouPe:36]))
			[GrouPe:36]GP_ReferenceID:1:=Uut_Numerote(->[GrouPe:36])
			[GrouPe:36]GP_Nuit:5:=(va_JourNuit="N")
			If (va_JourNuit="N")
				$ii:=Uut_Numerote(-><>vaCPT_GpeN)
			Else 
				$ii:=Uut_Numerote(-><>vaCPT_GpeJ)
			End if 
			[GrouPe:36]GP_Numéro:7:=va_JourNuit+"_"+String:C10($ii; "00000")
			va_TypeNo:="Format du numéro : "+va_JourNuit+"_00000"
		Else 
			OBJECT SET ENTERABLE:C238([GrouPe:36]GP_Numéro:7; False:C215)
		End if 
		OBJECT SET ENTERABLE:C238([GrouPe:36]GP_Numéro:7; False:C215)
		va_GPType:=("Nuit"*Num:C11([GrouPe:36]GP_Nuit:5=True:C214))+("Jour"*Num:C11([GrouPe:36]GP_Nuit:5=False:C215))
		QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GrouPe:36]GP_ReferenceID:1)
		vL_Nb_PR:=Records in selection:C76([Prolongation:38])
		ORDER BY:C49([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6; <)
		P_Tab_Pro(4; [GrouPe:36]GP_ReferenceID:1)
		
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		OBJECT SET VISIBLE:C603(*; "GPPR_BtAdd"; False:C215)
		
	: ($vl_EventFF=Sur données modifiées:K2:15)
		If (Modified:C32([GrouPe:36]GP_Intitulé:4))
			[GrouPe:36]GP_Intitulé:4:=Uppercase:C13([GrouPe:36]GP_Intitulé:4)
		End if 
		If (Modified:C32([GrouPe:36]GP_Numéro:7))
			$vb_OK:=True:C214
			If ([GrouPe:36]GP_Numéro:7[[1]]=va_JourNuit)
				If ([GrouPe:36]GP_Numéro:7[[2]]="_")
					$ii:=2
					Repeat 
						$ii:=$ii+1
						If ([GrouPe:36]GP_Numéro:7[[$ii]]>="0") & ([GrouPe:36]GP_Numéro:7[[$ii]]<="9")
						Else 
							$vb_OK:=False:C215
						End if 
					Until ($ii=7) | ($vb_OK=False:C215)
				Else 
					$vb_OK:=False:C215
				End if 
			Else 
				$vb_OK:=False:C215
			End if 
			If ($vb_OK=False:C215)
				REJECT:C38([GrouPe:36]GP_Numéro:7)
				ALERT:C41("Voir Format du numéro !")
			End if 
		End if 
		
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		$ii:=FORM Get current page:C276
		Case of 
			: ($ii=2)
				If ((vl_SourisX>7) & (vl_SourisX<547)) & ((vl_SourisY>236) & (vl_SourisY<401))
					
					If (Size of array:C274(<>tl_PR_Réf)>0)
						If (<>ta_PR_Centre>0) & (<>tl_PR_Réf{<>ta_PR_Centre}>0)
							QUERY:C277([Prolongation:38]; [Prolongation:38]PR_RéférenceID:1=<>tl_PR_Réf{<>ta_PR_Centre})
							If (Records in selection:C76([Prolongation:38])=1)
								If (F_Prolongation_FicheIncluse(2))
								End if 
							End if 
						End if 
					End if 
				End if 
			: ($ii=1)
				If ((vl_SourisX>7) & (vl_SourisX<547)) & ((vl_SourisY>242) & (vl_SourisY<401))
					If ([Prolongation:38]PR_RéférenceID:1>0)
						If (F_Prolongation_FicheIncluse(2))
						End if 
					End if 
				End if 
				
		End case 
End case 
