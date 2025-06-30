//%attributes = {}
C_BOOLEAN:C305($0)
$0:=True:C214

If (va_HGGP_Permanencier="")
	$0:=False:C215
	ALERT:C41("Champ : "+<>ta_RdsNomNew{<>vlSTR_HG-<>vlSTR}{3}+" à renseigner !")
End if 

If ($0=True:C214) & (va_HGGP_Signalement="")
	$0:=False:C215
	ALERT:C41("Champ : "+<>ta_RdsNomNew{<>vlSTR_HG-<>vlSTR}{5}+" à renseigner !")
End if 
If ($0=True:C214) & (va_HGGP_FamGroupe="")
	$0:=False:C215
	ALERT:C41("Champ : "+<>ta_RdsNomNew{<>vlSTR_HG-<>vlSTR}{62}+" à renseigner !")
End if 



If (vb_GroupeFamille)
	If ($0=True:C214) & (vl_HGGP_FamNbP#vl_GroupeNbHG)
		$0:=False:C215
		ALERT:C41("Erreur : "+<>ta_RdsNomNew{<>vlSTR_HG-<>vlSTR}{65}+" à vérifier !")
	End if 
	
End if 

If (7=8)
	If ($0=True:C214) & (va_HGGP_Orientation1="")
		$0:=False:C215
		ALERT:C41("Champ : "+<>ta_RdsNomNew{<>vlSTR_HG-<>vlSTR}{48}+" à renseigner !")
	End if 
	If ($0=True:C214) & (va_HGGP_Orientation2="")
		$0:=False:C215
		ALERT:C41("Champ : "+<>ta_RdsNomNew{<>vlSTR_HG-<>vlSTR}{49}+" à renseigner !")
	End if 
End if 

If (7=8)
	If ([GrouPe:36]GP_Famille:6)
		If ($0=True:C214) & (va_HGGP_FamClé="")
			$0:=False:C215
			ALERT:C41("Champ : "+<>ta_RdsNomNew{<>vlSTR_HG-<>vlSTR}{64}+" à renseigner !")
		End if 
	End if 
End if 
