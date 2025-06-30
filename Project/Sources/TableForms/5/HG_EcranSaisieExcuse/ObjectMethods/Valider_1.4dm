If (Form event code:C388=Sur clic:K2:4)
	
	Case of 
			
		: (([HeberGement:5]HG_ER_Excuse:124) & (Old:C35([HeberGement:5]HG_ER_Excuse:124)=False:C215) & ([HeberGement:5]HG_Cloturée:67))
			
			[HeberGement:5]HG_Cloturée:67:=False:C215
			P_BoolHeureCommute(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
			If ([HeberGement:5]HG_Cloturée:67)
				[HeberGement:5]HG_EnAttente:64:=False:C215
			Else 
				If ([HeberGement:5]HG_Transmis:65=True:C214) | ([HeberGement:5]HG_Cloturée:67=True:C214)
				Else 
					[HeberGement:5]HG_EnAttente:64:=True:C214
				End if 
			End if 
			P_CL_LitsExcusés([HeberGement:5]HG_Date:4; [HeberGement:5]HG_LC_ID:61; -1; va_JourNuit)
			[HeberGement:5]HG_CléFax:69:=Uut_FaxClé(->[HeberGement:5]HG_Date:4; ->[HeberGement:5]HG_Nuit:2; ->[HeberGement:5]HG_Cloturée:67)
			[HeberGement:5]HG_CléFax:69:=[HeberGement:5]HG_CléFax:69+"E"
			[HeberGement:5]HG_AutreSolutio:88:="Excusée du"
			
			[HeberGement:5]HG_AutreSolSuite:123:="Du "+String:C10([HeberGement:5]HG_ER_DateDébut:125; Système date court:K1:1)+" au "+String:C10([HeberGement:5]HG_ER_DateFin:126; Système date court:K1:1)
			ACCEPT:C269
			
			
		: (([HeberGement:5]HG_ER_Excuse:124) & (Old:C35([HeberGement:5]HG_ER_Excuse:124)=True:C214) & ([HeberGement:5]HG_Cloturée:67=False:C215))
			[HeberGement:5]HG_AutreSolutio:88:="Excusée du"
			[HeberGement:5]HG_AutreSolSuite:123:="Du "+String:C10([HeberGement:5]HG_ER_DateDébut:125; Système date court:K1:1)+" au "+String:C10([HeberGement:5]HG_ER_DateFin:126; Système date court:K1:1)
			ACCEPT:C269
			
		: (([HeberGement:5]HG_ER_Excuse:124=False:C215) & (Old:C35([HeberGement:5]HG_ER_Excuse:124)=True:C214) & ([HeberGement:5]HG_Cloturée:67=False:C215))
			
			<>vd_PourExcuseEnCours:=False:C215
			BEEP:C151
			//ALERTE("Remettre le lit !!!!")
			
			Process_Go(-><>PR_HébergementExc; "Go_HébergementExcuserAn"; "HébergementExcuserA"; 64)
			
			Repeat 
				IDLE:C311
			Until (<>vd_PourExcuseEnCours)
			
			[HeberGement:5]HG_ER_DateDébut:125:=!00-00-00!
			[HeberGement:5]HG_ER_DateFin:126:=[HeberGement:5]HG_ER_DateDébut:125
			[HeberGement:5]HG_ER_NuitEnCours:127:=0
			[HeberGement:5]HG_ER_NuitTotal:128:=0
			[HeberGement:5]HG_ER_NuitReste:129:=0
			
			[HeberGement:5]HG_Cloturée:67:=True:C214
			P_BoolHeureCommute(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
			If ([HeberGement:5]HG_Cloturée:67)
				[HeberGement:5]HG_EnAttente:64:=False:C215
			Else 
				If ([HeberGement:5]HG_Transmis:65=True:C214) | ([HeberGement:5]HG_Cloturée:67=True:C214)
				Else 
					[HeberGement:5]HG_EnAttente:64:=True:C214
				End if 
			End if 
			[HeberGement:5]HG_CléFax:69:=Uut_FaxClé(->[HeberGement:5]HG_Date:4; ->[HeberGement:5]HG_Nuit:2; ->[HeberGement:5]HG_Cloturée:67)
			
			
			[HeberGement:5]HG_AutreSolSuite:123:=""
			
			<>vd_PourExcuseEnCours:=True:C214
			$va_LC_Stop:=""
			Case of 
				: (<>vl_PourExcuseRéfCT=-1)
					//Pas de remplaçant
					If ([HeberGement:5]HG_LC_ID:61>0)
					Else 
						//Pas de référence à un centre
						<>vd_PourExcuseEnCours:=False:C215
					End if 
					
				: (<>vl_PourExcuseRéfCT=0)
					If ([HeberGement:5]HG_LC_ID:61>0)
					Else 
						//Pas de référence à un centre
						<>vd_PourExcuseEnCours:=False:C215
					End if 
				: (<>vl_PourExcuseRéfCT>0)
					//Lits remis et annulation d'un remplaçant
					If ([HeberGement:5]HG_LC_ID:61=<>vl_PourExcuseRéfCT)
					Else 
						[HeberGement:5]HG_LC_ID:61:=<>vl_PourExcuseRéfCT
						QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
						MultiSoc_Filter(->[LesCentres:9])
						If (Records in selection:C76([LesCentres:9])=1)
							[HeberGement:5]HG_CentreNom:62:=[LesCentres:9]LC_Nom:4
							[HeberGement:5]HG_CentreARR:63:=[LesCentres:9]LC_Lieu:5
							[HeberGement:5]HG_Médicalisé:56:=[LesCentres:9]LC_LitMédicalis:47
						End if 
					End if 
					
					
			End case 
			If (<>vd_PourExcuseEnCours)
				$va_LC_Stop:=F_CL_LitsDispoAffecter([HeberGement:5]HG_Date:4; [HeberGement:5]HG_LC_ID:61; 1; (("N"*Num:C11([HeberGement:5]HG_Nuit:2))+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215))); 1; 0; (1*Num:C11([HeberGement:5]HG_ER_Remplaçant:130=True:C214)))
				ACCEPT:C269
			Else 
				ALERT:C41("Pas de référence à un centre d'hébergement !")
			End if 
	End case 
End if 
