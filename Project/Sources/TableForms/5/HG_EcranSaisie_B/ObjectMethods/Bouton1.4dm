C_TEXT:C284($va_CasPlateforme)
C_BOOLEAN:C305($vb_OK)

$vb_OK:=([HeberGement:5]HG_NuitenCours:92>1)

If ($vb_OK)
	$va_CasPlateforme:=(" (Avec une nouvelle entrée)"*Num:C11(<>vb_T_PlateformeMod))+(" (En continuité)"*Num:C11(<>vb_T_PlateformeMod=False:C215))
	
	If (i_Confirmer("Confirmez-vous le changement de plateforme de la personne"+$va_CasPlateforme+" ?"))
		
		If (<>vb_T_PlateformeMod)  //06/06/2012
			[HeberGement:5]HG_Réservation:91:=False:C215
			[HeberGement:5]HG_NuitenCours:92:=1
			[HeberGement:5]HG_NuitTOTAL:93:=[HeberGement:5]HG_NuitenCours:92
			[HeberGement:5]HG_NuitReste:95:=0
			
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; False:C215)
			[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
		End if 
		
		[HeberGement:5]HG_Cloturée:67:=False:C215
		P_HG_StatutClôturé(1)
		
		[HeberGement:5]HG_PriseCharge:66:=False:C215
		P_HG_StatutEnCharge
		
		[HeberGement:5]HG_Transmis:65:=False:C215
		P_HG_StatutTransmis
		F_HebergementCible(0; <>vb_T_ModeCHRS; ("N"*Num:C11([HeberGement:5]HG_Nuit:2=True:C214))+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215)); [HeberGement:5]HG_Cloturée:67; va_CtrLib; 0)
		
		[HeberGement:5]HG_FamGroupe:102:=""
		[HeberGement:5]HG_Plateforme:139:=""
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (13/10/2022)
		[HeberGement:5]HG_Trans_DDASS:141:=False:C215
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (26/04/2023)
		[HeberGement:5]HG_Maraude1_2:97:=String:C10([HeberGement:5]HG_Date:4)
		
		//F_Report_FullPlateforme(->[HeberGement]HG_Trans_DDASS; [HeberGement]HG_Plateforme)
		OBJECT SET VISIBLE:C603(*; "141_@"; [HeberGement:5]HG_Trans_DDASS:141)
		
		// Modifié par : Scanu Rémy (20/10/2022) et re-Modifié par : Scanu Rémy (09/11/2022)
		Début_LoadTables("FM Groupe"; -><>ta_FMGrp)
		COPY ARRAY:C226(<>ta_FMGrp; <>ta_FMGrpCHRS)
		
		// Modifié par : Scanu Rémy (08/11/2022)
		va_CtrLib:="@"
	End if 
	
Else 
	ALERT:C41("Ce n'est pas une fiche reportée - c'est la première nuit en cours !")
End if 