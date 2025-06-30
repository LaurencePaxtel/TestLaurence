var $process_el : Integer

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$position_o:=New object:C1471("ecartHautEcran"; 30; "ecartBasEcran"; 70)
		$process_el:=New process:C317("outilsCreateWindowsForm"; 0; "Fenêtre 4D Write Pro"; "DL_DocWPro"; ->$position_o; New object:C1471; ->[DiaLogues:3])
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 