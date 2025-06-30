//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction:  F_DisponibilitéCentres
//{
//{          Lundi 20 décembre 2004 à 17:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_DATE:C307($1; $D_Date)
C_LONGINT:C283($2; $L_AvecMessage)  //message oui/non
C_LONGINT:C283($3; $L_AvecProlongation)  //0 sans 1 avec : prolongation
C_POINTER:C301($4; $P_NbLitsJour)  //vl_NbLitsJour
C_POINTER:C301($5; $P_NbLitsNuit)  //vl_NbLitsNuit

$D_Date:=$1  // #20170626-2
$L_AvecMessage:=$2  // #20170626-2
$L_AvecProlongation:=$3  // #20170626-2
$P_NbLitsJour:=$4  // #20170626-2
$P_NbLitsNuit:=$5  // #20170626-2

QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)
MultiSoc_Filter(->[LesCentres:9])  //3/2/2009

QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin; *)  //3/2/2009
MultiSoc_Filter(->[LesCentres:9])

QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Prestation:55=False:C215)
MultiSoc_Filter(->[LesCentres:9])

If (Records in selection:C76([LesCentres:9])>0)
	
	If ($L_AvecMessage=1)
		i_Message("Création en cours …")
	End if 
	
	READ WRITE:C146([CentresLits:16])
	
	Repeat   // Décompte des hébergements jour ou nuit par centre
		// Pour les reportés stantards
		USE SET:C118("◊E_HGrep")
		P_DisponibilitéCentresNb(1; [LesCentres:9]LC_RéférenceID:1; -><>vl_CtrRepStdJ; -><>vl_CtrRepStdN)
		
		// Pour les Excusés qui reviennent et entrent à nouveau en reportés stantards
		USE SET:C118("◊E_HGrepE")
		P_DisponibilitéCentresNb(1; [LesCentres:9]LC_RéférenceID:1; -><>vl_CtrRepRetJ; -><>vl_CtrRepRetN)
		
		// Pour le décompte des remplaçants   en reportés stantards
		USE SET:C118("◊E_HGrepRp")
		P_DisponibilitéCentresNb(1; [LesCentres:9]LC_RéférenceID:1; -><>vl_CtrRepRplJ; -><>vl_CtrRepRplN)
		
		// Pour le décompte des sortants
		USE SET:C118("◊E_HGrepS")
		P_DisponibilitéCentresNb(1; [LesCentres:9]LC_RéférenceID:1; -><>vl_CtrRepSorJ; -><>vl_CtrRepSorN)
		
		If ($L_AvecProlongation=1)  // Pour la gestion des prolongements et entrent à nouveau en reportés stantards
			USE SET:C118("◊E_HGrepP")
			P_DisponibilitéCentresNb(2; [LesCentres:9]LC_RéférenceID:1; -><>vl_CtrRepProJ; -><>vl_CtrRepProN)
		Else 
			<>vl_CtrRepProJ:=0
			<>vl_CtrRepProN:=0
		End if 
		
		If ($P_NbLitsJour->=0)
			
			If ([LesCentres:9]LC_Fermé:53=False:C215)
				P_DisponibilitéCréer(1; "J"; $D_Date; <>vl_CtrRepStdJ; <>vl_CtrRepSorJ; <>vl_CtrRepProJ; <>vl_CtrRepRetJ; <>vl_CtrRepRplJ)
			End if 
			
		End if 
		
		If ($P_NbLitsNuit->=0)
			
			If ([LesCentres:9]LC_Fermé:53=False:C215)
				P_DisponibilitéCréer(1; "N"; $D_Date; <>vl_CtrRepStdN; <>vl_CtrRepSorN; <>vl_CtrRepProN; <>vl_CtrRepRetN; <>vl_CtrRepRplN)
			End if 
			
		End if 
		
		NEXT RECORD:C51([LesCentres:9])
	Until (End selection:C36([LesCentres:9]))
	
	READ ONLY:C145([CentresLits:16])
	
	If ($L_AvecMessage=1)
		CLOSE WINDOW:C154
	End if 
	
	$0:=(($P_NbLitsJour->=0) | ($P_NbLitsNuit->=0))
End if 