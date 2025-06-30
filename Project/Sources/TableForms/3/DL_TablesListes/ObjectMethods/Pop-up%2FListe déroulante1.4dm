If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_DévTables)>0)
		If (ta_DévTables>0)
			Case of 
				: (ta_DévTables=Size of array:C274(ta_DévTables))
					CANCEL:C270
					Process_Show(<>PR_Genéral)
				: (ta_DévTables=(Size of array:C274(ta_DévTables)-2))
					If (ta_DévTables{ta_DévTables}="Menu général")
						ta_DévTables{ta_DévTables}:="Masquer Menu général"
						Process_Show(<>PR_Genéral)
					Else 
						ta_DévTables{ta_DévTables}:="Menu général"
						Process_Hide(<>PR_Genéral)
					End if 
				: (ta_DévTables=(Size of array:C274(ta_DévTables)-4))
					
					If (ta_DévTables{ta_DévTables}="Appels")
						ta_DévTables{ta_DévTables}:="Fermer Appels"
						Process_Go(-><>PR_Appel; "Go_Appel"; "Appel"; 64)
						//  Process_Show (◊PR_Appel)
					Else 
						ta_DévTables{ta_DévTables}:="Appels"
						POST OUTSIDE CALL:C329(<>PR_Appel)
						//    Process_Hide (◊PR_Appel)
					End if 
					
					
					
					
				: (ta_DévTables=1)
					Process_Go(-><>PR_DévTablesHB; "Go_uTablesHébergés"; "DévTablesHB"; 64)
				: (ta_DévTables=2)
					Process_Go(-><>PR_DévTablesHG; "Go_uTablesHébergements"; "DévTablesHG"; 64)
				: (ta_DévTables=3)
					Process_Go(-><>PR_DévTablesMR; "Go_uTablesMaraudes"; "DévTablesMR"; 64)
				: (ta_DévTables=4)
					Process_Go(-><>PR_DévTablesLC; "Go_uTablesCentres"; "DévTablesLC"; 64)
				: (ta_DévTables=5)
					Process_Go(-><>PR_DévTablesCL; "Go_uTablesCentresLits"; "DévTablesCL"; 64)
				: (ta_DévTables=7)
					Process_Go(-><>PR_DévTablesTType; "Go_uTablesTType"; "DévTablesTType"; 64)
				: (ta_DévTables=8)
					Process_Go(-><>PR_DévTablesTT; "Go_uTablesTT"; "DévTablesTT"; 64)
					
				: (ta_DévTables=10)
					ALERT:C41(ta_DévTables{ta_DévTables}+" : Non implémenté.")
				: (ta_DévTables=11)
					ALERT:C41(ta_DévTables{ta_DévTables}+" : Non implémenté.")
				: (ta_DévTables=12)
					ALERT:C41(ta_DévTables{ta_DévTables}+" : Non implémenté.")
				: (ta_DévTables=13)
					ALERT:C41(ta_DévTables{ta_DévTables}+" : Non implémenté.")
				: (ta_DévTables=14)
					Process_Go(-><>PR_DévTablesDE; "Go_uTablesSanté"; "DévTablesDE"; 64)
					
				: (ta_DévTables=16)
					Process_Go(-><>PR_DévTablesDP; "Go_uTablesDP"; "DévTablesDP"; 64)
				: (ta_DévTables=17)
					Process_Go(-><>PR_DévTablesRU; "Go_uTablesRU"; "DévTablesRU"; 64)
				: (ta_DévTables=18)
					Process_Go(-><>PR_DévTablesDL; "Go_uTablesDL"; "DévTablesDP"; 64)
				: (ta_DévTables=19)
					Process_Go(-><>PR_DévTablesRB; "Go_uTablesRB"; "DévTablesRBP"; 64)
				: (ta_DévTables=20)
					Process_Go(-><>PR_DévTablesAP; "Go_uTablesAP"; "DévTablesAP"; 64)
				: (ta_DévTables=21)
					Process_Go(-><>PR_DévTablesTD; "Go_uTablesDemande"; "DévTablesTD"; 64)
				: (ta_DévTables=22)
					Process_Go(-><>PR_DévTablesRG; "Go_uTablesRG"; "DévTablesRG"; 64)
				: (ta_DévTables=23)
					Process_Go(-><>PR_DévTablesM0; "Go_uTablesMemo"; "DévTablesMO"; 64)
					
					
				: (ta_DévTables=25)
					Process_Go(-><>PR_DévTablesIN; "Go_uTablesIN"; "DévTablesIN"; 64)
				: (ta_DévTables=26)
					Process_Go(-><>PR_DévTablesMP; "Go_uTablesINMPasse"; "DévTablesMP"; 64)
				: (ta_DévTables=28)
					Process_Go(-><>PR_DévTablesDX; "Go_uTablesIndex"; "DévIndex"; 64)
					//ALERTE("Développement en cours !")
					
					
				: (ta_DévTables=30)
					If (<>vb_FenPP)
						i_PPrincipalHide
						ta_DévTables{ta_DévTables}:="Utilisation directe"
						Process_Show(<>PR_Genéral)
					Else 
						i_PPrincipalShow
						ta_DévTables{ta_DévTables}:="Utilisation Menu général"
						Process_Hide(<>PR_Genéral)
					End if 
					//ALERTE(Chaine(◊vl_FenPP)+" : "+Chaine(Num(◊vb_FenPP=Vrai)))
					
				: (ta_DévTables=32)
					Migration_Plateforme
					
				: (ta_DévTables=34)
					Process_Go(-><>PR_BDOS; "Go_BDOS"; "BDO"; 64)
					
					
			End case 
		End if 
	End if 
End if 