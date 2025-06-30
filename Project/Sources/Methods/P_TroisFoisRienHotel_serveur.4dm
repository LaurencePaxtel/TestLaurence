//%attributes = {"executedOnServer":true}
// Method P_TroisFoisRienHotel_serveur  
C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1
C_OBJECT:C1216($O_Objet)
$O_Objet:=OB Copy:C1225($P_Objet->)

MultiSoc_Init_On_Server(Count parameters:C259; $2)

C_LONGINT:C283($ii; $jj; $kk; $vl_Position1)
C_BOOLEAN:C305($vb_OK; $B_Continue)
C_DATE:C307($vd_DateDuJour; $vd_DateDeFin; $vd_DateDuDebut)
C_LONGINT:C283($vl_Total)
C_TEXT:C284($va_EtCv)

$vd_DateDuJour:=OB Get:C1224($O_Objet; "$vd_DateDuJour"; Est une date:K8:7)
$B_Continue:=OB Get:C1224($O_Objet; "$B_Continue")
$vd_DateDuDebut:=OB Get:C1224($O_Objet; "$vd_DateDuDebut"; Est une date:K8:7)
$vd_DateDeFin:=OB Get:C1224($O_Objet; "$vd_DateDeFin"; Est une date:K8:7)
$vb_OK:=OB Get:C1224($O_Objet; "$vb_OK")

ARRAY TEXT:C222(ta_MoisColEtatCivil; 0)
ARRAY DATE:C224(td_DateAfficheDebut; 0)
ARRAY DATE:C224(td_DateAfficheFin; 0)
ARRAY INTEGER:C220(te_MoisDateIndices; 0)
ARRAY LONGINT:C221(tl_MoisColEtatCivil; 0)
ARRAY LONGINT:C221(tl_MoisDateJours; 0)
ARRAY LONGINT:C221(tl_MoisDateJoursPlus; 0)
ARRAY LONGINT:C221(tl_MoisDatePersonnes; 0)
ARRAY LONGINT:C221(tl_MoisPersonnes; 0)
ARRAY LONGINT:C221(tl_MoisPersonnesHB; 0)
ARRAY LONGINT:C221(tl_MoisPersonnesJ; 0)
ARRAY LONGINT:C221(tl_MoisPersonnesSel; 0)

//OB GET ARRAY($O_Objet;"ta_MoisColEtatCivil";ta_MoisColEtatCivil)
//OB GET ARRAY($O_Objet;"td_DateAfficheDebut";td_DateAfficheDebut)
//OB GET ARRAY($O_Objet;"td_DateAfficheFin";td_DateAfficheFin)
//OB GET ARRAY($O_Objet;"te_MoisDateIndices";te_MoisDateIndices)
//OB GET ARRAY($O_Objet;"tl_MoisColEtatCivil";tl_MoisColEtatCivil)
//OB GET ARRAY($O_Objet;"tl_MoisDateJours";tl_MoisDateJours)
//OB GET ARRAY($O_Objet;"tl_MoisDateJoursPlus";tl_MoisDateJoursPlus)
//OB GET ARRAY($O_Objet;"tl_MoisDatePersonnes";tl_MoisDatePersonnes)
//OB GET ARRAY($O_Objet;"tl_MoisPersonnes";tl_MoisPersonnes)
//OB GET ARRAY($O_Objet;"tl_MoisPersonnesHB";tl_MoisPersonnesHB)
//OB GET ARRAY($O_Objet;"tl_MoisPersonnesJ";tl_MoisPersonnesJ)
//OB GET ARRAY($O_Objet;"tl_MoisPersonnesSel";tl_MoisPersonnesSel)

$vb_OK:=False:C215
If ($B_Continue)
	
	i_Message("Nombre de personnes hébergées en hôtel depuis…")
	i_MessageSeul("Nombre de personnes hébergées en hôtel depuis…")
	
	ARRAY TEXT:C222(ta_MoisColEtatCivil; 4)
	ARRAY LONGINT:C221(tl_MoisColEtatCivil; 4)
	ta_MoisColEtatCivil{1}:="Homme seul"  //(HS)
	ta_MoisColEtatCivil{2}:="Femme seule"  //(FS)
	ta_MoisColEtatCivil{3}:="Couples"  //(HC-FC)
	ta_MoisColEtatCivil{4}:="Familles"  //(HF-HE-FF-FE FP-HP)
	For ($ii; 1; 4)
		tl_MoisColEtatCivil{$ii}:=0
	End for 
	
	
	
	ARRAY LONGINT:C221($tl_Centres; 0)
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Nom:4="115 H@")
	MultiSoc_Filter(->[LesCentres:9])
	If (Records in selection:C76([LesCentres:9])>0)
		SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tl_Centres)
	End if 
	
	$ii:=6
	ARRAY INTEGER:C220(te_MoisDateIndices; $ii)
	ARRAY DATE:C224(td_DateAfficheDebut; $ii)
	ARRAY DATE:C224(td_DateAfficheFin; $ii)
	ARRAY LONGINT:C221(tl_MoisDateJours; $ii)
	ARRAY LONGINT:C221(tl_MoisDateJoursPlus; $ii)
	ARRAY LONGINT:C221(tl_MoisDatePersonnes; $ii)
	
	$ii:=1
	te_MoisDateIndices{$ii}:=$ii
	td_DateAfficheFin{$ii}:=$vd_DateDuJour
	td_DateAfficheDebut{$ii}:=Add to date:C393(td_DateAfficheFin{$ii}; 0; -1; 1)
	tl_MoisDateJours{$ii}:=(td_DateAfficheFin{$ii}-td_DateAfficheDebut{$ii}+1)
	tl_MoisDateJoursPlus{$ii}:=tl_MoisDateJours{$ii}
	tl_MoisDatePersonnes{$ii}:=0
	$ii:=2
	te_MoisDateIndices{$ii}:=$ii
	td_DateAfficheFin{$ii}:=Add to date:C393(td_DateAfficheDebut{$ii-1}; 0; 0; -1)
	td_DateAfficheDebut{$ii}:=Add to date:C393(td_DateAfficheFin{$ii}; 0; -1; 1)
	tl_MoisDateJours{$ii}:=(td_DateAfficheFin{$ii}-td_DateAfficheDebut{$ii}+1)
	tl_MoisDateJoursPlus{$ii}:=tl_MoisDateJours{$ii}+tl_MoisDateJoursPlus{$ii-1}
	tl_MoisDatePersonnes{$ii}:=0
	
	$ii:=3
	te_MoisDateIndices{$ii}:=$ii
	td_DateAfficheFin{$ii}:=Add to date:C393(td_DateAfficheDebut{$ii-1}; 0; 0; -1)
	td_DateAfficheDebut{$ii}:=Add to date:C393(td_DateAfficheFin{$ii}; 0; -1; 1)
	tl_MoisDateJours{$ii}:=(td_DateAfficheFin{$ii}-td_DateAfficheDebut{$ii}+1)
	tl_MoisDateJoursPlus{$ii}:=tl_MoisDateJours{$ii}+tl_MoisDateJoursPlus{$ii-1}
	tl_MoisDatePersonnes{$ii}:=0
	
	$ii:=4
	te_MoisDateIndices{$ii}:=$ii
	td_DateAfficheFin{$ii}:=Add to date:C393(td_DateAfficheDebut{$ii-1}; 0; 0; -1)
	td_DateAfficheDebut{$ii}:=Add to date:C393(td_DateAfficheFin{$ii}; 0; -1; 1)
	tl_MoisDateJours{$ii}:=(td_DateAfficheFin{$ii}-td_DateAfficheDebut{$ii}+1)
	tl_MoisDateJoursPlus{$ii}:=tl_MoisDateJours{$ii}+tl_MoisDateJoursPlus{$ii-1}
	tl_MoisDatePersonnes{$ii}:=0
	
	$ii:=5
	te_MoisDateIndices{$ii}:=$ii
	td_DateAfficheFin{$ii}:=Add to date:C393(td_DateAfficheDebut{$ii-1}; 0; 0; -1)
	td_DateAfficheDebut{$ii}:=Add to date:C393(td_DateAfficheFin{$ii}; 0; -1; 1)
	tl_MoisDateJours{$ii}:=(td_DateAfficheFin{$ii}-td_DateAfficheDebut{$ii}+1)
	tl_MoisDateJoursPlus{$ii}:=tl_MoisDateJours{$ii}+tl_MoisDateJoursPlus{$ii-1}
	tl_MoisDatePersonnes{$ii}:=0
	
	$ii:=6
	te_MoisDateIndices{$ii}:=$ii
	td_DateAfficheFin{$ii}:=Add to date:C393(td_DateAfficheDebut{$ii-1}; 0; 0; -1)
	td_DateAfficheDebut{$ii}:=Add to date:C393(td_DateAfficheFin{$ii}; 0; -1; 1)
	tl_MoisDateJours{$ii}:=(td_DateAfficheFin{$ii}-td_DateAfficheDebut{$ii}+1)
	tl_MoisDateJoursPlus{$ii}:=1000000
	tl_MoisDatePersonnes{$ii}:=0
	
	
	ARRAY LONGINT:C221(tl_MoisPersonnesSel; 0)
	ARRAY LONGINT:C221(tl_MoisPersonnesHB; 0)
	ARRAY LONGINT:C221(tl_MoisPersonnes; 0)
	ARRAY LONGINT:C221(tl_MoisPersonnesJ; 0)
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=$vd_DateDuJour; *)  // je remplace le $1 par $vd_DateDuJour
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
	MultiSoc_Filter(->[HeberGement:5])
	If (Records in selection:C76([HeberGement:5])>0)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_NuitenCours:92; >)
		Repeat 
			If (Find in array:C230($tl_Centres; [HeberGement:5]HG_LC_ID:61)>0)
				$kk:=Size of array:C274(tl_MoisPersonnesHB)+1
				INSERT IN ARRAY:C227(tl_MoisPersonnesHB; $kk)
				INSERT IN ARRAY:C227(tl_MoisPersonnesSel; $kk)
				tl_MoisPersonnesHB{$kk}:=[HeberGement:5]HG_ReferenceID:1
				tl_MoisPersonnesSel{$kk}:=[HeberGement:5]HG_HB_ID:19
				
				
				$va_EtCv:=Substring:C12([HeberGement:5]HG_EtatCivil:20; Length:C16([HeberGement:5]HG_EtatCivil:20)-2; 2)  //Ancien
				$va_EtCv:=""
				$vl_Position1:=Position:C15("("; [HeberGement:5]HG_EtatCivil:20)
				If ($vl_Position1>0)
					$vl_Position1:=$vl_Position1+1
					$va_EtCv:=Substring:C12([HeberGement:5]HG_EtatCivil:20; $vl_Position1; 2)
				End if 
				
				
				Case of 
					: ($va_EtCv="HS")
						tl_MoisColEtatCivil{1}:=tl_MoisColEtatCivil{1}+1
					: ($va_EtCv="FS")
						tl_MoisColEtatCivil{2}:=tl_MoisColEtatCivil{2}+1
					: ($va_EtCv="HC") | ($va_EtCv="FC")
						tl_MoisColEtatCivil{3}:=tl_MoisColEtatCivil{3}+1
					: ($va_EtCv="HF") | ($va_EtCv="HE") | ($va_EtCv="FF") | ($va_EtCv="FE") | ($va_EtCv="FP") | ($va_EtCv="HP")
						tl_MoisColEtatCivil{4}:=tl_MoisColEtatCivil{4}+1
				End case 
			End if 
			NEXT RECORD:C51([HeberGement:5])
		Until (End selection:C36([HeberGement:5]))
	End if 
	$vb_OK:=(Size of array:C274(tl_MoisPersonnesSel)>0)
	CLOSE WINDOW:C154
End if 




If ($vb_OK)
	
	
	$vb_OK:=False:C215
	i_Message("Nombre de personnes hébergées en hôtel depuis… calculs")
	$jj:=Size of array:C274(tl_MoisPersonnesSel)
	ARRAY LONGINT:C221(tl_MoisPersonnes; $jj)
	ARRAY LONGINT:C221(tl_MoisPersonnesJ; $jj)
	For ($ii; 1; $jj)
		i_MessageSeul("Nombre de personnes hébergées en hôtel depuis…"+String:C10($jj)+"/"+String:C10($ii))
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=$vd_DateDuDebut; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$vd_DateDeFin; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_HB_ID:19=tl_MoisPersonnesSel{$ii}; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
		MultiSoc_Filter(->[HeberGement:5])
		tl_MoisPersonnesJ{$ii}:=Records in selection:C76([HeberGement:5])
		
		$kk:=0
		Repeat 
			$kk:=$kk+1
			$vb_OK:=(tl_MoisPersonnesJ{$ii}<=tl_MoisDateJoursPlus{$kk})
		Until ($vb_OK)
		tl_MoisDatePersonnes{$kk}:=tl_MoisDatePersonnes{$kk}+1
	End for 
	$vl_Total:=tl_MoisDatePersonnes{1}+tl_MoisDatePersonnes{2}+tl_MoisDatePersonnes{3}+tl_MoisDatePersonnes{4}+tl_MoisDatePersonnes{5}+tl_MoisDatePersonnes{6}
	CLOSE WINDOW:C154
	
End if 



OB SET:C1220($O_Objet; "$vb_OK"; $vb_OK)
OB SET ARRAY:C1227($O_Objet; "ta_MoisColEtatCivil"; ta_MoisColEtatCivil)
OB SET ARRAY:C1227($O_Objet; "td_DateAfficheDebut"; td_DateAfficheDebut)
OB SET ARRAY:C1227($O_Objet; "td_DateAfficheFin"; td_DateAfficheFin)
OB SET ARRAY:C1227($O_Objet; "te_MoisDateIndices"; te_MoisDateIndices)
OB SET ARRAY:C1227($O_Objet; "tl_MoisColEtatCivil"; tl_MoisColEtatCivil)
OB SET ARRAY:C1227($O_Objet; "tl_MoisDateJours"; tl_MoisDateJours)
OB SET ARRAY:C1227($O_Objet; "tl_MoisDateJoursPlus"; tl_MoisDateJoursPlus)
OB SET ARRAY:C1227($O_Objet; "tl_MoisDatePersonnes"; tl_MoisDatePersonnes)
OB SET ARRAY:C1227($O_Objet; "tl_MoisPersonnes"; tl_MoisPersonnes)
OB SET ARRAY:C1227($O_Objet; "tl_MoisPersonnesHB"; tl_MoisPersonnesHB)
OB SET ARRAY:C1227($O_Objet; "tl_MoisPersonnesJ"; tl_MoisPersonnesJ)
OB SET ARRAY:C1227($O_Objet; "tl_MoisPersonnesSel"; tl_MoisPersonnesSel)

$P_Objet->:=OB Copy:C1225($O_Objet)