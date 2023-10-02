<?php

namespace App\Controller\Admin;

use App\Entity\Categories;
use App\Entity\Products;
use App\Entity\Users;
use App\Entity\Coupons;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use EasyCorp\Bundle\EasyAdminBundle\Config\MenuItem;
use EasyCorp\Bundle\EasyAdminBundle\Config\Dashboard;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractDashboardController;

class DashboardController extends AbstractDashboardController
{
    #[Route('/admin', name: 'admin')]
    public function index(): Response
    {
        return $this->render('admin/dashboard.html.twig');
    }

    public function configureDashboard(): Dashboard
    {
        return Dashboard::new()
            ->setTitle('Boutique DouceurDeLune')
            ->renderContentMaximized();

            
    }

    public function configureMenuItems(): iterable
    {
        yield MenuItem::linkToDashboard('Dashboard', 'fa fa-home');
        yield MenuItem::linkToCrud('Les produits', 'fas fa-list', Products::class);
        yield MenuItem::linkToCrud('Les categories', 'fas fa-list', Categories::class);
        yield MenuItem::linkToCrud('Les utilisateurs', 'fas fa-list', Users::class);
        yield MenuItem::linkToCrud('Les coupons', 'fas fa-list', Coupons::class);
    }
}
