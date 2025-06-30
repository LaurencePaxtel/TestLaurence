//%attributes = {}
$ii:=Find in array:C230(ta_FilexEtCiv; [HeberGement:5]HG_EtatCivil:20)
If ($ii>0)
	[HeberGement:5]HG_EtatCivil:20:=ta_FileEtCiv{$ii}
End if 