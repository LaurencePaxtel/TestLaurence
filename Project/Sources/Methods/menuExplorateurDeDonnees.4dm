//%attributes = {}


If (Current user:C182()="apaxtel")
	$process_Id:=New process:C317("BSPK_ATL"; 0; "Fenetre Bspoke"; {vl_MenuBar: 1})
Else 
	ALERT:C41("Ce menu est uniquement disponible au support.")
End if 
