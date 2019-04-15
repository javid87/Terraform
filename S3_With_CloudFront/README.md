![AWS S3 with CloudFront](
https://user-images.githubusercontent.com/34796494/56144766-a55ea380-5fab-11e9-816a-674878d46246.PNG)


# English:
This is Basic Terraform confguration with two modules ( security, storage )
Storage Module - Create two Bucket. One of them is Basic Log buget that logging All access log. Secondary Bucket is our Site bucket where we put our site data ( in my case index.html and error.html ). you can change this files with your own files. 

Security Module - CloudFront with HTTP to HTTPS redirection and SSL cert ( if you have cert you must do some changes in security/main.tf for use your own TLS certificate ). For validate you certificate you must create DNS record manualy ( i try find and solve this as soon as possile ).

P.S: I'm new in terraform becouse i'm very happy if any one help improve this modules. Thanks

# Azerbaijan:
Salam Dostlar. Bu Terraformda sade S3 bucket ve CloudFront baglamasindan ibaret iki modullu( security, storage )  Terraform konfigurasiyadir.
Storage Module - Burada iki Bucket yaradilir. Bir Bucket sade Log bucketdir hansi ki ozunde bizim sehfemizie ziyaret edenlerin access loglarin toplayacaq. Ikinci ise bizim saytimizin melumatlari yerleshen esas bucketdir. Burada men oz file-larimizi yerleshdirmishem ( index.html ve error.html ) siz bu filelari oz shexsi fayllarinzla deyishe bielrsiniz.

Security Module - Burada CLoudFront service ishe dushur ve HTTP sprgulari https redirect edir ve TLS certificate ishe salir. ( sizin shexsi certificate-niz artiq varsa bunu security/main.tf deyishiklik etmelisiniz ve oz shexsi TLS cert yerleshdirmelisiniz ) certificate validation uchun Route53 recordlar el ile yaradilmalidir ( Bunun uzerinde maximum chalishiram tez bir zamanda bunuda code halina salacaqam ).

P.S: Men Terraformdan yeni istfadeye bashlamisham. Bunun uchun stenilen gozel meslehete ve tovsiyyeye cox shad olaram. Teshekkur edirem :)
