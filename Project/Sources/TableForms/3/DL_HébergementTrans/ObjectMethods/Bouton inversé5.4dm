
C_BOOLEAN:C305($vb_OK)

If (Form event code:C388=Sur clic:K2:4)
	//P_FaxPrintPlus 
	//   Si (◊vb_T_FullDuplex)
	//   P_TransFullTransfert 
	//    $vb_OK:=F_Trans_FullDuplex 
	//  Sinon 
	//     P_TransTransfert 
	//   Fin de si 
	$vb_OK:=F_Trans_FullDuplex
End if 