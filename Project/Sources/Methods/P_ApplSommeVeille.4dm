//%attributes = {}
If ([Sommes:48]SM_RéférenceID:1>0)
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
	//CHERCHER([HeberGement];  & ; [HeberGement]HG_Nuit=Faux; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Orientation1:58=([Sommes:48]SM_libellé:5+"@"))
	MultiSoc_Filter(->[HeberGement:5])
	[Sommes:48]SM_Attribués:7:=Records in selection:C76([HeberGement:5])
	[Sommes:48]SM_Reste:9:=[Sommes:48]SM_Capacité:6-[Sommes:48]SM_Attribués:7
	
	vl_TTcapacite:=vl_TTcapacite+[Sommes:48]SM_Capacité:6
	vl_TTattribue:=vl_TTattribue+[Sommes:48]SM_Attribués:7
	vl_TTreste:=vl_TTreste+[Sommes:48]SM_Reste:9
End if 