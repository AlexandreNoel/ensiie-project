<?php

namespace Client\Hydrator;
/**
 * Class Client
 * @package Client\Hydrator
 */
class Client{
    public function extract(\Client\Entity\Client $object): array
    {
        $data = [];
        if ($object->getId()) {
            $data['idutilisateur'] = $object->getId();
        }
        if ($object->getFirstname()) {
            $data['prenom'] = $object->getFirstname();
        }
        if ($object->getNickname()) {
            $data['pseudo'] = $object->getNickname();
        }
        if ($object->getLastname()) {
            $data['nom'] = $object->getLastname();
        }
        if ($object->getSolde()) {
            $data['solde'] = $object->getSolde();
        }
        if ($object->getIdrole()) {
            $data['idrole'] = $object->getIdRole();
        }
        if ($object->getCodebarmen()) {
            $data['codebarmen'] = $object->getCodebarmen();
        }
        return $data;
    }
    public function hydrate(array $data, \Client\Entity\Client $emptyEntity): \Client\Entity\Client
    {
        return $emptyEntity
            ->setId($data['idutilisateur'] ?? 0)
            ->setNickname(strtolower($data['pseudo']) ?? null)
            ->setLastname(strtolower($data['nom']) ?? null)
            ->setFirstname(strtolower($data['prenom']) ?? null)
            ->setSolde($data['solde'] ?? 0)
            ->setIdrole($date['idrole'] ?? 1)
            ->setCodebarmen($data['codebarmen'] ?? null);
    }
}
?>
