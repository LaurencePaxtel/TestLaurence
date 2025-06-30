//%attributes = {}

$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur impression corps:K2:18)
		va_LibRup:=("Total lits médicalisés"*Num:C11([LesCentres:9]LC_LitMédicalis:47=True:C214))+("Total lits non médicalisés"*Num:C11([LesCentres:9]LC_LitMédicalis:47=False:C215))
		vPos:=Find in array:C230(t_CT_ID; [LesCentres:9]LC_RéférenceID:1)
		If (vPos>0)
			vl_1:=t_CT_SHom{vPos}
			vl_2:=t_CT_CHom{vPos}
			vl_3:=t_CT_EHom{vPos}
			vl_4:=t_CT_FHom{vPos}
			vl_5:=t_CT_SFem{vPos}
			vl_6:=t_CT_CFem{vPos}
			vl_7:=t_CT_EFem{vPos}
			vl_8:=t_CT_FFem{vPos}
			vl_9:=t_CT_PMin{vPos}
			vl_10:=t_CT_MMin{vPos}
			vl_11:=t_CT_Total{vPos}
			vl_12:=t_CT_Dis{vPos}
			vl_13:=t_CT_Rest{vPos}
			
			vl_14:=t_CT_Capa{vPos}
			vl_15:=t_CT_DisJ{vPos}
			vl_16:=t_CT_Abs{vPos}
			
			
			vl_17:=t_CT_SGrép{vPos}
			vl_18:=t_CT_SGas{vPos}
			vl_19:=t_CT_SGmd{vPos}
			vl_20:=t_CT_Lat{vPos}
			vl_21:=t_CT_DistA{vPos}
			
			vl_tx1:=vl_tx1+t_CT_SHom{vPos}
			vl_tx2:=vl_tx2+t_CT_CHom{vPos}
			vl_tx3:=vl_tx3+t_CT_EHom{vPos}
			vl_tx4:=vl_tx4+t_CT_FHom{vPos}
			vl_tx5:=vl_tx5+t_CT_SFem{vPos}
			vl_tx6:=vl_tx6+t_CT_CFem{vPos}
			vl_tx7:=vl_tx7+t_CT_EFem{vPos}
			vl_tx8:=vl_tx8+t_CT_FFem{vPos}
			vl_tx9:=vl_tx9+t_CT_PMin{vPos}
			vl_tx10:=vl_tx10+t_CT_MMin{vPos}
			vl_tx11:=vl_tx11+t_CT_Total{vPos}
			vl_tx12:=vl_tx12+t_CT_Dis{vPos}
			vl_tx13:=vl_tx13+t_CT_Rest{vPos}
			
			vl_tx14:=vl_tx14+t_CT_Capa{vPos}
			vl_tx15:=vl_tx15+t_CT_DisJ{vPos}
			vl_tx16:=vl_tx16+t_CT_Abs{vPos}
			
			vl_tx17:=vl_tx17+t_CT_SGrép{vPos}
			vl_tx18:=vl_tx18+t_CT_SGas{vPos}
			vl_tx19:=vl_tx19+t_CT_SGmd{vPos}
			vl_tx20:=vl_tx20+t_CT_Lat{vPos}
			vl_tx21:=vl_tx21+t_CT_DistA{vPos}
			
		Else 
			vl_1:=0
			vl_2:=0
			vl_3:=0
			vl_4:=0
			vl_5:=0
			vl_6:=0
			vl_7:=0
			vl_8:=0
			vl_9:=0
			vl_10:=0
			vl_11:=0
			vl_12:=0
			vl_13:=0
			vl_14:=0
			vl_15:=0
			vl_16:=0
			vl_17:=0
			vl_18:=0
			vl_19:=0
			vl_20:=0
			vl_21:=0
		End if 
		
		If (vl_1<=0)
			_O_OBJECT SET COLOR:C271(vl_1; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_1; -15)
		End if 
		If (vl_2<=0)
			_O_OBJECT SET COLOR:C271(vl_2; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_2; -15)
		End if 
		If (vl_3<=0)
			_O_OBJECT SET COLOR:C271(vl_3; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_3; -15)
		End if 
		If (vl_4<=0)
			_O_OBJECT SET COLOR:C271(vl_4; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_4; -15)
		End if 
		If (vl_5<=0)
			_O_OBJECT SET COLOR:C271(vl_5; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_5; -15)
		End if 
		If (vl_6<=0)
			_O_OBJECT SET COLOR:C271(vl_6; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_6; -15)
		End if 
		If (vl_7<=0)
			_O_OBJECT SET COLOR:C271(vl_7; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_7; -15)
		End if 
		If (vl_8<=0)
			_O_OBJECT SET COLOR:C271(vl_8; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_8; -15)
		End if 
		If (vl_9<=0)
			_O_OBJECT SET COLOR:C271(vl_9; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_9; -15)
		End if 
		If (vl_10<=0)
			_O_OBJECT SET COLOR:C271(vl_10; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_10; -15)
		End if 
		If (vl_11<=0)
			_O_OBJECT SET COLOR:C271(vl_11; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_11; -15)
		End if 
		If (vl_12<=0)
			_O_OBJECT SET COLOR:C271(vl_12; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_12; -15)
		End if 
		If (vl_13<=0)
			_O_OBJECT SET COLOR:C271(vl_13; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_13; -15)
		End if 
		
		If (vl_14<=0)
			_O_OBJECT SET COLOR:C271(vl_14; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_14; -15)
		End if 
		If (vl_15<=0)
			_O_OBJECT SET COLOR:C271(vl_15; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_15; -15)
		End if 
		If (vl_16<=0)
			_O_OBJECT SET COLOR:C271(vl_16; -14)
		Else 
			_O_OBJECT SET COLOR:C271(vl_16; -15)
		End if 
	: ($vl_Event=Sur impression sous total:K2:19)
		
		If (Level:C101=2)
			vl_t1:=vl_tx1
			vl_t2:=vl_tx2
			vl_t3:=vl_tx3
			vl_t4:=vl_tx4
			vl_t5:=vl_tx5
			vl_t6:=vl_tx6
			vl_t7:=vl_tx7
			vl_t8:=vl_tx8
			vl_t9:=vl_tx9
			vl_t10:=vl_tx10
			vl_t11:=vl_tx11
			vl_t12:=vl_tx12
			vl_t13:=vl_tx13
			
			vl_t14:=vl_tx14
			vl_t15:=vl_tx15
			vl_t16:=vl_tx16
			
			vl_t17:=vl_tx17
			vl_t18:=vl_tx18
			vl_t19:=vl_tx19
			vl_t20:=vl_tx20
			vl_t21:=vl_tx21
			
			vl_tx1:=0
			vl_tx2:=0
			vl_tx3:=0
			vl_tx4:=0
			vl_tx5:=0
			vl_tx6:=0
			vl_tx7:=0
			vl_tx8:=0
			vl_tx9:=0
			vl_tx10:=0
			vl_tx11:=0
			vl_tx12:=0
			vl_tx13:=0
			
			vl_tx14:=0
			vl_tx15:=0
			vl_tx16:=0
			
			vl_tx17:=0
			vl_tx18:=0
			vl_tx19:=0
			vl_tx20:=0
			vl_tx21:=0
			
		End if 
	: ($vl_Event=Sur impression pied de page:K2:20)
		vl_Page:=Printing page:C275
End case 