//%attributes = {}
C_BLOB:C604(Blob)
$image:=<>vi_Limage
PICTURE TO BLOB:C692(<>i_image; Blob; "JPEG")
WEB SEND BLOB:C654(Blob; "image/jpeg")