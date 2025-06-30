If (Form event code:C388=Sur chargement:K2:1)
	If (7=8)
		OBJECT SET ENTERABLE:C238([CentresLits:16]CL_Capacité:4; False:C215)
		OBJECT SET ENTERABLE:C238([CentresLits:16]CL_DispoTotal:5; False:C215)
		
		OBJECT SET ENTERABLE:C238([CentresLits:16]CL_NbPersonnes:18; False:C215)
		OBJECT SET ENTERABLE:C238([CentresLits:16]CL_NbPersonnesNouvelles:19; False:C215)
		OBJECT SET ENTERABLE:C238([CentresLits:16]CL_NbFamilles:20; False:C215)
		OBJECT SET ENTERABLE:C238([CentresLits:16]CL_NbAdultes:21; False:C215)
		OBJECT SET ENTERABLE:C238([CentresLits:16]CL_NbEnfants:22; False:C215)
	End if 
	If ([CentresLits:16]CL_Niveau:17=1)
		
		_O_OBJECT SET COLOR:C271(*; "Rec_@"; -(Jaune:K11:2+(256*Jaune:K11:2)))
		_O_OBJECT SET COLOR:C271([CentresLits:16]CL_Capacité:4; -(Noir:K11:16+(256*Jaune:K11:2)))
		_O_OBJECT SET COLOR:C271([CentresLits:16]CL_DispoTotal:5; -(Noir:K11:16+(256*Jaune:K11:2)))
		
		_O_OBJECT SET COLOR:C271([CentresLits:16]CL_NbPersonnes:18; -(Noir:K11:16+(256*Jaune:K11:2)))
		_O_OBJECT SET COLOR:C271([CentresLits:16]CL_NbPersonnesNouvelles:19; -(Noir:K11:16+(256*Jaune:K11:2)))
		_O_OBJECT SET COLOR:C271([CentresLits:16]CL_NbFamilles:20; -(Noir:K11:16+(256*Jaune:K11:2)))
		_O_OBJECT SET COLOR:C271([CentresLits:16]CL_NbAdultes:21; -(Noir:K11:16+(256*Jaune:K11:2)))
		_O_OBJECT SET COLOR:C271([CentresLits:16]CL_NbEnfants:22; -(Noir:K11:16+(256*Jaune:K11:2)))
	End if 
End if 