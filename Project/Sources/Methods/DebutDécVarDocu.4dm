//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DebutDécVarDocu
//{
//{          Jeudi 15 octobre 2009 à 11:38
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)

Case of 
	: ($1=0)
		//Les données 
		C_TEXT:C284(vt_DocuDécode)
		C_TEXT:C284(va_DocuIndice)
		C_TEXT:C284(va_DocuTitre)
		C_TEXT:C284(va_DocuEtCv)
		C_TEXT:C284(va_DocuDateFiche)
		C_DATE:C307(vd_DocuDateFiche)
		C_TEXT:C284(va_DocuNo)
		C_TEXT:C284(va_DocuCle)
		C_TEXT:C284(va_DocuNom)
		C_TEXT:C284(va_DocuPrenom)
		C_TEXT:C284(va_DocuNele)
		C_TEXT:C284(va_DocuOrient1)
		C_TEXT:C284(va_DocuAge)
		C_TEXT:C284(va_DocuNC)
		C_TEXT:C284(va_DocuNT)
		C_TEXT:C284(va_DocuCleFam)
		C_TEXT:C284(va_DocuPLATEFORME)
		C_BOOLEAN:C305(vb_DocuChefFam)
		//C_ALPHA(80;va_DocuE)
		C_TEXT:C284(va_DocuE)
		C_TEXT:C284(vt_DocuT)
		C_LONGINT:C283(ve_DocuStatut)
		C_TEXT:C284(va_DocuStatut)
		
		C_BOOLEAN:C305(vb_DocuCleCodeEtat)
		C_TEXT:C284(va_DocuCleCode)
		
		C_DATE:C307(vd_DateDocu)
		C_TEXT:C284(va_DateDocu)
		
		C_LONGINT:C283(vl_RépNombre; vl_DateNombre)
		C_TEXT:C284(va_DateNombre)
		
		C_TEXT:C284(vt_RépTrans; vt_RépCentre; vt_RépCentreLu; vt_RépDocu; vt_LeDocument)
		C_TEXT:C284(vt_CheminDuDocu; vt_CheminDuDocuNew; vt_ContenuDuDocu; vt_ContenuNote)
		
		
		ARRAY TEXT:C222(tt_TransDocu; 0)
		ARRAY TEXT:C222(tt_TransDocuDisk; 0)
		ARRAY INTEGER:C220(te_TransDocuCas; 0)
		ARRAY TEXT:C222(ta_TransDocuTri; 0)
		
		
		ARRAY DATE:C224(td_DocuDates; 0)
		ARRAY TEXT:C222(ta_DocuDates; 0)
		
		
		C_BOOLEAN:C305(vb_CinqOctDeuxMilNeuf)  //Nouvel ordre et champs d'export créé le 5/10/2009
		
		DebutDécVarDocu(1)
		
	: ($1=1)
		vt_DocuDécode:=""
		va_DocuIndice:=""
		va_DocuTitre:=""
		va_DocuEtCv:=""
		va_DocuDateFiche:=""
		vd_DocuDateFiche:=!00-00-00!
		va_DocuNo:=""
		va_DocuCle:=""
		va_DocuNom:=""
		va_DocuPrenom:=""
		va_DocuNele:=""
		va_DocuOrient1:=""
		va_DocuAge:=""
		va_DocuNC:=""
		va_DocuNT:=""
		va_DocuCleFam:=""
		va_DocuPLATEFORME:=""
		vb_DocuChefFam:=False:C215
		va_DocuE:=""
		vt_DocuT:=""
		ve_DocuStatut:=0
		va_DocuStatut:=""
		
		vb_DocuCleCodeEtat:=False:C215
		va_DocuCleCode:=""
		
		vd_DateDocu:=!00-00-00!
		va_DateDocu:=""
		
		vl_RépNombre:=0
		vl_DateNombre:=0
		va_DateNombre:=""
		
		vt_RépTrans:=""
		vt_RépCentre:=""
		vt_RépCentreLu:=""
		vt_RépDocu:=""
		vt_LeDocumen:=""
		
		tvt_CheminDuDocu:=""
		vt_CheminDuDocuNew:=""
		vt_ContenuDuDocu:=""
		vt_ContenuNote:=""
		
		vb_CinqOctDeuxMilNeuf:=False:C215
		
	: ($1=2)
		vt_DocuDécode:=""
		va_DocuIndice:=""
		va_DocuTitre:=""
		va_DocuEtCv:=""
		va_DocuDateFiche:=""
		vd_DocuDateFiche:=!00-00-00!
		va_DocuNo:=""
		va_DocuCle:=""
		va_DocuNom:=""
		va_DocuPrenom:=""
		va_DocuNele:=""
		va_DocuOrient1:=""
		va_DocuAge:=""
		va_DocuNC:=""
		va_DocuNT:=""
		va_DocuCleFam:=""
		vb_DocuChefFam:=False:C215
		va_DocuE:=""
		vt_DocuT:=""
		ve_DocuStatut:=0
		va_DocuStatut:=""
		
		vb_CinqOctDeuxMilNeuf:=False:C215
		
End case 



