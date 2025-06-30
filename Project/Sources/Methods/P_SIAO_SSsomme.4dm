//%attributes = {}

vr_Ss_RS_MontantMois:=vr_Ss_RS_Montant1+vr_Ss_RS_Montant2+vr_Ss_RS_Montant3+vr_Ss_RS_Montant4+vr_Ss_RS_Montant5
vr_Ss_RS_MontantAnnuel:=vr_Ss_RS_MontantMois*12
If (F_SIAO_Var_SsTotal(3; 0; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0))  //Totaux
	Case of 
		: (vr_Ss_TOTAL_Disponible<0)
			_O_OBJECT SET COLOR:C271(vr_Ss_TOTAL_Disponible; -(Rouge:K11:4+(256*Gris clair:K11:13)))
		: (vr_Ss_TOTAL_Disponible=0)
			_O_OBJECT SET COLOR:C271(vr_Ss_TOTAL_Disponible; -(Noir:K11:16+(256*Gris clair:K11:13)))
		: (vr_Ss_TOTAL_Disponible>0)
			_O_OBJECT SET COLOR:C271(vr_Ss_TOTAL_Disponible; -(Vert:K11:9+(256*Gris clair:K11:13)))
	End case 
End if 