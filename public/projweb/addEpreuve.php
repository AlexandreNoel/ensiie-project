
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
<title>Ajout d'épreuve</title>
</head>
<body>
<link rel="stylesheet" type="text/css" href="style.css" />

<div class="navbar">
  <a href="#accueil"><a href="./main.html">Accueil</a></a>
  <a href="#candidats"><a href="./classement.php">Classement</a></a>
  <a href='#epreuves'><a href="./epreuves.php">Épreuves</a></a>
  <a href="#login"><a href="./login.html">Login</a>
  <a href="#signup"><a href="./Inscription.html">S'enregistrer</a></a>
  <a href="#admin"><a href="./administration.php">Administration</a></a>
  <a href="#deconnexion"><a href="./deconnexion.php">Déconnexion</a></a>
</div>
<br/><br/>
<link rel="stylesheet" type="text/css" href="style.css" />
<form method="post" action="add.php">
	Nom de l'épreuve (50 caractères max)<br/>
	<textarea name='nom' id='nom'></textarea><br />
	Description de l'épreuve (1000 caractères max)<br/>
	<textarea name='description' id='description'></textarea><br />
	Date de l'épreuve <br/>
	<input type="date" name="date" /><br/>
	<input type="submit" name="sub" />
</form>
</body>
</html>