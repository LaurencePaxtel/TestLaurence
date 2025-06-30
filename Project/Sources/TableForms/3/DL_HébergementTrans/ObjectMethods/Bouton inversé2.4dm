If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	[DiaLogues:3]DL_Date:2:=Add to date:C393([DiaLogues:3]DL_Date:2; 0; 0; 1)
Else 
	[DiaLogues:3]DL_Date:2:=Current date:C33
End if 

If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	Rec_TransFamille(0; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; 0)
Else 
	OBJECT SET ENABLED:C1123(b_VoirNotes; False:C215)
	OBJECT SET ENABLED:C1123(b_VoirSP; False:C215)
	OBJECT SET ENABLED:C1123(b_DSOui; False:C215)
	OBJECT SET ENABLED:C1123(b_DSNon; False:C215)
	OBJECT SET ENABLED:C1123(b_DSVoir; False:C215)
	OBJECT SET ENABLED:C1123(b_FaxHB; False:C215)
	OBJECT SET ENABLED:C1123(b_PrintHB; False:C215)
End if 