//%attributes = {}
READ WRITE:C146([Prolongation:38])

FIRST RECORD:C50([GrouPe:36])
Repeat 
	QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_GP_Référence:2=[GrouPe:36]GP_ReferenceID:1)
	MultiSoc_Filter(->[GroupeHeberges:37])
	If (Records in selection:C76([GroupeHeberges:37])>0)
		FIRST RECORD:C50([GroupeHeberges:37])
		$ii:=[GroupeHeberges:37]GH_HB_Référence:3
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$ii)
		MultiSoc_Filter(->[HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_RéservationDateFin:134; <)
			FIRST RECORD:C50([HeberGement:5])
			$vd_Date:=[HeberGement:5]HG_RéservationDateFin:134
		End if 
		CREATE RECORD:C68([Prolongation:38])
		MultiSoc_Init_Structure(->[Prolongation:38])
		[Prolongation:38]PR_RéférenceID:1:=Uut_Numerote(->[Prolongation:38])
		[Prolongation:38]PR_Date:2:=Current date:C33
		[Prolongation:38]PR_Heure:3:=Current time:C178
		[Prolongation:38]PR_Groupe:4:=True:C214
		[Prolongation:38]PR_GPHB_Référence:5:=[GrouPe:36]GP_ReferenceID:1
		
		[Prolongation:38]PR_RésaDateDébut:6:=$vd_Date
		[Prolongation:38]PR_RésaNbJours:8:=30
		[Prolongation:38]PR_RésaDateFin:7:=$vd_Date+30
		[Prolongation:38]PR_LC_ID:9:=0
		[Prolongation:38]PR_CentreNoms:10:=""
		[Prolongation:38]PR_ProlongationEffectuée:11:=False:C215
		
		SAVE RECORD:C53([Prolongation:38])
		UNLOAD RECORD:C212([Prolongation:38])
	End if 
	NEXT RECORD:C51([GrouPe:36])
Until (End selection:C36([GrouPe:36]))

READ ONLY:C145([Prolongation:38])