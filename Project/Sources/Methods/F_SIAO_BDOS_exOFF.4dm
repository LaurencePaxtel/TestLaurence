//%attributes = {}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_DATE:C307($3)

C_LONGINT:C283($ii; $vl_fiche; $vl_Envoyer)
C_LONGINT:C283($vl_UrgenceDispo; $vl_InsertionDispo; $vl_StabiliseDispo; $vl_LogementDispo; $vl_AutreDispo)
C_LONGINT:C283($vl_UrgenceOccup; $vl_InsertionOccup; $vl_StabiliseOccup; $vl_LogementOccup; $vlAutreOccup)
C_TEXT:C284($va_Type)
C_TIME:C306($vh_RefDoc)
C_BOOLEAN:C305($vb_OK; $vb_115)
vb_OKFalse:=False:C215
QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Prestation:55=False:C215)
MultiSoc_Filter(->[LesCentres:9])

$vb_OK:=(Records in selection:C76([LesCentres:9])>0)
If ($vb_OK)
	//Création du document sur disque ou fichier
	$vh_RefDoc:=Create document:C266(<>vt_BDOS_DOSSIER+<>va_BDOS_FichierNom)
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		<>vt_BDOS_VALEUR:=""
		//•• 1 ere ligne
		$vb_OK:=F_BDOS_Tables(<>ta_BDOS_FichierCode{$1}; ""; 0)
		For ($ii; 1; Size of array:C274(<>ta_BDOS_ChampNom))
			<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+<>ta_BDOS_ChampNom{$ii}+va_SepCHAMP
		End for 
		<>vt_BDOS_VALEUR:=Substring:C12(<>vt_BDOS_VALEUR; 1; Length:C16(<>vt_BDOS_VALEUR)-1)
		<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+va_SepFICHE
		SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
		
		
		ARRAY TEXT:C222($ta_Repertoire; 0)
		DISTINCT VALUES:C339([LesCentres:9]LC_Répertoire:54; $ta_Repertoire)
		SORT ARRAY:C229($ta_Repertoire; >)
		For ($ii; 1; Size of array:C274($ta_Repertoire))
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Répertoire:54=$ta_Repertoire{$ii})
			If (Records in selection:C76([LesCentres:9])>0)
				ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
				$vl_UrgenceDispo:=0
				$vl_InsertionDispo:=0
				$vl_StabiliseDispo:=0
				$vl_LogementDispo:=0
				$vl_AutreDispo:=0
				$vl_UrgenceOccup:=0
				$vl_InsertionOccup:=0
				$vl_StabiliseOccup:=0
				$vl_LogementOccup:=0
				$vlAutreOccup:=0
				
				
				$vl_AutreDispo:=0
				$vlAutreOccup:=0
				
				$vl_Envoyer:=0
				FIRST RECORD:C50([LesCentres:9])
				Repeat 
					If ([LesCentres:9]LC_Répertoire:54="115")
						$vb_115:=True:C214
						$vl_Envoyer:=1
						QUERY:C277([CentresLits:16]; [CentresLits:16]CL_LC_ID_date:1=Uut_NumeroteLits($3; [LesCentres:9]LC_RéférenceID:1))
						If (Records in selection:C76([CentresLits:16])=1)
							$vl_UrgenceDispo:=$vl_UrgenceDispo+[CentresLits:16]CL_Capacité:4  //[CentresLits]CL_DispoTotal
							$vl_UrgenceOccup:=$vl_UrgenceOccup+[CentresLits:16]CL_Distribué:6
						End if 
						
					Else 
						$vb_115:=False:C215
						$va_Type:=Substring:C12([LesCentres:9]LC_Nom:4; 1; 2)
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=[CentresLits:16]CL_LC_ID:2; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4=$3)
						MultiSoc_Filter(->[HeberGement:5])
						$vl_fiche:=Records in selection:C76([HeberGement:5])
						If ($vl_fiche>0)
							Case of 
								: ($va_Type="00")  //"Urgence"
									$vl_UrgenceDispo:=$vl_UrgenceDispo+[LesCentres:9]LC_DispoJour:48
									$vl_UrgenceOccup:=$vl_UrgenceOccup+$vl_fiche
									
								: ($va_Type="01")  //"Stabilisation"
									$vl_StabiliseDispo:=$vl_StabiliseDispo+[LesCentres:9]LC_DispoJour:48
									$vl_StabiliseOccup:=$vl_StabiliseOccup+$vl_fiche
									
								: ($va_Type="02")  //"Insertion"
									$vl_InsertionDispo:=$vl_InsertionDispo+[LesCentres:9]LC_DispoJour:48
									$vl_InsertionOccup:=$vl_InsertionOccup+$vl_fiche
									
								: ((Num:C11($va_Type)>=3) & (Num:C11($va_Type)<=39))  //"Logements"
									$vl_LogementDispo:=$vl_LogementDispo+[LesCentres:9]LC_DispoJour:48
									$vl_LogementOccup:=$vl_LogementOccup+$vl_fiche
									
								Else   //"Autres"                  
									$vl_AutreDispo:=$vl_AutreDispo+[LesCentres:9]LC_DispoJour:48
									$vlAutreOccup:=$vlAutreOccup+$vl_fiche
							End case 
							$vl_Envoyer:=$vl_Envoyer+1
						End if 
					End if 
					NEXT RECORD:C51([LesCentres:9])
				Until (End selection:C36([LesCentres:9]))
				$vb_OK:=$vb_115
				$vb_OK:=($vb_OK | (($vb_115=False:C215) & ($vl_Envoyer>0)))
				If ($vb_OK)
					
					If (($vl_UrgenceDispo+$vl_UrgenceOccup+$vl_StabiliseDispo+$vl_StabiliseOccup+$vl_InsertionDispo+$vl_InsertionOccup)>0)
						<>vt_BDOS_VALEUR:=F_Chaine("Departement"; -><>va_T_Departement)+$ta_Repertoire{$ii}+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+$ta_Repertoire{$ii}+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Departement"; -><>va_T_Departement)+$ta_Repertoire{$ii}+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+F_Chaine("Site"; -><>va_T_Site)+F_Chaine("Departement"; -><>va_T_Departement)+"115"+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+"0000-00-00 00:00:00"+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+String:C10($vl_UrgenceDispo)+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+String:C10($vl_InsertionDispo)+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+String:C10($vl_StabiliseDispo)+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+String:C10($vl_LogementDispo)+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+String:C10($vl_UrgenceOccup)+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+String:C10($vl_InsertionOccup)+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+String:C10($vl_StabiliseOccup)+va_SepCHAMP
						<>vt_BDOS_VALEUR:=<>vt_BDOS_VALEUR+String:C10($vl_LogementOccup)+va_SepFICHE
						SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
					End if 
					
					
					
				End if 
			End if 
		End for 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($vh_RefDoc)
	End if 
End if 