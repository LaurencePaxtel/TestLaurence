//%attributes = {}
C_TEXT:C284(va_ASD_Date)
C_DATE:C307(vd_ASD_Date)
C_TEXT:C284(va_ASD_Nom)
C_TEXT:C284(va_ASD_Prén)
C_LONGINT:C283($nbFic)
C_TEXT:C284($aTotFic)
MESSAGES ON:C181
OK:=1
Repeat 
	va_ASD_Date:=Request:C163("Date -17/07/2000: "; "")
	If (OK=1)
		vd_ASD_Date:=Date:C102(va_ASD_Date)
		CONFIRM:C162("Recherche des hébergements du : "+String:C10(vd_ASD_Date))
		If (OK=1)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_ASD_Date)
			MultiSoc_Filter(->[HeberGement:5])
			If (Records in selection:C76([HeberGement:5])>0)
				$aTotFic:=String:C10(Records in selection:C76([HeberGement:5]))
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
				FIRST RECORD:C50([HeberGement:5])
				CREATE EMPTY SET:C140([HeberGement:5]; "EaSupp")
				
				
				va_ASD_Nom:=""
				va_ASD_Prén:=""
				
				i_Message("rechercher en cours …")
				Repeat 
					
					$nbFic:=$nbFic+1
					i_MessageSeul("recherche en cours  : "+String:C10($nbFic)+"/"+$aTotFic)
					If (va_ASD_Nom=[HeberGement:5]HG_Nom:21) & (va_ASD_Prén=[HeberGement:5]HG_Prénom:22)
						ADD TO SET:C119([HeberGement:5]; "EaSupp")
					End if 
					va_ASD_Nom:=[HeberGement:5]HG_Nom:21
					va_ASD_Prén:=[HeberGement:5]HG_Prénom:22
					NEXT RECORD:C51([HeberGement:5])
				Until (End selection:C36([HeberGement:5]))
				CLOSE WINDOW:C154
				ALERT:C41("fiches à supprimer : "+String:C10(Records in set:C195("EaSupp")))
				If (Records in set:C195("EaSupp")>0)
					READ WRITE:C146([HeberGement:5])
					USE SET:C118("EaSupp")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Facture:172=False:C215)
					DELETE SELECTION:C66([HeberGement:5])
					READ ONLY:C145([HeberGement:5])
				End if 
				CLEAR SET:C117("EaSupp")
			End if 
		End if 
	End if 
Until (OK=0)