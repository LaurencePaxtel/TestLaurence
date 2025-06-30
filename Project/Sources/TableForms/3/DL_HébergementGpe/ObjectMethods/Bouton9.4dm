var $P_Phone : Pointer

var $heberge_es; $hebergeB_es : cs:C1710.HeBergeSelection
var $hebergement_es : cs:C1710.HeberGementSelection

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		MESSAGES ON:C181
		
		REDUCE SELECTION:C351([HeBerge:4]; 0)
		UNLOAD RECORD:C212([HeBerge:4])
		
		$P_Phone:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "telephone")  // ajouté 20/01/2017
		
		If (va_IDT_Nom>"")
			$heberge_es:=ds:C1482.HeBerge.query("HB_Clé = :1"; (va_IDT_Nom+"@"))
		End if 
		
		If (vd_IDT_NéLe>!00-00-00!)
			
			If (Num:C11($heberge_es.length)>0)
				$heberge_es:=$heberge_es.query("HB_DateNéLe = :1"; vd_IDT_NéLe)
			Else 
				$heberge_es:=ds:C1482.HeBerge.query("HB_DateNéLe = :1"; vd_IDT_NéLe)
			End if 
			
		End if 
		
		If (va_IDT_Pré>"")
			
			If (Num:C11($heberge_es.length)>0)
				$heberge_es:=$heberge_es.query("HB_Prénom = :1"; (va_IDT_Pré+"@"))
			Else 
				$heberge_es:=ds:C1482.HeBerge.query("HB_Prénom = :1"; (va_IDT_Pré+"@"))
			End if 
			
		End if 
		
		If ($P_Phone->#"")
			
			If (Num:C11($heberge_es.length)>0)
				$heberge_es:=$heberge_es.query("HB_Telephone = :1"; $P_Phone->)
			Else 
				$heberge_es:=ds:C1482.HeBerge.query("HB_Telephone = :1"; $P_Phone->)
			End if 
			
		End if 
		
		If (va_IDT_LienFam>"")
			$hebergement_es:=ds:C1482.HeberGement.query("HG_FamClé = :1"; va_IDT_LienFam)
			$hebergeB_es:=$hebergement_es.HG_HB_ID_1_HB_ReferenceID
			
			If (Num:C11($heberge_es.length)>0)
				$heberge_es:=$heberge_es.and($hebergeB_es)
			Else 
				$heberge_es:=$hebergeB_es.copy()
			End if 
			
		End if 
		
		outilsOrdaSearchByRefStctre(->$heberge_es)
		
		USE ENTITY SELECTION:C1513($heberge_es)
		LOAD RECORD:C52([HeBerge:4])
		
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		UNLOAD RECORD:C212([HeBerge:4])
		
		va_NNN:=""
		vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
		
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		vL_Nb_HG_F:=0
		
		MESSAGES OFF:C175
		P_HébergementNotesBt(0)
		
		If (wresMulti=0)
			OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 