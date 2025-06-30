If (Form event code:C388=Sur affichage corps:K2:22)
	If ([Messagerie:34]MS_User:4=-1)
		va_UserLeNom:="PAXTEL gestionnaire !"
	Else 
		QUERY:C277([INtervenants:10]; [INtervenants:10]IN_RéférenceID:1=[Messagerie:34]MS_User:4)
		MultiSoc_Filter(->[INtervenants:10])
		If (Records in selection:C76([INtervenants:10])=1)
			va_UserLeNom:=[INtervenants:10]IN_Nom:4+" "+[INtervenants:10]IN_Prénom:5
		Else 
			va_UserLeNom:="n'est plus référencé !"
		End if 
	End if 
End if 
