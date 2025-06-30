//%attributes = {}
[Maraude:24]MR_DuréRencontr:79:=[Maraude:24]MR_HeureFin:23-[Maraude:24]MR_HeureDebut:22
If ([Maraude:24]MR_DuréRencontr:79<?00:00:00?)
	
	[Maraude:24]MR_DuréRencontr:79:=(?24:00:00?-[Maraude:24]MR_HeureDebut:22)+[Maraude:24]MR_HeureFin:23
End if 