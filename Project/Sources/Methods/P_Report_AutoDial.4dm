//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Report_Auto
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)
C_TIME:C306($2)

If (Records in selection:C76([HeberGement:5])>0)
	
	vd_DateServeur:=!00-00-00!
	vl_CHJx:=0
	vl_CHNx:=0
	va_DateType:=Uut_NumeroteLitsType($1; "J")
	vd_DateServeur:=$1
	
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
	MultiSoc_Filter(->[CentresLits:16])
	vl_CHJx:=Records in selection:C76([CentresLits:16])
	va_DateType:=Uut_NumeroteLitsType([DiaLogues:3]DL_Date:2; "N")
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
	MultiSoc_Filter(->[CentresLits:16])
	vl_CHNx:=Records in selection:C76([CentresLits:16])
	CLOSE WINDOW:C154
	If (vl_CHNx<=0) | (vl_CHNx<=0)
		<>vt_ReportTrans:="Vous devez saisir les disponibilités."
		POST OUTSIDE CALL:C329(<>PR_ReportAUTO)
	Else 
		
		
		
		ARRAY LONGINT:C221(t_HGrepID; 0)
		
		i_Message("Report automatique en cours…")
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; t_HGrepID)
		vl_NoRéfHG:=Uut_Numerote(->[HeberGement:5])
		vl_NoFicheHG:=Uut_Numerote115(vd_DateServeur)
		vl_NoRéfHGNb:=0
		For ($ii; 1; Size of array:C274(t_HGrepID))
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=t_HGrepID{$ii})
			MultiSoc_Filter(->[HeberGement:5])
			If (Records in selection:C76([HeberGement:5])=1)
				Va_NoUFicR:=[HeberGement:5]HG_FicheNuméro:3
				If ([HeberGement:5]HG_Réservation:91) & ([HeberGement:5]HG_Reporté:94="")
					If ([HeberGement:5]HG_NuitReste:95<=0) | ([HeberGement:5]HG_Cloturée:67=False:C215)
						READ WRITE:C146([HeberGement:5])
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=Va_NoUFicR)
						MultiSoc_Filter(->[CentresLits:16])
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
					Else 
						vl_NoRéfHG:=vl_NoRéfHG+1
						vl_NoFicheHG:=vl_NoFicheHG+1
						vl_NoRéfHGNb:=vl_NoRéfHGNb+1
						P_ReportPasse1
						P_ReportPasse2($1; vl_NoRéfHG; vl_NoFicheHG; 1)
						P_ReportPasse3(1)
					End if 
				End if 
			End if 
		End for 
		vl_NoRéfHG:=Uut_NumerotePlus(->[HeberGement:5]; vl_NoRéfHGNb)
		var $vaCPT_115 : Text
		$vaCPT_115:=Storage:C1525.numerotation.vaCPT_115
		vl_NoFicheHG:=Uut_NumerotePlus(->$vaCPT_115; vl_NoRéfHGNb)
		CLOSE WINDOW:C154
	End if 
	ARRAY LONGINT:C221(t_HGrepID; 0)
	
	
	
End if 