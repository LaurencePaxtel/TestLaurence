//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Méthode : P_HébergementDécoupageLibellé
//{
//{          Lundi 28 décembre 2009 à 16:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_POINTER:C301($0)

C_LONGINT:C283($1)  //Type de variable pointée
C_LONGINT:C283($2)  //Mois
C_LONGINT:C283($3)  //Cas de sommation

Case of 
	: ($1=1)
		Case of 
			: ($2=1)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_1_1
					: ($3=2)
						$0:=->tl_ColRéf_1_2
					: ($3=3)
						$0:=->tl_ColRéf_1_3
					: ($3=4)
						$0:=->tl_ColRéf_1_4
				End case 
			: ($2=2)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_2_1
					: ($3=2)
						$0:=->tl_ColRéf_2_2
					: ($3=3)
						$0:=->tl_ColRéf_2_3
					: ($3=4)
						$0:=->tl_ColRéf_2_4
				End case 
			: ($2=3)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_3_1
					: ($3=2)
						$0:=->tl_ColRéf_3_2
					: ($3=3)
						$0:=->tl_ColRéf_3_3
					: ($3=4)
						$0:=->tl_ColRéf_3_4
				End case 
			: ($2=4)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_4_1
					: ($3=2)
						$0:=->tl_ColRéf_4_2
					: ($3=3)
						$0:=->tl_ColRéf_4_3
					: ($3=4)
						$0:=->tl_ColRéf_4_4
				End case 
			: ($2=5)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_5_1
					: ($3=2)
						$0:=->tl_ColRéf_5_2
					: ($3=3)
						$0:=->tl_ColRéf_5_3
					: ($3=4)
						$0:=->tl_ColRéf_5_4
				End case 
			: ($2=6)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_6_1
					: ($3=2)
						$0:=->tl_ColRéf_6_2
					: ($3=3)
						$0:=->tl_ColRéf_6_3
					: ($3=4)
						$0:=->tl_ColRéf_6_4
				End case 
			: ($2=7)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_7_1
					: ($3=2)
						$0:=->tl_ColRéf_7_2
					: ($3=3)
						$0:=->tl_ColRéf_7_3
					: ($3=4)
						$0:=->tl_ColRéf_7_4
				End case 
			: ($2=8)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_8_1
					: ($3=2)
						$0:=->tl_ColRéf_8_2
					: ($3=3)
						$0:=->tl_ColRéf_8_3
					: ($3=4)
						$0:=->tl_ColRéf_8_4
				End case 
			: ($2=9)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_9_1
					: ($3=2)
						$0:=->tl_ColRéf_9_2
					: ($3=3)
						$0:=->tl_ColRéf_9_3
					: ($3=4)
						$0:=->tl_ColRéf_9_4
				End case 
			: ($2=10)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_10_1
					: ($3=2)
						$0:=->tl_ColRéf_10_2
					: ($3=3)
						$0:=->tl_ColRéf_10_3
					: ($3=4)
						$0:=->tl_ColRéf_10_4
				End case 
			: ($2=11)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_11_1
					: ($3=2)
						$0:=->tl_ColRéf_11_2
					: ($3=3)
						$0:=->tl_ColRéf_11_3
					: ($3=4)
						$0:=->tl_ColRéf_11_4
				End case 
			: ($2=12)
				Case of 
					: ($3=1)
						$0:=->tl_ColRéf_12_1
					: ($3=2)
						$0:=->tl_ColRéf_12_2
					: ($3=3)
						$0:=->tl_ColRéf_12_3
					: ($3=4)
						$0:=->tl_ColRéf_12_4
				End case 
				
		End case 
		
		
	: ($1=2)
		Case of 
			: ($2=1)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_1_1
					: ($3=2)
						$0:=->ta_ColRéfFam_1_2
					: ($3=3)
						$0:=->ta_ColRéfFam_1_3
					: ($3=4)
						$0:=->ta_ColRéfFam_1_4
				End case 
			: ($2=2)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_2_1
					: ($3=2)
						$0:=->ta_ColRéfFam_2_2
					: ($3=3)
						$0:=->ta_ColRéfFam_2_3
					: ($3=4)
						$0:=->ta_ColRéfFam_2_4
				End case 
			: ($2=3)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_3_1
					: ($3=2)
						$0:=->ta_ColRéfFam_3_2
					: ($3=3)
						$0:=->ta_ColRéfFam_3_3
					: ($3=4)
						$0:=->ta_ColRéfFam_3_4
				End case 
			: ($2=4)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_4_1
					: ($3=2)
						$0:=->ta_ColRéfFam_4_2
					: ($3=3)
						$0:=->ta_ColRéfFam_4_3
					: ($3=4)
						$0:=->ta_ColRéfFam_4_4
				End case 
			: ($2=5)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_5_1
					: ($3=2)
						$0:=->ta_ColRéfFam_5_2
					: ($3=3)
						$0:=->ta_ColRéfFam_5_3
					: ($3=4)
						$0:=->ta_ColRéfFam_5_4
				End case 
			: ($2=6)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_6_1
					: ($3=2)
						$0:=->ta_ColRéfFam_6_2
					: ($3=3)
						$0:=->ta_ColRéfFam_6_3
					: ($3=4)
						$0:=->ta_ColRéfFam_6_4
				End case 
			: ($2=7)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_7_1
					: ($3=2)
						$0:=->ta_ColRéfFam_7_2
					: ($3=3)
						$0:=->ta_ColRéfFam_7_3
					: ($3=4)
						$0:=->ta_ColRéfFam_7_4
				End case 
			: ($2=8)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_8_1
					: ($3=2)
						$0:=->ta_ColRéfFam_8_2
					: ($3=3)
						$0:=->ta_ColRéfFam_8_3
					: ($3=4)
						$0:=->ta_ColRéfFam_8_4
				End case 
			: ($2=9)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_9_1
					: ($3=2)
						$0:=->ta_ColRéfFam_9_2
					: ($3=3)
						$0:=->ta_ColRéfFam_9_3
					: ($3=4)
						$0:=->ta_ColRéfFam_9_4
				End case 
			: ($2=10)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_10_1
					: ($3=2)
						$0:=->ta_ColRéfFam_10_2
					: ($3=3)
						$0:=->ta_ColRéfFam_10_3
					: ($3=4)
						$0:=->ta_ColRéfFam_10_4
				End case 
			: ($2=11)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_11_1
					: ($3=2)
						$0:=->ta_ColRéfFam_11_2
					: ($3=3)
						$0:=->ta_ColRéfFam_11_3
					: ($3=4)
						$0:=->ta_ColRéfFam_11_4
				End case 
			: ($2=12)
				Case of 
					: ($3=1)
						$0:=->ta_ColRéfFam_12_1
					: ($3=2)
						$0:=->ta_ColRéfFam_12_2
					: ($3=3)
						$0:=->ta_ColRéfFam_12_3
					: ($3=4)
						$0:=->ta_ColRéfFam_12_4
				End case 
				
		End case 
		
	: ($1=3)
		Case of 
			: ($2=1)
				$0:=->vl_ColF1_P_1
			: ($2=2)
				$0:=->vl_ColF1_P_2
			: ($2=3)
				$0:=->vl_ColF1_P_3
			: ($2=4)
				$0:=->vl_ColF1_P_4
			: ($2=5)
				$0:=->vl_ColF1_P_5
			: ($2=6)
				$0:=->vl_ColF1_P_6
			: ($2=7)
				$0:=->vl_ColF1_P_7
			: ($2=8)
				$0:=->vl_ColF1_P_8
			: ($2=9)
				$0:=->vl_ColF1_P_9
			: ($2=10)
				$0:=->vl_ColF1_P_10
			: ($2=11)
				$0:=->vl_ColF1_P_11
			: ($2=12)
				$0:=->vl_ColF1_P_12
		End case 
		
	: ($1=4)
		Case of 
			: ($2=1)
				$0:=->vl_ColF2_P_1
			: ($2=2)
				$0:=->vl_ColF2_P_2
			: ($2=3)
				$0:=->vl_ColF2_P_3
			: ($2=4)
				$0:=->vl_ColF2_P_4
			: ($2=5)
				$0:=->vl_ColF2_P_5
			: ($2=6)
				$0:=->vl_ColF2_P_6
			: ($2=7)
				$0:=->vl_ColF2_P_7
			: ($2=8)
				$0:=->vl_ColF2_P_8
			: ($2=9)
				$0:=->vl_ColF2_P_9
			: ($2=10)
				$0:=->vl_ColF2_P_10
			: ($2=11)
				$0:=->vl_ColF2_P_11
			: ($2=12)
				$0:=->vl_ColF2_P_12
		End case 
		
	: ($1=5)
		Case of 
			: ($2=1)
				$0:=->vl_ColF3_P_1
			: ($2=2)
				$0:=->vl_ColF3_P_2
			: ($2=3)
				$0:=->vl_ColF3_P_3
			: ($2=4)
				$0:=->vl_ColF3_P_4
			: ($2=5)
				$0:=->vl_ColF3_P_5
			: ($2=6)
				$0:=->vl_ColF3_P_6
			: ($2=7)
				$0:=->vl_ColF3_P_7
			: ($2=8)
				$0:=->vl_ColF3_P_8
			: ($2=9)
				$0:=->vl_ColF3_P_9
			: ($2=10)
				$0:=->vl_ColF3_P_10
			: ($2=11)
				$0:=->vl_ColF3_P_11
			: ($2=12)
				$0:=->vl_ColF3_P_12
		End case 
End case 