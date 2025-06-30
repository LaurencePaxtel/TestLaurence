<>vl_RAP_Jours:=<>vd_RAP_Jusque-<>vd_RAP_Départ+1

If (<>vd_RAP_Départ><>vd_RAP_Jusque) | (<>vd_RAP_Départ=!00-00-00!) | (<>vd_RAP_Jusque=!00-00-00!)
	<>vl_RAP_Jours:=0
End if 