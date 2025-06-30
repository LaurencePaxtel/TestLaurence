If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_Champs)>0)
		If (ta_Champs>0)
			
			If (ta_Champs=21)
				
				i_Paramnum(-1)
				
			End if 
			va_Libellé:=""
			vl_Numéro:=0
			vl_NombrePG:=0
			vl_Nombre:=0
			Case of 
				: (ta_Champs=Size of array:C274(ta_Champs))
					ALL RECORDS:C47([ReferenceUnique:2])
					ORDER BY:C49([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2)
					FIRST RECORD:C50([ReferenceUnique:2])
					PREVIOUS RECORD:C110([ReferenceUnique:2])
					vL_Nb_HG_F:=Records in selection:C76([ReferenceUnique:2])
					ta_Champs{0}:=ta_Champs{ta_Champs}
				: (ta_ChampsCode{ta_Champs}="-")
					ta_Champs:=Find in array:C230(ta_Champs; ta_Champs{0})
				: (ta_ChampsCode{ta_Champs}="T")
					QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256(tp_Champs{ta_Champs}))
					ORDER BY:C49([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2; >)
					FIRST RECORD:C50([ReferenceUnique:2])
					PREVIOUS RECORD:C110([ReferenceUnique:2])
					vL_Nb_HG_F:=Records in selection:C76([ReferenceUnique:2])
					ta_Champs{0}:=ta_Champs{ta_Champs}
					
				: (ta_ChampsCode{ta_Champs}="GP")
					QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2="No_Groupe@")
					ORDER BY:C49([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2; >)
					FIRST RECORD:C50([ReferenceUnique:2])
					PREVIOUS RECORD:C110([ReferenceUnique:2])
					vL_Nb_HG_F:=Records in selection:C76([ReferenceUnique:2])
					ta_Champs{0}:=ta_Champs{ta_Champs}
					//  ◊vaCPT_GpeJ:="No_GroupeJour"
					//     ◊vaCPT_GpeN:="No_GroupeNuit"
					
				Else 
					QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=(ta_ChampsCode{ta_Champs}+"@"))
					ORDER BY:C49([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2; >)
					FIRST RECORD:C50([ReferenceUnique:2])
					PREVIOUS RECORD:C110([ReferenceUnique:2])
					vL_Nb_HG_F:=Records in selection:C76([ReferenceUnique:2])
					ta_Champs{0}:=ta_Champs{ta_Champs}
			End case 
		End if 
	End if 
End if 