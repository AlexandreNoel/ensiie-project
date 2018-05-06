<?php
namespace User;
class UserRepository
{
    /**
     * @var \PDO
     */
    private $connection;

    /**
     * UserRepository constructor.
     * @param \PDO $connection
     */
    public function __construct(\PDO $connection)
    {
        $this->connection = $connection;
    }

    public function fetchAll()
    {
        $rows = $this->connection->query('SELECT * FROM "user"')->fetchAll(\PDO::FETCH_OBJ);
        $users = [];
        foreach ($rows as $row) {
            $user = new User();
            $user
                ->setId($row->id)
                ->setFirstname($row->firstname)
                ->setLastname($row->lastname)
                ->setBirthday(new \DateTimeImmutable($row->birthday));

            $users[] = $user;
        }

        return $users;
    }


    public function connect($postpseudo,$postmdp)
    {

	    $pseudo = htmlspecialchars(($postpseudo)) ;
	    $mdp = htmlspecialchars(md5($postmdp)) ;
	    
	    $rows = $this->connection->query('SELECT * FROM "user"')->fetchAll(\PDO::FETCH_OBJ);	
	    $users = [];
	    $flag=0;
	   
	    foreach ($rows as $row) {		 
		    $user = new User();		 
		    $user  
			    ->setId($row->id)
			    ->setFirstname($row->firstname)	
			    ->setLastname($row->lastname)	 
			    ->setBirthday(new \DateTimeImmutable($row->birthday))
			    ->setNickname($row->nickname)
			    ->setMdp($row->mdp);

		    $users[] = $user;
	    }
	    foreach ($users as $user) {
		    $nick = $user->getNickname();
		    if ($nick == $pseudo)
		    {
			    $flag=1;
			    $pass = $user->getMdp();
			    if ($pass == $mdp )
			    {
				    session_start(); 
				    $_SESSION['id'] = $user->getId();	      
				    $_SESSION['pseudo'] = $pseudo;	       
				    echo 'Vous êtes connecté !';
			    }
			    else 
			    {
				    echo 'Mauvais mot de passe';
			    }
		    }
	    }
		
	    if ($flag==0){
		    echo 'Mauvais pseudo';
	    }
    }

    public function signin($postpseudo,$postmdp,$postmdp_verif)
    {	       
        $pseudo = htmlspecialchars($postpseudo) ;    
        $mdp = htmlspecialchars(md5($postmdp)) ;            
        $mdp_verif = htmlspecialchars(md5($postmdp_verif)) ;
        $userlevel = 1 ;                              
         
	if( $mdp == $mdp_verif )  // Vérification Mdp
	{
		$stmt2 = $this->connection->query('SELECT COUNT(*) FROM "user" WHERE nickname='.$this->connection->quote($pseudo)); // Vérification de l'unicité du pseudo
                        $nb_rows2= $stmt2->fetchColumn();
 
                        if($nb_rows2 != 1)
                        {      
				$req=$this->connection->prepare('INSERT INTO "user"(nickname,mdp,id_groupe) VALUES (:pseudo,:mdp,:id_groupe)');
				
				$req->execute(array(
                                'pseudo' => $pseudo,
                                'mdp' => $mdp,
                                'id_groupe'=> $userlevel )) ;
			       
				echo ' Vous êtes inscrit !  ' ;
 
			}
			else 
			{ 
				echo " <center>Erreur : Le pseudo est déja utilisé .</center>" ; 
			}
	}
	else 
	{ 
		echo " <center>Erreur : Les deux mots de passe entrés sont différents .</center>" ;
	}
    
    }


}
