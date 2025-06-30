//Script : Go_Actions
C_TEXT:C284($vt_Temp)

$vt_Temp:=F_DonneesDistri

// Modifié par : Scanu Rémy (27/06/2022)
//Process_Go20(-><>PR_HBAction; "Go_HébergementAction"; "Actions"; 0; [HeberGement]HG_HB_ID; "N"; $vt_Temp; [HeberGement]ID)
Go_HébergementAction([HeberGement:5]HG_HB_ID:19; "N"; $vt_Temp)