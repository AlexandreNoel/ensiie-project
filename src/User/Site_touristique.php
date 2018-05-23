<?php
namespace User;

class Site_touristique
{
    /**
     * @var int
     */
    private $id_st;

    /**
     * @var string
     */
    private $nom_st;

    /**
     * @var string
     */
    private $nom_v;


    
    /**
     * @var string
     */
    private $lienwiki_st;


    /**
     * @return int
     */
    public function getId_st()
    {
        return $this->id_st;
    }

    /**
     * @param int $
     * @return User
     */
    public function setId_st($id_st)
    {
        $this->id_st = $id_st;
        return $this;
    }

    /**
     * @return string
     */
    public function getNom_st()
    {
        return $this->nom_st;
    }

    public function setNom_st($nom_st)
    {
        $this->nom_st = $nom_st;
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



    public function getLienwiki_st()
    {
        return $this->lienwiki_st;
    }

    public function setLienwiki_st($lienwiki_st)
    {
        $this->lienwiki_st = $lienwiki_st;
        return $this;
    }
    


}
