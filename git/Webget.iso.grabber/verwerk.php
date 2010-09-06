<?php
$iso=$_POST['iso'];
$ww=$_POST['ww'];
if($ww == "[PUT YOUR PASSWORD HERE BETWEEN THE QUOTES]") {
 if(!empty($iso)) {
 if ( @fopen("$iso", r) ) {
 echo "Iso Bestaat, We gaan Door \n";
 if(preg_match("/^[a-z]+://([a-z]+.)*[a-z]+/[^ ;]+.iso$/i", "$iso")) {
 echo"De link eindigd op .iso \n";
 system("echo $iso > /var/tmp/iso_addr");
 echo("De iso word gedownload. \n");
 exec("[PATH TO SHELL.SH SCRIPT]shell.sh");
 } else {
 echo"De link eindigd niet op .iso...<br \>\n";
 }
 } else {
 echo "De Link Klopt niet. Vul een goede link in.<br \>\n";
 }

 } else {
 echo"Je moet wel wat invullen<br \>\n";
 }
} else {
 echo "Je moet wel het tweede veld invullen.<br \>\n";
}

?>
