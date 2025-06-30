//%attributes = {}
C_TEXT:C284($1)
C_LONGINT:C283($2; $vl_TrancheEnCours)
$vl_TrancheEnCours:=$2
C_LONGINT:C283($3; $vl_TrancheLigne)
$vl_TrancheLigne:=$3

ARRAY LONGINT:C221($tl_Temp; 0)
Case of 
	: ($1="TR")
		// i_Message ("Recherche…")
		
		// remplacement get pointer 17/2/17
		// <>vp_PointeurTranche:=Get pointer("tl_TrancheCol"+String($2)+"_"+String($3))
		
		
		Case of 
			: ($vl_TrancheEnCours=1)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol1_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol1_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol1_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol1_4
					Else 
						TRACE:C157
				End case 
			: ($vl_TrancheEnCours=2)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol2_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol2_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol2_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol2_4
					Else 
						TRACE:C157
				End case 
				
			: ($vl_TrancheEnCours=3)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol3_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol3_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol3_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol3_4
					Else 
						TRACE:C157
				End case 
				
			: ($vl_TrancheEnCours=4)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol4_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol4_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol4_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol4_4
					Else 
						TRACE:C157
				End case 
				
			: ($vl_TrancheEnCours=5)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol5_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol5_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol5_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol5_4
					Else 
						TRACE:C157
				End case 
				
			: ($vl_TrancheEnCours=6)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol6_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol6_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol6_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol6_4
					Else 
						TRACE:C157
				End case 
				
			: ($vl_TrancheEnCours=7)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol7_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol7_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol7_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol7_4
					Else 
						TRACE:C157
				End case 
				
			: ($vl_TrancheEnCours=8)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol8_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol8_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol8_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol8_4
					Else 
						TRACE:C157
				End case 
				
			: ($vl_TrancheEnCours=9)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol9_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol9_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol9_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol9_4
					Else 
						TRACE:C157
				End case 
				
			: ($vl_TrancheEnCours=10)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol10_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol10_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol10_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol10_4
					Else 
						TRACE:C157
				End case 
				
			: ($vl_TrancheEnCours=11)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol11_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol11_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol11_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol11_4
					Else 
						TRACE:C157
				End case 
				
			: ($vl_TrancheEnCours=12)
				
				Case of 
					: ($vl_TrancheLigne=1)
						vp_LePointeur:=->tl_TrancheCol12_1
					: ($vl_TrancheLigne=2)
						vp_LePointeur:=->tl_TrancheCol12_2
					: ($vl_TrancheLigne=3)
						vp_LePointeur:=->tl_TrancheCol12_3
					: ($vl_TrancheLigne=4)
						vp_LePointeur:=->tl_TrancheCol12_4
					Else 
						TRACE:C157
				End case 
				
			Else 
				TRACE:C157
		End case 
		
		
		
		
		
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; vp_LePointeur->)  // <>vp_PointeurTranche->
		DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_Temp)
		P_HébergementVeilleSort(2)
		
		// remplacement get pointer 17/2/17
		// pas utilisé
		// <>vp_PointeurTranche:=Get pointer("va_TrancheAffiche"+String($2))
		
		vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" fiche(s)"+"  pour  "+String:C10(Size of array:C274($tl_Temp))+" personne(s) #"
		// CLOSE WINDOW
		
	: ($1="TRT")
		// i_Message ("Recherche…")
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_TrancheOK)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_DateNéLe:24; >)
		vt_ColRéf_Libellé:=String:C10(Size of array:C274(tl_TrancheOK))+" fiche(s)"+"  pour  "+String:C10(Size of array:C274(tl_TranchePersOld))+" personne(s) #"
		//CLOSE WINDOW
		
End case 