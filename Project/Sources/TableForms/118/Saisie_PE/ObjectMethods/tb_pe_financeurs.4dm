

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		//C_LONGINT($pos)
		
		//READ ONLY([Financeurs])
		//QUERY([Financeurs];[Financeurs]ID=[Prise_en_Charge]PE_Financeur_ID)
		//MultiSoc_Filter (->[Financeurs])
		
		//$pos:=Find in array(tb_pe_financeurs;[Financeurs]FIN_Code)
		//TRACE
		//If ($pos>0)
		//tb_pe_financeurs:=$pos
		//tb_pe_financeurs{0}:=[Financeurs]FIN_Code
		//End if 
		
		
End case 