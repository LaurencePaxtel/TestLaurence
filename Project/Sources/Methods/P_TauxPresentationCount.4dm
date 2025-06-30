//%attributes = {}

<>vl_ShowIndice:=Find in array:C230(<>ta_TBEtCiv; [HeberGement:5]HG_EtatCivil:20)
If (<>vl_ShowIndice>0)
	<>tl_ShowDemande{<>vl_ShowIndice}:=<>tl_ShowDemande{<>vl_ShowIndice}+1
	If ([HeberGement:5]HG_Cloturée:67)
		<>tl_ShowHébergé{<>vl_ShowIndice}:=<>tl_ShowHébergé{<>vl_ShowIndice}+1
		
		If ([HeberGement:5]HG_NuitenCours:92=1)
			<>tl_ShowHébergéJ{<>vl_ShowIndice}:=<>tl_ShowHébergéJ{<>vl_ShowIndice}+1
		End if 
	Else 
		<>tl_ShowNonHébergé{<>vl_ShowIndice}:=<>tl_ShowNonHébergé{<>vl_ShowIndice}+1
		If ([HeberGement:5]HG_AutreSolutio:88="115@")
			<>vl_ShowIndice:=Find in array:C230(<>ta_ShowAutreSol; [HeberGement:5]HG_AutreSolutio:88)
			If (<>vl_ShowIndice>0)
				<>tl_ShowAutreSol{<>vl_ShowIndice}:=<>tl_ShowAutreSol{<>vl_ShowIndice}+1
			Else 
				<>vl_ShowIndice:=Size of array:C274(<>ta_ShowAutreSol)+1
				INSERT IN ARRAY:C227(<>ta_ShowAutreSol; <>vl_ShowIndice)
				INSERT IN ARRAY:C227(<>tl_ShowAutreSol; <>vl_ShowIndice)
				INSERT IN ARRAY:C227(<>tr_ShowAutreSol; <>vl_ShowIndice)
				<>ta_ShowAutreSol{<>vl_ShowIndice}:=[HeberGement:5]HG_AutreSolutio:88
				<>tl_ShowAutreSol{<>vl_ShowIndice}:=1
				<>tr_ShowAutreSol{<>vl_ShowIndice}:=0
			End if 
		End if 
	End if 
End if 