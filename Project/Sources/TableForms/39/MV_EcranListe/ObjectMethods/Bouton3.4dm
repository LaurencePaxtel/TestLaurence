READ WRITE:C146([MessagerieVSM:39])
ADD RECORD:C56([MessagerieVSM:39]; *)
If (Read only state:C362([MessagerieVSM:39]))
Else 
	UNLOAD RECORD:C212([MessagerieVSM:39])
	READ ONLY:C145([MessagerieVSM:39])
End if 
P_MessagerieVSM