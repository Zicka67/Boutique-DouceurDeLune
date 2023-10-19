<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use App\Repository\ProductsRepository;

class HomeController extends AbstractController
{
    private $productsRepository;

    public function __construct(ProductsRepository $productsRepository)
    {
        $this->productsRepository = $productsRepository;
    }


    #[Route('/', name: 'home')]
    public function index()
    {
        // Récupère les produits depuis la DBs
        $products = $this->productsRepository->findAll();

        // Render a la vue
        return $this->render('home/index.html.twig', [
            'products' => $products,
        ]);
    }
}

