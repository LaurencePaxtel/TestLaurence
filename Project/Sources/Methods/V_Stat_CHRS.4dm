//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : V_Stat_CHRS
//{
//{          Mercredi 28 janvier 2009 à 17:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

Case of 
	: ($1=0)  //•••••••••••••••••••Déclaration    
		C_DATE:C307(vd_Date1; vd_Date2)
		
		vd_Date1:=!00-00-00!
		vd_Date2:=!00-00-00!
		
		C_LONGINT:C283(vl_NbJ)
		
		vl_NbJ:=0
		
		C_TEXT:C284(vt_StTexte)
		C_LONGINT:C283(vl_NbHBd)
		
		vl_NbHBd:=0
		
		C_LONGINT:C283(vl_NbHom)
		C_LONGINT:C283(vl_NbFem)
		
		vl_NbHom:=0
		vl_NbFem:=0
		
		C_LONGINT:C283(vl_Tab1)
		C_LONGINT:C283(vl_Tab2)
		C_LONGINT:C283(vl_Tab3)
		C_LONGINT:C283(vl_Tab4)
		C_LONGINT:C283(vl_Tab5)
		
		vl_Tab1:=0
		vl_Tab2:=0
		vl_Tab3:=0
		vl_Tab4:=0
		vl_Tab5:=0
		
		C_BOOLEAN:C305(vb_EtCivRegroupé)
		C_BOOLEAN:C305(vb_CentreRegroupé)
		C_BOOLEAN:C305(vb_PrestaRegroupé)
		
		C_LONGINT:C283(vl_lit_At)
		C_LONGINT:C283(vl_lit_Dist)
		C_LONGINT:C283(vl_lit_Rest)
		
		C_REAL:C285(vr_lit_Pc)
		
		vl_lit_At:=0
		vl_lit_Dist:=0
		vl_lit_Rest:=0
		vr_lit_Pc:=0
		
		
		C_LONGINT:C283(vl_HG_Appels)
		C_LONGINT:C283(vl_HG_AppelsJour)
		C_LONGINT:C283(vl_HG_AppelsJourClo)
		
		//••••••••••••     Etat civil
		vl_Tab1:=0
		
		ARRAY TEXT:C222(ta_ET_EtcivGroupe; vl_Tab1)
		ARRAY LONGINT:C221(tl_ET_EtcivGroupe; vl_Tab1)
		
		ARRAY TEXT:C222(ta_ET_EtcivLienGroupe; vl_Tab1)
		ARRAY TEXT:C222(ta_ET_EtcivLienOrigine; vl_Tab1)
		
		ARRAY LONGINT:C221(tl_ET_Dem; vl_Tab1)
		ARRAY REAL:C219(tr_ET_DemPc; vl_Tab1)
		
		ARRAY LONGINT:C221(tl_ET_Dis; vl_Tab1)
		ARRAY REAL:C219(tr_ET_DisPc; vl_Tab1)
		
		ARRAY LONGINT:C221(tl_ET_Med; vl_Tab1)
		ARRAY REAL:C219(tr_ET_MedPc; vl_Tab1)
		
		C_LONGINT:C283(vl_ET_Dem)
		C_REAL:C285(vr_ET_DemPc)
		C_LONGINT:C283(vl_ET_Dis)
		C_REAL:C285(vr_ET_DisPc)
		C_LONGINT:C283(vl_ET_Med)
		C_REAL:C285(vr_ET_MedPc)
		
		vl_ET_Dem:=0
		vr_ET_DemPc:=0
		vl_ET_Dis:=0
		vr_ET_DisPc:=0
		vl_ET_Med:=0
		vr_ET_MedPc:=0
		
		//••••••••••••     Centres
		vl_Tab2:=0
		
		ARRAY TEXT:C222(ta_LC_Centre; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_Centre; vl_Tab2)
		
		ARRAY BOOLEAN:C223(tb_LC_CentreR; vl_Tab2)
		
		ARRAY TEXT:C222(ta_LC_CentreLien; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_CentreLien; vl_Tab2)
		
		ARRAY LONGINT:C221(tl_LC_SHom; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_CHom; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_EHom; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_FHom; vl_Tab2)
		
		ARRAY LONGINT:C221(tl_LC_SFem; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_CFem; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_EFem; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_FFem; vl_Tab2)
		
		ARRAY LONGINT:C221(tl_LC_PMin; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_MMin; vl_Tab2)
		
		
		ARRAY LONGINT:C221(tl_LC_Total; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_Dis; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_Rest; vl_Tab2)
		ARRAY REAL:C219(tr_LC_TauxOccup; vl_Tab2)
		
		C_LONGINT:C283(vl_LC_SHom)
		C_LONGINT:C283(vl_LC_CHom)
		C_LONGINT:C283(vl_LC_EHom)
		C_LONGINT:C283(vl_LC_FHom)
		
		C_LONGINT:C283(vl_LC_SFem)
		C_LONGINT:C283(vl_LC_CFem)
		C_LONGINT:C283(vl_LC_EFem)
		C_LONGINT:C283(vl_LC_FFem)
		
		C_LONGINT:C283(vl_LC_PMin)
		C_LONGINT:C283(vl_LC_MMin)
		
		C_LONGINT:C283(vl_LC_Total)
		C_LONGINT:C283(vl_LC_Dis)
		C_LONGINT:C283(vl_LC_Rest)
		C_REAL:C285(vr_LC_TauxOccup)
		
		vl_LC_SHom:=0
		vl_LC_CHom:=0
		vl_LC_EHom:=0
		vl_LC_FHom:=0
		
		vl_LC_SFem:=0
		vl_LC_CFem:=0
		vl_LC_EFem:=0
		vl_LC_FFem:=0
		
		vl_LC_PMin:=0
		vl_LC_MMin:=0
		
		vl_LC_Total:=0
		vl_LC_Dis:=0
		vl_LC_Rest:=0
		
		vr_LC_TauxOccup:=0
		
		//••••••••••••     Prestations
		vl_Tab3:=0
		
		ARRAY TEXT:C222(ta_LC_Presta; vl_Tab3)
		ARRAY TEXT:C222(ta_LC_PrestaLien; vl_Tab3)
		
		ARRAY LONGINT:C221(tl_LC_Presta; vl_Tab3)
		ARRAY LONGINT:C221(tl_LC_PrestaLien; vl_Tab3)
		ARRAY LONGINT:C221(tl_LC_PrestaNb; vl_Tab3)
		
		C_LONGINT:C283(vl_LC_PrestaNb)
		
		vl_LC_PrestaNb:=0
		
		//••••••••••••     Signl
		vl_Tab4:=0
		
		ARRAY TEXT:C222(ta_xTBSglt; vl_Tab4)
		
		ARRAY LONGINT:C221(tl_xNbSgltJ; vl_Tab4)
		ARRAY LONGINT:C221(tl_xNbSgltJC; vl_Tab4)
		ARRAY LONGINT:C221(tl_xNbSgltN; vl_Tab4)
		ARRAY LONGINT:C221(tl_xNbSgltT; vl_Tab4)
		
		C_LONGINT:C283(vl_xNbSgltJ; vl_xNbSgltJC; vl_xNbSgltN; vl_xNbSgltT)
		
		vl_xNbSgltJ:=0
		vl_xNbSgltJC:=0
		vl_xNbSgltN:=0
		vl_xNbSgltT:=0
		
		//••••••••••••     Pièces d'Identité
		vl_Tab5:=0
		
		ARRAY TEXT:C222(ta_xTBPIdté; vl_Tab5)
		
		ARRAY LONGINT:C221(tl_xNbIdtéJ; vl_Tab5)
		ARRAY LONGINT:C221(tl_xNbIdtéJC; vl_Tab5)
		ARRAY LONGINT:C221(tl_xNbIdtéN; vl_Tab5)
		ARRAY LONGINT:C221(tl_xNbIdtéT; vl_Tab5)
		
		C_LONGINT:C283(vl_xNbIdtéJ; vl_xNbIdtéJC; vl_xNbIdtéN; vl_xNbIdtéT)
		
		vl_xNbIdtéJ:=0
		vl_xNbIdtéJC:=0
		vl_xNbIdtéN:=0
		vl_xNbIdtéT:=0
	: ($1=1)  //•••••••••••••••••••Mise à zéro
		vl_lit_At:=0
		vl_lit_Dist:=0
		vl_lit_Rest:=0
		vr_lit_Pc:=0
		
		//••••••••••••     Etat civil
		vl_Tab1:=Size of array:C274(ta_ET_EtcivGroupe)
		ARRAY LONGINT:C221(tl_ET_Dem; vl_Tab1)
		ARRAY REAL:C219(tr_ET_DemPc; vl_Tab1)
		ARRAY LONGINT:C221(tl_ET_Dis; vl_Tab1)
		ARRAY REAL:C219(tr_ET_DisPc; vl_Tab1)
		ARRAY LONGINT:C221(tl_ET_Med; vl_Tab1)
		ARRAY REAL:C219(tr_ET_MedPc; vl_Tab1)
		
		C_LONGINT:C283($ii)
		
		For ($ii; 1; vl_Tab1)
			tl_ET_Dem{$ii}:=0
			tr_ET_DemPc{$ii}:=0
			tl_ET_Dis{$ii}:=0
			tr_ET_DisPc{$ii}:=0
			tl_ET_Med{$ii}:=0
			tr_ET_MedPc{$ii}:=0
		End for 
		
		vl_ET_Dem:=0
		vr_ET_DemPc:=0
		vl_ET_Dis:=0
		vr_ET_DisPc:=0
		vl_ET_Med:=0
		vr_ET_MedPc:=0
		
		//••••••••••••     Centres
		vl_Tab2:=Size of array:C274(ta_LC_Centre)
		
		ARRAY BOOLEAN:C223(tb_LC_CentreR; vl_Tab2)
		
		ARRAY LONGINT:C221(tl_LC_SHom; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_CHom; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_EHom; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_FHom; vl_Tab2)
		
		ARRAY LONGINT:C221(tl_LC_SFem; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_CFem; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_EFem; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_FFem; vl_Tab2)
		
		ARRAY LONGINT:C221(tl_LC_PMin; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_MMin; vl_Tab2)
		
		ARRAY LONGINT:C221(tl_LC_Total; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_Dis; vl_Tab2)
		ARRAY LONGINT:C221(tl_LC_Rest; vl_Tab2)
		
		ARRAY REAL:C219(tr_LC_TauxOccup; vl_Tab2)
		
		For ($ii; 1; vl_Tab2)
			tb_LC_CentreR{$ii}:=False:C215
			
			tl_LC_SHom{$ii}:=0
			tl_LC_CHom{$ii}:=0
			tl_LC_EHom{$ii}:=0
			tl_LC_FHom{$ii}:=0
			
			tl_LC_SFem{$ii}:=0
			tl_LC_CFem{$ii}:=0
			tl_LC_EFem{$ii}:=0
			tl_LC_FFem{$ii}:=0
			tl_LC_PMin{$ii}:=0
			tl_LC_MMin{$ii}:=0
			
			tl_LC_Total{$ii}:=0
			tl_LC_Dis{$ii}:=0
			tl_LC_Rest{$ii}:=0
			tr_LC_TauxOccup{$ii}:=0
		End for 
		
		vl_LC_SHom:=0
		vl_LC_CHom:=0
		vl_LC_EHom:=0
		vl_LC_FHom:=0
		
		vl_LC_SFem:=0
		vl_LC_CFem:=0
		vl_LC_EFem:=0
		vl_LC_FFem:=0
		
		vl_LC_PMin:=0
		vl_LC_MMin:=0
		
		vl_LC_Total:=0
		vl_LC_Dis:=0
		vl_LC_Rest:=0
		vr_LC_TauxOccup:=0
		
		//••••••••••••     Prestations
		vl_Tab3:=Size of array:C274(ta_LC_Presta)
		
		ARRAY LONGINT:C221(tl_LC_PrestaNb; vl_Tab3)
		
		For ($ii; 1; vl_Tab3)
			tl_LC_PrestaNb{$ii}:=0
		End for 
		
		vl_LC_PrestaNb:=0
		
		//••••••••••••     Signl
		vl_Tab4:=Size of array:C274(ta_xTBSglt)
		
		ARRAY LONGINT:C221(tl_xNbSgltJ; vl_Tab4)
		ARRAY LONGINT:C221(tl_xNbSgltJC; vl_Tab4)
		ARRAY LONGINT:C221(tl_xNbSgltN; vl_Tab4)
		ARRAY LONGINT:C221(tl_xNbSgltT; vl_Tab4)
		
		For ($ii; 1; vl_Tab4)
			tl_xNbSgltJ{$ii}:=0
			tl_xNbSgltJC{$ii}:=0
			tl_xNbSgltN{$ii}:=0
			tl_xNbSgltT{$ii}:=0
		End for 
		
		vl_xNbSgltJ:=0
		vl_xNbSgltJC:=0
		vl_xNbSgltN:=0
		vl_xNbSgltT:=0
		
		//••••••••••••     Pièces d'Identité
		vl_Tab5:=Size of array:C274(ta_xTBPIdté)
		
		ARRAY LONGINT:C221(tl_xNbIdtéJ; vl_Tab5)
		ARRAY LONGINT:C221(tl_xNbIdtéJC; vl_Tab5)
		ARRAY LONGINT:C221(tl_xNbIdtéN; vl_Tab5)
		ARRAY LONGINT:C221(tl_xNbIdtéT; vl_Tab5)
		
		For ($ii; 1; vl_Tab5)
			tl_xNbIdtéJ{$ii}:=0
			tl_xNbIdtéJC{$ii}:=0
			tl_xNbIdtéN{$ii}:=0
			tl_xNbIdtéT{$ii}:=0
		End for 
		
		vl_xNbIdtéJ:=0
		vl_xNbIdtéJC:=0
		vl_xNbIdtéN:=0
		vl_xNbIdtéT:=0
End case 