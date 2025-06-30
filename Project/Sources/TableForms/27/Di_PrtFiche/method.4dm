$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur entête:K2:17)
		ve_LC_Pg:=Printing page:C275
		vt_Txti1:=""
		vt_Txti2:=""
		vt_Txti3:=""
		vt_Txti4:=""
		vt_Txti5:=""
	: ($vl_EventFF=Sur impression corps:K2:18)
		va_MRsexe:=("F"*Num:C11([DossierInfirmie:27]DI_Genre:18=True:C214))+("M"*Num:C11([DossierInfirmie:27]DI_Genre:18=False:C215))
		vt_Texte:=[HeBerge:4]HB_Infirmier:43
		
		vt_Txti1:=""
		vt_Txti2:=""
		vt_Txti3:=""
		vt_Txti4:=""
		vt_Txti5:=""
		_O_ALL SUBRECORDS:C109([DossierInfirmie:27]DI_IndicesTypes:23)
		If (_O_Records in subselection:C7([DossierInfirmie:27]DI_IndicesTypes:23)>0)
			_O_FIRST SUBRECORD:C61([DossierInfirmie:27]DI_IndicesTypes:23)
			Repeat 
				vt_Txti1:=vt_Txti1+[DossierInfirmie]DI_IndicesTypes'Indice+Char:C90(13)
				vt_Txti2:=vt_Txti2+[DossierInfirmie]DI_IndicesTypes'Libellé+Char:C90(13)
				_O_NEXT SUBRECORD:C62([DossierInfirmie:27]DI_IndicesTypes:23)
			Until (_O_End subselection:C37([DossierInfirmie:27]DI_IndicesTypes:23))
		End if 
		_O_ALL SUBRECORDS:C109([DossierInfirmie:27]DI_DépendTypes:25)
		If (_O_Records in subselection:C7([DossierInfirmie:27]DI_DépendTypes:25)>0)
			_O_FIRST SUBRECORD:C61([DossierInfirmie:27]DI_DépendTypes:25)
			Repeat 
				vt_Txti3:=vt_Txti3+[DossierInfirmie]DI_DépendTypes'Type+Char:C90(13)
				_O_NEXT SUBRECORD:C62([DossierInfirmie:27]DI_DépendTypes:25)
			Until (_O_End subselection:C37([DossierInfirmie:27]DI_DépendTypes:25))
		End if 
		
		_O_ALL SUBRECORDS:C109([DossierInfirmie:27]DI_PathoTypes:31)
		If (_O_Records in subselection:C7([DossierInfirmie:27]DI_PathoTypes:31)>0)
			_O_FIRST SUBRECORD:C61([DossierInfirmie:27]DI_PathoTypes:31)
			Repeat 
				vt_Txti4:=vt_Txti4+[DossierInfirmie]DI_PathoTypes'Pathologie+Char:C90(13)
				vt_Txti5:=vt_Txti5+[DossierInfirmie]DI_PathoTypes'Libellé+Char:C90(13)
				_O_NEXT SUBRECORD:C62([DossierInfirmie:27]DI_PathoTypes:31)
			Until (_O_End subselection:C37([DossierInfirmie:27]DI_PathoTypes:31))
		End if 
End case 
