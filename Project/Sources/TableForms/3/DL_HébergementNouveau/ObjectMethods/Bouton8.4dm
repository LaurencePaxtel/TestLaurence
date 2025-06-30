//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_VoirNotes  
//{
//{          Lundi 28 Juillet 1997 à 17:02:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

<>vt_Trans:=""
If ([HeBerge:4]HB_ReferenceID:1>0)
	<>vt_Trans:=[HeBerge:4]HB_Clé:2
	P_MemoFusion(0; <>ve_MemoFusion; -><>vt_Trans)
	<>vt_Trans:=""
Else 
	StrAlerte(24; "")
End if 