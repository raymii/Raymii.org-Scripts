<html>
<head>
<title>Simple todolist</title>
</head>
<body>
<form action="verwerk.php" method="post">
Taak:<br />
<select name="category">
<option name="Normaal">Gewoon</option>
<option name="Urgent">Urgent</option>
<option name="Nog_te_Bellen">Nog te bellen</option>
<option name="Service_Tag">Servicetags</option>
<option name="MAC">MAC adressen</option>
<option name="Lange_Termijn">Lange Termijn</option>
</select>
- <input type="text" name="taak" /> -
<input type="password" name="pw"><br />
<input type="submit" name="submit" value="Taak Toevoegen" /><br />
</form>
</body>
</html>
