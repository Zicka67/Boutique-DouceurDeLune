<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/profil', name: 'profil_')]
class ProfileController extends AbstractController
{

#[Route('/', name: 'index')]
public function index(): Response
{
    $user = $this->getUser();

    return $this->render('profil/index.html.twig', [
        'user' => $user,
        // 'user' => $this->getUser(),
    ]);
}


    // #[Route('/commandes', name: 'orders')]
    // public function orders(): Response
    // {
    //     return $this->render('profile/index.html.twig', [
    //         'controller_name' => 'Commande de l\'utilisateur',
    //     ]);
    // }

}
