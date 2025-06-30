C_LONGINT:C283($vl_Réf)

READ WRITE:C146([Messagerie:34])
ADD RECORD:C56([Messagerie:34]; *)

If (Read only state:C362([Messagerie:34])=False:C215)
	
	If (OK=1)
		$vl_Réf:=[Messagerie:34]MS_RéférenceID:1
	End if 
	
	UNLOAD RECORD:C212([Messagerie:34])
	READ ONLY:C145([Messagerie:34])
End if 

QUERY:C277([Messagerie:34]; [Messagerie:34]MS_Groupe:5=va_GroupeMes; *)
QUERY:C277([Messagerie:34];  & [Messagerie:34]MS_Catégorie:6="")


// Modified by: Scanu Rémy - remy@connect-io.fr (24/02/2021)
MultiSoc_Filter(->[Messagerie:34])

ORDER BY:C49([Messagerie:34]; [Messagerie:34]MS_Date:2; <; *)
ORDER BY:C49([Messagerie:34]; [Messagerie:34]MS_Heure:3; <)

If ($vl_Réf>0)
	SET QUERY DESTINATION:C396(Vers ensemble:K19:2; "MUserSet")
	QUERY:C277([Messagerie:34]; [Messagerie:34]MS_RéférenceID:1=$vl_Réf)
	
	SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
	HIGHLIGHT RECORDS:C656("MUserSet")
End if 