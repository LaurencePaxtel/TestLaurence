$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		C_TIME:C306($vh_HeurC)
		
		[DiaLogues:3]DL_Date:2:=Current date:C33(*)
		[DiaLogues:3]DL_LibelAutre:5:=""
		[DiaLogues:3]DL_Libellé:3:=""
		[DiaLogues:3]DL_LibelPlus:6:=""
		
		r1:=1
		r2:=0
		r3:=0
		r4:=0
		r5:=0
		r6:=0
		r7:=0
		r8:=0
		r9:=0
		r10:=0
		r11:=0
		sOr1:=0
		t1:=1
		t2:=0
		tLocal:=0
		
		rJourNuit1:=1  //Jour
		rJourNuit2:=1  //Nuit
		
		//24/06/2008 : Fonctionnement Type CHRS
		If (False:C215)
			
			If (<>vb_T_ModeCHRS)
				rJourNuit2:=0  //Nuit  
				
				OBJECT SET ENABLED:C1123(rJourNuit1; False:C215)
				OBJECT SET ENABLED:C1123(rJourNuit2; False:C215)
			End if 
			
		End if 
		
		If (7=8)
			$vh_HeurC:=Current time:C178
			
			rJourNuit1:=Num:C11(($vh_HeurC>=?08:00:00?) & ($vh_HeurC<=?19:59:59?))  //Jour
			rJourNuit2:=Num:C11(rJourNuit1=0)  //Nuit
		End if 
		
		If (<>vb_AvecProlongation)
			OBJECT SET VISIBLE:C603(*; "Rbt_Prolongé"; True:C214)
			
			P_HébergementReportFindPR
		Else 
			OBJECT SET VISIBLE:C603(*; "Rbt_Prolongé"; False:C215)
			
			P_HébergementReportFind
		End if 
		
		u1:=1
		u2:=0
		
		uEmplace:=1
		
		// Modifié par : Scanu Rémy (07/04/2021)
		If (Accès_Groupe(<>Groupe_DEVELOP; "Rattrapage")=True:C214) | (User in group:C338(Current user:C182; <>Groupe_DEVELOP)=True:C214)
			OBJECT SET VISIBLE:C603(b_RpRepRat; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(b_RpRepRat; False:C215)
		End if 
		
	: ($vl_EventFF=Sur données modifiées:K2:15)
		If (Modified:C32([DiaLogues:3]DL_Date:2) | Modified:C32([DiaLogues:3]DL_Libellé:3) | Modified:C32([DiaLogues:3]DL_LibelPlus:6))
			
			If (<>vb_AvecProlongation)
				P_HébergementReportFindPR
			Else 
				P_HébergementReportFind
			End if 
			
		End if 
End case 