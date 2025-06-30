//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script : ta_InfoNom
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Size of array:C274(ta_InfoNom)>0)
	If (ta_InfoNom>0)
		$ii:=Num:C11(Substring:C12(ta_InfoNom{ta_InfoNom}; 1; 5))
		vt_InfoTEXTE:=xliff_Get_text_resource($ii)
	Else 
		ta_InfoNom:=0
		vt_InfoTEXTE:=""
	End if 
End if 
REDRAW:C174(vt_InfoTEXTE)