//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HbGpeNewCléfamille
//{
//{          Samedi 18 septembre 2004 à 11:46:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (vb_HGGP_FamC)
	va_HGGP_FamClé:=""
	READ WRITE:C146([HeBerge:4])
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=<>tl_GpHBID{1})
	MultiSoc_Filter(->[HeBerge:4])
	If (Records in selection:C76([HeBerge:4])=1)
		Repeat 
			LOAD RECORD:C52([HeBerge:4])
		Until (Not:C34(Locked:C147([HeBerge:4])))
		If (Not:C34(Locked:C147([HeBerge:4])))
			If ([HeBerge:4]HB_CléFam:47>"")
				
			Else 
				[HeBerge:4]HB_Trans_CléFam:56:=[HeBerge:4]HB_CléFam:47
				[HeBerge:4]HB_CléFam:47:=F_LienDeFamille("Nouveau")
				
				
				SAVE RECORD:C53([HeBerge:4])
			End if 
			va_HGGP_FamClé:=[HeBerge:4]HB_CléFam:47
		End if 
	End if 
	UNLOAD RECORD:C212([HeBerge:4])
	READ ONLY:C145([HeBerge:4])
End if 