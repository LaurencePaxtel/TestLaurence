If (Size of array:C274(ta_Décision_Clé)>0)
	If (ta_Décision_Clé>0)
		<>vl_NoHHisto:=tl_Décision_RéfClé{ta_Décision_Clé}
		
		$ve_Borne:=0
		Case of 
			: (r1=1)  //7 jours
				$ve_Borne:=7
			: (r2=1)  //30 jours
				$ve_Borne:=30
			: (r3=1)  //60 jours
				$ve_Borne:=60
			: (r4=1)  //90 jours
				$ve_Borne:=90
		End case 
		
		If (<>vl_NoHHisto>0)
			Process_Go9(-><>PR_HébergementH; "Go_HébergementHisto"; "Histo"; 32; [DiaLogues:3]DL_Date:2; $ve_Borne)
		End if 
	End if 
End if 
