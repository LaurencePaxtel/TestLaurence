CONFIRM:C162("Voulez-vous recopier les valeurs 'Capacité' des centres ?")
If (OK=1)
	UNLOAD RECORD:C212([CentresLits:16])
	READ ONLY:C145([CentresLits:16])
	Rec_CentreLitsConso
	If (Records in selection:C76([CentresLits:16])>0)
		i_Message("Recopie en cours …")
		READ WRITE:C146([CentresLits:16])
		APPLY TO SELECTION:C70([CentresLits:16]; P_MajCapacité)
		UNLOAD RECORD:C212([CentresLits:16])
		READ ONLY:C145([CentresLits:16])
		REDRAW:C174([CentresLits:16])
		CLOSE WINDOW:C154
	End if 
End if 
