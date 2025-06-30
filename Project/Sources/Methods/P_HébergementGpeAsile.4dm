//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementGpeAsile
//{
//{          Mardi 11 Mai 2004 à 10:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)

Case of 
	: ($1=0)  // Chargement
		
		If ($2)  // (Appartient au groupe(Utilisateur courant;◊Groupe_Asile))
			OBJECT SET VISIBLE:C603(*; "Asile_Cache"; False:C215)
			
			OBJECT SET ENTERABLE:C238(ve_FamH; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamF; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamFe; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamEMi; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamEMa; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamPMi; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamPMa; True:C214)
			
			OBJECT SET ENABLED:C1123(x1; True:C214)
			OBJECT SET ENABLED:C1123(x2; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "Asile_Cache"; True:C214)
			
			OBJECT SET ENTERABLE:C238(ve_FamH; False:C215)
			OBJECT SET ENTERABLE:C238(ve_FamF; False:C215)
			OBJECT SET ENTERABLE:C238(ve_FamFe; False:C215)
			OBJECT SET ENTERABLE:C238(ve_FamEMi; False:C215)
			OBJECT SET ENTERABLE:C238(ve_FamEMa; False:C215)
			OBJECT SET ENTERABLE:C238(ve_FamPMi; False:C215)
			OBJECT SET ENTERABLE:C238(ve_FamPMa; False:C215)
			
			OBJECT SET ENABLED:C1123(x1; False:C215)
			OBJECT SET ENABLED:C1123(x2; False:C215)
		End if 
		
	: ($1=1)  // Nouvel enregistrement
		
		If ($2)  // (Appartient au groupe(Utilisateur courant;◊Groupe_Asile))
			
			If (Storage:C1525.dispositif.HG_ASFamChéf#3)
				x1:=Num:C11([HeberGement:5]HG_FamChef:103=True:C214)
				x2:=Num:C11([HeberGement:5]HG_FamChef:103=False:C215)
			End if 
			
			If ([HeberGement:5]HG_FamChef:103)
				[HeberGement:5]HG_FamNbJour:107:=ve_IDT_FJou
				[HeberGement:5]HG_FamNbChambre:108:=ve_IDT_FChb
				[HeberGement:5]HG_FamPrixJour:109:=vr_IDT_FPxJ
				[HeberGement:5]HG_FamTotal:110:=vr_IDT_FPxT
			End if 
			
			[HeberGement:5]HG_FamCompoVar:117:=""
			
			P_HG_Famille(0)
			P_HG_FamilleChef(0)
		Else 
			[HeberGement:5]HG_FamGroupe:102:=Storage:C1525.dispositif.HG_ASPasFamGroupe  //"115"      
		End if 
		
	: ($1=2)  // Modification de fiche
		
		If ($2)  // (Appartient au groupe(Utilisateur courant;◊Groupe_Asile))
			x1:=Num:C11([HeberGement:5]HG_FamChef:103=True:C214)
			x2:=Num:C11([HeberGement:5]HG_FamChef:103=False:C215)
			
			P_HG_Famille(2)
			P_HG_FamilleChef2  // 21/09/2009
		End if 
		
End case 