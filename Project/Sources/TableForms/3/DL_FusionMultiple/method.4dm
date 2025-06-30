$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		va_HGRNom:=""
		va_HGRPré:=""
		vd_HGRNé:=!00-00-00!
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		va_FrappeClavier:=""
		P_HébergementNotesBt(0)
		OBJECT SET ENABLED:C1123(b_Fuse; False:C215)
		OBJECT SET ENABLED:C1123(b_CléEffacer; False:C215)
		P_FusionBt(0)
	: ($vl_EventFF=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		Case of 
			: ((vl_SourisX>284) & (vl_SourisX<760)) & ((vl_SourisY>66) & (vl_SourisY<228))  //DEMANDEUR
				If ([HeBerge:4]HB_ReferenceID:1>0)
					//va_NNN:=[HéBergé]HB_Clé
					P_HébergementNotesBt(1)
				Else 
					//va_NNN:=""
					P_HébergementNotesBt(0)
				End if 
			: ((vl_SourisX>5) & (vl_SourisX<765)) & ((vl_SourisY>327) & (vl_SourisY<479))  //Clés à fusionner
				P_FusionBt(Num:C11((Size of array:C274(ta_FU_Clé)>0) & (ta_FU_Clé>0)))
				UNLOAD RECORD:C212([HeBerge:4])
				REDRAW:C174([HeBerge:4])
				P_HébergementNotesBt(0)
		End case 
		
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		Case of 
			: ((vl_SourisX>284) & (vl_SourisX<760)) & ((vl_SourisY>66) & (vl_SourisY<228))  //DEMANDEUR
				If ([HeBerge:4]HB_ReferenceID:1=vl_IDT_Réf1)
					ALERT:C41("Cette clé est déja maîtresse : "+[HeBerge:4]HB_Clé:2+" !")
				Else 
					$ii:=Find in array:C230(tl_FU_Référence; [HeBerge:4]HB_ReferenceID:1)
					If ($ii>0)
						Tab_Fusion(1; $ii; 0)
					Else 
						Tab_Fusion(2; 0; 0)
					End if 
					P_FusionBt(Num:C11((Size of array:C274(ta_FU_Clé)>0) & (ta_FU_Clé>0)))
				End if 
				
			: ((vl_SourisX>5) & (vl_SourisX<765)) & ((vl_SourisY>327) & (vl_SourisY<479))  //Clés à fusionner
				If (Size of array:C274(tl_FU_Référence)>0)
					If (ta_FU_Clé>0)
						CONFIRM:C162("Confirmez-vous le retrait de la liste de fusion de :"+ta_FU_Clé{ta_FU_Clé}+" ?")
						If (OK=1)
							Tab_Fusion(3; ta_FU_Clé; 0)
							P_FusionBt(Num:C11((Size of array:C274(ta_FU_Clé)>0) & (ta_FU_Clé>0)))
							
						End if 
					End if 
				End if 
		End case 
End case 
