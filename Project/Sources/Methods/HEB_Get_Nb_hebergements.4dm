//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time: 26/09/19, 18:52:02
// ----------------------------------------------------
// Method: HEB_Get_Nb_hebergements
// Description
// 
//
// Parameters
// $1 : HB_ReferenceID
// ----------------------------------------------------


C_LONGINT:C283($0; $1; $nombre)

READ ONLY:C145([HeberGement:5])

If ($1>0)
	SET QUERY DESTINATION:C396(Vers variable:K19:4; $nombre)
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$1; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]Ref_Structure:169=<>ref_soc_active)
	SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
End if 

$0:=$nombre









//C_LONGINT($0)
//C_LONGINT($1)

//READ ONLY([HeberGement])
//If ($1>0)
//QUERY([HeberGement];[HeberGement]HG_HB_ID=$1)
//MultiSoc_Filter (->[HeberGement])
//Else 
//REDUCE SELECTION([HeberGement];0)
//End if 
//$0:=Records in selection([HeberGement])
