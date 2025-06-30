If (Records in set:C195("UserSet")=1)
	CREATE SET:C116([Messagerie:34]; "$Etemp")
	USE SET:C118("UserSet")
	READ WRITE:C146([Messagerie:34])
	LOAD RECORD:C52([Messagerie:34])
	MODIFY RECORD:C57([Messagerie:34]; *)
	UNLOAD RECORD:C212([Messagerie:34])
	READ ONLY:C145([Messagerie:34])
	USE SET:C118("$Etemp")
	CLEAR SET:C117("$Etemp")
	
End if 