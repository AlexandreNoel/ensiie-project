<?php
namespace User;
class Site_touristiqueRepository
{
    /**
     * @var \PDO
     */
    private $connection;

    /**
     * Site_touristiqueRepository constructor.
     * @param \PDO $connection
     */
    public function __construct(\PDO $connection)
    {
        $this->connection = $connection;
    }

    public function fetchAll()
    {
        $rows = $this->connection->query('SELECT * FROM Site_touristique')->fetchAll(\PDO::FETCH_OBJ);
        $sts = [];
        foreach ($rows as $row) {
            $st = new Site_touristique();
            $st
                ->setId_st($row->id_st)
                ->setNom_st($row->nom_st)
		->setNom_v($row->nom_v)
                ->setLienwiki_st($row->lienwiki_st);

            $sts[] = $st;
        }

        return $sts;
    }

}
