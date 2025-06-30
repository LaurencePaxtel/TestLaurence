//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HG_StatutClôturé  
//{
//{          Lundi 28 Juillet 1997 à 17:36:17
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

// 🚨 Il existe une version web de cette méthode : Web_HG_StatutClôture

C_LONGINT:C283($1)

C_LONGINT:C283($kk)
C_BOOLEAN:C305($vb_OK; $continue_b)

// Modifié par : Scanu Rémy (07/02/2024)
// Levé de l'interdiction de cloturer la fiche si celle-ci est inconnue

// Modifié par : Scanu Rémy (20/10/2022)
// Simplification du code
$continue_b:=([HeberGement:5]HG_Cloturée:67=False:C215)

If ($continue_b=False:C215)
	
	If ([HeberGement:5]HG_LC_ID:61<=0)
		StrAlerte(20; "")
		[HeberGement:5]HG_Cloturée:67:=False:C215
	Else 
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
		MultiSoc_Filter(->[LesCentres:9])
		
		If (Records in selection:C76([LesCentres:9])=1)
			
			Case of 
				: (Value type:C1509(w_visiteur)#Est une variable indéfinie:K8:13) && (w_visiteur#Null:C1517)
					
					If ([LesCentres:9]LC_Répertoire:54=ref_soc_active)
						$vb_OK:=True:C214
					Else 
						w_visiteur.notificationError:="Vous ne pouvez pas clôturer dans ce centre !"
						[HeberGement:5]HG_Cloturée:67:=False:C215
					End if 
					
				: ([LesCentres:9]LC_Répertoire:54=<>va_T_Site)
					$vb_OK:=True:C214
				Else 
					ALERT:C41("Vous ne pouvez pas clôturer dans ce centre !")
					[HeberGement:5]HG_Cloturée:67:=False:C215
			End case 
			
		Else 
			[HeberGement:5]HG_Cloturée:67:=False:C215
		End if 
		
		If ($vb_OK)
			
			// 09/02/2004 : ouverture SP au cas ou il y a clôture
			If ($1=1)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
				MultiSoc_Filter(->[HeBerge:4])
				
				If (Records in selection:C76([HeBerge:4])=1)
					$kk:=Num:C11([HeBerge:4]HB_Cas1:7)+Num:C11([HeBerge:4]HB_Cas2:8)+Num:C11([HeBerge:4]HB_Cas3:9)+Num:C11([HeBerge:4]HB_Cas4:10)+Num:C11([HeBerge:4]HB_Cas5:11)
					$kk:=$kk+Num:C11([HeBerge:4]HB_Cas6:12)+Num:C11([HeBerge:4]HB_Cas7:13)+Num:C11([HeBerge:4]HB_Cas8:14)+Num:C11([HeBerge:4]HB_Cas9:15)+Num:C11([HeBerge:4]HB_Cas10:16)
					
					// Modifié par : Scanu Rémy (05/03/2024)
					If ($kk>0) && ((Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined"))
						P_VoirStatutSP([HeBerge:4]HB_ReferenceID:1)
					End if 
					
				End if 
				
			End if 
			
			$continue_b:=True:C214
		End if 
		
	End if 
	
End if 

If ($continue_b=True:C214)
	P_BoolHeureCommute(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
	
	Case of 
		: ([HeberGement:5]HG_Cloturée:67=True:C214)
			[HeberGement:5]HG_EnAttente:64:=False:C215
		: ([HeberGement:5]HG_Transmis:65=False:C215) & ([HeberGement:5]HG_Cloturée:67=False:C215)
			[HeberGement:5]HG_EnAttente:64:=True:C214
	End case 
	
End if 