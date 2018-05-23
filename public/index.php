
<?php
require '../vendor/autoload.php';

//postgres
$dbName = getenv('DB_NAME');
$dbUser = getenv('DB_USER');
$dbPassword = getenv('DB_PASSWORD');
$connection = new PDO("pgsql:host=postgres user=$dbUser dbname=$dbName password=$dbPassword");

$userRepository = new \User\UserRepository($connection);
$users = $userRepository->fetchAll();
?>


<html>
  <head>
    <link rel="stylesheet" href="presentation_pages.css" type="text/css">
    <meta charset="utf-8" />
    <title>Blog de voyage </title>
  </head>
  <body>

    <nav>
    <ul>
      <li><a href="page_accueil.html">Accueil</a></li>
      <li><a href="recherche.html">Recherche destination</a></li>
      <li><a href="formulaire_contact.html">Contact</a></li>
    </ul>
    </nav>
    
    <h1> Présentation du contexte</h1>
    <p> 
    blabla présentation contexte
    <?php foreach ($users as $user) : 
    if ($user->getPseudo()=="1") {
    
    echo $user->getnom();} ?>
    <?php endforeach; ?>
    </p>
    <h1>Les destinations du moment:</h1>
    <a href=""> <p><em>Bayonne</em></p> <img src="/data/bayonne.jpg" width="320" alt="bayonne"/> </a>

    
    <connexion>
      <form action="connexion.php" method="post">
       <p>
	 <label for="Pseudo">   Pseudo:</label>
	 <input type="text" size="5" name="Pseudo" id="Pseudo size=10"/>
       </p>
       <p>
	 <label for="mdp">   Mot de passe:</label>
	 <input type="password" size="5" name="mdp" id="mdp"/>
	 
       </p>
       <input type="submit" value="Se connecter"/>
      </form>

      <br/>
       
      <ut><p>Pas encore utilisateur?</p></ut>
      <form action="creation_compte.html" method="post">
	<input type="submit" value="Créer un compte"/>
      </form>
    </connexion> 
  </body>

  <footer>
  </footer>
  
</html>
