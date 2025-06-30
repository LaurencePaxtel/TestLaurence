If (Form event code:C388=Sur données modifiées:K2:15)
	If ([DiaLogues:3]DL_Date:2>!00-00-00!)
		
		Rec_FaxFamille(0; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; 0)
	Else 
		OBJECT SET ENABLED:C1123(b_VoirNotes; False:C215)
		OBJECT SET ENABLED:C1123(b_VoirSP; False:C215)
		OBJECT SET ENABLED:C1123(b_VoirTexte; False:C215)
		OBJECT SET ENABLED:C1123(b_VoirTextef; False:C215)
		OBJECT SET ENABLED:C1123(b_DSOui; False:C215)
		OBJECT SET ENABLED:C1123(b_DSNon; False:C215)
		OBJECT SET ENABLED:C1123(b_DSVoir; False:C215)
		OBJECT SET ENABLED:C1123(b_FaxDist; False:C215)
		OBJECT SET ENABLED:C1123(b_FaxDExp; False:C215)
		OBJECT SET ENABLED:C1123(b_FaxHBH; False:C215)
		OBJECT SET ENABLED:C1123(b_FaxHBS; False:C215)
		OBJECT SET ENABLED:C1123(b_FaxHB; False:C215)
		OBJECT SET ENABLED:C1123(b_PrintHB; False:C215)
		
	End if 
End if 