<?php

namespace App\Controller;

use App\Repository\CategoriesRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'home')]
    public function index(CategoriesRepository $categoriesRepository): Response
    {
        // $categoriesRepository = $categoriesRepository->findAll();
        return $this->render('home/index.html.twig', [
            'categories' => $categoriesRepository->findBy([], ['categoryOrder' => 'asc'])
        ]);
    }
    
}
