//%attributes = {}
C_BLOB:C604(Blob)
$image:=<>vi_Limage
PICTURE TO BLOB:C692(<>vi_Limage; Blob; "JPEG")
BLOB TO DOCUMENT:C526(":DossierWeb:image.jpg"; Blob)