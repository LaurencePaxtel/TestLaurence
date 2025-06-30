//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction:  F_DisponibilitéHébergnt
//{
//{          Lundi 20 décembre 2004 à 17:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_DATE:C307($1)
C_LONGINT:C283($2)

C_LONGINT:C283($ii)
C_DATE:C307($D_Date)

$D_Date:=$1

//Les à reporter standard
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=($D_Date-1); *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95>0; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94#<>va_RepA)

MultiSoc_Filter(->[HeberGement:5])

If (Records in selection:C76([HeberGement:5])>0)
	CREATE SET:C116([HeberGement:5]; "◊E_HGrep")
End if 

//Les sortants
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=($1-1); *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95=0; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
MultiSoc_Filter(->[HeberGement:5])

If (Records in selection:C76([HeberGement:5])>0)
	CREATE SET:C116([HeberGement:5]; "◊E_HGrepS")
End if 

//Les remplçants
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=($1-1); *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_ER_Remplaçant:130=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95>0; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94#<>va_RepA)

MultiSoc_Filter(->[HeberGement:5])

//Les excusés
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=($1-1); *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95>0; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=False:C215; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_ER_Excuse:124=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_ER_NuitReste:129=0)

MultiSoc_Filter(->[HeberGement:5])

If (Records in selection:C76([HeberGement:5])>0)
	CREATE SET:C116([HeberGement:5]; "◊E_HGrepE")
End if 

If ($2=1)  //Prolongations
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=($1-1); *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95=0; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94#<>va_RepA)
	
	MultiSoc_Filter(->[HeberGement:5])
	
	If (Records in selection:C76([HeberGement:5])>0)
		
		Repeat 
			QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_HB_Référence:3=[HeberGement:5]HG_HB_ID:19)
			
			If (Records in selection:C76([GroupeHeberges:37])=1)
				QUERY:C277([GrouPe:36]; [GrouPe:36]GP_ReferenceID:1=[GroupeHeberges:37]GH_GP_Référence:2)
				
				If (Records in selection:C76([GrouPe:36])=1)
					QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GrouPe:36]GP_ReferenceID:1)
					
					If (Records in selection:C76([Prolongation:38])>0)
						QUERY SELECTION:C341([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6=$1)
						
						If (Records in selection:C76([Prolongation:38])=1)
							Tab_PR_data(2; 0)
							Tab_PR_data(3; 0)
						End if 
						
					End if 
					
				End if 
				
			End if 
			
			NEXT RECORD:C51([HeberGement:5])
		Until (End selection:C36([HeberGement:5]))
		
		Tab_PR_data(4; 0)
		CREATE SET:C116([HeberGement:5]; "◊E_HGrepP")
	End if 
	
End if 

$ii:=Records in set:C195("◊E_HGrep")
$ii:=$ii+Records in set:C195("◊E_HGrepS")
$ii:=$ii+Records in set:C195("◊E_HGrepE")

If ($2=1)  // Prolongations
	$ii:=$ii+Records in set:C195("◊E_HGrepP")
End if 

$0:=($ii>0)