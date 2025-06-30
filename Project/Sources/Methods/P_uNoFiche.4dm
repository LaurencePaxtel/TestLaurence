//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_uNoFiche
//{          Mercredi 10 Août 2001 à 20:02:24
//{          Modifiée :  Lundi 16 avril 2012 à 16:50:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_TEXT:C284($va_Cas)

i_Message("Recherche en cours…")
Case of 
	: (ta_Champs=Size of array:C274(ta_Champs))
		OBJECT SET ENTERABLE:C238(va_Libellé; False:C215)
		OBJECT SET ENTERABLE:C238(vl_Numéro; False:C215)
	: (ta_ChampsCode{ta_Champs}="T")
		OBJECT SET ENTERABLE:C238(va_Libellé; False:C215)
		OBJECT SET ENTERABLE:C238(vl_Numéro; True:C214)
		$3->:=Records in table:C83(Table:C252(Table:C252(tp_Champs{ta_Champs}))->)
		ALL RECORDS:C47(Table:C252(Table:C252(tp_Champs{ta_Champs}))->)
		ORDER BY:C49(Table:C252(Table:C252(tp_Champs{ta_Champs}))->; tp_Champs{ta_Champs}->; <)
		$4->:=tp_Champs{ta_Champs}->
	Else 
		OBJECT SET ENTERABLE:C238(va_Libellé; True:C214)
		OBJECT SET ENTERABLE:C238(vl_Numéro; True:C214)
		$3->:=0
		$4->:=0
		va_LibelléClé:=""
		va_LibelléClé2:=""
		$va_Cas:="1"
		Case of 
			: (ta_ChampsCode{ta_Champs}="HG")
				va_LibelléClé:="J"
				va_LibelléClé2:="N"
			: (ta_ChampsCode{ta_Champs}="DS")
				va_LibelléClé:=<>va_T_Site+"s"
			: (ta_ChampsCode{ta_Champs}="DE")
				va_LibelléClé:=<>va_T_Site+"é"
			: (ta_ChampsCode{ta_Champs}="DI")
				va_LibelléClé:=<>va_T_Site+"i"
			: (ta_ChampsCode{ta_Champs}="DY")
				va_LibelléClé:=<>va_T_Site+"p"
			: (ta_ChampsCode{ta_Champs}="DM")
				va_LibelléClé:=<>va_T_Site+"m"
			: (ta_ChampsCode{ta_Champs}="MR")
				va_LibelléClé:=<>va_T_Site+"J"
				va_LibelléClé2:=<>va_T_Site+"N"
				
				
			: (ta_ChampsCode{ta_Champs}="GP")
				va_LibelléClé:="J"
				va_LibelléClé2:="N"
				//  ◊vaCPT_GpeJ:="No_GroupeJour"
				//     ◊vaCPT_GpeN:="No_GroupeNuit"
				$va_Cas:="2"
			: (ta_ChampsCode{ta_Champs}="X0")
				va_LibelléClé:="X0"
		End case 
		
		Case of 
			: ($va_Cas="1")
				va_LibelléClé:=va_LibelléClé+Substring:C12([ReferenceUnique:2]RU_Fichier:2; 3)+"@"
				va_LibelléClé2:=va_LibelléClé2+Substring:C12([ReferenceUnique:2]RU_Fichier:2; 3)+"@"
			: ($va_Cas="2")
				va_LibelléClé:=""
				va_LibelléClé2:=""
				If ([ReferenceUnique:2]RU_Fichier:2=<>vaCPT_GpeJ)
					va_LibelléClé:=va_LibelléClé+"J_@"
				End if 
				If ([ReferenceUnique:2]RU_Fichier:2=<>vaCPT_GpeN)
					va_LibelléClé2:=va_LibelléClé2+"N_@"
				End if 
				
		End case 
		
		C_LONGINT:C283($ii)
		$ii:=0
		$kk:=0
		QUERY:C277(Table:C252(Table:C252(tp_Champs{ta_Champs}))->; tp_Champs{ta_Champs}->=va_LibelléClé)
		$ii:=Records in selection:C76(Table:C252(Table:C252(tp_Champs{ta_Champs}))->)
		ORDER BY:C49(Table:C252(Table:C252(tp_Champs{ta_Champs}))->; tp_Champs{ta_Champs}->; <)
		va_LibelléClé:=tp_Champs{ta_Champs}->
		
		Case of 
			: ($va_Cas="1")
				va_LibelléClé:=Substring:C12(va_LibelléClé; Position:C15("-"; va_LibelléClé)+1)
			: ($va_Cas="2")
				va_LibelléClé:=Substring:C12(va_LibelléClé; Position:C15("_"; va_LibelléClé)+1)
		End case 
		
		
		
		If (va_LibelléClé2>"")
			QUERY:C277(Table:C252(Table:C252(tp_Champs{ta_Champs}))->; tp_Champs{ta_Champs}->=va_LibelléClé2)
			$kk:=Records in selection:C76(Table:C252(Table:C252(tp_Champs{ta_Champs}))->)
			ORDER BY:C49(Table:C252(Table:C252(tp_Champs{ta_Champs}))->; tp_Champs{ta_Champs}->; <)
			va_LibelléClé2:=tp_Champs{ta_Champs}->
			Case of 
				: ($va_Cas="1")
					va_LibelléClé2:=Substring:C12(va_LibelléClé2; Position:C15("-"; va_LibelléClé2)+1)
				: ($va_Cas="2")
					va_LibelléClé2:=Substring:C12(va_LibelléClé2; Position:C15("_"; va_LibelléClé2)+1)
			End case 
			
		End if 
		
		Case of 
			: ($va_Cas="1")
				$3->:=$ii+$kk
				
				If (va_LibelléClé2>"")
					If (Num:C11(va_LibelléClé)>Num:C11(va_LibelléClé2))
						$4->:=Num:C11(va_LibelléClé)
					Else 
						$4->:=Num:C11(va_LibelléClé2)
					End if 
				Else 
					$4->:=Num:C11(va_LibelléClé)
				End if 
			: ($va_Cas="2")
				If (va_LibelléClé2>"")
					$3->:=$kk
					$4->:=Num:C11(va_LibelléClé2)
				Else 
					$3->:=$ii
					$4->:=Num:C11(va_LibelléClé)
				End if 
		End case 
		
		
End case 
CLOSE WINDOW:C154