READ WRITE:C146([MessagerieVSM:39])
If (Records in set:C195("UserSet")=1)
	USE SET:C118("UserSet")
	Repeat 
		LOAD RECORD:C52([MessagerieVSM:39])
	Until (Not:C34(Locked:C147([MessagerieVSM:39])))
	
	If (i_Confirmer("Suppression de l'info : "+[MessagerieVSM:39]MV_Clé:6))
		DELETE RECORD:C58([MessagerieVSM:39])
	End if 
	UNLOAD RECORD:C212([MessagerieVSM:39])
Else 
	StrAlerte(22; "")
End if 


UNLOAD RECORD:C212([MessagerieVSM:39])
READ ONLY:C145([MessagerieVSM:39])
P_MessagerieVSM