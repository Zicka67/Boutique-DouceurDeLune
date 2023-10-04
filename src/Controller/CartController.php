<?php

namespace App\Controller;

use App\Entity\Products;
use Symfony\Component\HttpFoundation\JsonResponse;
use App\Repository\ProductsRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;



#[Route('/cart', name: 'cart_')]
class CartController extends AbstractController
{

    #[Route('/', name: 'index')]
    public function index(SessionInterface $session, ProductsRepository $productsRespository)
    {
        $panier = $session->get('panier', []);
        // Initialisation
        $data = [];
        $total = 0;

        foreach($panier as $id => $quantity){
            $product = $productsRespository->find($id);

            $data[] = [
                'product' => $product,
                'quantity' => $quantity,
            ];
            $total += $product->getPrice() * $quantity;
        }
        $totalItems = $this->calculateTotalItems($panier);

        return $this->render("cart/index.html.twig", compact('data', 'total', 'totalItems'));

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
    public function add(Products $product, SessionInterface $session, EntityManagerInterface $em, Request $request)
    {
    $id = $product->getId();
    $panier = $session->get('panier', []);

    if($product->getStock() > 0) {
        if(!isset($panier[$id])) {
            $panier[$id] = 0;
        }
        $panier[$id]++;
    
        // Décrémentez le stock du produit
        $product->setStock($product->getStock() - 1);
        $em->persist($product);  
        $em->flush();
    
        // Mettez à jour le panier dans la session
        $session->set('panier', $panier);
    } else {
        $this->addFlash('warning', 'Le produit ' . $product->getName() . ' est en rupture de stock.');
    }

    $totalItems = $this->calculateTotalItems($session->get('panier', []));

    // Si la requête est en AJAX, retourne une réponse JSON
    if ($request->isXmlHttpRequest()) {
        return new JsonResponse(['totalItems' => $totalItems]);
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

}