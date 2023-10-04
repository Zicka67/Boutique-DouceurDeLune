<?php

namespace App\Controller;

use App\Entity\Products;
use App\Repository\ProductsRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\ORM\EntityManagerInterface;

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
        return $this->render("cart/index.html.twig", compact('data', 'total'));

    }

    #[Route('/add/{id}', name: 'add')]
    public function add(Products $product, SessionInterface $session, EntityManagerInterface $em)
    {
        $id = $product->getId();

        $panier = $session->get('panier', []);

        if($product->getStock() > 0) {

            if(empty($panier[$id])){
                $panier[$id] = 1;
            }else {
                $panier[$id] ++;
            }

            //Décrémente la quantité du produit en DB avec em, limite a 0
            $product->setStock(max(0, $product->getStock() - 1));
            $em->flush();

            $session->set('panier', $panier);
        
        } else {
            //message d'erreurs
            $this->addFlash('warning', 'Le produit ' . $product->getName() . ' est en rupture de stock.');
        }
        
            return $this->redirectToRoute('cart_index');

    }

    #[Route('/remove/{id}', name: 'remove')]
    public function remove(Products $product, SessionInterface $session, EntityManagerInterface $em)
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
    
        return $this->redirectToRoute('cart_index');

        }
    }

    #[Route('/delete/{id}', name: 'delete')]
    public function delete(Products $product, SessionInterface $session)
    {
        $id = $product->getId();

        $panier = $session->get('panier', []);

        if(!empty($panier[$id])){
                unset($panier[$id]);
            }

        $session->set('panier', $panier);
    
        return $this->redirectToRoute('cart_index');
        
    }

    #[Route('/vider', name: 'vider')]
    public function vider(SessionInterface $session)
    {
    
        $session->remove('panier');
    
        return $this->redirectToRoute('cart_index');
        
    }

}