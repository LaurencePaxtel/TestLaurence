//%attributes = {}

C_TEXT:C284($vDestinationFolder)
_O_ARRAY STRING:C218(80; aFileNames; 0)

$vDestinationFolder:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"photos"+Séparateur dossier:K24:12
DOCUMENT LIST:C474($vDestinationFolder; aFileNames)