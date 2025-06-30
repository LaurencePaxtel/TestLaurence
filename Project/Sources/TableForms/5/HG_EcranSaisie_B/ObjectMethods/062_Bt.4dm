C_TEXT:C284($valueAvantModif_t; $valueARechercher_t)
C_BOOLEAN:C305($B_Dummy)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$valueAvantModif_t:=va_CtrLib
		$valueARechercher_t:="@"+va_CtrLib
		
		If (outilsCheckCharacterIsNumber(Substring:C12($valueAvantModif_t; 1; 1))=True:C214) & (outilsCheckCharacterIsNumber(Substring:C12($valueAvantModif_t; 2; 1))=True:C214)
			$valueARechercher_t:=va_CtrLib
		End if 
		
		$B_Dummy:=F_HebergementCible(Num:C11(Not:C34((Macintosh control down:C544) | (Windows Ctrl down:C562))); <>vb_T_ModeCHRS; ("N"*Num:C11([HeberGement:5]HG_Nuit:2=True:C214))+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215)); [HeberGement:5]HG_Cloturée:67; $valueARechercher_t; 0)
		
		// 26/07/2011
		P_Transfert_HBAlors("Libelle")
		
		// Modifié par : Scanu Rémy (31/10/2022)
		va_CtrLib:=$valueAvantModif_t
End case 