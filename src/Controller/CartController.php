<?php

namespace App\Controller;

use App\Entity\Products;
use App\Repository\CouponsRepository;
use App\Repository\ProductsRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;



    #[Route('/cart', name: 'cart_')]
    class CartController extends AbstractController
    {

    #[Route('/', name: 'index')]
    public function index(SessionInterface $session, ProductsRepository $productsRespository, Request $request, CouponsRepository $couponsRepository)
    {
        $panier = $session->get('panier', []);
        // Initialisation
        $data = [];
        $total = 0;
    
        foreach($panier as $id => $quantity) {
            $product = $productsRespository->find($id);
            
            // Vérifie si le produit existe
            if ($product) {
                $data[] = [
                    'product' => $product,
                    'quantity' => $quantity,
                ];
                $total += $product->getPrice() * $quantity;
            }
        }
    
        $totalItems = $this->calculateTotalItems($panier);
    
        // Récupération du coupon de la session
        $discount = $session->get('discount', 0);
    
        $couponCode = $request->request->get('code');
    
        // Si un nouveau coupon est envoyé
        if ($couponCode) {
            $coupon = $couponsRepository->findOneBy(['code' => $couponCode]);
            if ($coupon && $coupon->isIsValid()) {
                $discount = $coupon->getDiscount();
                // Save de la discount en session
                $session->set('discount', $discount);
            }
        }
    
        // Application de la remise
        $total = $total - ($total * $discount / 100); 
    
        return $this->render("cart/index.html.twig", [
            'data' => $data,
            'total' => $total,
            'totalItems' => $totalItems,
            'discount' => $discount 
        ]);
    }
    


    private function calculateTotalItems($cart)
    {
        $totalItems = 0;
        foreach ($cart as $quantity) {  
            $totalItems += $quantity;
        }
        return $totalItems;
    }
    

    #[Route('/add/{id}', name: 'add')]
    public function add(Products $product, SessionInterface $session, EntityManagerInterface $em, Request $request, ProductsRepository  $productsRepository)
    {
        $id = $product->getId();
        $panier = $session->get('panier', []);
      
    
        if($product->getStock() > 0) {
            if(!isset($panier[$id])) {
                $panier[$id] = 0;
            }
            $panier[$id]++;
        
            // Décrémente le stock du produit
            $product->setStock($product->getStock() - 1);
            $em->persist($product);  
            $em->flush();
        
            // Met à jour le panier dans la session
            $session->set('panier', $panier);
        } else {
            $this->addFlash('warning', 'Le produit ' . $product->getName() . ' est en rupture de stock.');
        }
    
        $total = 0;
        foreach($panier as $id => $quantity){
            $product = $productsRepository->find($id);
            $total += $product->getPrice() * $quantity;
        }
    
        $totalItems = $this->calculateTotalItems($session->get('panier', []));
    
        // Si la requête est en AJAX, retourne une réponse JSON
        if ($request->isXmlHttpRequest()) {
            return new JsonResponse([
                'totalItems' => $totalItems,
                'total' => $total,
                'productId' => $id, 
                'newStock' => $product->getStock(),
                'newQuantity' => $panier[$id]  
            ]);
        }
        
        return $this->redirectToRoute('cart_index');
    }
    

    #[Route('/remove/{id}', name: 'remove')]
    public function remove(Products $product, SessionInterface $session, EntityManagerInterface $em, Request $request)
    {
        $id = $product->getId();

        $panier = $session->get('panier', []);

        if(!empty($panier[$id])){
            if($panier[$id] > 1) {
                $panier[$id] -- ;
            }else {
                unset($panier[$id]);
            }

            //Incrémente la quantité du produit en DB avec em
            $product->setStock($product->getStock() + 1);
            $em->flush();

        $session->set('panier', $panier);

        $totalItems = $this->calculateTotalItems($session->get('cart', []));

        // Si la requête est en AJAX, retourne une réponse JSON
        if ($request->isXmlHttpRequest()) {
            return new JsonResponse(['totalItems' => $totalItems]);
        }
    
        return $this->redirectToRoute('cart_index');

        }
    }

    #[Route('/delete/{id}', name: 'delete')]
    public function delete(Products $product, SessionInterface $session, Request $request)
    {
        $id = $product->getId();

        $panier = $session->get('panier', []);

        if(!empty($panier[$id])){
                unset($panier[$id]);
            }

        $session->set('panier', $panier);

        $totalItems = $this->calculateTotalItems($session->get('panier', []));

        // Si la requête est en AJAX, retournez une réponse JSON
        if ($request->isXmlHttpRequest()) {
        return new JsonResponse(['totalItems' => $totalItems]);
    }
    
        return $this->redirectToRoute('cart_index');
        
    }

    #[Route('/vider', name: 'vider')]
    public function vider(SessionInterface $session, Request $request)
    {
    
        $session->remove('panier');

        $totalItems = 0;  

        // Si la requête est en AJAX, retournez une réponse JSON
        if ($request->isXmlHttpRequest()) {
        return new JsonResponse(['totalItems' => $totalItems]);
    }
    
        return $this->redirectToRoute('cart_index');
        
    }


#[Route("/add-to-cart", name: "add_to_cart", methods:["POST"])]
public function addToCart(Request $request, SessionInterface $session, ProductsRepository $productsRepository)
{
    $productId = $request->request->get('productId');

    // Validation du produit
    if (!is_numeric($productId) || $productId <= 0) {
        return new JsonResponse([
            'message' => 'Produit invalide.',
        ], JsonResponse::HTTP_BAD_REQUEST);
    }

    try {
        $cart = $session->get('panier', []);

        // Recherche du produit dans la base de données
        $product = $productsRepository->find($productId);
        if (!$product) {
            return new JsonResponse([
                'message' => 'Produit non trouvé.',
            ], JsonResponse::HTTP_NOT_FOUND);
        }

        // Ajout du produit au panier
        if (!isset($cart[$productId])) {
            $cart[$productId] = 0;
        }
        $cart[$productId]++;

        $session->set('panier', $cart);
        // Réponse avec le nombre d'articles dans le panier et un message
        return new JsonResponse([
            'message' => 'Le produit a été ajouté au panier.',
            'cartCount' => array_sum($cart) // Total des produits dans le panier
        ]);
    } catch (\Exception $e) {
        // Gestion des exceptions
        return new JsonResponse([
            'message' => 'Une erreur est survenue lors de l\'ajout du produit au panier.',
        ], JsonResponse::HTTP_INTERNAL_SERVER_ERROR);
    }
}


#[Route('/update-cart', name: 'update_cart', methods: ["POST"])]
public function updateCart(SessionInterface $session, Request $request, ProductsRepository $productsRepository, CouponsRepository $couponsRepository)
{
    // Récupérer les données de la requête
    $productId = $request->request->get('productId');
    $quantity = $request->request->get('quantity');
    
    // Mettre à jour la quantité dans la session
    $panier = $session->get('panier', []);
    $panier[$productId] = $quantity;
    $session->set('panier', $panier);
    
    // Initialisation
    $data = [];
    $total = 0;
    $totalItems = 0;

    // Calcul du total
    foreach($panier as $id => $quantity){
        $product = $productsRepository->find($id);
        if ($product) {
            $total += $product->getPrice() * $quantity;
            $totalItems += $quantity;
        }
    }

    // Récupération du coupon de la session
    $discount = $session->get('discount', 0);

    // Application de la remise
    $total = $total - ($total * $discount / 100);
    
    return new JsonResponse([
        'total' => $total,
        'totalItems' => $totalItems,
        'discount' => $discount
    ]);
}

}