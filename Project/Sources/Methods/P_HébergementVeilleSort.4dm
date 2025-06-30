//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementVeilleSort
//{
//{          Jeudi 19 juillet 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_LONGINT:C283($ii)

If (7=8)
	
	If (Size of array:C274(ta_xTri)>0)
		
		If (ta_xTri>0)
			
			Case of 
				: (ta_xTri=1)  //"> Centre"
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_CentreNom:62; >; *)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3; >)
				: (ta_xTri=2)  //"> Code postal"
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_CodePostal:14; >)
				: (ta_xTri=3)  //"< Date"
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
				: (ta_xTri=4)  //"> Nom"
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >)
				: (ta_xTri=5)  //"> Numéro de fiche"
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3; >)
			End case 
			
		End if 
		
	Else 
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3; >)
	End if 
	
End if 

MESSAGES ON:C181

Case of 
	: ($1=-4)
		//"Date"
		te_TriSens{1}:=1
		te_TriSel{1}:=3
		
		//"Heure"
		te_TriSens{2}:=1
		te_TriSel{2}:=4
		
		//"Centre"
		te_TriSens{3}:=1
		te_TriSel{3}:=0
		
		//"Numéro de fiche"
		te_TriSens{4}:=-1
		te_TriSel{4}:=0
		
		//"Nom"
		te_TriSens{5}:=1
		te_TriSel{5}:=1
		
		//"Prénom"
		te_TriSens{6}:=1
		te_TriSel{6}:=2
		
		//"Né(e) le"
		te_TriSens{7}:=1
		te_TriSel{7}:=0
		
		//"C.P."
		te_TriSens{8}:=1
		te_TriSel{8}:=0
		
		//"Clé de lien familial"
		te_TriSens{9}:=1
		te_TriSel{9}:=0
	: ($1=-3)
		//"Date"
		te_TriSens{1}:=1
		te_TriSel{1}:=0
		
		//"Heure"
		te_TriSens{2}:=1
		te_TriSel{2}:=0
		
		//"Centre"
		te_TriSens{3}:=1
		te_TriSel{3}:=3
		
		//"Numéro de fiche"
		te_TriSens{4}:=-1
		te_TriSel{4}:=0
		
		//"Nom"
		te_TriSens{5}:=1
		te_TriSel{5}:=1
		
		//"Prénom"
		te_TriSens{6}:=1
		te_TriSel{6}:=2
		
		//"Né(e) le"
		te_TriSens{7}:=1
		te_TriSel{7}:=0
		
		//"C.P."
		te_TriSens{8}:=1
		te_TriSel{8}:=0
		
		//"Clé de lien familial"
		te_TriSens{9}:=1
		te_TriSel{9}:=0
	: ($1=-2)
		//"Date"
		te_TriSens{1}:=1
		te_TriSel{1}:=4
		
		//"Heure"
		te_TriSens{2}:=1
		te_TriSel{2}:=5
		
		//"Centre"
		te_TriSens{3}:=1
		te_TriSel{3}:=0
		
		//"Numéro de fiche"
		te_TriSens{4}:=-1
		te_TriSel{4}:=0
		
		//"Nom"
		te_TriSens{5}:=1
		te_TriSel{5}:=2
		
		//"Prénom"
		te_TriSens{6}:=1
		te_TriSel{6}:=3
		
		//"Né(e) le"
		te_TriSens{7}:=1
		te_TriSel{7}:=0
		
		//"C.P."
		te_TriSens{8}:=1
		te_TriSel{8}:=0
		
		//"Clé de lien familial"
		te_TriSens{9}:=1
		te_TriSel{9}:=1
	: ($1=0)
		ARRAY INTEGER:C220(te_TriSel; 9)
		ARRAY TEXT:C222(ta_TriRub; 9)
		ARRAY POINTER:C280(ta_TriRubPtr; 9)
		ARRAY INTEGER:C220(ta_TriRubNo; 9)
		ARRAY INTEGER:C220(te_TriSens; 9)
		
		ta_TriRub{1}:="Date"
		ta_TriRubPtr{1}:=->[HeberGement:5]HG_Date:4
		te_TriSens{1}:=-1
		te_TriSel{1}:=1
		ta_TriRub{2}:="Heure"
		ta_TriRubPtr{2}:=->[HeberGement:5]HG_HeureAppel:5
		te_TriSens{2}:=-1
		te_TriSel{2}:=2
		ta_TriRub{3}:="Centre"
		ta_TriRubPtr{3}:=->[HeberGement:5]HG_CentreNom:62
		te_TriSens{3}:=1
		te_TriSel{3}:=0
		ta_TriRub{4}:="Numéro de fiche"
		ta_TriRubPtr{4}:=->[HeberGement:5]HG_FicheNuméro:3
		te_TriSens{4}:=-1
		te_TriSel{4}:=0
		ta_TriRub{5}:="Nom"
		ta_TriRubPtr{5}:=->[HeberGement:5]HG_Nom:21
		te_TriSens{5}:=1
		te_TriSel{5}:=0
		ta_TriRub{6}:="Prénom"
		ta_TriRubPtr{6}:=->[HeberGement:5]HG_Prénom:22
		te_TriSens{6}:=1
		te_TriSel{6}:=0
		ta_TriRub{7}:="Né(e) le"
		ta_TriRubPtr{7}:=->[HeberGement:5]HG_DateNéLe:24
		te_TriSens{7}:=1
		te_TriSel{7}:=0
		ta_TriRub{8}:="C.P."
		ta_TriRubPtr{8}:=->[HeberGement:5]HG_CodePostal:14
		te_TriSens{8}:=1
		te_TriSel{8}:=0
		ta_TriRub{9}:="Clé de lien familial"
		ta_TriRubPtr{9}:=->[HeberGement:5]HG_FamClé:104
		te_TriSens{9}:=1
		te_TriSel{9}:=0
	: ($1=1)
		C_LONGINT:C283($vl_Fenetre)
		
		$vl_Fenetre:=i_FenêtreNo(324; 398; 5; "Tri"; 4; "")
		DIALOG:C40([DiaLogues:3]; "DL_DialTri2")
		
		CLOSE WINDOW:C154($vl_Fenetre)
		
		If (OK=1)
			P_HébergementVeilleSort(2)
		End if 
		
	: ($1=2)
		$va_sens:=""
		
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
						ORDER BY:C49([HeberGement:5]; $ta_TriRubPtr{$ii}->; >; *)
					Else 
						ORDER BY:C49([HeberGement:5]; $ta_TriRubPtr{$ii}->; <; *)
					End if 
					
				End if 
				
			End for 
			
			ORDER BY:C49([HeberGement:5])
		End if 
		
End case 