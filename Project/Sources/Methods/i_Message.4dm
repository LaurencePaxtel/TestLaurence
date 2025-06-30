//%attributes = {}
//Procédure : i_Message
//Jeudi 2 Novembre 1995 11:10
//Philippe GUEDJ


C_TEXT:C284($1)
If ((Application type:C494=4D Server:K5:6)=False:C215)
	
	C_LONGINT:C283($vl_Fenetre)
	$vl_Fenetre:=i_FenêtreNo(450; 18; -((16*45))-2; "Message SSP™"; 20; "")
	//POSITION MESSAGE(450/Longueur($1);1)
	GOTO XY:C161(5; 5)
	MESSAGE:C88($1)
End if 


