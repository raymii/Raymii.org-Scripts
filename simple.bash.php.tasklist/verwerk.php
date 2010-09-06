<?php
### Copyright (c) 2010 Remy van Elst
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.

$sumbit=$_POST['submit'];
#linkje naar de index
echo"<a href=\"index.php\">Terug naar de lijst.</a><br /><br />\n";

#dit zet de taken in de queue die door het crontab shellscript gebruikt word.
function zetindelijst($todo) {
	$todo = $todo . "\n";
	$tasklist = fopen("tasks.php", "a+");
	if($tasklist) {
			$taskwrite = fwrite($tasklist,$todo);
			if($taskwrite) {
				echo "<br />\nTaak is succesvol weggeschreven in de que.";
			} else {
				die("Fout tijdens schrijven van bestand");
			}
	} else {
		die("Fout bij openen van bestand.");
	}
}

function taaklimiet() {
	$ipcount = 0;
	$bip =  isset($_SERVER['HTTP_X_FORWARDED_FOR']) ? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['REMOTE_ADDR'];
	$ip = $bip . "\n";
	$iplist = fopen("iplist.txt", "a+");
	if($iplist) {
		$ipwrite = fwrite($iplist,$ip);
		if(!$ipwrite) {
			echo "IP $ip kan niet opgelsagen worden.<br /> \n";
		}
		$ip_file = file('iplist.txt');
		foreach ($ip_file as $ip_num => $los_ip) {
			if($ip == $los_ip) {
				$ipcount++;
			}
		}
		if($ipcount > 4) {
			echo "Je hebt te veel taken toegevoegd. Wacht een half uurtje en doe het dan nog eens.<br />\n";
			die("Error: Tasklimit reached.");
		}
	} else {
		die("Fout bij openen van lijst");
	}
	echo $ipcount;
}

taaklimiet();

if($_SERVER['REQUEST_METHOD'] == 'POST') {
	$taak=$_POST['taak'];
	$pw=$_POST['pw'];
	$cat=$_POST['category'];
	#md5 hash your password and put it in the following variable. it is filled with the md5 has of the word password.
	$pwval="5f4dcc3b5aa765d61d8327deb882cf99";
	if(empty($taak)) {
		die("Voer een taak in.<br /> \n");
	}
	if(empty($pw)) {
		die("Voer een wachtwoord in.<br /> \n");
	}
	if(empty($cat)) {
		die("Categorie mag niet leeg zijn.<br /> \n");
	}
	$striptaak = preg_replace("/\W/", " ", $taak);
	$stripcat = preg_replace("/\W/", " ", $cat);
	$strippw = stripslashes(htmlspecialchars(htmlentities($pw)));
	echo "<br /> \n";

	if(md5($strippw) == $pwval) {
			$taakcompleet = "$stripcat - $striptaak";
			echo("Taak: $taakcompleet <br /> \nis verwerkt en wordt in de que gezet.<br /> \n<br /> \n");
			zetindelijst($taakcompleet);
		} else {
			die("Het wachtwoord is fout.<br /> \n");
		}
} else {
		die("Deze pagina mag niet zonder geldige invoer aangeroepen worden.");

}
?>

