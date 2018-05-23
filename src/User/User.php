<?php
namespace User;

class User
{
    /**
     * @var int
     */
    private $pseudo;

    /**
     * @var string
     */
    private $nom;

    /**
     * @var string
     */
    private $prenom;

    /**
     * @var string
     */
    private $email;
    
    /**
     * @var string
     */
    private $nom_p;

    /**
     * @var string
     */
    private $nom_v;

    /**
     * @var string
     */
    private $mdp;


    /**
     * @return int
     */
    public function getPseudo()
    {
        return $this->pseudo;
    }

    /**
     * @param int $pseudo
     * @return User
     */
    public function setPseudo($pseudo)
    {
        $this->pseudo = $pseudo;
        return $this;
    }

    /**
     * @return string
     */
    public function getNom()
    {
        return $this->nom;
    }

    /**
     * @param string $nom
     * @return User
     */
    public function setNom($nom)
    {
        $this->nom = $nom;
        return $this;
    }

    /**
     * @return string
     */
    public function getPrenom()
    {
        return $this->prenom;
    }

    /**
     * @param string $lastname
     * @return User
     */
    public function setPrenom($prenom)
    {
        $this->prenom = $prenom;
        return $this;
    }

    /**
     * @return \string
     */
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * @param \DateTimeInterface $birthday
     * @return User
     */
    public function setEmail($email)
    {
        $this->email = $email;
        return $this;
    }

    public function getNom_p()
    {
        return $this->nom_p;
    }

    public function setNom_p($nom_p)
    {
        $this->nom_p = $nom_p;
        return $this;
    }

    public function getNom_v()
    {
        return $this->nom_v;
    }

    public function setNom_v($nom_v)
    {
        $this->nom_v = $nom_v;
        return $this;
    }
    
    public function getMdp()
    {
        return $this->mdp;
    }

    public function setMdp($mdp)
    {
        $this->mdp = $mdp;
        return $this;
    }
    


}

