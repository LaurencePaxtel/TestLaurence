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
		va_MRsexe:=("F"*Num:C11([DossierPsycho:28]DY_Genre:18=True:C214))+("M"*Num:C11([DossierPsycho:28]DY_Genre:18=False:C215))
		vt_Texte:=[HeBerge:4]HB_Psycho:44
		
		vt_Txti1:=""
		vt_Txti2:=""
		vt_Txti3:=""
		vt_Txti4:=""
		vt_Txti5:=""
		_O_ALL SUBRECORDS:C109([DossierPsycho:28]DY_AntéTypes:21)
		If (_O_Records in subselection:C7([DossierPsycho:28]DY_AntéTypes:21)>0)
			_O_FIRST SUBRECORD:C61([DossierPsycho:28]DY_AntéTypes:21)
			Repeat 
				vt_Txti1:=vt_Txti1+[DossierPsycho]DY_AntéTypes'Type_S+Char:C90(13)
				vt_Txti2:=vt_Txti2+[DossierPsycho]DY_AntéTypes'Libellé+Char:C90(13)
				vt_Txti3:=vt_Txti3+[DossierPsycho]DY_AntéTypes'Lieu+Char:C90(13)
				_O_NEXT SUBRECORD:C62([DossierPsycho:28]DY_AntéTypes:21)
			Until (_O_End subselection:C37([DossierPsycho:28]DY_AntéTypes:21))
		End if 
		_O_ALL SUBRECORDS:C109([DossierPsycho:28]DY_EtatPsyTypes:23)
		If (_O_Records in subselection:C7([DossierPsycho:28]DY_EtatPsyTypes:23)>0)
			_O_FIRST SUBRECORD:C61([DossierPsycho:28]DY_EtatPsyTypes:23)
			Repeat 
				vt_Txti4:=vt_Txti4+[DossierPsycho]DY_EtatPsyTypes'Type_S+Char:C90(13)
				vt_Txti5:=vt_Txti5+[DossierPsycho]DY_EtatPsyTypes'Commentaire+Char:C90(13)
				_O_NEXT SUBRECORD:C62([DossierPsycho:28]DY_EtatPsyTypes:23)
			Until (_O_End subselection:C37([DossierPsycho:28]DY_EtatPsyTypes:23))
		End if 
End case 
