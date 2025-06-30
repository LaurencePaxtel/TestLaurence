//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Transfert
//{
//{          Vendrdi 23 février 2007 à 17:02:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)

Case of 
	: ($1=1)
		
		If ([HeberGement:5]HG_NuitenCours:92=1)
			<>vt_TransHisto:=""
			<>vl_NoHHisto:=[HeberGement:5]HG_HB_ID:19
			
			
			If (<>vl_NoHHisto>0)
				
				If (<>PR_HébergementH=0)
					<>PR_HébergementH:=New process:C317("Go_HébergementHisto"; 0; "Histo"; !00-00-00!; -100)
				Else 
					POST OUTSIDE CALL:C329(<>PR_HébergementH)
				End if 
				
				//  Process_Go9 (->◊PR_HébergementH;"Go_HébergementHisto";"Histo";32;!00/00/00!;-1
				
				Repeat 
					IDLE:C311
				Until (<>PR_HébergementH=0)
			End if 
			If (<>vt_TransHisto>"")
				READ WRITE:C146([HeBerge:4])
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
				MultiSoc_Filter(->[HeBerge:4])
				If (Records in selection:C76([HeBerge:4])=1)
					LOAD RECORD:C52([HeBerge:4])
					If (Not:C34(Locked:C147([HeBerge:4])))
						[HeBerge:4]HB_NotesTrans:53:=<>vt_TransHisto  //+◊va_CR+[HéBergé]HG_NotesTrans
						SAVE RECORD:C53([HeBerge:4])
					Else 
						Case of 
							: ((<>PR_HBAction#0) | (<>PR_HBActionV#0))
								ALERT:C41("Veuillez au préalable fermer la fiche 'Actions'.")
							: ((<>PR_HBST#0) | (<>PR_HBSTV#0) | (<>PR_HBSP#0))
								ALERT:C41("Veuillez au préalable fermer la fiche SP.")
							Else 
								ALERT:C41("La fiche 'Notes' est momentanément inaccessible.")
						End case 
					End if 
				End if 
			End if 
		End if 
End case 
