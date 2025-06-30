//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_SIAO_PEsup
//{          Lundi 7 février 2010 à 10:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_LONGINT:C283($ii)
C_BOOLEAN:C305($vb_OK)



$vb_OK:=False:C215

ta_SP_Nom:=$1
If (ta_SP_Nom>0)
	If (ta_SP_SousTheme{ta_SP_Nom}=ta_SIAO_PopSitFamCode{3})
		ALERT:C41("Vous ne pouvez pas supprimer le demandeur.")
	Else 
		If (i_Confirmer(ta_SP_Nom{ta_SP_Nom}+" "+ta_SP_Prenom{ta_SP_Nom}+<>va_CR+"Confirmez-vous la suppression ?"))
			i_Message("Suppression en cours en cours…")
			READ WRITE:C146([SIAO_Personnes:51])
			READ WRITE:C146([SIAO_Situations:52])
			READ WRITE:C146([Adresses:53])
			QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_RéférenceID:1=tl_SP_Reference{ta_SP_Nom})
			MultiSoc_Filter(->[SIAO_Personnes:51])
			If (Records in selection:C76([SIAO_Personnes:51])=1)
				If (i_NonVerrou(->[SIAO_Personnes:51]))
					QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=[SIAO_Personnes:51]Sp_RéférenceID:1)
					MultiSoc_Filter(->[SIAO_Situations:52])
					If (Records in selection:C76([SIAO_Situations:52])>0)
						DELETE SELECTION:C66([SIAO_Situations:52])
					End if 
					QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=[SIAO_Personnes:51]Sp_RéférenceID:1)
					MultiSoc_Filter(->[SIAO_Situations:52])
					If (Records in selection:C76([SIAO_Situations:52])>0)
						DELETE SELECTION:C66([SIAO_Situations:52])
					End if 
					QUERY:C277([Adresses:53]; [Adresses:53]AD_SIAO_Personne_ID:4=[SIAO_Personnes:51]Sp_RéférenceID:1)
					MultiSoc_Filter(->[Adresses:53])
					If (Records in selection:C76([Adresses:53])>0)
						DELETE SELECTION:C66([Adresses:53])
					End if 
					DELETE RECORD:C58([SIAO_Personnes:51])
					$vb_OK:=True:C214
				End if 
			End if 
			UNLOAD RECORD:C212([SIAO_Personnes:51])
			UNLOAD RECORD:C212([SIAO_Situations:52])
			UNLOAD RECORD:C212([Adresses:53])
			
			READ ONLY:C145([SIAO_Personnes:51])
			READ ONLY:C145([SIAO_Situations:52])
			READ ONLY:C145([Adresses:53])
			
			
			If ($vb_OK)
				$ii:=ta_SP_Nom
				DELETE FROM ARRAY:C228(tl_SP_Reference; $ii)
				DELETE FROM ARRAY:C228(tl_SP_SIAO_ID; $ii)
				DELETE FROM ARRAY:C228(tl_SP_Personne_ID; $ii)
				DELETE FROM ARRAY:C228(ta_SP_Famille; $ii)
				DELETE FROM ARRAY:C228(ta_SP_Theme; $ii)
				DELETE FROM ARRAY:C228(ta_SP_SousTheme; $ii)
				DELETE FROM ARRAY:C228(tl_SP_Rang; $ii)
				DELETE FROM ARRAY:C228(ta_SP_Nom; $ii)
				DELETE FROM ARRAY:C228(ta_SP_Prenom; $ii)
				DELETE FROM ARRAY:C228(td_SP_NeLeDate; $ii)
				If (ta_SP_Nom>Size of array:C274(tl_SP_Reference))
					ta_SP_Nom:=Size of array:C274(tl_SP_Reference)
				End if 
				P_SIAO_PEClick(->ta_SP_Nom)
			End if 
			CLOSE WINDOW:C154
		End if 
	End if 
End if 


