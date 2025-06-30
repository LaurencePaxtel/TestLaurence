var $vl_EventFF : Integer

var $intervenant_e : cs:C1710.INtervenantsEntity
var $intervenant_es : cs:C1710.INtervenantsSelection

$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur entête:K2:17)
		SET WINDOW TITLE:C213(vaTitreMes+" : "+String:C10(Records in selection:C76([Messagerie:34])))
		
		If (Read only state:C362([Messagerie:34])=False:C215)
			UNLOAD RECORD:C212([Messagerie:34])
			READ ONLY:C145([Messagerie:34])
		End if 
		
	: ($vl_EventFF=Sur chargement:K2:1)
		
		If (Current process:C322=<>PR_Messagerie115)
			OBJECT SET VISIBLE:C603(*; "Flux_@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "Flux_@"; False:C215)
		End if 
		
	: ($vl_EventFF=Sur affichage corps:K2:22)
		outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]IN_RéférenceID:1; [Messagerie:34]MS_User:4; ->$intervenant_es)
		outilsOrdaSearchByRefStctre(->$intervenant_es)
		
		Case of 
			: ([Messagerie:34]MS_User:4=-1)
				va_UserLeNom:="PAXTEL gestionnaire !"
			: ($intervenant_es.length=1)
				$intervenant_e:=$intervenant_es.first()
				va_UserLeNom:=$intervenant_e.nomComplet()
			Else 
				va_UserLeNom:=""
		End case 
		
	: ($vl_EventFF=Sur double clic:K2:5)
		
		If ([Messagerie:34]MS_User:4=<>vl_UserRéfU)
			
			If ([Messagerie:34]MS_Date:2=Current date:C33(*))
				
				If (Read only state:C362([Messagerie:34]))
					READ WRITE:C146([Messagerie:34])
				Else 
					UNLOAD RECORD:C212([Messagerie:34])
					READ ONLY:C145([Messagerie:34])
				End if 
				
			End if 
			
		End if 
		
End case 