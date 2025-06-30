//%attributes = {}

vr_Ss_DT_MontantMois:=vr_Ss_DT_Montant1+vr_Ss_DT_Montant2+vr_Ss_DT_Montant3+vr_Ss_DT_Montant4+vr_Ss_DT_Montant5
vr_Ss_DT_MontantAnnuel:=vr_Ss_DT_MontantMois*12

If (F_SIAO_Var_SsTotal(3; 0; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0))  //Totauxp
End if 