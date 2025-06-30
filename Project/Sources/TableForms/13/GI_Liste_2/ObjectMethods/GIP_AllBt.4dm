USE SET:C118("E_EnCours")
<>ta_SsTh:=0
va_LibSsTh:="Tous"


ORDER BY:C49([GIP:13]; [GIP:13]GI_Nom:5; >)
FIRST RECORD:C50([GIP:13])
SET WINDOW TITLE:C213(<>Va_Rubrique+" : "+<>Va_Thème+" : "+String:C10(Records in selection:C76([GIP:13])))
