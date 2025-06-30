//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementDécoupage
//{
//{          Lundi 28 décembre 2009 à 16:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
Case of 
	: ($1=0)
		
		C_TEXT:C284(vt_ColRéf_Libellé; vt_ColRéf_LibelléRupture)
		C_LONGINT:C283(ve_ColMois; ve_ColType)
		ARRAY TEXT:C222(ta_ColRéfFam_Code; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_1_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_1_1; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_1_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_1_2; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_1_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_1_3; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_1_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_1_4; 0)
		
		
		ARRAY LONGINT:C221(tl_ColRéf_2_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_2_1; 0)
		ARRAY LONGINT:C221(tl_ColRéf_2_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_2_2; 0)
		ARRAY LONGINT:C221(tl_ColRéf_2_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_2_3; 0)
		ARRAY LONGINT:C221(tl_ColRéf_2_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_2_4; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_3_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_3_1; 0)
		ARRAY LONGINT:C221(tl_ColRéf_3_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_3_2; 0)
		ARRAY LONGINT:C221(tl_ColRéf_3_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_3_3; 0)
		ARRAY LONGINT:C221(tl_ColRéf_3_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_3_4; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_4_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_4_1; 0)
		ARRAY LONGINT:C221(tl_ColRéf_4_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_4_2; 0)
		ARRAY LONGINT:C221(tl_ColRéf_4_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_4_3; 0)
		ARRAY LONGINT:C221(tl_ColRéf_4_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_4_4; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_5_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_5_1; 0)
		ARRAY LONGINT:C221(tl_ColRéf_5_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_5_2; 0)
		ARRAY LONGINT:C221(tl_ColRéf_5_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_5_3; 0)
		ARRAY LONGINT:C221(tl_ColRéf_5_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_5_4; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_6_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_6_1; 0)
		ARRAY LONGINT:C221(tl_ColRéf_6_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_6_2; 0)
		ARRAY LONGINT:C221(tl_ColRéf_6_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_6_3; 0)
		ARRAY LONGINT:C221(tl_ColRéf_6_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_6_4; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_7_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_7_1; 0)
		ARRAY LONGINT:C221(tl_ColRéf_7_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_7_2; 0)
		ARRAY LONGINT:C221(tl_ColRéf_7_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_7_3; 0)
		ARRAY LONGINT:C221(tl_ColRéf_7_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_7_4; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_8_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_8_1; 0)
		ARRAY LONGINT:C221(tl_ColRéf_8_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_8_2; 0)
		ARRAY LONGINT:C221(tl_ColRéf_8_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_8_3; 0)
		ARRAY LONGINT:C221(tl_ColRéf_8_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_8_4; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_9_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_9_1; 0)
		ARRAY LONGINT:C221(tl_ColRéf_9_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_9_2; 0)
		ARRAY LONGINT:C221(tl_ColRéf_9_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_9_3; 0)
		ARRAY LONGINT:C221(tl_ColRéf_9_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_9_4; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_10_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_10_1; 0)
		ARRAY LONGINT:C221(tl_ColRéf_10_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_10_2; 0)
		ARRAY LONGINT:C221(tl_ColRéf_10_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_10_3; 0)
		ARRAY LONGINT:C221(tl_ColRéf_10_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_10_4; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_11_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_11_1; 0)
		ARRAY LONGINT:C221(tl_ColRéf_11_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_11_2; 0)
		ARRAY LONGINT:C221(tl_ColRéf_11_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_11_3; 0)
		ARRAY LONGINT:C221(tl_ColRéf_11_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_11_4; 0)
		
		ARRAY LONGINT:C221(tl_ColRéf_12_1; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_12_1; 0)
		ARRAY LONGINT:C221(tl_ColRéf_12_2; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_12_2; 0)
		ARRAY LONGINT:C221(tl_ColRéf_12_3; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_12_3; 0)
		ARRAY LONGINT:C221(tl_ColRéf_12_4; 0)
		ARRAY TEXT:C222(ta_ColRéfFam_12_4; 0)
		
		
		ARRAY TEXT:C222(ta_ColFamClé; 0)
		ARRAY BOOLEAN:C223(tb_ColFamClé; 0)
		
		
		
		C_LONGINT:C283(vl_ColT1_1)
		C_LONGINT:C283(vl_ColT1_2)
		C_LONGINT:C283(vl_ColT1_3)
		C_LONGINT:C283(vl_ColT1_4)
		C_LONGINT:C283(vl_ColT1_5)
		C_LONGINT:C283(vl_ColT1_6)
		C_LONGINT:C283(vl_ColT1_7)
		C_LONGINT:C283(vl_ColT1_8)
		C_LONGINT:C283(vl_ColT1_9)
		C_LONGINT:C283(vl_ColT1_10)
		C_LONGINT:C283(vl_ColT1_11)
		C_LONGINT:C283(vl_ColT1_12)
		
		C_LONGINT:C283(vl_ColN1_1)
		C_LONGINT:C283(vl_ColN1_2)
		C_LONGINT:C283(vl_ColN1_3)
		C_LONGINT:C283(vl_ColN1_4)
		C_LONGINT:C283(vl_ColN1_5)
		C_LONGINT:C283(vl_ColN1_6)
		C_LONGINT:C283(vl_ColN1_7)
		C_LONGINT:C283(vl_ColN1_8)
		C_LONGINT:C283(vl_ColN1_9)
		C_LONGINT:C283(vl_ColN1_10)
		C_LONGINT:C283(vl_ColN1_11)
		C_LONGINT:C283(vl_ColN1_12)
		
		
		C_LONGINT:C283(vl_ColHS1_1)
		C_LONGINT:C283(vl_ColHS1_2)
		C_LONGINT:C283(vl_ColHS1_3)
		C_LONGINT:C283(vl_ColHS1_4)
		C_LONGINT:C283(vl_ColHS1_5)
		C_LONGINT:C283(vl_ColHS1_6)
		C_LONGINT:C283(vl_ColHS1_7)
		C_LONGINT:C283(vl_ColHS1_8)
		C_LONGINT:C283(vl_ColHS1_9)
		C_LONGINT:C283(vl_ColHS1_10)
		C_LONGINT:C283(vl_ColHS1_11)
		C_LONGINT:C283(vl_ColHS1_12)
		
		C_LONGINT:C283(vl_ColFS1_1)
		C_LONGINT:C283(vl_ColFS1_2)
		C_LONGINT:C283(vl_ColFS1_3)
		C_LONGINT:C283(vl_ColFS1_4)
		C_LONGINT:C283(vl_ColFS1_5)
		C_LONGINT:C283(vl_ColFS1_6)
		C_LONGINT:C283(vl_ColFS1_7)
		C_LONGINT:C283(vl_ColFS1_8)
		C_LONGINT:C283(vl_ColFS1_9)
		C_LONGINT:C283(vl_ColFS1_10)
		C_LONGINT:C283(vl_ColFS1_11)
		C_LONGINT:C283(vl_ColFS1_12)
		
		C_LONGINT:C283(vl_ColCP1_1)
		C_LONGINT:C283(vl_CoCP1_2)
		C_LONGINT:C283(vl_ColCP1_3)
		C_LONGINT:C283(vl_ColCP1_4)
		C_LONGINT:C283(vl_ColCP1_5)
		C_LONGINT:C283(vl_ColCP1_6)
		C_LONGINT:C283(vl_ColCP1_7)
		C_LONGINT:C283(vl_ColCP1_8)
		C_LONGINT:C283(vl_ColCP1_9)
		C_LONGINT:C283(vl_ColCP1_10)
		C_LONGINT:C283(vl_ColCP1_11)
		C_LONGINT:C283(vl_ColCP1_12)
		
		
		
		
		C_LONGINT:C283(vl_ColF1_1)
		C_LONGINT:C283(vl_ColF1_2)
		C_LONGINT:C283(vl_ColF1_3)
		C_LONGINT:C283(vl_ColF1_4)
		C_LONGINT:C283(vl_ColF1_5)
		C_LONGINT:C283(vl_ColF1_6)
		C_LONGINT:C283(vl_ColF1_7)
		C_LONGINT:C283(vl_ColF1_8)
		C_LONGINT:C283(vl_ColF1_9)
		C_LONGINT:C283(vl_ColF1_10)
		C_LONGINT:C283(vl_ColF1_11)
		C_LONGINT:C283(vl_ColF1_12)
		
		C_LONGINT:C283(vl_ColF1_P_1)
		C_LONGINT:C283(vl_ColF1_P_2)
		C_LONGINT:C283(vl_ColF1_P_3)
		C_LONGINT:C283(vl_ColF1_P_4)
		C_LONGINT:C283(vl_ColF1_P_5)
		C_LONGINT:C283(vl_ColF1_P_6)
		C_LONGINT:C283(vl_ColF1_P_7)
		C_LONGINT:C283(vl_ColF1_P_8)
		C_LONGINT:C283(vl_ColF1_P_9)
		C_LONGINT:C283(vl_ColF1_P_10)
		C_LONGINT:C283(vl_ColF1_P_11)
		C_LONGINT:C283(vl_ColF1_P_12)
		
		
		C_LONGINT:C283(vl_ColF2_1)
		C_LONGINT:C283(vl_ColF2_2)
		C_LONGINT:C283(vl_ColF2_3)
		C_LONGINT:C283(vl_ColF2_4)
		C_LONGINT:C283(vl_ColF2_5)
		C_LONGINT:C283(vl_ColF2_6)
		C_LONGINT:C283(vl_ColF2_7)
		C_LONGINT:C283(vl_ColF2_8)
		C_LONGINT:C283(vl_ColF2_9)
		C_LONGINT:C283(vl_ColF2_10)
		C_LONGINT:C283(vl_ColF2_11)
		C_LONGINT:C283(vl_ColF2_12)
		
		
		C_LONGINT:C283(vl_ColF2_P_1)
		C_LONGINT:C283(vl_ColF2_P_2)
		C_LONGINT:C283(vl_ColF2_P_3)
		C_LONGINT:C283(vl_ColF2_P_4)
		C_LONGINT:C283(vl_ColF2_P_5)
		C_LONGINT:C283(vl_ColF2_P_6)
		C_LONGINT:C283(vl_ColF2_P_7)
		C_LONGINT:C283(vl_ColF2_P_8)
		C_LONGINT:C283(vl_ColF2_P_9)
		C_LONGINT:C283(vl_ColF2_P_10)
		C_LONGINT:C283(vl_ColF2_P_11)
		C_LONGINT:C283(vl_ColF2_P_12)
		
		
		
		C_LONGINT:C283(vl_ColF3_1)
		C_LONGINT:C283(vl_ColF3_2)
		C_LONGINT:C283(vl_ColF3_3)
		C_LONGINT:C283(vl_ColF3_4)
		C_LONGINT:C283(vl_ColF3_5)
		C_LONGINT:C283(vl_ColF3_6)
		C_LONGINT:C283(vl_ColF3_7)
		C_LONGINT:C283(vl_ColF3_8)
		C_LONGINT:C283(vl_ColF3_9)
		C_LONGINT:C283(vl_ColF3_10)
		C_LONGINT:C283(vl_ColF3_11)
		C_LONGINT:C283(vl_ColF3_12)
		
		
		C_LONGINT:C283(vl_ColF3_P_1)
		C_LONGINT:C283(vl_ColF3_P_2)
		C_LONGINT:C283(vl_ColF3_P_3)
		C_LONGINT:C283(vl_ColF3_P_4)
		C_LONGINT:C283(vl_ColF3_P_5)
		C_LONGINT:C283(vl_ColF3_P_6)
		C_LONGINT:C283(vl_ColF3_P_7)
		C_LONGINT:C283(vl_ColF3_P_8)
		C_LONGINT:C283(vl_ColF3_P_9)
		C_LONGINT:C283(vl_ColF3_P_10)
		C_LONGINT:C283(vl_ColF3_P_11)
		C_LONGINT:C283(vl_ColF3_P_12)
		
		
		
		C_LONGINT:C283(vl_ColNA1_1)
		C_LONGINT:C283(vl_ColNA1_2)
		C_LONGINT:C283(vl_ColNA1_3)
		C_LONGINT:C283(vl_ColNA1_4)
		C_LONGINT:C283(vl_ColNA1_5)
		C_LONGINT:C283(vl_ColNA1_6)
		C_LONGINT:C283(vl_ColNA1_7)
		C_LONGINT:C283(vl_ColNA1_8)
		C_LONGINT:C283(vl_ColNA1_9)
		C_LONGINT:C283(vl_ColNA1_10)
		C_LONGINT:C283(vl_ColNA1_11)
		C_LONGINT:C283(vl_ColNA1_12)
		
		
		vt_ColRéf_Libellé:=""
		
		
		
		vl_ColT1_1:=0
		vl_ColT1_2:=0
		vl_ColT1_3:=0
		vl_ColT1_4:=0
		vl_ColT1_5:=0
		vl_ColT1_6:=0
		vl_ColT1_7:=0
		vl_ColT1_8:=0
		vl_ColT1_9:=0
		vl_ColT1_10:=0
		vl_ColT1_11:=0
		vl_ColT1_12:=0
		
		vl_ColN1_1:=0
		vl_ColN1_2:=0
		vl_ColN1_3:=0
		vl_ColN1_4:=0
		vl_ColN1_5:=0
		vl_ColN1_6:=0
		vl_ColN1_7:=0
		vl_ColN1_8:=0
		vl_ColN1_9:=0
		vl_ColN1_10:=0
		vl_ColN1_11:=0
		vl_ColN1_12:=0
		
		
		
		vl_ColHS1_1:=0
		vl_ColHS1_2:=0
		vl_ColHS1_3:=0
		vl_ColHS1_4:=0
		vl_ColHS1_5:=0
		vl_ColHS1_6:=0
		vl_ColHS1_7:=0
		vl_ColHS1_8:=0
		vl_ColHS1_9:=0
		vl_ColHS1_10:=0
		vl_ColHS1_11:=0
		vl_ColHS1_12:=0
		
		vl_ColFS1_1:=0
		vl_ColFS1_2:=0
		vl_ColFS1_3:=0
		vl_ColFS1_4:=0
		vl_ColFS1_5:=0
		vl_ColFS1_6:=0
		vl_ColFS1_7:=0
		vl_ColFS1_8:=0
		vl_ColFS1_9:=0
		vl_ColFS1_10:=0
		vl_ColFS1_11:=0
		vl_ColFS1_12:=0
		
		vl_ColCP1_1:=0
		vl_ColCP1_2:=0
		vl_ColCP1_3:=0
		vl_ColCP1_4:=0
		vl_ColCP1_5:=0
		vl_ColCP1_6:=0
		vl_ColCP1_7:=0
		vl_ColCP1_8:=0
		vl_ColCP1_9:=0
		vl_ColCP1_10:=0
		vl_ColCP1_11:=0
		vl_ColCP1_12:=0
		
		
		vl_ColF1_1:=0
		vl_ColF1_2:=0
		vl_ColF1_3:=0
		vl_ColF1_4:=0
		vl_ColF1_5:=0
		vl_ColF1_6:=0
		vl_ColF1_7:=0
		vl_ColF1_8:=0
		vl_ColF1_9:=0
		vl_ColF1_10:=0
		vl_ColF1_11:=0
		vl_ColF1_12:=0
		
		vl_ColF1_P_1:=0
		vl_ColF1_P_2:=0
		vl_ColF1_v3:=0
		vl_ColF1_P_4:=0
		vl_ColF1_P_5:=0
		vl_ColF1_P_6:=0
		vl_ColF1_P_7:=0
		vl_ColF1_P_8:=0
		vl_ColF1_P_9:=0
		vl_ColF1_P_10:=0
		vl_ColF1_P_11:=0
		vl_ColF1_P_12:=0
		
		vl_ColF2_1:=0
		vl_ColF2_2:=0
		vl_ColF2_3:=0
		vl_ColF2_4:=0
		vl_ColF2_5:=0
		vl_ColF2_6:=0
		vl_ColF2_7:=0
		vl_ColF2_8:=0
		vl_ColF2_9:=0
		vl_ColF2_10:=0
		vl_ColF2_11:=0
		vl_ColF2_12:=0
		
		vl_ColF2_ P_1:=0
		vl_ColF2_ P_2:=0
		vl_ColF2_ P_3:=0
		vl_ColF2_ P_4:=0
		vl_ColF2_ P_5:=0
		vl_ColF2_ P_6:=0
		vl_ColF2_ P_7:=0
		vl_ColF2_ P_8:=0
		vl_ColF2_ P_9:=0
		vl_ColF2_ P_10:=0
		vl_ColF2_ P_11:=0
		vl_ColF2_ P_12:=0
		
		vl_ColF3_1:=0
		vl_ColF3_2:=0
		vl_ColF3_3:=0
		vl_ColF3_4:=0
		vl_ColF3_5:=0
		vl_ColF3_6:=0
		vl_ColF3_7:=0
		vl_ColF3_8:=0
		vl_ColF3_9:=0
		vl_ColF3_10:=0
		vl_ColF3_11:=0
		vl_ColF3_12:=0
		
		vl_ColF3_ P_1:=0
		vl_ColF3_ P_2:=0
		vl_ColF3_ P_3:=0
		vl_ColF3_ P_4:=0
		vl_ColF3_ P_5:=0
		vl_ColF3_ P_6:=0
		vl_ColF3_ P_7:=0
		vl_ColF3_ P_8:=0
		vl_ColF3_ P_9:=0
		vl_ColF3_ P_10:=0
		vl_ColF3_ P_11:=0
		vl_ColF3_ P_12:=0
		
		
		vl_ColNA1_1:=0
		vl_ColNA1_2:=0
		vl_ColNA1_3:=0
		vl_ColNA1_4:=0
		vl_ColNA1_5:=0
		vl_ColNA1_6:=0
		vl_ColNA1_7:=0
		vl_ColNA1_8:=0
		vl_ColNA1_9:=0
		vl_ColNA1_10:=0
		vl_ColNA1_11:=0
		vl_ColNA1_12:=0
		
		
End case 