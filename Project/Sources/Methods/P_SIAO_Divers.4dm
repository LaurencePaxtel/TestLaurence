//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{          Procédure : P_SIAO_Divers
//{          Jeudi 24 février 2011 à 16:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)
If ($1)  //Pas fermé
Else 
	OBJECT SET ENABLED:C1123(r1; False:C215)
	OBJECT SET ENABLED:C1123(r2; False:C215)
	OBJECT SET ENABLED:C1123(r3; False:C215)
	
End if 

OBJECT SET ENTERABLE:C238([SIAO:50]Si_Log_Souhaite1:22; False:C215)
OBJECT SET ENTERABLE:C238([SIAO:50]Si_Log_Souhaite2:23; False:C215)
OBJECT SET ENTERABLE:C238([SIAO:50]Si_Log_Souhaite3:24; False:C215)

OBJECT SET ENTERABLE:C238([SIAO:50]Si_Log_Adapte:25; False:C215)

OBJECT SET ENTERABLE:C238([SIAO:50]Si_Ac_Souhaite1:26; False:C215)
OBJECT SET ENTERABLE:C238([SIAO:50]Si_Ac_Souhaite2:27; False:C215)
OBJECT SET ENTERABLE:C238([SIAO:50]Si_Ac_Souhaite3:28; False:C215)

OBJECT SET ENTERABLE:C238([SIAO:50]Si_Demandeur_Projet:43; $1)

If ($1)
	OBJECT SET ENABLED:C1123(b_AnnSIAO; True:C214)
Else 
	If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN))
		OBJECT SET ENABLED:C1123(b_AnnSIAO; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(b_AnnSIAO; False:C215)
	End if 
End if 

If ($1)
	OBJECT SET ENABLED:C1123(b_TransSIAO; True:C214)
Else 
	OBJECT SET ENABLED:C1123(b_TransSIAO; False:C215)
End if 

OBJECT SET ENTERABLE:C238([SIAO:50]Si_Trans_Type:34; $1)
OBJECT SET ENTERABLE:C238([SIAO:50]Si_Trans_Competent:35; False:C215)


OBJECT SET ENTERABLE:C238([SIAO:50]Si_Etat_Type:41; False:C215)
OBJECT SET ENTERABLE:C238([SIAO:50]Si_Demandeur_Suivi:45; $1)


//•• Date de fermeture
OBJECT SET VISIBLE:C603(b_MaJ; (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN)))

If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_SIAOFermeture))
	OBJECT SET VISIBLE:C603(*; "Fermeture_@"; True:C214)
	OBJECT SET ENTERABLE:C238([SIAO:50]Si_Fermeture:46; True:C214)
Else 
	OBJECT SET ENTERABLE:C238([SIAO:50]Si_Fermeture:46; False:C215)
	If ([SIAO:50]Si_Fermeture:46>!00-00-00!)
		OBJECT SET VISIBLE:C603(*; "Fermeture_@"; True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*; "Fermeture_@"; False:C215)
	End if 
End if 


OBJECT SET VISIBLE:C603(ta_SIAO_PopModFam; $1)

OBJECT SET VISIBLE:C603(*; "Pop_b_@"; $1)
OBJECT SET VISIBLE:C603(*; "icon_@"; $1)


OBJECT SET VISIBLE:C603(ta_SIAO_PopSitFam; False:C215)
OBJECT SET VISIBLE:C603(b_SIAO_SP_New; $1)
