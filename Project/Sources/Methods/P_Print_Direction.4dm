//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Print_Direction
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

td_ORnb:=0
td_ORJ:=0
td_ORN:=0
td_ORT:=0

td_DrDt:=0
td_DrAjJ:=0
td_DrAjN:=0
td_DrAjT:=0
td_DrOjJ:=0
td_DrOjN:=0
td_DrOjT:=0

td_DrMs:=0
td_DrAmJ:=0
td_DrAmN:=0
td_DrAmT:=0
td_DrOmJ:=0
td_DrOmN:=0
td_DrOmT:=0

C_LONGINT:C283($vlLeNb)
C_LONGINT:C283($vlLeReste)
C_LONGINT:C283($ii)
C_LONGINT:C283($vlLeNbréél)
C_LONGINT:C283($NbLignes)

C_LONGINT:C283($Position01)
C_LONGINT:C283($Position02)


ARRAY DATE:C224(td_DrDtb; 0)
ARRAY LONGINT:C221(td_DrAjJb; 0)
ARRAY LONGINT:C221(td_DrAjNb; 0)
ARRAY LONGINT:C221(td_DrAjTb; 0)
ARRAY LONGINT:C221(td_DrOjJb; 0)
ARRAY LONGINT:C221(td_DrOjNb; 0)
ARRAY LONGINT:C221(td_DrOjTb; 0)
C_LONGINT:C283(vl_NbLigneP)
vl_NbLigneP:=54
C_TEXT:C284(va_QuellesStats)
va_QuellesStats:="DIR"
_O_PAGE SETUP:C299([HeBerge:4]; "DP_Stat_ParDemandeur1")
PRINT SETTINGS:C106
If (OK=1)
	QUERY:C277([DePart:1]; [DePart:1]DP_Param:3=True:C214)
	MultiSoc_Filter(->[DePart:1])
	If (Records in selection:C76([DePart:1])>0)
		
		//Nombre d'orientations par personne
		If (sNbOrHB=1)  //Nombre d'orientations par personne
			vl_NbJ:=Size of array:C274(td_ORnb)
			If (Size of array:C274(td_ORnb)<=vl_NbLigneP)
				FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParDemandeur1")  //[DéPart];"DRStat02")
				PRINT SELECTION:C60([DePart:1]; *)
			Else 
				COPY ARRAY:C226(td_ORT; td_DrAjTb)
				COPY ARRAY:C226(td_ORnb; td_DrOjJb)
				$vlLeNb:=vl_NbJ\vl_NbLigneP
				$vlLeReste:=Mod:C98(vl_NbJ; vl_NbLigneP)
				If ($vlLeReste>0)
					$vlLeNbréél:=$vlLeNb+1
				Else 
					$vlLeNbréél:=$vlLeNb
				End if 
				For ($ii; 1; $vlLeNbréél)
					FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParDemandeur2")  //[DéPart];"DRStat02b")
					PRINT SELECTION:C60([DePart:1]; *)
					If ($ii<$vlLeNbréél)
						$NbLignes:=vl_NbLigneP
					Else 
						$NbLignes:=$vlLeReste
					End if 
					DELETE FROM ARRAY:C228(td_DrAjTb; 1; $NbLignes)
					DELETE FROM ARRAY:C228(td_DrOjJb; 1; $NbLignes)
				End for 
			End if 
		End if   //Nombre d'orientations par personne
		
		If (sNbHOrB=1)  //Nombre de personnes orientées
			vl_NbJ:=Size of array:C274(td_DrDt)
			If (vl_NbJ<=vl_NbLigneP)
				FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParJour1")  //[DéPart];"DRStat03")
				PRINT SELECTION:C60([DePart:1]; *)
			Else 
				COPY ARRAY:C226(td_DrDt; td_DrDtb)
				COPY ARRAY:C226(td_DrAjJ; td_DrAjJb)
				COPY ARRAY:C226(td_DrAjN; td_DrAjNb)
				COPY ARRAY:C226(td_DrAjT; td_DrAjTb)
				COPY ARRAY:C226(td_DrOjJ; td_DrOjJb)
				COPY ARRAY:C226(td_DrOjN; td_DrOjNb)
				COPY ARRAY:C226(td_DrOjT; td_DrOjTb)
				$vlLeNb:=vl_NbJ\vl_NbLigneP
				$vlLeReste:=Mod:C98(vl_NbJ; vl_NbLigneP)
				If ($vlLeReste>0)
					$vlLeNbréél:=$vlLeNb+1
				Else 
					$vlLeNbréél:=$vlLeNb
				End if 
				For ($ii; 1; $vlLeNbréél)
					FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParJour2")  //[DéPart];"DRStat03b")
					PRINT SELECTION:C60([DePart:1]; *)
					If ($ii<$vlLeNbréél)
						$NbLignes:=vl_NbLigneP
					Else 
						$NbLignes:=$vlLeReste
					End if 
					DELETE FROM ARRAY:C228(td_DrDtb; 1; $NbLignes)
					DELETE FROM ARRAY:C228(td_DrAjJb; 1; $NbLignes)
					DELETE FROM ARRAY:C228(td_DrAjNb; 1; $NbLignes)
					DELETE FROM ARRAY:C228(td_DrAjTb; 1; $NbLignes)
					DELETE FROM ARRAY:C228(td_DrOjJb; 1; $NbLignes)
					DELETE FROM ARRAY:C228(td_DrOjNb; 1; $NbLignes)
					DELETE FROM ARRAY:C228(td_DrOjTb; 1; $NbLignes)
				End for 
			End if 
			
			FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParJour3")  //[DéPart];"DRStat04")
			PRINT SELECTION:C60([DePart:1]; *)
		End if   //Nombre de personnes orientées
		
		If (sNbNote=1)
			FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_Rapport")
			PRINT SELECTION:C60([DePart:1]; *)
		End if 
		
	End if 
	
	
	
	If (sNbParHB=1) | (sHGliste=1)
		
		If ((vl_Break<=0) & (vl_Break2<=0))
		Else 
			If (vl_Break2<vl_Break)
				vl_Break2:=vl_Break
			End if 
			SORT ARRAY:C229(<>tsp_NbToutc; <>tsp_NbNc; <>tsp_IDHB; <>tsp_NbJc; <>tsp_NbTout; <>tsp_NbN; <>tsp_NbJ; >)
			$Position01:=0
			$Position02:=0
			$ii:=0
			$vb_Stop:=False:C215
			Repeat 
				$ii:=$ii+1
				// Si (vl_Break>=◊tsp_NbTout{$ii})
				If (vl_Break<=<>tsp_NbToutc{$ii})
					$vb_Stop:=True:C214
				End if 
				$Position01:=$ii
			Until (($vb_Stop) | ($ii=Size of array:C274(<>tsp_NbToutc)))
			$vb_Stop:=False:C215
			$ii:=0
			Repeat 
				$ii:=$ii+1
				If (vl_Break2<<>tsp_NbToutc{$ii})
					$vb_Stop:=True:C214
				End if 
				$Position02:=$ii-1
			Until (($vb_Stop) | ($ii=Size of array:C274(<>tsp_NbToutc)))
			If ($vb_Stop=False:C215)
				$Position02:=Size of array:C274(<>tsp_NbToutc)
			End if 
			CREATE EMPTY SET:C140([HeBerge:4]; "E_HBb")
			For ($ii; $Position01; $Position02)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=<>tsp_IDHB{$ii})
				MultiSoc_Filter(->[HeBerge:4])
				If (Records in selection:C76([HeBerge:4])=1)
					ADD TO SET:C119([HeBerge:4]; "E_HBb")
				End if 
			End for 
			If (Records in set:C195("E_HBb")>0)
				USE SET:C118("E_HBb")
				RELATE MANY SELECTION:C340([HeberGement:5]HG_HB_ID:19)
				If (Records in selection:C76([HeberGement:5])>0)
					CREATE SET:C116([HeberGement:5]; "E_HBTemp1")
					CREATE EMPTY SET:C140([HeberGement:5]; "E_HBTemp2")
					INTERSECTION:C121("E_encours"; "E_HBTemp1"; "E_HBTemp2")
					If (Records in set:C195("E_HBTemp2")>0)
						
						If (sNbParHB=1)
							USE SET:C118("E_HBTemp2")
							SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
							FIRST RECORD:C50([HeberGement:5])
							If (wNom1=1)
								QR REPORT:C197([HeberGement:5]; "Stat01")
							Else 
								QR REPORT:C197([HeberGement:5]; "Stat02")
							End if 
							SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
						End if 
						
						If (sHGliste=1)
							vl_NbHBdx:=0
							vl_NbHBx:=0
							USE SET:C118("E_HBTemp2")
							vl_NbHBx:=Records in set:C195("E_HBTemp2")
							RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
							MultiSoc_Filter(->[HeBerge:4])
							If (Records in selection:C76([HeBerge:4])>0)
								vl_NbHBdx:=Records in selection:C76([HeBerge:4])
								ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
								FIRST RECORD:C50([HeBerge:4])
								If (wNom1=1)
									FORM SET OUTPUT:C54([HeBerge:4]; "HB_Prt_StatAvecNom")  //[HéBergé];"FL_StatDir3")
								Else 
									FORM SET OUTPUT:C54([HeBerge:4]; "HB_Prt_StatSansNom")  //[HéBergé];"FL_StatDir4")
								End if 
								PRINT SELECTION:C60([HeBerge:4])  //;*)
							End if 
						End if 
					End if 
					CLEAR SET:C117("E_HBTemp1")
					CLEAR SET:C117("E_HBTemp2")
				End if 
			End if 
			CLEAR SET:C117("E_HBb")
		End if 
	End if 
End if 