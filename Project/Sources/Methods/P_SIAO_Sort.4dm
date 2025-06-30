//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_SIAO_Sort
//{          Mercredi 1 décembre 2010 à 10:45:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
Case of 
		
	: ($1=0)
		ARRAY INTEGER:C220(te_TriSel; 3)
		ARRAY TEXT:C222(ta_TriRub; 3)
		ARRAY POINTER:C280(ta_TriRubPtr; 3)
		ARRAY INTEGER:C220(ta_TriRubNo; 3)
		ARRAY INTEGER:C220(te_TriSens; 3)
		ta_TriRub{1}:="Date"
		ta_TriRubPtr{1}:=->[SIAO:50]Si_Demande_Date:2
		te_TriSens{1}:=-1
		te_TriSel{1}:=2
		
		ta_TriRub{2}:="Numéro"
		ta_TriRubPtr{2}:=->[SIAO:50]Si_Demande_Numero:3
		te_TriSens{2}:=1
		te_TriSel{2}:=0
		
		ta_TriRub{3}:="Demandeur"
		ta_TriRubPtr{3}:=->[SIAO:50]Si_Demandeur:20
		te_TriSens{3}:=1
		te_TriSel{3}:=1
		
	: ($1=1)
		C_LONGINT:C283($vl_Fenetre)  // BS ajout 21/12/16
		$vl_Fenetre:=i_FenêtreNo(324; 398; 5; "Tri"; 4; "")
		DIALOG:C40([DiaLogues:3]; "DL_DialTri2")
		CLOSE WINDOW:C154($vl_Fenetre)
		If (OK=1)
			P_SIAO_Sort(2)
		End if 
		
	: ($1=2)
		
		C_LONGINT:C283($ik; $ii)  // BS ajout 21/12/16
		//$va_sens:=""
		$ik:=0
		//$ij:=0
		$ii:=0
		Repeat 
			$ii:=$ii+1
			If (te_TriSel{$ii}>0)
				$ik:=$ik+1
			End if 
		Until ($ik>0) | ($ii=Size of array:C274(te_TriSel))
		
		If ($ik>0)
			COPY ARRAY:C226(te_TriSel; $te_TriSel)
			COPY ARRAY:C226(ta_TriRub; $ta_TriRub)
			COPY ARRAY:C226(ta_TriRubPtr; $ta_TriRubPtr)
			COPY ARRAY:C226(te_TriSens; $te_TriSens)
			SORT ARRAY:C229($te_TriSel; $ta_TriRub; $ta_TriRubPtr; $te_TriSens; >)
			
			For ($ii; 1; Size of array:C274($te_TriSel))
				If ($te_TriSel{$ii}>0)
					If ($te_TriSens{$ii}=1)
						ORDER BY:C49([SIAO:50]; $ta_TriRubPtr{$ii}->; >; *)
					Else 
						ORDER BY:C49([SIAO:50]; $ta_TriRubPtr{$ii}->; <; *)
					End if 
				End if 
			End for 
			ORDER BY:C49([SIAO:50])
		End if 
		
		//
		// TRIER([SIAO];[SIAO]Si_Demandeur;>)
		
End case 