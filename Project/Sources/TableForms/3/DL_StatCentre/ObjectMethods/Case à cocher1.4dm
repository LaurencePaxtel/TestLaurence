If (rNonVérif=1)
	If (Size of array:C274(<>tsC_IDHB)>0)
		If (<>tsC_Clé>0)
			$jj:=<>tsC_Clé
		Else 
			$jj:=1
		End if 
		$ii:=Size of array:C274(<>tsC_IDHB)
		Repeat 
			If (<>tsC_DateVérif{$ii}>!00-00-00!)
				DELETE FROM ARRAY:C228(<>tsC_IDID; $ii)
				DELETE FROM ARRAY:C228(<>tsC_IDHB; $ii)
				DELETE FROM ARRAY:C228(<>tsC_IDGP; $ii)
				DELETE FROM ARRAY:C228(<>tsC_NbPers; $ii)
				DELETE FROM ARRAY:C228(<>tsC_NbJours; $ii)
				DELETE FROM ARRAY:C228(<>tsC_NbChbres; $ii)
				DELETE FROM ARRAY:C228(<>tsC_CoutJour; $ii)
				
				DELETE FROM ARRAY:C228(<>tsC_Cout; $ii)
				DELETE FROM ARRAY:C228(<>tsC_Groupe; $ii)
				DELETE FROM ARRAY:C228(<>tsC_Clé; $ii)
				
				DELETE FROM ARRAY:C228(<>tsC_Date; $ii)
				DELETE FROM ARRAY:C228(<>tsC_DateVérif; $ii)
				DELETE FROM ARRAY:C228(<>tsC_Bon; $ii)
				DELETE FROM ARRAY:C228(<>tsC_DateFin; $ii)
			End if 
			$ii:=$ii-1
		Until ($ii=0)
		<>vl_NbJours:=0
		<>vl_NbChbres:=0
		<>vl_NbPers:=0
		<>vr_CoutJ:=0
		<>vr_Cout:=0
		For ($ii; 1; Size of array:C274(<>tsC_Clé))
			<>vl_NbJours:=<>vl_NbJours+<>tsC_NbJours{$ii}
			<>vl_NbChbres:=<>vl_NbChbres+<>tsC_NbChbres{$ii}
			<>vl_NbPers:=<>vl_NbPers+<>tsC_NbPers{$ii}
			<>vr_CoutJ:=<>vr_CoutJ+<>tsC_CoutJour{$ii}
			<>vr_Cout:=<>vr_Cout+<>tsC_Cout{$ii}
		End for 
		
		
		
		If ($jj>Size of array:C274(<>tsC_Clé))
			$jj:=Size of array:C274(<>tsC_Clé)
		End if 
		
		<>tsC_Clé:=$jj
		
		<>tsC_IDID:=<>tsC_Clé
		<>tsC_IDHB:=<>tsC_Clé
		<>tsC_IDGP:=<>tsC_Clé
		<>tsC_NbPers:=<>tsC_Clé
		<>tsC_NbJours:=<>tsC_Clé
		<>tsC_NbChbres:=<>tsC_Clé
		<>tsC_CoutJour:=<>tsC_Clé
		
		<>tsC_Cout:=<>tsC_Clé
		<>tsC_Groupe:=<>tsC_Clé
		
		<>tsC_Date:=<>tsC_Clé
		<>tsC_DateVérif:=<>tsC_Clé
		<>tsC_Bon:=<>tsC_Clé
		<>tsC_DateFin:=<>tsC_Clé
		
		
	End if 
Else 
	P_Calc_Centre
End if 