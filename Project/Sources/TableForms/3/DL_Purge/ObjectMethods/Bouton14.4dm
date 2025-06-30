
ARRAY LONGINT:C221($tl_Hébérgé; 0)
ARRAY LONGINT:C221($tl_Hébérgement; 0)
C_LONGINT:C283($ii)
C_TEXT:C284($va_EtCv)
C_TEXT:C284($va_Perm)
C_TEXT:C284($va_Coor)
C_TEXT:C284($va_Reg)
C_DATE:C307($vd_Date)

C_LONGINT:C283($vl_Num_HBE)
C_LONGINT:C283($vl_RéfU_HG)

If (Records in table:C83([HeberGement:5])>0)
	CONFIRM:C162("Transférer les informations de la dernière fiche Nuit "+" vers une fiche jour au 31/12/2007."+Char:C90(13)+"Confirmez-vous cette action ?")
	If (OK=1)
		MESSAGES ON:C181
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Nuit:2=True:C214; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<!2008-01-01!)
		MultiSoc_Filter(->[HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			//    REDUIRE SELECTION([HéberGement];50)
			DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_Hébérgé)
			If (Size of array:C274($tl_Hébérgé)>0)
				i_Message("Transfert en cours …")
				If (7=7)
					ARRAY LONGINT:C221($tl_Hébérgement; Size of array:C274($tl_Hébérgé))
					$vd_Date:=!2007-12-31!
					$vl_Num_HBE:=Uut_Numerote115($vd_Date)
					$vl_RéfU_HG:=Uut_NumerotePlus(->[HeberGement:5]; Size of array:C274($tl_Hébérgé))
					
					
					READ WRITE:C146([HeberGement:5])
					For ($ii; 1; Size of array:C274($tl_Hébérgé))
						i_MessageSeul("Transfert en cours  : "+String:C10(Size of array:C274($tl_Hébérgé))+" / "+String:C10($ii))
						
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$tl_Hébérgé{$ii})
						MultiSoc_Filter(->[HeberGement:5])
						ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
						ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
						//FIRST RECORD([HeberGement])
						
						If ([HeberGement:5]HG_Nuit:2=False:C215)
							If (F_VariablesTransite(2; 1; False:C215))
							End if 
							$va_EtCv:=[HeberGement:5]HG_EtatCivil:20
							$va_Perm:=[HeberGement:5]HG_Permanencier:9
							$va_Coor:=[HeberGement:5]HG_Coordinateur:7
							$va_Reg:=[HeberGement:5]HG_Régulateur:8
							UNLOAD RECORD:C212([HeberGement:5])
							
							CREATE RECORD:C68([HeberGement:5])
							MultiSoc_Init_Structure(->[HeberGement:5])
							[HeberGement:5]HG_DateCreationFiche:149:=Current date:C33(*)
							[HeberGement:5]HG_Date:4:=$vd_Date
							[HeberGement:5]HG_HeureAppel:5:=?02:00:00?
							[HeberGement:5]HG_Nuit:2:=False:C215
							[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("J"; [HeberGement:5]HG_Date:4; $vl_Num_HBE)
							$vl_Num_HBE:=$vl_Num_HBE+1
							
							[HeberGement:5]HG_EnAttente:64:=True:C214
							[HeberGement:5]HG_DateDuJour:82:=$vd_Date  //•Date du jour
							[HeberGement:5]HG_AttenteHeur:83:=?10:00:00?  //•Heure courante
							[HeberGement:5]HG_Transmis:65:=False:C215
							[HeberGement:5]HG_PriseCharge:66:=False:C215
							[HeberGement:5]HG_Cloturée:67:=False:C215
							
							[HeberGement:5]HG_EtatCivil:20:=$va_EtCv
							[HeberGement:5]HG_Permanencier:9:=$va_Perm
							[HeberGement:5]HG_Coordinateur:7:=$va_Coor
							[HeberGement:5]HG_Régulateur:8:=$va_Reg
							
							[HeberGement:5]HG_ReferenceID:1:=$vl_RéfU_HG
							$vl_RéfU_HG:=$vl_RéfU_HG+1
							[HeberGement:5]HG_HB_ID:19:=$tl_Hébérgé{$ii}
							
							[HeberGement:5]HG_Réservation:91:=False:C215
							[HeberGement:5]HG_NuitenCours:92:=1
							[HeberGement:5]HG_NuitTOTAL:93:=1
							[HeberGement:5]HG_Reporté:94:=""
							[HeberGement:5]HG_NuitReste:95:=0
							//06/09/2004
							[HeberGement:5]HG_RéservationDateFin:134:=$vd_Date
							
							If (F_VariablesTransite(4; 1; False:C215))
							End if 
							[HeberGement:5]HG_Age:23:=Uut_HébergéAgePlus(->[HeberGement:5]HG_DateNéLe:24; ->[HeberGement:5]HG_Date:4)
							
							[HeberGement:5]HG_GestionCentreNuit:133:="J"
							[HeberGement:5]HG_LS_PiècesIdt:30:="Trans31"
							
							[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
							
							SAVE RECORD:C53([HeberGement:5])
							UNLOAD RECORD:C212([HeberGement:5])
						End if 
					End for 
					
					READ ONLY:C145([HeberGement:5])
					
				End if 
				CLOSE WINDOW:C154
				
			Else 
				ALERT:C41("aucune fiche distincte ")
			End if 
		Else 
			ALERT:C41("aucune fiche nuit ")
		End if 
		MESSAGES OFF:C175
	End if 
End if 