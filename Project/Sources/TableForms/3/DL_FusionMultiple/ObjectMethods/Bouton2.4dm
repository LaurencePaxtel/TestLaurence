//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_VoirHG  
//{
//{          Lundi 28 Juillet 1997 à 17:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Size of array:C274(tl_FU_Référence)>0)
	If (ta_FU_Clé>0)
		CONFIRM:C162("Confirmez-vous le retrait de la liste de fusion de :"+ta_FU_Clé{ta_FU_Clé}+" ?")
		If (OK=1)
			Tab_Fusion(3; ta_FU_Clé; 0)
			P_FusionBt(Num:C11((Size of array:C274(ta_FU_Clé)>0) & (ta_FU_Clé>0)))
		End if 
	Else 
		StrAlerte(22; "")
	End if 
End if 