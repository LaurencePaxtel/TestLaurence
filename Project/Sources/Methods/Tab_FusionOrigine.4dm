//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Tab_FusionOrigine
//{
//{          Mercredi 6 avril 2005 à 11:06:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($ii)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(ta_xEtCiv; $2)
		ARRAY INTEGER:C220(te_xEtCiv; $2)
		ARRAY INTEGER:C220(te_xEtCivEtat; $2)
		
	: ($1=1)
		ta_xEtCiv:=$2
		te_xEtCiv:=$2
		te_xEtCivEtat:=$2
		
	: ($1=2)
		COPY ARRAY:C226(<>ta_TBEtCiv; ta_xEtCiv)
		$ii:=Size of array:C274(ta_xEtCiv)
		vl_NbEtCv:=$ii
		ARRAY INTEGER:C220(te_xEtCiv; $ii)
		ARRAY INTEGER:C220(te_xEtCivEtat; $ii)
		For ($ii; 1; Size of array:C274(ta_xEtCiv))
			te_xEtCiv{$ii}:=0
			te_xEtCivEtat{$ii}:=0
		End for 
		Tab_FusionOrigine(1; 0; 0)
		
	: ($1=3)
		For ($ii; 1; Size of array:C274(ta_xEtCiv))
			$jj:=Find in array:C230(ta_FilexEtCiv; ta_xEtCiv{$ii})
			te_xEtCivEtat{$ii}:=Num:C11($jj>0)
		End for 
		
	: ($1=4)
		For ($ii; 1; Size of array:C274(tl_yEtCivRéf))
			te_yEtCivCheck{$ii}:=0
		End for 
		$jj:=0
		If ($2>0)
			$ii:=Find in array:C230(ta_FilexEtCiv; ta_xEtCiv{$2})
			If ($ii>0)
				$jj:=Find in array:C230(ta_yEtCiv; ta_FileEtCiv{$ii})
				If ($jj>0)
					te_yEtCivCheck{$jj}:=1
				End if 
			End if 
		End if 
		
	: ($1=5)  //Tri
		
End case 