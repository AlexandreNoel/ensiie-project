<?php
/**
 * Created by PhpStorm.
 * User: KevinXu
 * Date: 16/04/2018
 * Time: 17:30
 */
namespace Message;

class Message
{
    /**
     * @var int
     */
    private $id;

    /**
     * @var string
     */
    private $emetteur;

    /**
     * @var string
     */
    private $recepteur;

    /**
     * @var \DateTimeInterface
     */
    private $date;

    /**
     * @var string
     */
    private $contenu;


    //Liste des setters et getters

    /**
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param int $id
     * @return Message
     */
    public function setId($id)
    {
        $this->id = $id;
        return $this;
    }

    /**
     * @return string
     */
    public function getEmetteur()
    {
        return $this->emetteur;
    }

    /**
     * @param string $emetteur
     * @return Message
     */
    public function setEmetteur($emetteur)
    {
        $this->emetteur = $emetteur;
        return $this;
    }

    /**
     * @return string
     */
    public function getRecepteur()
    {
        return $this->recepteur;
    }

    /**
     * @param string $recepteur
     * @return Message
     */
    public function setRecepteur($recepteur)
    {
        $this->recepteur = $recepteur;
        return $this;
    }

    /**
     * @return \DateTimeInterface
     */
    public function getDate()
    {
        return $this->date;
    }

    /**
     * @param \DateTimeInterface $date
     * @return Message
     */
    public function setDate($date)
    {
        $this->date = $date;
        return $this;
    }

    /**
     * @return string
     */
    public function getContenu()
    {
        return $this->contenu;
    }

    /**
     * @param string $contenu
     * @return Message
     */
    public function setContenu($contenu)
    {
        $this->contenu = $contenu;
        return $this;
    }
}

