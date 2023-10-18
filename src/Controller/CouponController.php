<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class CouponController extends AbstractController
{
    #[Route('/coupon', name: 'app_coupon')]
    public function index(): Response
    {
        return $this->render('coupon/index.html.twig', [
            'controller_name' => 'CouponController',
        ]);
    }
}
