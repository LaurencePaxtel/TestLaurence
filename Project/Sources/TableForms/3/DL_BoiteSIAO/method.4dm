If (Form event code:C388=Sur chargement:K2:1)
	
	rSIAOinsertion:=Num:C11((<>vl_T_SIAOType=1) | (<>vl_T_SIAOType=3))
	rSIAOUrgence:=Num:C11((<>vl_T_SIAOType=2) | (<>vl_T_SIAOType=3))
	
	OBJECT SET ENABLED:C1123(rSIAOinsertion; False:C215)
	OBJECT SET ENABLED:C1123(rSIAOUrgence; False:C215)
	
	<>vl_T_SIAO_IU:=(1*Num:C11(rSIAOinsertion=1))+(2*Num:C11(rSIAOUrgence=1))
	
End if 
