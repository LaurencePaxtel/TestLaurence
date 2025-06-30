If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Report des valeurs par défaut ?"))
		[TrancheAge:40]TA_Tranche_0Nombre:1:=9
		[TrancheAge:40]TA_Tranche_1:2:="de 0 jusqu' à  3"
		[TrancheAge:40]TA_Tranche_2:3:="plus de 3 et moins de 18"
		[TrancheAge:40]TA_Tranche_3:4:="plus de 18 jusqu' à 24"
		[TrancheAge:40]TA_Tranche_4:5:="plus de 24 jusqu' à 29"
		[TrancheAge:40]TA_Tranche_5:6:="plus de 29 jusqu' à 39"
		[TrancheAge:40]TA_Tranche_6:7:="plus de 39 jusqu' à 49"
		[TrancheAge:40]TA_Tranche_7:8:="plus de 49 jusqu' à 59"
		[TrancheAge:40]TA_Tranche_8:9:="plus de 59 jusqu' à 69"
		[TrancheAge:40]TA_Tranche_9:10:="plus de 69"
		[TrancheAge:40]TA_TrancheAge_1:11:=3
		[TrancheAge:40]TA_TrancheAge_2:12:=18
		[TrancheAge:40]TA_TrancheAge_3:13:=24
		[TrancheAge:40]TA_TrancheAge_4:14:=29
		[TrancheAge:40]TA_TrancheAge_5:15:=39
		[TrancheAge:40]TA_TrancheAge_6:16:=49
		[TrancheAge:40]TA_TrancheAge_7:17:=59
		[TrancheAge:40]TA_TrancheAge_8:18:=69
		[TrancheAge:40]TA_TrancheAge_9:19:=70
		OBJECT SET VISIBLE:C603(*; "TR@"; True:C214)
	End if 
End if 