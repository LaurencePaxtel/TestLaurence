//%attributes = {}

If (Size of array:C274(t_TabNiv1)>0)
	If (t_TabNiv1>0)
		
		QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=vPtrT2_R->)
		MultiSoc_Filter(->[TAbles:12])
		If (Records in selection:C76([TAbles:12])>0)
			QUERY SELECTION:C341([TAbles:12]; [TAbles:12]TB_Libellé:6=t_TabNiv1{t_TabNiv1})
			If (Records in selection:C76([TAbles:12])=1)
				$TTNiveau:=Substring:C12([TAbles:12]TB_TT_Niveau:4; 1; 4)+"2"+Substring:C12([TAbles:12]TB_TT_Niveau:4; 6; 4)+"@"
				QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=$TTNiveau)
				MultiSoc_Filter(->[TAbles:12])
				SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; t_TabNiv2)
				SORT ARRAY:C229(t_TabNiv2; >)
				t_TabNiv2:=0
				t_TabNiv2{t_TabNiv2}:=""
			Else 
				ARRAY TEXT:C222(t_TabNiv2; 0)
				t_TabNiv2:=0
			End if 
		Else 
			ARRAY TEXT:C222(t_TabNiv2; 0)
			t_TabNiv2:=0
		End if 
	Else 
		ARRAY TEXT:C222(t_TabNiv2; 0)
		t_TabNiv2:=0
	End if 
End if 