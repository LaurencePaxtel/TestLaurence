//%attributes = {}
If ([GrouPe:36]GP_Numéro:7[[1]]="N")
	[GrouPe:36]GP_Numéro:7:="N"+"_"+String:C10(Uut_Numerote(-><>vaCPT_GpeN); "00000")
Else 
	[GrouPe:36]GP_Numéro:7:="J"+"_"+String:C10(Uut_Numerote(-><>vaCPT_GpeJ); "00000")
End if 