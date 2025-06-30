//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_DosSocialVeilleSort
//{
//{          Vendredi 3 mars 2006 à 13:25
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_LONGINT:C283($ii; $ij; $ik)
MESSAGES ON:C181
Case of 
	: ($1=0)  //Déclarer    
		$ii:=3
		ARRAY INTEGER:C220(te_TriSel; $ii)
		ARRAY TEXT:C222(ta_TriRub; $ii)
		ARRAY POINTER:C280(ta_TriRubPtr; $ii)
		ARRAY INTEGER:C220(te_TriSens; $ii)
		
		ta_TriRub{1}:="Numéro de fiche"
		ta_TriRubPtr{1}:=->[DossierSocial:25]DS_FicheNuméro:3
		te_TriSens{1}:=1
		te_TriSel{1}:=1
		ta_TriRub{2}:="Date"
		ta_TriRubPtr{2}:=->[DossierSocial:25]DS_Date:4
		te_TriSens{2}:=1
		te_TriSel{2}:=1
		ta_TriRub{3}:="Nom"
		ta_TriRubPtr{3}:=->[DossierSocial:25]DS_Nom:12
		te_TriSens{3}:=1
		te_TriSel{3}:=1
		
	: ($1=1)  //Paramètres       
		$vl_Fenetre:=i_FenêtreNo(324; 398; 5; "Tri"; 4; "")
		DIALOG:C40([DiaLogues:3]; "DL_DialTri2")
		CLOSE WINDOW:C154($vl_Fenetre)
		If (OK=1)
			P_DosSocialVeilleSort(2)
		End if 
		
	: ($1=2)  //Trier
		$ik:=0
		$ij:=0
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
						ORDER BY:C49([DossierSocial:25]; $ta_TriRubPtr{$ii}->; >; *)
					Else 
						ORDER BY:C49([DossierSocial:25]; $ta_TriRubPtr{$ii}->; <; *)
					End if 
				End if 
			End for 
			ORDER BY:C49([DossierSocial:25])
		End if 
		
End case 