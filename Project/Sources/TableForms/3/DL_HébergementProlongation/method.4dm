//Formule Format : Prolongation
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		ve_QuelCas:=-1
		
		C_TIME:C306($vh_HeurC)
		If (vd_LastDate>!00-00-00!)
			[DiaLogues:3]DL_Date:2:=vd_LastDate
			[DiaLogues:3]DL_Date2:8:=vd_LastDate
		Else 
			[DiaLogues:3]DL_Date:2:=Current date:C33(*)
			[DiaLogues:3]DL_Date2:8:=Current date:C33(*)
		End if 
		If (Day of:C23([DiaLogues:3]DL_Date:2+1)=1)
			[DiaLogues:3]DL_Date2:8:=[DiaLogues:3]DL_Date:2
		Else 
			[DiaLogues:3]DL_Date2:8:=F_DateFinDeMois([DiaLogues:3]DL_Date:2)
		End if 
		[DiaLogues:3]DL_LibelAutre:5:=""
		[DiaLogues:3]DL_Libellé:3:=""
		[DiaLogues:3]DL_LibelPlus:6:=""
		[DiaLogues:3]DL_LibelléN:9:=""
		[DiaLogues:3]DL_LibelléG:10:=""
		
		rJourNuit1:=1  //Jour
		rJourNuit2:=1  //Nuit
		$vh_HeurC:=Current time:C178
		If (<>vb_CentreEXC)
			rJourNuit1:=1
			rJourNuit2:=0
		Else 
			rJourNuit1:=Num:C11(($vh_HeurC>=?08:00:00?) & ($vh_HeurC<=?19:59:59?))  //Jour
			rJourNuit2:=Num:C11(rJourNuit1=0)  //Nuit
		End if 
		
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		wGprPR_Prorogés:=1
		wGprPR_NonProrogés:=1
		
		ve_QuelCas:=F_PRquelCas
		ve_Cdr2L:=6
		ve_Cdr2R:=764
		ve_Cdr2T:=365
		ve_Cdr2B:=501
		
		ve_Cdr3L:=6
		ve_Cdr3R:=341
		ve_Cdr3T:=142
		ve_Cdr3B:=301
		
		ve_Cdr4L:=0
		ve_Cdr4R:=0
		ve_Cdr4T:=0
		ve_Cdr4B:=0
		
		P_HébergementProlongFind(0)
		
	: ($vl_EventFF=Sur données modifiées:K2:15)
		If (Modified:C32([DiaLogues:3]DL_Date:2))
			If (vd_LastDate>!00-00-00!)
				If ([DiaLogues:3]DL_Date:2<vd_LastDate)
					ALERT:C41("La date doit être postérieure au "+String:C10(vd_LastDate))
				Else 
				End if 
			Else 
			End if 
			[DiaLogues:3]DL_Date2:8:=F_DateFinDeMois([DiaLogues:3]DL_Date:2)
		End if 
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		
	: ($vl_EventFF=Sur clic:K2:4)
		
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		Case of 
			: ((vl_SourisX>=ve_Cdr2L) & (vl_SourisX<=ve_Cdr2R)) & ((vl_SourisY>=ve_Cdr2T) & (vl_SourisY<=ve_Cdr2B))
				//Liste des situations
			: ((vl_SourisX>=ve_Cdr3L) & (vl_SourisX<=ve_Cdr3R)) & ((vl_SourisY>=ve_Cdr3T) & (vl_SourisY<=ve_Cdr3B))
				//Liste des Groupes      
				If ([GrouPe:36]GP_ReferenceID:1>0)
					P_Tab_PR(4; 0)
				Else 
					P_Tab_PR(0; 0)
				End if 
				
			: ((vl_SourisX>=ve_Cdr4L) & (vl_SourisX<=ve_Cdr4R)) & ((vl_SourisY>=ve_Cdr4T) & (vl_SourisY<=ve_Cdr4B))
				//Liste des Membres
		End case 
		
		
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>=ve_Cdr2L) & (vl_SourisX<=ve_Cdr2R)) & ((vl_SourisY>=ve_Cdr2T) & (vl_SourisY<=ve_Cdr2B))
			If ([HeberGement:5]HG_ReferenceID:1>0)
				$vaUn:=(("N"*Num:C11([HeberGement:5]HG_Nuit:2))+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215)))
				Process_Go7(-><>PR_HébergementP; "Go_HébergementR"; "FicheSignal"; 64; $vaUn; "P"; [HeberGement:5]HG_FicheNuméro:3)
			End if 
		End if 
End case 