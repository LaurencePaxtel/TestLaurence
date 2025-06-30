$vl_EventFF:=Form event code:C388
Case of 
		
	: ($vl_EventFF=Sur affichage corps:K2:22)
		ve_Nuit:=Num:C11([Maraude:24]MR_Nuit:2)
		ve_Genre:=Num:C11([Maraude:24]MR_Genre:42)
		If ([HeBerge:4]HB_ReferenceID:1>0)
			ve_GenreHB:=Num:C11([HeBerge:4]HG_Genre:39)
		Else 
			ve_GenreHB:=-1
		End if 
		If (Size of array:C274(ta_Champs)>0)
			If (ta_Champs>0)
				Case of 
					: (te_ChampsType{ta_Champs}=Est un champ alpha:K8:1)
						vt_Champs:=tp_Champs{ta_Champs}->
					: (te_ChampsType{ta_Champs}=Est un texte:K8:3)
						If (Length:C16(tp_Champs{ta_Champs}->)>160)
							vt_Champs:=Substring:C12(tp_Champs{ta_Champs}->; 1; 160)+"•••"
						Else 
							vt_Champs:=tp_Champs{ta_Champs}->
						End if 
					: (te_ChampsType{ta_Champs}=Est un numérique:K8:4)
						vt_Champs:=String:C10(tp_Champs{ta_Champs}->)
					: (te_ChampsType{ta_Champs}=Est un entier:K8:5)
						vt_Champs:=String:C10(tp_Champs{ta_Champs}->)
					: (te_ChampsType{ta_Champs}=Est un entier long:K8:6)
						vt_Champs:=String:C10(tp_Champs{ta_Champs}->)
					: (te_ChampsType{ta_Champs}=Est une date:K8:7)
						vt_Champs:=String:C10(tp_Champs{ta_Champs}->)
					: (te_ChampsType{ta_Champs}=Est une heure:K8:8)
						vt_Champs:=Time string:C180(tp_Champs{ta_Champs}->)
					: (te_ChampsType{ta_Champs}=Est un booléen:K8:9)
						vt_Champs:=("Oui"*Num:C11((tp_Champs{ta_Champs}->)))+("Non"*Num:C11((tp_Champs{ta_Champs}->)=False:C215))
					: (te_ChampsType{ta_Champs}=Est une image:K8:10)
						vt_Champs:="Est une image"
					: (te_ChampsType{ta_Champs}=Est une sous table:K8:11)
						vt_Champs:="Est une sous table"
					: (te_ChampsType{ta_Champs}=Est un BLOB:K8:12)
						vt_Champs:="Est un BLOB "
					Else 
						vt_Champs:="Est un ????? "
				End case 
			End if 
		End if 
	: ($vl_EventFF=Sur double clic:K2:5)
		FILTER EVENT:C321
End case 