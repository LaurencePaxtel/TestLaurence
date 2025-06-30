var $intervenant_e : cs:C1710.INtervenantsEntity
var $intervenant_es : cs:C1710.INtervenantsSelection

If (Form event code:C388=Sur chargement:K2:1)
	
	If (Is new record:C668([Messagerie:34]))
		MultiSoc_Init_Structure(->[Messagerie:34])
		[Messagerie:34]MS_RéférenceID:1:=Uut_Numerote(->[Messagerie:34])
		[Messagerie:34]MS_Date:2:=Current date:C33
		[Messagerie:34]MS_Heure:3:=Current time:C178
		
		// Modifié par : Scanu Rémy (30/06/2023)
		outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]IN_Login:3; <>User_Actif_Login; ->$intervenant_es)
		outilsOrdaSearchByRefStctre(->$intervenant_es)
		
		Case of 
			: (Current user:C182="apaxtel")
				[Messagerie:34]MS_User:4:=-1
			: ($intervenant_es.length>0)
				[Messagerie:34]MS_User:4:=$intervenant_es.first().IN_RéférenceID
		End case 
		
		[Messagerie:34]MS_Groupe:5:=va_GroupeMes
	End if 
	
	va_UserLeNom:=""
	
	outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]IN_RéférenceID:1; [Messagerie:34]MS_User:4; ->$intervenant_es)
	outilsOrdaSearchByRefStctre(->$intervenant_es)
	
	Case of 
		: ([Messagerie:34]MS_User:4=-1)
			va_UserLeNom:="PAXTEL gestionnaire !"
		: ($intervenant_es.length=1)
			$intervenant_e:=$intervenant_es.first()
			
			If ([Messagerie:34]intervenantID:12=0)
				[Messagerie:34]intervenantID:12:=$intervenant_e.ID
			End if 
			
			va_UserLeNom:=$intervenant_e.nomComplet()
		Else 
			va_UserLeNom:="n'est plus référencé !"
	End case 
	
End if 