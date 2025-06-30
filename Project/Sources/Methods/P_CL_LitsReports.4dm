//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CL_LitsReports
//{
//{          Mardi 13 Février 2001 à 11:55:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)

i_Message("Disponibilités du "+String:C10($1)+"…")

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=($1-1); *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95>0; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)

//4/11/2008
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
//Fin 4/11/2008

QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94#<>va_RepA)

MultiSoc_Filter(->[HeberGement:5])

If (Records in selection:C76([HeberGement:5])>0)
	CREATE SET:C116([HeberGement:5]; "E_HGrep")
Else 
	CREATE EMPTY SET:C140([HeberGement:5]; "E_HGrep")
End if 

ALL RECORDS:C47([LesCentres:9])
MultiSoc_Filter(->[LesCentres:9])

If (Records in selection:C76([LesCentres:9])>0)
	
	Repeat 
		$vl_JRep:=0
		$vl_NRep:=0
		
		USE SET:C118("E_HGrep")
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=[LesCentres:9]LC_RéférenceID:1)
		
		If (Records in selection:C76([HeberGement:5])>0)
			FIRST RECORD:C50([HeberGement:5])
			
			Repeat 
				
				If ([HeberGement:5]HG_Nuit:2)
					$vl_NRep:=$vl_NRep+1
				Else 
					$vl_JRep:=$vl_JRep+1
				End if 
				
				NEXT RECORD:C51([HeberGement:5])
			Until (End selection:C36([HeberGement:5]))
		End if 
		
		If ([LesCentres:9]LC_Fermé:53=False:C215)
			P_DisponibilitéCréer(3; "J"; $1; $vl_JRep; 0; 0; 0; 0)
		End if 
		
		NEXT RECORD:C51([LesCentres:9])
	Until (End selection:C36([LesCentres:9]))
	
End if 

CLOSE WINDOW:C154