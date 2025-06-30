//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Report_ManuelPR
//{
//{          Vendredi 17 septembre 2004 à 10:58:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($vb_OK)
ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)

If ([HeberGement:5]HG_ReferenceID:1>0)
	Va_NoUFicR:=[HeberGement:5]HG_FicheNuméro:3
	If (i_Confirmer("Confirmez-vous le report ?"))
		If ([HeberGement:5]HG_ReferenceID:1>0)
			Case of 
				: ([HeberGement:5]HG_Réservation:91=False:C215)
					ALERT:C41("La réservation est désactivée !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepR)
					ALERT:C41("Cette fiche a déjà été reportée !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepF)
					ALERT:C41("Cette fiche a déjà été signalée en fin !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepA)
					ALERT:C41("Cette fiche a déjà été signalée en Absence !")
					//: ([HéberGement]HG_Reporté=◊va_RepO)
					//Alerte ("Cette fiche a déjà été signalée en Réorientation !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepRE)
					ALERT:C41("Cette fiche a déjà été reportée et excusé !")
				: ([HeberGement:5]HG_Reporté:94=<>va_RepRP)
					ALERT:C41("Cette fiche a déjà été reportée par prolongation !")
				Else 
					
					vd_DateServeur:=!00-00-00!
					vd_DateServeur:=[DiaLogues:3]DL_Date:2
					ve_IDT_ProlongTotN:=0
					$vb_OK:=False:C215
					If ([HeberGement:5]HG_NuitenCours:92>=[HeberGement:5]HG_NuitTOTAL:93)
						//Est ce que cette personne qui appartient à un groupe a une prolongation
						
						QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_HB_Référence:3=[HeberGement:5]HG_HB_ID:19)
						If (Records in selection:C76([GroupeHeberges:37])=1)
							QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GroupeHeberges:37]GH_GP_Référence:2)
							If (Records in selection:C76([Prolongation:38])>0)
								QUERY SELECTION:C341([Prolongation:38]; [Prolongation:38]PR_Date:2=[DiaLogues:3]DL_Date:2)
								If (Records in selection:C76([Prolongation:38])=1)
									ve_IDT_ProlongTotN:=[Prolongation:38]PR_RésaNbJours:8
									$vb_OK:=True:C214
								End if 
							End if 
						End if 
						
						If ($vb_OK=False:C215)
							READ WRITE:C146([HeberGement:5])
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=Va_NoUFicR)
							If (Records in selection:C76([HeberGement:5])=1)
								If (i_NonVerrou(->[HeberGement:5]))
									[HeberGement:5]HG_Reporté:94:=<>va_RepF
									[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
									
									SAVE RECORD:C53([HeberGement:5])
									UNLOAD RECORD:C212([HeberGement:5])
								Else 
									UNLOAD RECORD:C212([HeberGement:5])
								End if 
							End if 
							READ ONLY:C145([HeberGement:5])
						End if 
					Else 
						$vb_OK:=True:C214
					End if 
					
					If ($vb_OK)
						vl_NoRéfHG:=Uut_Numerote(->[HeberGement:5])
						vl_NoFicheHG:=Uut_Numerote115(vd_DateServeur)
						vl_NoRéfHGNb:=0
						P_ReportPasse1
						
						//•Est ce une base CHRS  et y a til des fiches reportées :  ici reunir les fiches 
						If (vb_IDT_TransDDASS)
							$vb_OK:=True:C214
							If (<>vb_T_Fiches115)
								$vb_OK:=(va_IDT_TransFiche="")  //25/5/2011 (c'est pas une fiche 115)
							End if 
							
							If ($vb_OK)
								F_Report_FullReporté(->tl_Trans_Réf_HG; vl_NoRéfHG)
							End if 
							If (F_Regional_Refs(->tl_Regional_Réf_HG; vl_NoRéfHG))
							End if 
						End if 
						//FIN ici reunir les fiches reportées
						
						P_ReportPasse2(vd_DateServeur; vl_NoRéfHG; vl_NoFicheHG; 1)
						P_ReportPasse3(1)
						
						//Message sur le déroulement du Report strictement
						$vb_OK:=F_Report_FullDuplexMessage(False:C215; "OK"; "Report manuel P "+"effectué"; "Une Fiche reportée")
						
						
						
						
						//•Est ce une base CHRS  et y a til des fiches reportées
						$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Report manuel P Transfert ")
						$vb_OK:=F_Regional_Transfert(->tl_Regional_Réf_HG; False:C215; "Transfert régional RM")
						
					End if 
			End case 
		End if 
		P_HébergementReportFindPR
	End if 
Else 
	StrAlerte(22; "")
End if 