//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementClignote
//{
//{          Mardi 11 Mai 2004 à 10:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)

Case of 
	: ($1=0)
		vl_CasSP:=0
		vb_CasSP:=False:C215
		vl_CasSP:=F_CasSP([HeberGement:5]HG_HB_ID:19; 1)
		vb_CasSP:=True:C214
		Case of 
			: (vl_CasSP=-1)
				OBJECT SET VISIBLE:C603(*; "Cligne_SP"; True:C214)
				vb_CasSP:=True:C214
			: (vl_CasSP=0)
				OBJECT SET VISIBLE:C603(*; "Cligne_SP"; False:C215)
				vb_CasSP:=False:C215
			: (vl_CasSP>0)
				OBJECT SET VISIBLE:C603(*; "Cligne_SP"; True:C214)
				vb_CasSP:=True:C214
				SET TIMER:C645(60)
		End case 
		
		
		
		vl_CasSiao:=0
		vb_Casiao:=True:C214
		
		If ([HeberGement:5]HG_DossierSIAO:164>"")
			$va_Cas:=Substring:C12([HeberGement:5]HG_DossierSIAO:164; 1; 1)
			If ($va_Cas="1") | ($va_Cas="2") | ($va_Cas="3")
				vl_CasSiao:=1
			End if 
		End if 
		
		
		
		Case of 
			: (vl_CasSiao=-1)
				OBJECT SET VISIBLE:C603(*; "Cligne_Siao"; True:C214)
				vb_Casiao:=True:C214
			: (vl_CasSiao=0)
				OBJECT SET VISIBLE:C603(*; "Cligne_Siao"; False:C215)
				vb_Casiao:=False:C215
			: (vl_CasSiao>0)
				OBJECT SET VISIBLE:C603(*; "Cligne_Siao"; True:C214)
				vb_Casiao:=True:C214
				SET TIMER:C645(60)
		End case 
		
	: ($1=1)
		If (vl_CasSP#0)
			OBJECT SET VISIBLE:C603(*; "Cligne_SP"; vb_CasSP)
			vb_CasSP:=Not:C34(vb_CasSP)
		End if 
		
	: ($1=2)
		If (vl_CasSiao#0)
			OBJECT SET VISIBLE:C603(*; "Cligne_Siao"; vb_Casiao)
			vb_Casiao:=Not:C34(vb_Casiao)
		End if 
		
End case 