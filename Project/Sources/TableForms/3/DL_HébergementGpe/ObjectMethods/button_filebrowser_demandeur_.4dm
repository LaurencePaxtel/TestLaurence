Case of 
	: (Form event code:C388=Sur clic:K2:4)
		outilsHebergeLoadRecord
		
		If ([HeBerge:4]HB_ReferenceID:1>0)
			FileBrowser_open([HeBerge:4]HB_Clé:2)  // #20180511-1
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 