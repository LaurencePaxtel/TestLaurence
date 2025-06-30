//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Print_EtudeS1
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
_O_PAGE SETUP:C299([DePart:1]; "DP_Stat_ParRépartition")
PRINT SETTINGS:C106
If (OK=1)
	C_LONGINT:C283(vl_NbLigneP)
	vl_NbLigneP:=50
	READ ONLY:C145([DePart:1])
	QUERY:C277([DePart:1]; [DePart:1]DP_Param:3=True:C214)
	MultiSoc_Filter(->[DePart:1])
	If (Records in selection:C76([DePart:1])>0)
		
		If (sSexe=1) | (sAge=1) | (Size of array:C274(ta_xGroupe)>0)
			FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParSexeAge")  //([DéPart];"DP_EtudeS2")
			PRINT SELECTION:C60([DePart:1]; *)
		End if 
		
		ARRAY TEXT:C222(ta_StdLib; 0)
		ARRAY LONGINT:C221(tl_StdLib; 0)
		ARRAY LONGINT:C221(te_StdLib; 0)
		va_Libel:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{5}  //"Signalement"
		If (sSignal=1) & (vl_NbSig>0)
			$kk:=0
			
			C_LONGINT:C283($ii)
			For ($ii; 1; Size of array:C274(<>ta_TBSglt))
				If (<>te_NbSglt{$ii}>0) | (<>tl_NbSglt{$ii}>0)
					$kk:=$kk+1
					INSERT IN ARRAY:C227(ta_StdLib; $kk)
					INSERT IN ARRAY:C227(tl_StdLib; $kk)
					INSERT IN ARRAY:C227(te_StdLib; $kk)
					ta_StdLib{$kk}:=<>ta_TBSglt{$ii}
					tl_StdLib{$kk}:=<>tl_NbSglt{$ii}
					te_StdLib{$kk}:=<>te_NbSglt{$ii}
				End if 
			End for 
			If (Size of array:C274(ta_StdLib)>0)
				$nbTaille:=Size of array:C274(ta_StdLib)
				If ($nbTaille<=vl_NbLigneP)
					FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParRépartition")  //[DéPart];"DP_EtudeS1")
					PRINT SELECTION:C60([DePart:1]; *)
				Else 
					$vlLeNb:=$nbTaille\vl_NbLigneP
					$vlLeReste:=Mod:C98($nbTaille; vl_NbLigneP)
					If ($vlLeReste>0)
						$vlLeNbréél:=$vlLeNb+1
					Else 
						$vlLeNbréél:=$vlLeNb
					End if 
					For ($ii; 1; $vlLeNbréél)
						FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParRépartition")
						PRINT SELECTION:C60([DePart:1]; *)
						If ($ii<$vlLeNbréél)
							$NbLignes:=vl_NbLigneP
						Else 
							$NbLignes:=$vlLeReste
						End if 
						DELETE FROM ARRAY:C228(ta_StdLib; 1; $NbLignes)
						DELETE FROM ARRAY:C228(tl_StdLib; 1; $NbLignes)
						DELETE FROM ARRAY:C228(te_StdLib; 1; $NbLignes)
					End for 
				End if 
			End if 
		End if 
		
		ARRAY TEXT:C222(ta_StdLib; 0)
		ARRAY LONGINT:C221(tl_StdLib; 0)
		ARRAY LONGINT:C221(te_StdLib; 0)
		va_Libel:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{7}  //"Provenance"
		If (sProv=1) & (vl_NbProv>0)
			$kk:=0
			For ($ii; 1; Size of array:C274(<>ta_TBArr))
				If (<>te_NbArr{$ii}>0) | (<>tl_NbArr{$ii}>0)
					$kk:=$kk+1
					INSERT IN ARRAY:C227(ta_StdLib; $kk)
					INSERT IN ARRAY:C227(tl_StdLib; $kk)
					INSERT IN ARRAY:C227(te_StdLib; $kk)
					ta_StdLib{$kk}:=<>ta_TBArr{$ii}
					tl_StdLib{$kk}:=<>tl_NbArr{$ii}
					te_StdLib{$kk}:=<>te_NbArr{$ii}
				End if 
			End for 
			If (Size of array:C274(ta_StdLib)>0)
				$nbTaille:=Size of array:C274(ta_StdLib)
				If ($nbTaille<=vl_NbLigneP)
					FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParRépartition")
					PRINT SELECTION:C60([DePart:1]; *)
				Else 
					$vlLeNb:=$nbTaille\vl_NbLigneP
					$vlLeReste:=Mod:C98($nbTaille; vl_NbLigneP)
					If ($vlLeReste>0)
						$vlLeNbréél:=$vlLeNb+1
					Else 
						$vlLeNbréél:=$vlLeNb
					End if 
					For ($ii; 1; $vlLeNbréél)
						FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParRépartition")
						PRINT SELECTION:C60([DePart:1]; *)
						If ($ii<$vlLeNbréél)
							$NbLignes:=vl_NbLigneP
						Else 
							$NbLignes:=$vlLeReste
						End if 
						DELETE FROM ARRAY:C228(ta_StdLib; 1; $NbLignes)
						DELETE FROM ARRAY:C228(tl_StdLib; 1; $NbLignes)
						DELETE FROM ARRAY:C228(te_StdLib; 1; $NbLignes)
					End for 
				End if 
			End if 
		End if 
		
		ARRAY TEXT:C222(ta_StdLib; 0)
		ARRAY LONGINT:C221(tl_StdLib; 0)
		ARRAY LONGINT:C221(te_StdLib; 0)
		va_Libel:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{8}  //"Lieu de naissance"
		If (sErrance=1) & (vl_Nbné>0)
			$kk:=0
			For ($ii; 1; Size of array:C274(<>ta_TBGare))
				If (<>te_NbGare{$ii}>0) | (<>tl_NbGare{$ii}>0)
					$kk:=$kk+1
					INSERT IN ARRAY:C227(ta_StdLib; $kk)
					INSERT IN ARRAY:C227(tl_StdLib; $kk)
					INSERT IN ARRAY:C227(te_StdLib; $kk)
					ta_StdLib{$kk}:=<>ta_TBGare{$ii}
					tl_StdLib{$kk}:=<>tl_NbGare{$ii}
					te_StdLib{$kk}:=<>te_NbGare{$ii}
				End if 
			End for 
			If (Size of array:C274(ta_StdLib)>0)
				$nbTaille:=Size of array:C274(ta_StdLib)
				If ($nbTaille<=vl_NbLigneP)
					FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParRépartition")
					PRINT SELECTION:C60([DePart:1]; *)
				Else 
					$vlLeNb:=$nbTaille\vl_NbLigneP
					$vlLeReste:=Mod:C98($nbTaille; vl_NbLigneP)
					If ($vlLeReste>0)
						$vlLeNbréél:=$vlLeNb+1
					Else 
						$vlLeNbréél:=$vlLeNb
					End if 
					For ($ii; 1; $vlLeNbréél)
						FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParRépartition")
						PRINT SELECTION:C60([DePart:1]; *)
						If ($ii<$vlLeNbréél)
							$NbLignes:=vl_NbLigneP
						Else 
							$NbLignes:=$vlLeReste
						End if 
						DELETE FROM ARRAY:C228(ta_StdLib; 1; $NbLignes)
						DELETE FROM ARRAY:C228(tl_StdLib; 1; $NbLignes)
						DELETE FROM ARRAY:C228(te_StdLib; 1; $NbLignes)
					End for 
				End if 
			End if 
		End if 
		
		ARRAY TEXT:C222(ta_StdLib; 0)
		ARRAY LONGINT:C221(tl_StdLib; 0)
		ARRAY LONGINT:C221(te_StdLib; 0)
		va_Libel:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{12}  //"Nationalité"
		If (sNatio=1) & (vl_Nbnatio>0)
			$kk:=0
			For ($ii; 1; Size of array:C274(<>ta_TBNatio))
				If (<>te_NbNatio{$ii}>0) | (<>tl_NbNatio{$ii}>0)
					$kk:=$kk+1
					INSERT IN ARRAY:C227(ta_StdLib; $kk)
					INSERT IN ARRAY:C227(tl_StdLib; $kk)
					INSERT IN ARRAY:C227(te_StdLib; $kk)
					ta_StdLib{$kk}:=<>ta_TBNatio{$ii}
					tl_StdLib{$kk}:=<>tl_NbNatio{$ii}
					te_StdLib{$kk}:=<>te_NbNatio{$ii}
				End if 
			End for 
			If (Size of array:C274(ta_StdLib)>0)
				$nbTaille:=Size of array:C274(ta_StdLib)
				If ($nbTaille<=vl_NbLigneP)
					FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParRépartition")
					PRINT SELECTION:C60([DePart:1]; *)
				Else 
					$vlLeNb:=$nbTaille\vl_NbLigneP
					$vlLeReste:=Mod:C98($nbTaille; vl_NbLigneP)
					If ($vlLeReste>0)
						$vlLeNbréél:=$vlLeNb+1
					Else 
						$vlLeNbréél:=$vlLeNb
					End if 
					For ($ii; 1; $vlLeNbréél)
						FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParRépartition")
						PRINT SELECTION:C60([DePart:1]; *)
						If ($ii<$vlLeNbréél)
							$NbLignes:=vl_NbLigneP
						Else 
							$NbLignes:=$vlLeReste
						End if 
						DELETE FROM ARRAY:C228(ta_StdLib; 1; $NbLignes)
						DELETE FROM ARRAY:C228(tl_StdLib; 1; $NbLignes)
						DELETE FROM ARRAY:C228(te_StdLib; 1; $NbLignes)
					End for 
				End if 
			End if 
		End if 
	End if 
End if 