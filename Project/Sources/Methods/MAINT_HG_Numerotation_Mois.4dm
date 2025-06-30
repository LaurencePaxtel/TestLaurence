//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/05/20, 11:21:47
// ----------------------------------------------------
// Method: MAINT_HG_Numerotation_Mois
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(vaCPT_115)
C_LONGINT:C283($compteur)

$compteur:=0

READ WRITE:C146([HeberGement:5])
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3%<>ref_soc_active; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4#!00-00-00!)

ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; >)

While (Not:C34(End selection:C36([HeberGement:5])))
	
	vaCPT_115:=<>ref_soc_active+"-"
	
	If ([HeberGement:5]HG_Nuit:2)
		vaCPT_115:=vaCPT_115+"N"
	Else 
		vaCPT_115:=vaCPT_115+"J"
	End if 
	
	vaCPT_115:=vaCPT_115+Substring:C12(String:C10(Year of:C25([HeberGement:5]HG_Date:4); "0000"); 3; 2)+String:C10(Month of:C24([HeberGement:5]HG_Date:4); "00")
	
	If (Substring:C12([HeberGement:5]HG_FicheNuméro:3; 1; 9)#vaCPT_115)
		
		If ([HeberGement:5]HG_Nuit:2)
			[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("N"; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
		Else 
			[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("J"; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
		End if 
		
		SAVE RECORD:C53([HeberGement:5])
		
		$compteur:=$compteur+1
		
	End if 
	
	NEXT RECORD:C51([HeberGement:5])
End while 

ALERT:C41("Opération effectuée avec succès : "+String:C10($compteur)+" ont été traîtées")
