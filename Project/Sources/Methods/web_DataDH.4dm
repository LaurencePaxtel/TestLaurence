//%attributes = {}
//web_DataDH
C_TEXT:C284($0)
ALL RECORDS:C47([PresentationData:45])
MultiSoc_Filter(->[PresentationData:45])
FIRST RECORD:C50([PresentationData:45])
$0:=String:C10([PresentationData:45]PN_Date:1; 3)+" à "+String:C10([PresentationData:45]PN_Heure:11; 2)

