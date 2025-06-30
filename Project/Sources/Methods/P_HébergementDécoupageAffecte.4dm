//%attributes = {}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_POINTER:C301(vp_Ptr01; vp_Ptr02; vp_Ptr03; vp_Ptr04)
C_LONGINT:C283($kk; $Position)

Case of 
	: ($1=0)  //Les nuités totales : nombre
		Case of 
			: ($2=1)
				vl_ColN1_1:=$3
			: ($2=2)
				vl_ColN1_2:=$3
			: ($2=3)
				vl_ColN1_3:=$3
			: ($2=4)
				vl_ColN1_4:=$3
			: ($2=5)
				vl_ColN1_5:=$3
			: ($2=6)
				vl_ColN1_6:=$3
			: ($2=7)
				vl_ColN1_7:=$3
			: ($2=8)
				vl_ColN1_8:=$3
			: ($2=9)
				vl_ColN1_9:=$3
			: ($2=10)
				vl_ColN1_10:=$3
			: ($2=11)
				vl_ColN1_11:=$3
			: ($2=12)
				vl_ColN1_12:=$3
		End case 
		
		
	: ($1=1)  //Les nuités totales : fiches
		Case of 
			: ($2=1)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_1_1)
			: ($2=2)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_2_1)
			: ($2=3)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_3_1)
			: ($2=4)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_4_1)
			: ($2=5)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_5_1)
			: ($2=6)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_6_1)
			: ($2=7)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_7_1)
			: ($2=8)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_8_1)
			: ($2=9)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_9_1)
			: ($2=10)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_10_1)
			: ($2=11)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_11_1)
			: ($2=12)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_12_1)
		End case 
		
	: ($1=2)
		Case of 
			: ($2=1)
				vl_ColF1_1:=Size of array:C274(ta_ColFamClé)
			: ($2=2)
				vl_ColF1_2:=Size of array:C274(ta_ColFamClé)
			: ($2=3)
				vl_ColF1_3:=Size of array:C274(ta_ColFamClé)
			: ($2=4)
				vl_ColF1_4:=Size of array:C274(ta_ColFamClé)
			: ($2=5)
				vl_ColF1_5:=Size of array:C274(ta_ColFamClé)
			: ($2=6)
				vl_ColF1_6:=Size of array:C274(ta_ColFamClé)
			: ($2=7)
				vl_ColF1_7:=Size of array:C274(ta_ColFamClé)
			: ($2=8)
				vl_ColF1_8:=Size of array:C274(ta_ColFamClé)
			: ($2=9)
				vl_ColF1_9:=Size of array:C274(ta_ColFamClé)
			: ($2=10)
				vl_ColF1_10:=Size of array:C274(ta_ColFamClé)
			: ($2=11)
				vl_ColF1_11:=Size of array:C274(ta_ColFamClé)
			: ($2=12)
				vl_ColF1_12:=Size of array:C274(ta_ColFamClé)
		End case 
		
	: ($1=3)
		Case of 
			: ($2=1)
				vl_ColF1_P_1:=0
			: ($2=2)
				vl_ColF1_P_2:=0
			: ($2=3)
				vl_ColF1_P_3:=0
			: ($2=4)
				vl_ColF1_P_4:=0
			: ($2=5)
				vl_ColF1_P_5:=0
			: ($2=6)
				vl_ColF1_P_6:=0
			: ($2=7)
				vl_ColF1_P_7:=0
			: ($2=8)
				vl_ColF1_P_8:=0
			: ($2=9)
				vl_ColF1_P_9:=0
			: ($2=10)
				vl_ColF1_P_10:=0
			: ($2=11)
				vl_ColF1_P_11:=0
			: ($2=12)
				vl_ColF1_P_12:=0
		End case 
		
	: ($1=4)
		Case of 
			: ($2=1)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_1_2)
			: ($2=2)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_2_2)
			: ($2=3)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_3_2)
			: ($2=4)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_4_2)
			: ($2=5)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_5_2)
			: ($2=6)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_6_2)
			: ($2=7)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_7_2)
			: ($2=8)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_8_2)
			: ($2=9)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_9_2)
			: ($2=10)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_10_2)
			: ($2=11)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_11_2)
			: ($2=12)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_12_2)
		End case 
		
		
	: ($1=5)
		Case of 
			: ($2=1)
				ARRAY LONGINT:C221(tl_ColRéf_1_2; 0)
			: ($2=2)
				ARRAY LONGINT:C221(tl_ColRéf_2_2; 0)
			: ($2=3)
				ARRAY LONGINT:C221(tl_ColRéf_3_2; 0)
			: ($2=4)
				ARRAY LONGINT:C221(tl_ColRéf_4_2; 0)
			: ($2=5)
				ARRAY LONGINT:C221(tl_ColRéf_5_2; 0)
			: ($2=6)
				ARRAY LONGINT:C221(tl_ColRéf_6_2; 0)
			: ($2=7)
				ARRAY LONGINT:C221(tl_ColRéf_7_2; 0)
			: ($2=8)
				ARRAY LONGINT:C221(tl_ColRéf_8_2; 0)
			: ($2=9)
				ARRAY LONGINT:C221(tl_ColRéf_9_2; 0)
			: ($2=10)
				ARRAY LONGINT:C221(tl_ColRéf_10_2; 0)
			: ($2=11)
				ARRAY LONGINT:C221(tl_ColRéf_11_2; 0)
			: ($2=12)
				ARRAY LONGINT:C221(tl_ColRéf_12_2; 0)
		End case 
		
	: ($1=6)
		Case of 
			: ($2=1)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_1_2)
			: ($2=2)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_2_2)
			: ($2=3)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_3_2)
			: ($2=4)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_4_2)
			: ($2=5)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_5_2)
			: ($2=6)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_6_2)
			: ($2=7)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_7_2)
			: ($2=8)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_8_2)
			: ($2=9)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_9_2)
			: ($2=10)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_10_2)
			: ($2=11)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_11_2)
			: ($2=12)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_12_2)
		End case 
		
		
	: ($1=7)
		Case of 
			: ($2=1)
				vl_ColF1_P_1:=$3
			: ($2=2)
				vl_ColF1_P_2:=$3
			: ($2=3)
				vl_ColF1_P_3:=$3
			: ($2=4)
				vl_ColF1_P_4:=$3
			: ($2=5)
				vl_ColF1_P_5:=$3
			: ($2=6)
				vl_ColF1_P_6:=$3
			: ($2=7)
				vl_ColF1_P_7:=$3
			: ($2=8)
				vl_ColF1_P_8:=$3
			: ($2=9)
				vl_ColF1_P_9:=$3
			: ($2=10)
				vl_ColF1_P_10:=$3
			: ($2=11)
				vl_ColF1_P_11:=$3
			: ($2=12)
				vl_ColF1_P_12:=$3
		End case 
		
		
	: ($1=8)
		Case of 
			: ($2=1)
				vl_ColF2_1:=Size of array:C274(ta_ColFamClé)
			: ($2=2)
				vl_ColF2_2:=Size of array:C274(ta_ColFamClé)
			: ($2=3)
				vl_ColF2_3:=Size of array:C274(ta_ColFamClé)
			: ($2=4)
				vl_ColF2_4:=Size of array:C274(ta_ColFamClé)
			: ($2=5)
				vl_ColF2_5:=Size of array:C274(ta_ColFamClé)
			: ($2=6)
				vl_ColF2_6:=Size of array:C274(ta_ColFamClé)
			: ($2=7)
				vl_ColF2_7:=Size of array:C274(ta_ColFamClé)
			: ($2=8)
				vl_ColF2_8:=Size of array:C274(ta_ColFamClé)
			: ($2=9)
				vl_ColF2_9:=Size of array:C274(ta_ColFamClé)
			: ($2=10)
				vl_ColF2_10:=Size of array:C274(ta_ColFamClé)
			: ($2=11)
				vl_ColF2_11:=Size of array:C274(ta_ColFamClé)
			: ($2=12)
				vl_ColF2_12:=Size of array:C274(ta_ColFamClé)
		End case 
		
		
	: ($1=9)
		Case of 
			: ($2=1)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_1_3)
			: ($2=2)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_2_3)
			: ($2=3)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_3_3)
			: ($2=4)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_4_3)
			: ($2=5)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_5_3)
			: ($2=6)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_6_3)
			: ($2=7)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_7_3)
			: ($2=8)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_8_3)
			: ($2=9)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_9_3)
			: ($2=10)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_10_3)
			: ($2=11)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_11_3)
			: ($2=12)
				COPY ARRAY:C226(ta_ColFamClé; ta_ColRéfFam_12_3)
		End case 
		
	: ($1=10)
		Case of 
			: ($2=1)
				vl_ColF2_P_1:=0
			: ($2=2)
				vl_ColF2_P_2:=0
			: ($2=3)
				vl_ColF2_P_3:=0
			: ($2=4)
				vl_ColF2_P_4:=0
			: ($2=5)
				vl_ColF2_P_5:=0
			: ($2=6)
				vl_ColF2_P_6:=0
			: ($2=7)
				vl_ColF2_P_7:=0
			: ($2=8)
				vl_ColF2_P_8:=0
			: ($2=9)
				vl_ColF2_P_9:=0
			: ($2=10)
				vl_ColF2_P_10:=0
			: ($2=11)
				vl_ColF2_P_11:=0
			: ($2=12)
				vl_ColF2_P_12:=0
		End case 
		
		
	: ($1=11)
		Case of 
			: ($2=1)
				ARRAY LONGINT:C221(tl_ColRéf_1_3; 0)
			: ($2=2)
				ARRAY LONGINT:C221(tl_ColRéf_2_3; 0)
			: ($2=3)
				ARRAY LONGINT:C221(tl_ColRéf_3_3; 0)
			: ($2=4)
				ARRAY LONGINT:C221(tl_ColRéf_4_3; 0)
			: ($2=5)
				ARRAY LONGINT:C221(tl_ColRéf_5_3; 0)
			: ($2=6)
				ARRAY LONGINT:C221(tl_ColRéf_6_3; 0)
			: ($2=7)
				ARRAY LONGINT:C221(tl_ColRéf_7_3; 0)
			: ($2=8)
				ARRAY LONGINT:C221(tl_ColRéf_8_3; 0)
			: ($2=9)
				ARRAY LONGINT:C221(tl_ColRéf_9_3; 0)
			: ($2=10)
				ARRAY LONGINT:C221(tl_ColRéf_10_3; 0)
			: ($2=11)
				ARRAY LONGINT:C221(tl_ColRéf_11_3; 0)
			: ($2=12)
				ARRAY LONGINT:C221(tl_ColRéf_12_3; 0)
		End case 
		
	: ($1=12)
		Case of 
			: ($2=1)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_1_3)
			: ($2=2)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_2_3)
			: ($2=3)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_3_3)
			: ($2=4)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_4_3)
			: ($2=5)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_5_3)
			: ($2=6)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_6_3)
			: ($2=7)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_7_3)
			: ($2=8)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_8_3)
			: ($2=9)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_9_3)
			: ($2=10)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_10_3)
			: ($2=11)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_11_3)
			: ($2=12)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_12_3)
		End case 
		
		
	: ($1=13)
		Case of 
			: ($2=1)
				vl_ColF2_P_1:=$3
			: ($2=2)
				vl_ColF2_P_2:=$3
			: ($2=3)
				vl_ColF2_P_3:=$3
			: ($2=4)
				vl_ColF2_P_4:=$3
			: ($2=5)
				vl_ColF2_P_5:=$3
			: ($2=6)
				vl_ColF2_P_6:=$3
			: ($2=7)
				vl_ColF2_P_7:=$3
			: ($2=8)
				vl_ColF2_P_8:=$3
			: ($2=9)
				vl_ColF2_P_9:=$3
			: ($2=10)
				vl_ColF2_P_10:=$3
			: ($2=11)
				vl_ColF2_P_11:=$3
			: ($2=12)
				vl_ColF2_P_12:=$3
		End case 
		
	: ($1=14)
		Case of 
			: ($2=1)
				vl_ColF3_1:=vl_ColF2_1
			: ($2=2)
				vl_ColF3_2:=vl_ColF2_2
			: ($2=3)
				vl_ColF3_3:=vl_ColF2_3
			: ($2=4)
				vl_ColF3_4:=vl_ColF2_4
			: ($2=5)
				vl_ColF3_5:=vl_ColF2_5
			: ($2=6)
				vl_ColF3_6:=vl_ColF2_6
			: ($2=7)
				vl_ColF3_7:=vl_ColF2_7
			: ($2=8)
				vl_ColF3_8:=vl_ColF2_8
			: ($2=9)
				vl_ColF3_9:=vl_ColF2_9
			: ($2=10)
				vl_ColF3_10:=vl_ColF2_10
			: ($2=11)
				vl_ColF3_11:=vl_ColF2_11
			: ($2=12)
				vl_ColF3_11:=vl_ColF2_11
		End case 
		
	: ($1=15)
		Case of 
			: ($2=1)
				COPY ARRAY:C226(ta_ColRéfFam_1_3; ta_ColRéfFam_1_4)
			: ($2=2)
				COPY ARRAY:C226(ta_ColRéfFam_2_3; ta_ColRéfFam_2_4)
			: ($2=3)
				COPY ARRAY:C226(ta_ColRéfFam_3_3; ta_ColRéfFam_3_4)
			: ($2=4)
				COPY ARRAY:C226(ta_ColRéfFam_4_3; ta_ColRéfFam_4_4)
			: ($2=5)
				COPY ARRAY:C226(ta_ColRéfFam_5_3; ta_ColRéfFam_5_4)
			: ($2=6)
				COPY ARRAY:C226(ta_ColRéfFam_6_3; ta_ColRéfFam_6_4)
			: ($2=7)
				COPY ARRAY:C226(ta_ColRéfFam_7_3; ta_ColRéfFam_7_4)
			: ($2=8)
				COPY ARRAY:C226(ta_ColRéfFam_8_3; ta_ColRéfFam_8_4)
			: ($2=9)
				COPY ARRAY:C226(ta_ColRéfFam_9_3; ta_ColRéfFam_9_4)
			: ($2=10)
				COPY ARRAY:C226(ta_ColRéfFam_10_3; ta_ColRéfFam_10_4)
			: ($2=11)
				COPY ARRAY:C226(ta_ColRéfFam_11_3; ta_ColRéfFam_11_4)
			: ($2=12)
				COPY ARRAY:C226(ta_ColRéfFam_12_3; ta_ColRéfFam_12_4)
		End case 
		
	: ($1=16)
		Case of 
			: ($2=1)
				vl_ColF3_P_1:=vl_ColF2_P_1
			: ($2=2)
				vl_ColF3_P_2:=vl_ColF2_P_2
			: ($2=3)
				vl_ColF3_P_3:=vl_ColF2_P_3
			: ($2=4)
				vl_ColF3_P_4:=vl_ColF2_P_4
			: ($2=5)
				vl_ColF3_P_5:=vl_ColF2_P_5
			: ($2=6)
				vl_ColF3_P_6:=vl_ColF2_P_6
			: ($2=7)
				vl_ColF3_P_7:=vl_ColF2_P_7
			: ($2=8)
				vl_ColF3_P_8:=vl_ColF2_P_8
			: ($2=9)
				vl_ColF3_P_9:=vl_ColF2_P_9
			: ($2=10)
				vl_ColF3_P_10:=vl_ColF2_P_10
			: ($2=11)
				vl_ColF3_P_11:=vl_ColF2_P_11
			: ($2=12)
				vl_ColF3_P_12:=vl_ColF2_P_12
		End case 
		
		
	: ($1=17)
		Case of 
			: ($2=1)
				COPY ARRAY:C226(tl_ColRéf_1_3; tl_ColRéf_1_4)
			: ($2=2)
				COPY ARRAY:C226(tl_ColRéf_2_3; tl_ColRéf_2_4)
			: ($2=3)
				COPY ARRAY:C226(tl_ColRéf_3_3; tl_ColRéf_3_4)
			: ($2=4)
				COPY ARRAY:C226(tl_ColRéf_4_3; tl_ColRéf_4_4)
			: ($2=5)
				COPY ARRAY:C226(tl_ColRéf_5_3; tl_ColRéf_5_4)
			: ($2=6)
				COPY ARRAY:C226(tl_ColRéf_6_3; tl_ColRéf_6_4)
			: ($2=7)
				COPY ARRAY:C226(tl_ColRéf_7_3; tl_ColRéf_7_4)
			: ($2=8)
				COPY ARRAY:C226(tl_ColRéf_8_3; tl_ColRéf_8_4)
			: ($2=9)
				COPY ARRAY:C226(tl_ColRéf_9_3; tl_ColRéf_9_4)
			: ($2=10)
				COPY ARRAY:C226(tl_ColRéf_10_3; tl_ColRéf_10_4)
			: ($2=11)
				COPY ARRAY:C226(tl_ColRéf_11_3; tl_ColRéf_11_4)
			: ($2=12)
				COPY ARRAY:C226(tl_ColRéf_12_3; tl_ColRéf_12_4)
		End case 
		
		
	: ($1=18)
		Case of 
			: ($2=1)
				COPY ARRAY:C226(ta_ColRéfFam_1_3; ta_ColRéfFam_1_4)
			: ($2=2)
				COPY ARRAY:C226(ta_ColRéfFam_2_3; ta_ColRéfFam_2_4)
			: ($2=3)
				COPY ARRAY:C226(ta_ColRéfFam_3_3; ta_ColRéfFam_3_4)
			: ($2=4)
				COPY ARRAY:C226(ta_ColRéfFam_4_3; ta_ColRéfFam_4_4)
			: ($2=5)
				COPY ARRAY:C226(ta_ColRéfFam_5_3; ta_ColRéfFam_5_4)
			: ($2=6)
				COPY ARRAY:C226(ta_ColRéfFam_6_3; ta_ColRéfFam_6_4)
			: ($2=7)
				COPY ARRAY:C226(ta_ColRéfFam_7_3; ta_ColRéfFam_7_4)
			: ($2=8)
				COPY ARRAY:C226(ta_ColRéfFam_8_3; ta_ColRéfFam_8_4)
			: ($2=9)
				COPY ARRAY:C226(ta_ColRéfFam_9_3; ta_ColRéfFam_9_4)
			: ($2=10)
				COPY ARRAY:C226(ta_ColRéfFam_10_3; ta_ColRéfFam_10_4)
			: ($2=11)
				COPY ARRAY:C226(ta_ColRéfFam_11_3; ta_ColRéfFam_11_4)
			: ($2=12)
				COPY ARRAY:C226(ta_ColRéfFam_12_3; ta_ColRéfFam_12_4)
		End case 
		
		
	: ($1=19)
		Case of 
			: ($2=1)
				vp_Ptr01:=->ta_ColRéfFam_1_4
				vp_Ptr03:=->vl_ColF3_1
				vp_Ptr04:=->vl_ColF3_P_1
				vp_Ptr05:=->tl_ColRéf_1_4
			: ($2=2)
				vp_Ptr01:=->ta_ColRéfFam_2_4
				vp_Ptr02:=->ta_ColRéfFam_1_3
				vp_Ptr03:=->vl_ColF3_2
				vp_Ptr04:=->vl_ColF3_P_2
				vp_Ptr05:=->tl_ColRéf_2_4
			: ($2=3)
				vp_Ptr01:=->ta_ColRéfFam_3_4
				vp_Ptr02:=->ta_ColRéfFam_2_3
				vp_Ptr03:=->vl_ColF3_3
				vp_Ptr04:=->vl_ColF3_P_3
				vp_Ptr05:=->tl_ColRéf_3_4
			: ($2=4)
				vp_Ptr01:=->ta_ColRéfFam_4_4
				vp_Ptr02:=->ta_ColRéfFam_3_3
				vp_Ptr03:=->vl_ColF3_4
				vp_Ptr04:=->vl_ColF3_P_4
				vp_Ptr05:=->tl_ColRéf_4_4
			: ($2=5)
				vp_Ptr01:=->ta_ColRéfFam_5_4
				vp_Ptr02:=->ta_ColRéfFam_4_3
				vp_Ptr03:=->vl_ColF3_5
				vp_Ptr04:=->vl_ColF3_P_5
				vp_Ptr05:=->tl_ColRéf_5_4
			: ($2=6)
				vp_Ptr01:=->ta_ColRéfFam_6_4
				vp_Ptr02:=->ta_ColRéfFam_5_3
				vp_Ptr03:=->vl_ColF3_6
				vp_Ptr04:=->vl_ColF3_P_6
				vp_Ptr05:=->tl_ColRéf_6_4
			: ($2=7)
				vp_Ptr01:=->ta_ColRéfFam_7_4
				vp_Ptr02:=->ta_ColRéfFam_6_3
				vp_Ptr03:=->vl_ColF3_7
				vp_Ptr04:=->vl_ColF3_P_7
				vp_Ptr05:=->tl_ColRéf_7_4
			: ($2=8)
				vp_Ptr01:=->ta_ColRéfFam_8_4
				vp_Ptr02:=->ta_ColRéfFam_7_3
				vp_Ptr03:=->vl_ColF3_8
				vp_Ptr04:=->vl_ColF3_P_8
				vp_Ptr05:=->tl_ColRéf_8_4
			: ($2=9)
				vp_Ptr01:=->ta_ColRéfFam_9_4
				vp_Ptr02:=->ta_ColRéfFam_8_3
				vp_Ptr03:=->vl_ColF3_9
				vp_Ptr04:=->vl_ColF3_P_9
				vp_Ptr05:=->tl_ColRéf_9_4
			: ($2=10)
				vp_Ptr01:=->ta_ColRéfFam_10_4
				vp_Ptr02:=->ta_ColRéfFam_9_3
				vp_Ptr03:=->vl_ColF3_10
				vp_Ptr04:=->vl_ColF3_P_10
				vp_Ptr05:=->tl_ColRéf_10_4
			: ($2=11)
				vp_Ptr01:=->ta_ColRéfFam_11_4
				vp_Ptr02:=->ta_ColRéfFam_10_3
				vp_Ptr03:=->vl_ColF3_11
				vp_Ptr04:=->vl_ColF3_P_11
				vp_Ptr05:=->tl_ColRéf_11_4
			: ($2=12)
				vp_Ptr01:=->ta_ColRéfFam_12_4
				vp_Ptr02:=->ta_ColRéfFam_11_3
				vp_Ptr03:=->vl_ColF3_12
				vp_Ptr04:=->vl_ColF3_P_12
				vp_Ptr05:=->tl_ColRéf_12_4
		End case 
		If (Size of array:C274(vp_Ptr01->)>0)
			$kk:=1
			Repeat 
				$Position:=Find in array:C230(vp_Ptr02->; vp_Ptr01->{$kk})
				If ($Position>0)
					DELETE FROM ARRAY:C228(vp_Ptr01->; $kk; 1)
				Else 
					$kk:=$kk+1
				End if 
			Until ($kk>Size of array:C274(vp_Ptr01->))
		End if 
		
		If (Size of array:C274(vp_Ptr01->)>0)
			COPY ARRAY:C226(vp_Ptr01->; ta_ColFamCléB)
		End if 
		
		vp_Ptr03->:=Size of array:C274(vp_Ptr01->)
		vp_Ptr04->:=0
		ARRAY LONGINT:C221(vp_Ptr05->; 0)
		
		
	: ($1=20)
		Case of 
			: ($2=1)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_1_4)
			: ($2=2)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_2_4)
			: ($2=3)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_3_4)
			: ($2=4)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_4_4)
			: ($2=5)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_5_4)
			: ($2=6)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_6_4)
			: ($2=7)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_7_4)
			: ($2=8)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_8_4)
			: ($2=9)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_9_4)
			: ($2=10)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_10_4)
			: ($2=11)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_11_4)
			: ($2=12)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ColRéf_12_4)
		End case 
		
		
	: ($1=21)
		Case of 
			: ($2=1)
				vl_ColF3_P_1:=$3
			: ($2=2)
				vl_ColF3_P_2:=$3
			: ($2=3)
				vl_ColF3_P_3:=$3
			: ($2=4)
				vl_ColF3_P_4:=$3
			: ($2=5)
				vl_ColF3_P_5:=$3
			: ($2=6)
				vl_ColF3_P_6:=$3
			: ($2=7)
				vl_ColF3_P_7:=$3
			: ($2=8)
				vl_ColF3_P_8:=$3
			: ($2=9)
				vl_ColF3_P_9:=$3
			: ($2=10)
				vl_ColF3_P_10:=$3
			: ($2=11)
				vl_ColF3_P_11:=$3
			: ($2=12)
				vl_ColF3_P_12:=$3
		End case 
		
End case 