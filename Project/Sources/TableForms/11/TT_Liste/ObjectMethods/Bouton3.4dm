Case of 
	: (Form event code:C388=Sur clic:K2:4)
		// test evenement formulaire ajoute 15/2/17
		
		C_TIME:C306($h_RefDoc)
		$h_RefDoc:=?00:00:00?
		C_TEXT:C284($vt_Message; $vt_Cartouche; $vt_CheminDossier)
		C_DATE:C307($vd_Date)
		C_TIME:C306($vh_Heure)
		C_LONGINT:C283($vl_Nombre)
		C_TEXT:C284($ve_Dummy)
		
		If (Records in set:C195("UserSet")>0)
			$vt_Message:="Exporter les données de "
			$vt_Message:=$vt_Message+String:C10(Records in set:C195("UserSet"))
			$vt_Message:=$vt_Message+" énumération"
			$vt_Message:=$vt_Message+("s"*Num:C11(Records in set:C195("UserSet")>1))
			$vt_Message:=$vt_Message+"."
			$vt_Message:=$vt_Message+<>va_CR
			$vt_Message:=$vt_Message+"Confirmez-vous ?"
			
			If (i_Confirmer($vt_Message))
				CREATE SET:C116([TypesTables:11]; "$E_Encours")
				USE SET:C118("Userset")
				ORDER BY:C49([TypesTables:11]; [TypesTables:11]TT_Libellé:4; >)
				$vt_CheminDossier:=Select folder:C670("Veuillez sélectionner le dossier où exporter les énumérations.")
				If (OK=1)
					$vd_Date:=Current date:C33
					$vh_Heure:=Current time:C178
					$vt_Cartouche:="SSPEnumExport "
					$vt_Cartouche:=$vt_Cartouche+String:C10(Day of:C23($vd_Date); "00")+"/"+String:C10(Month of:C24($vd_Date); "00")+"/"+String:C10(Year of:C25($vd_Date); "0000")
					$vt_Cartouche:=$vt_Cartouche+" à "
					$vt_Cartouche:=$vt_Cartouche+String:C10($vh_Heure; h mn:K7:2)
					$vt_Cartouche:=$vt_Cartouche+<>va_CR
					
					
					//FIRST RECORD([TypesTables])
					Repeat 
						QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_ID:2=[TypesTables:11]TT_RéférenceID:1)
						MultiSoc_Filter(->[TAbles:12])
						If (Records in selection:C76([TAbles:12])>0)
							$vl_Nombre:=Records in selection:C76([TAbles:12])
							ORDER BY:C49([TAbles:12]; [TAbles:12]TB_Code:5; >)
							// /FIRST RECORD([TAbles])
							$vt_Message:=Substring:C12(String:C10(Year of:C25($vd_Date); "0000"); 3; 2)+String:C10(Month of:C24($vd_Date); "00")+String:C10(Day of:C23($vd_Date); "00")+"a"
							$ve_Dummy:=String:C10($vh_Heure; h mn:K7:2)
							$ve_Dummy:=Replace string:C233($ve_Dummy; ":"; "")
							$vt_Message:=$vt_Message+$ve_Dummy
							If (Length:C16([TypesTables:11]TT_Libellé:4)>19)
								$vt_Message:=Substring:C12([TypesTables:11]TT_Libellé:4; 1; 19)+$vt_Message
							Else 
								$vt_Message:=[TypesTables:11]TT_Libellé:4+$vt_Message
							End if 
							$h_RefDoc:=Create document:C266($vt_CheminDossier+$vt_Message)
							If (OK=1)
								USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
								
								$vt_Message:=[TypesTables:11]TT_Libellé:4+<>va_TAB+String:C10([TypesTables:11]TT_RéférenceID:1)+<>va_TAB+String:C10([TypesTables:11]TT_NbNiveaux:2)+<>va_TAB+String:C10([TypesTables:11]TT_Ordre:3)+<>va_CR
								$vt_Message:=$vt_Message+String:C10($vl_Nombre)+<>va_CR
								
								$vt_Message:=$vt_Cartouche+$vt_Message
								
								SEND PACKET:C103($h_RefDoc; $vt_Message)
								Repeat 
									$vt_Message:=[TAbles:12]TB_Libellé:6+<>va_TAB+String:C10([TAbles:12]TB_Niveau:3)+<>va_TAB+String:C10([TAbles:12]TB_Ordre:8)+<>va_TAB+[TAbles:12]TB_Code:5+<>va_CR
									
									
									SEND PACKET:C103($h_RefDoc; $vt_Message)
									NEXT RECORD:C51([TAbles:12])
								Until (End selection:C36([TAbles:12]))
								$vt_Message:="SSPEnumExport FIN"
								SEND PACKET:C103($h_RefDoc; $vt_Message)
								
								USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
								CLOSE DOCUMENT:C267($h_RefDoc)
							End if 
						End if 
						NEXT RECORD:C51([TypesTables:11])
					Until (End selection:C36([TypesTables:11]))
				End if 
				
				CLEAR SET:C117("$E_Encours")
				ORDER BY:C49([TypesTables:11]; [TypesTables:11]TT_Libellé:4; >)
				
			End if 
		Else 
			ALERT:C41("Veuillez sélectionner les énumérations à exporter.")
		End if 
		
End case 



