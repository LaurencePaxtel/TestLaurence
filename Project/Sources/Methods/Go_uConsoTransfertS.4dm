//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : Go_uConsoTransfertS
//{          Mercrdi 16 mai 2012 à 15:45
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)
C_BOOLEAN:C305(vb_SurServeur)

vb_SurServeur:=$1

C_BOOLEAN:C305($vb_OK; vb_OK)
C_TIME:C306($vh_HeureD; $vh_HeureF)
C_TEXT:C284($vt_Chemin)

C_BOOLEAN:C305(vb_OK; vb_Conso; vb_ConsoJour; vb_ConsoNuit)
C_LONGINT:C283(gError; vl_ii; vl_ij)
$vh_HeureD:=Current time:C178
vb_OK:=False:C215
vb_Conso:=False:C215
vb_ConsoJour:=False:C215
vb_ConsoNuit:=False:C215
gError:=0
vl_ii:=0
vl_ij:=0
$vh_HeureF:=$vh_HeureD

vb_SurServeur:=$1

READ ONLY:C145(*)
MESSAGES OFF:C175

//P_Conso_Transfert ("DeclarerParam")
P_Conso_Transfert("Declarer")

DebutInitConsoTranfert(0)
If (<>vb_ConsoTransfert)
	
	
	
	Repeat 
		$vh_HeureD:=Current time:C178
		$vh_HeureF:=$vh_HeureD
		$vl_AfficheToutes:=0
		
		//•(1) Les dates et heures    
		i_DateServeurPoste(vb_SurServeur)
		
		//•(2) Une condition
		If (vb_SurServeur)
			If (vd_HeureRéelle>=<>vh_ConsoTransfert1) & (vd_HeureRéelle<=<>vh_ConsoTransfert2)
				vb_Conso:=True:C214
			Else 
				vb_Conso:=False:C215
			End if 
		Else 
			vb_Conso:=True:C214
		End if 
		
		vb_ConsoJour:=vb_Conso
		vb_ConsoNuit:=vb_Conso
		
		//On fait l'import  gError:=0
		ON ERR CALL:C155("i_Error")
		
		
		//•••••••••••////// fiches d'hébergement //////••••••••••
		
		//•(3) Le répertoire origine existe  t il
		If (vb_ConsoJour)
			$vt_Chemin:=<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12
			vb_ConsoJour:=F_Répertoire($vt_Chemin)
			If (vb_ConsoJour=False:C215)
				$vb_OK:=F_Conso115_Message(vb_SurServeur; "NO"; "Transfert : absence de repertoire ou de chemin origine"; "Pas de Transfert")
			End if 
		End if 
		
		//•(4) Le répertoire destination existe  t il
		If (vb_ConsoJour)
			$vt_Chemin:=<>vt_T_CheminSO_CheminRepDistant+<>va_Rép_TransReport+Séparateur dossier:K24:12
			vb_ConsoJour:=F_Répertoire($vt_Chemin)
			If (vb_ConsoJour=False:C215)
				$vb_OK:=F_Conso115_Message(vb_SurServeur; "NO"; "Transfert : absence de repertoire ou de chemin destination"; "Pas de Transfert")
			End if 
		End if 
		
		
		//•(5) Le répertoire a t il des fiches
		If (vb_ConsoJour)
			$vh_HeureD:=Current time:C178
			$vh_HeureF:=$vh_HeureD
			P_Conso_Transfert("Initialiser")
			If (F_Dossier("DocuSSP"; -><>vt_T_CheminRép))
				$vb_OK:=F_Dossier("DocuChemin"; -><>vt_T_CheminRép)
			End if 
			vl_ij:=Size of array:C274(ta_ConsoDocuFichier)
			If (vl_ij>0)
				For (vl_ii; 1; vl_ij)
					If (7=8)
						If (<>vb_CestUnMac)
							MOVE DOCUMENT:C540(F_FichierSuffixe(<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}); F_FichierSuffixe(<>vt_T_CheminSO_CheminRepDistant+<>va_Rép_TransReport+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}))
							
						Else 
							COPY DOCUMENT:C541(F_FichierSuffixe(<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}); F_FichierSuffixe(<>vt_T_CheminSO_CheminRepDistant+<>va_Rép_TransReport+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}))
							DELETE DOCUMENT:C159(F_FichierSuffixe(<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}))
						End if 
					End if 
					
					
					MOVE DOCUMENT:C540(F_FichierSuffixe(<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}); F_FichierSuffixe(<>vt_T_CheminSO_CheminRepDistant+<>va_Rép_TransReport+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}))
					
					If (7=8)
						If (<>vb_CestUnMac=False:C215)
							If (Test path name:C476(F_FichierSuffixe(<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}))=Est un document:K24:1)
								DELETE DOCUMENT:C159(F_FichierSuffixe(<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}))
							End if 
						End if 
					End if 
					
					
					
				End for 
				//•(6) Message dans transmission
				$vh_HeureF:=Current time:C178
				$vb_OK:=F_Conso115_Message(vb_Serveur; "OK"; "Transfert des fiches hébergements effectuée"; "Début à "+String:C10($vh_HeureD)+" Fin à "+String:C10($vh_HeureF)+" Durée "+String:C10($vh_HeureF-$vh_HeureD)+" Pour "+String:C10(vl_ij)+" fiche(s)")
			End if 
		End if 
		
		
		//•••••••••••////// fiches de prestations //////••••••••••
		//•(3 Bis) Le répertoire origine existe  t il
		If (vb_ConsoNuit)
			$vt_Chemin:=<>vt_T_CheminRép+<>va_Rép_TransPresta+Séparateur dossier:K24:12
			vb_ConsoNuit:=F_Répertoire($vt_Chemin)
			If (vb_ConsoNuit=False:C215)
				$vb_OK:=F_Conso115_Message(vb_SurServeur; "NO"; "TransfertPrestation : absence de repertoire ou de chemin origine"; "Pas de Transfert")
			End if 
		End if 
		
		//•(4 Bis) Le répertoire destination existe  t il
		If (vb_ConsoNuit)
			$vt_Chemin:=<>vt_T_CheminSO_CheminRepDistant+<>va_Rép_TransPresta+Séparateur dossier:K24:12
			vb_ConsoNuit:=F_Répertoire($vt_Chemin)
			If (vb_ConsoNuit=False:C215)
				$vb_OK:=F_Conso115_Message(vb_SurServeur; "NO"; "TransfertPrestation : absence de repertoire ou de chemin destination"; "Pas de Transfert")
			End if 
		End if 
		
		//•(5) Bis Le répertoire a t il des fiches
		If (vb_ConsoNuit)
			$vh_HeureD:=Current time:C178
			$vh_HeureF:=$vh_HeureD
			P_Conso_Transfert("Initialiser")
			If (F_Dossier("DocuSSPNuit"; -><>vt_T_CheminRép))
				$vb_OK:=F_Dossier("DocuCheminNuit"; -><>vt_T_CheminRép)
			End if 
			vl_ij:=Size of array:C274(ta_ConsoDocuFichier)
			If (vl_ij>0)
				For (vl_ii; 1; vl_ij)
					If (7=8)
						If (<>vb_CestUnMac)
							MOVE DOCUMENT:C540(F_FichierSuffixe(<>vt_T_CheminRép+<>va_Rép_TransPresta+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}); F_FichierSuffixe(<>vt_T_CheminSO_CheminRepDistant+<>va_Rép_TransPresta+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}))
							
						Else 
							COPY DOCUMENT:C541(F_FichierSuffixe(<>vt_T_CheminRép+<>va_Rép_TransPresta+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}); F_FichierSuffixe(<>vt_T_CheminSO_CheminRepDistant+<>va_Rép_TransPresta+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}))
							DELETE DOCUMENT:C159(F_FichierSuffixe(<>vt_T_CheminRép+<>va_Rép_TransPresta+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}))
						End if 
					End if 
					
					
					MOVE DOCUMENT:C540(F_FichierSuffixe(<>vt_T_CheminRép+<>va_Rép_TransPresta+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}); F_FichierSuffixe(<>vt_T_CheminSO_CheminRepDistant+<>va_Rép_TransPresta+Séparateur dossier:K24:12+ta_ConsoDocuFichier{vl_ii}))
					
				End for 
				//•(6 Bis) Message dans transmission
				$vh_HeureF:=Current time:C178
				$vb_OK:=F_Conso115_Message(vb_Serveur; "OK"; "Transfert des fiches prestation effectuée"; "Début à "+String:C10($vh_HeureD)+" Fin à "+String:C10($vh_HeureF)+" Durée "+String:C10($vh_HeureF-$vh_HeureD)+" Pour "+String:C10(vl_ij)+" fiche(s)")
			End if 
		End if 
		
		
		//••••••••••••••••••••••••/••••••••••••••••••••••••
		
		//•(7) on s'endort ou on quitte 
		vb_OK:=(<>vb_ConsoTransfert=False:C215)
		If (<>vb_ConsoTransfert)
			DELAY PROCESS:C323(<>PR_ConsoTransfertAuto; <>vl_ConsoTransfertTicks)
			DebutInitConsoTranfert(4)
			vb_OK:=(<>vb_ConsoTransfert=False:C215)
		End if 
		
		
	Until (vb_OK)
End if 

ON ERR CALL:C155("")
<>PR_ConsoTransfertAuto:=0