//%attributes = {}

C_TEXT:C284($1)
C_TEXT:C284($va_Titre)
$va_Titre:=""
If ([HeberGement:5]HG_ReferenceID:1>0)
	Va_NoUFicR:=[HeberGement:5]HG_FicheNuméro:3
	Case of 
		: ($1="Absence")
			$va_Titre:="Confirmez-vous l'absence ?"
		: ($1="Annulé")
			$va_Titre:="Confirmez-vous l'annulation ?"
		: ($1="Initial")
			$va_Titre:="Confirmez-vous la réinitialisation ?"
		: ($1="Fin")
			$va_Titre:="Confirmez-vous la fin du report ?"
		: ($1="Reorienté")
			$va_Titre:="Confirmez-vous la réorientation ?"
		: ($1="Excusé")
			$va_Titre:="Confirmez-vous le Retour avant date prévue de l'excusé ?"
		: ($1="Remplaçant")
			$va_Titre:="Confirmez-vous la Sortie avant date du remplaçant ?"
	End case 
	
	If (i_Confirmer($va_Titre))
		
		If ($1="Absence") | ($1="Annulé") | ($1="Fin") | ($1="Excusé") | ($1="Remplaçant")
			Case of 
				: ([HeberGement:5]HG_Réservation:91=False:C215)
					ALERT:C41("La réservation est désactivée !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepR)
					ALERT:C41("Cette fiche a déjà été reportée !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepRE)
					ALERT:C41("Cette fiche a déjà été reportée (excusée) !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepRP)
					ALERT:C41("Cette fiche a déjà été reportée (prologation) !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepF)
					ALERT:C41("Cette fiche a déjà été signalée en fin !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepA)
					ALERT:C41("Cette fiche a déjà été signalée en Absence !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepO)
					ALERT:C41("Cette fiche a déjà été signalée en Réorientation !")
				Else 
					READ WRITE:C146([HeberGement:5])
					QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=Va_NoUFicR)
					If (Records in selection:C76([HeberGement:5])=1)
						If (i_NonVerrou(->[HeberGement:5]))
							[HeberGement:5]HG_Réservation:91:=True:C214
							If ($1="Fin")
								[HeberGement:5]HG_SignalCentre:13:="Fin de report"
								[HeberGement:5]HG_Reporté:94:=<>va_RepF
							End if 
							If (($1="Absence") | ($1="Annulé"))
								[HeberGement:5]HG_SignalCentre:13:="Absence"
								[HeberGement:5]HG_Reporté:94:=<>va_RepA
							End if 
							If ($1="Absence")
								[HeberGement:5]HG_AutreSolutio:88:="Ne s'est pas présentée"
							End if 
							If ($1="Annulé")
								[HeberGement:5]HG_AutreSolutio:88:=""
							End if 
							If ($1="Reorienté")
								[HeberGement:5]HG_SignalCentre:13:="Réorienté"
								[HeberGement:5]HG_AutreSolutio:88:="Réorienté"
								[HeberGement:5]HG_Reporté:94:=<>va_RepO
							End if 
							If ($1="Excusé") & ([HeberGement:5]HG_ER_Excuse:124)
								//[HéberGement]HG_ER_Excuse:=Faux
								[HeberGement:5]HG_ER_DateFin:126:=([DiaLogues:3]DL_Date:2-1)
								[HeberGement:5]HG_ER_NuitTotal:128:=[HeberGement:5]HG_ER_NuitEnCours:127
								[HeberGement:5]HG_ER_NuitReste:129:=0
								[HeberGement:5]HG_AutreSolutio:88:=<>va_RADAutresolution
							End if 
							
							If ($1="Remplaçant") & ([HeberGement:5]HG_ER_Remplaçant:130)
								[HeberGement:5]HG_Reporté:94:=<>va_RepA
								[HeberGement:5]HG_AutreSolutio:88:=<>va_SADAutresolution
							End if 
							[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
							
							SAVE RECORD:C53([HeberGement:5])
							UNLOAD RECORD:C212([HeberGement:5])
						Else 
							UNLOAD RECORD:C212([HeberGement:5])
						End if 
					End if 
					READ ONLY:C145([HeberGement:5])
			End case 
		End if 
		
		If ($1="Initial")
			Case of 
				: ([HeberGement:5]HG_Réservation:91=False:C215)
					ALERT:C41("La réservation est désactivée !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepR)
					ALERT:C41("Cette fiche a déjà été reportée !")
				Else 
					READ WRITE:C146([HeberGement:5])
					QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=Va_NoUFicR)
					If (Records in selection:C76([HeberGement:5])=1)
						If (i_NonVerrou(->[HeberGement:5]))
							[HeberGement:5]HG_Réservation:91:=True:C214
							[HeberGement:5]HG_SignalCentre:13:="Report"
							[HeberGement:5]HG_AutreSolutio:88:=""
							[HeberGement:5]HG_Reporté:94:=""
							[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
							
							SAVE RECORD:C53([HeberGement:5])
							UNLOAD RECORD:C212([HeberGement:5])
						Else 
							UNLOAD RECORD:C212([HeberGement:5])
						End if 
					End if 
					READ ONLY:C145([HeberGement:5])
			End case 
		End if 
		
		P_HébergementReportFind
	End if 
Else 
	StrAlerte(5; "")
End if 
