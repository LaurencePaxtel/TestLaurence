Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT SET ENTERABLE:C238(*; "091_Chp1"; [HeberGement:5]HG_FamChef:103)  // Si fiche d'hébergement appartient à une hébergé désigné comme chef de famille, on rend ce champ saissisable
	: (Form event code:C388=Sur clic:K2:4)
		CONFIRM:C162("Souhaitez-vous vraiment "+Choose:C955([HeberGement:5]HG_ReservationProvisoire:177=False:C215; "ne plus mettre"; "passer")+" cette fiche en réservation provisoire ? (Toutes les fiches postérieures à celle-ci pour tous les membres de la famille le seront également pendant la durée du séjour"+\
			" soit jusqu'au "+String:C10([HeberGement:5]HG_RéservationDateFin:134)+")"; "Oui"; "Non")
		
		If (OK=1)
			Form:C1466.reservationProvisoire:=[HeberGement:5]HG_ReservationProvisoire:177
		Else 
			[HeberGement:5]HG_ReservationProvisoire:177:=Old:C35([HeberGement:5]HG_ReservationProvisoire:177)
		End if 
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (25/08/2022)
		OBJECT SET VISIBLE:C603(*; "Rectangle rond7"; [HeberGement:5]HG_ReservationProvisoire:177)
End case 