//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Méthode : P_Planing_Charger
//{
//{          Mercredi 12 janvier 2011 à 11:20:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)  //Date du jour sélectionné
C_LONGINT:C283($2)  //ID de l'utilisateur

C_TEXT:C284($va_Temp; $va_Temp2)
C_LONGINT:C283($ve_AnnéeJ; ve_SemJ; $ve_SemJ)
C_BOOLEAN:C305($vb_OK)
C_DATE:C307($vd_DateJ; $vd_DateDeb; $vd_DateFin; $vd_DateDuJour)

C_POINTER:C301(vp_Btn; vp_Image; vp_JD; vp_Jour; vp_Hono; vp_Frai)

$vd_DateDuJour:=Current date:C33

$vd_DateJ:=$1
$ve_AnnéeJ:=Year of:C25($1)

// Calcul du n° de semaine
$ve_SemJ:=Upg_NumSemaine($vd_DateJ)
ve_SemJ:=$ve_SemJ

If (Day number:C114($vd_DateJ)#2)  // Calcul du premier jour de la semaine : Lundi
	
	Repeat 
		$vd_DateJ:=$vd_DateJ-1
	Until (Day number:C114($vd_DateJ)=2)
	
End if 

// Calcul du premier et dernier jour
vd_DateRef:=$vd_DateJ

$vd_DateDeb:=$vd_DateJ
$vd_DateFin:=$vd_DateJ+6

veD1:=Day of:C23($vd_DateDeb)
vdD1:=$vd_DateDeb

veD2:=Day of:C23($vd_DateDeb+1)
vdD2:=($vd_DateDeb+1)

veD3:=Day of:C23($vd_DateDeb+2)
vdD3:=($vd_DateDeb+2)

veD4:=Day of:C23($vd_DateDeb+3)
vdD4:=($vd_DateDeb+3)

veD5:=Day of:C23($vd_DateDeb+4)
vdD5:=($vd_DateDeb+4)

veD6:=Day of:C23($vd_DateDeb+5)
vdD6:=($vd_DateDeb+5)

veD7:=Day of:C23($vd_DateDeb+6)
vdD7:=($vd_DateDeb+6)

// Rond d'aujourd'hui
OBJECT SET VISIBLE:C603(*; "D_Jour@"; False:C215)

If ($vd_DateDuJour>=$vd_DateDeb) & ($vd_DateDuJour<=$vd_DateFin)
	OBJECT SET VISIBLE:C603(*; "D_Jour"+String:C10(Day number:C114($vd_DateDuJour)); True:C214)
End if 

// Libellé de la semaine
va_Semaine:="Du "+String:C10(Day of:C23($vd_DateDeb); "00")+"/"+String:C10(Month of:C24($vd_DateDeb); "00")+" au "+String:C10(Day of:C23($vd_DateFin); "00")+"/"+String:C10(Month of:C24($vd_DateFin); "00")+"   "+String:C10(Year of:C25($vd_DateFin); "0000")

$vb_OK:=F_Planning_OP(1)

OBJECT SET VISIBLE:C603(*; "b_Cadre_V_@"; False:C215)
OBJECT SET VISIBLE:C603(*; "i_Trou_@"; True:C214)

QUERY:C277([Objets_Planification:57]; [Objets_Planification:57]OP_Objet_ID:2=$2; *)
QUERY:C277([Objets_Planification:57];  & ; [Objets_Planification:57]OP_Date:3>=$vd_DateDeb; *)
QUERY:C277([Objets_Planification:57];  & ; [Objets_Planification:57]OP_Date:3<=$vd_DateFin)
MultiSoc_Filter(->[Objets_Planification:57])

If (Records in selection:C76([Objets_Planification:57])>0)
	
	Repeat 
		$va_Temp:=String:C10([Objets_Planification:57]OP_Rang:5; "0")
		$va_Temp2:=String:C10(Day number:C114([Objets_Planification:57]OP_Date:3); "0")
		
		If ($va_Temp2="1")
			$va_Temp2:="7"
		Else 
			$va_Temp2:=String:C10(Num:C11($va_Temp2)-1; "0")
		End if 
		
		vp_UnPointeur:=Get pointer:C304("vl_NomID_"+$va_Temp+"_"+$va_Temp2)
		vp_UnPointeur->:=[Objets_Planification:57]OP_Référence:1
		
		vp_UnPointeur:=Get pointer:C304("va_Nom_"+$va_Temp+"_"+$va_Temp2)
		vp_UnPointeur->:=[Objets_Planification:57]OP_Hébergé_Clé:7
		
		vp_UnPointeur:=Get pointer:C304("va_OPEat_"+$va_Temp+"_"+$va_Temp2)
		vp_UnPointeur->:=[Objets_Planification:57]OP_Etat:8
		
		OBJECT SET VISIBLE:C603(*; "b_Cadre_V_"+$va_Temp+"_"+$va_Temp2; True:C214)
		OBJECT SET VISIBLE:C603(*; "i_Trou_"+$va_Temp+"_"+$va_Temp2; False:C215)
		
		NEXT RECORD:C51([Objets_Planification:57])
	Until (End selection:C36([Objets_Planification:57]))
	
End if 