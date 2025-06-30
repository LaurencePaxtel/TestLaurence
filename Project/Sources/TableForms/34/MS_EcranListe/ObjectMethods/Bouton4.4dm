
If (vd_DateMess=!00-00-00!)
	vd_DateMess:=Current date:C33
End if 
$va_Date:=Request:C163("Date recherchée ?"; String:C10(vd_DateMess; Interne date court:K1:7))
If (OK=1)
	vd_DateMess:=Date:C102($va_Date)
	
	If (vd_DateMess>!00-00-00!)
		
		QUERY:C277([Messagerie:34]; [Messagerie:34]MS_Groupe:5=va_GroupeMes; *)
		QUERY:C277([Messagerie:34];  & [Messagerie:34]MS_Catégorie:6="")
		MultiSoc_Filter(->[Messagerie:34])
		ORDER BY:C49([Messagerie:34]; [Messagerie:34]MS_Date:2; <; *)
		ORDER BY:C49([Messagerie:34]; [Messagerie:34]MS_Heure:3; <)
		
		SET QUERY DESTINATION:C396(Vers ensemble:K19:2; "MUserSet")
		QUERY:C277([Messagerie:34]; [Messagerie:34]MS_Groupe:5=va_GroupeMes; *)
		QUERY:C277([Messagerie:34];  & [Messagerie:34]MS_Date:2=vd_DateMess; *)
		QUERY:C277([Messagerie:34];  & [Messagerie:34]MS_Catégorie:6="")
		MultiSoc_Filter(->[Messagerie:34])
		SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
		HIGHLIGHT RECORDS:C656("MUserSet")
		
	Else 
		QUERY:C277([Messagerie:34]; [Messagerie:34]MS_Groupe:5=va_GroupeMes; *)
		QUERY:C277([Messagerie:34];  & [Messagerie:34]MS_Catégorie:6="")
		MultiSoc_Filter(->[Messagerie:34])
		ORDER BY:C49([Messagerie:34]; [Messagerie:34]MS_Date:2; <; *)
		ORDER BY:C49([Messagerie:34]; [Messagerie:34]MS_Heure:3; <)
	End if 
End if 