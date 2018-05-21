<?php

/**
* 
*/
class EvenementsManager
{
	private $db;
	public $uMan;
	public $pMan;

	function __construct($db)
	{
		$this->db = $db;
		$this->uMan = new UserManager($db);
		$this->pMan = new ParticipantsManager($db);
	}

	function queryCategorie ($id_categorie, $conjonction) {
		if ($id_categorie)
			return " $conjonction categorie = $id_categorie "; 
		else 
			return " ";
	}


	function getId ($id)
	{
		$query = $this->db->query("SELECT * FROM Evenements WHERE id = $id");

		if ($query->rowCount() > 0) 
		{
			$resultat = $query->fetch();
			return new Evenement($resultat);
		}
		else 
		{
			echo "EvenementsManager: id:$id pas trouvé<br>";
			return null;
		}
	}

	function getMusique ($id) 
	{
		if ($id) 
		{
			$query = $this->db->query("SELECT * FROM musiques WHERE id = $id");

			if ($query->rowCount() > 0) 
			{
				$resultat = $query->fetch();
				return $resultat['musique'];
			}
			else 
			{
				echo "EvenementsManager: musique pas trouvée<br>";
				return null;
			}
		}
		else 
		{
			echo "EvenementManager: getMusique: pas de musique<br>";
		}
		
	}

	function getCategorie ($id) 
	{
		if ($id)
		{
			$query = $this->db->query("SELECT * FROM categories WHERE id = $id");

			if ($query->rowCount() > 0) 
			{
				$resultat = $query->fetch();
				return $resultat['categorie'];
			}
			else 
			{
				echo "EvenementsManager: categorie pas trouvée<br>";
				return null;
			}
		}
	}

	function getAllCategories () 
	{
		$query = $this->db->query('SELECT * FROM categories');
		return $query->fetchAll();
	}



	function getAll ($id_categorie = null) 
	{
		$query = $this->db->query('SELECT * FROM Evenements'. $this->queryCategorie($id_categorie, 'WHERE'));
		echo 'SELECT * FROM Evenements'. $this->queryCategorie($id_categorie, 'WHERE');
		$tableau_events = [];
		while ($resultat = $query->fetch()) 
		{
			$tableau_events[] = new Evenement($resultat);
		}
		return $tableau_events;
	}



	function getFirsts ($nb_evenements, $id_categorie = null) 
	{
		$query = $this->db->query('SELECT * FROM Evenements' . $this->queryCategorie($id_categorie, 'WHERE') . "ORDER BY date LIMIT $nb_evenements");
		$tableau_evenements;
		while ($resultat = $query->fetch()) 
		{
			$tableau_evenements[] = new Evenement($resultat);
		}
		return $tableau_evenements;
	}



	function update (Evenement $e)
	{
		$resultat = $this->db->query("
			UPDATE Evenements 
			SET organisateur = '$e->organisateur',
			nom = '$e->nom',
			description = '$e->description',
			lieu = '$e->lieu',
			date = '$e->date',
			date_creation = $e->date_creation,
			date_modif = ". date("Y-m-d H:i:s") ."
			before = '$e->before',
			prix = $e->prix,
			musique = '$e->musique',
			categorie = '$e->categorie'
			WHERE $id = $e->id"
		);
		if ($resultat) {
			echo "EvenementsManager: Evènement bien mis à jour <br>";
		}
		else {
			echo "EvenementsManager: Erreur lors de la mise à jour de l'évènement<br>";
		}
	}



	function add (Evenement $e)
	{
		$table_participants = 'p'. random_int(0, 10000000000);
		$all_attributs = ['organisateur', 'nom', 'description', 'lieu', 'date', 'lieu_before', 'prix', 'musique', 'categorie'];
		$liste_attributs;
		$liste_valeurs;
		foreach ($all_attributs as $attribut) {
			if ($e->$attribut) {
				$liste_attributs[] = $attribut;
				$liste_valeurs[] = $e->$attribut;
			}
		}
		$liste_attributs[] = 'date_creation';
		$liste_valeurs[] = date("Y-m-d H:i:s");
		$liste_attributs[] = 'table_participants';
		$liste_valeurs[] = $table_participants;

		$valide = true;
		$obligatoires = ['organisateur', 'nom', 'lieu', 'date', 'prix'];
		foreach ($obligatoires as $value) {
			if (! in_array($value, $all_attributs)) {
				$valide = false;
			}
		}


		if ($valide) {
			$liste_attributs = join(', ', $liste_attributs);
			$liste_valeurs = join("', '", $liste_valeurs);
			$r1 = $this->db->query("INSERT INTO Evenements ($liste_attributs) VALUES ('$liste_valeurs')");
			if ($r1){

				$r2 = $this->db->query("CREATE TABLE $table_participants (id INT(10) PRIMARY KEY)");

				if ($r2)
					echo 	'<div class="alert alert-success">
		  				<strong>Votre évènement a bien été créé ! </strong> 
						</div>';
				
				else 
					echo 	"<div class='alert alert-danger'>
		  				<strong>Une erreur est survenue lors création de la table des participants</strong> 
						$this->db->errorInfo())</div>";;
			}
			else 
				echo 	"<div class='alert alert-danger'>
		  				<strong>Une erreur est survenue pendant la création de l'évènement</strong> 
						$this->db->errorInfo())</div>";

		}
		else {
			echo "EvenementsManager: add: Détails manquants<br>";
		}

	}



	function remove (Evenement $e) 
	{
		$this->db->exec('DELETE FROM Evenements WHERE id ='. $e->id);
		$this->db->exec('DROP TABLE $e->table_participants');
	}
}

