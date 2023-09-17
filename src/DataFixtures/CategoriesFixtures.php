<?php

namespace App\DataFixtures;

use App\Entity\Categories;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Symfony\Component\String\Slugger\SluggerInterface;

class CategoriesFixtures extends Fixture
{
    private $counter = 1;
    

    public function __construct(private SluggerInterface $slugger)
    {
        
    }


    public function load(ObjectManager $manager): void
    {
        // ***************
        $parent = $this->createCategory("Portage", null, $manager);

        $this->createCategory('Echarpes', $parent, $manager);
        $this->createCategory('Porte-bébé', $parent, $manager);
        $this->createCategory('Test', $parent, $manager);

        // ***************
        $parent = $this->createCategory("Accessoires", null, $manager);

        $this->createCategory('Biberons', $parent, $manager);
        $this->createCategory('Tétines', $parent, $manager);
        $this->createCategory('Test', $parent, $manager);

        $manager->flush();
    }

    public function createCategory(string $name, Categories $parent = null, ObjectManager $manager)
    {
        $category = new Categories();
        $category->setName($name);
        //Créera le slug en prenant le nom de la category ( ->lower() pour mettre en minuscule)
        $category->setSlug($this->slugger->slug($category->getName())->lower());
        $category->setParent($parent);
        $manager->persist($category);

        $this->addReference('cat-'.$this->counter, $category);
        $this->counter++;

        return $category;
    }

}