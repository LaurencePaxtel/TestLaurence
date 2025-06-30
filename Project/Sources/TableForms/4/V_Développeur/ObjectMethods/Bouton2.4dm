If (Records in set:C195("UserSet")>0)
	USE SET:C118("UserSet")
	CLEAR SET:C117("UserSet")
	vL_Nb_HG_F:=Records in selection:C76([HeBerge:4])
	SET WINDOW TITLE:C213(va_Titre+String:C10(vL_Nb_HG_F))
End if 