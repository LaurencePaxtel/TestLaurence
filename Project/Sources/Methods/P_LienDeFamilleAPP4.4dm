//%attributes = {}
vl_LDF_Indice:=vl_LDF_Indice+1
i_MessageSeul("Création des dossiers SIAO : "+String:C10(vl_LDF_Indice)+"/"+String:C10(vl_LDF_Taille))
If ([HeberGement:5]HG_DossierSIAO:164>"") & ([HeberGement:5]HG_FamClé:104>"")
	va_LDF_Cas:=Substring:C12([HeberGement:5]HG_DossierSIAO:164; 1; 1)
	If ((va_LDF_Cas="1") | (va_LDF_Cas="2") | (va_LDF_Cas="3"))
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Personne_ID:3=[HeberGement:5]HG_HB_ID:19)
		MultiSoc_Filter(->[SIAO_Personnes:51])
		If (Records in selection:C76([SIAO_Personnes:51])>0)
		Else 
			Case of 
				: (va_LDF_Cas="1")  //Urgence
					vl_SiaoHG_Cas:=1
					If (F_SIAO_DansHebergement("Conso1et2"; ->vl_SiaoHG_Cas))
					End if 
				: (va_LDF_Cas="2")  //Insertion
					vl_SiaoHG_Cas:=2
					If (F_SIAO_DansHebergement("Conso1et2"; ->vl_SiaoHG_Cas))
					End if 
				: (va_LDF_Cas="3")  //Co-Demandeur
					vl_SiaoHG_Cas:=3
					If (F_SIAO_DansHebergement("Conso4"; ->[HeberGement:5]HG_FamClé:104; ->vl_SiaoHG_Cas))
					End if 
			End case 
		End if 
	End if 
End if 