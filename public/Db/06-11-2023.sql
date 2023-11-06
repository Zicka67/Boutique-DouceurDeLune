-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour e-commerce
CREATE DATABASE IF NOT EXISTS `e-commerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `e-commerce`;

-- Listage de la structure de table e-commerce. categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_order` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3AF34668727ACA70` (`parent_id`),
  CONSTRAINT `FK_3AF34668727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.categories : ~14 rows (environ)
INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `category_order`) VALUES
	(106, NULL, 'Portage', 'portage', 1),
	(107, 106, 'Echarpes', 'echarpes', 1),
	(108, 106, 'Porte-bébé1', 'porte-bebe', 1),
	(109, 106, 'Porte-bébé2', 'porte-bebe', 1),
	(110, NULL, 'Accessoires', 'accessoires', 2),
	(111, 110, 'Biberons', 'biberons', 2),
	(112, 110, 'Tétines', 'tetines', 2),
	(113, 110, 'Test', 'test', 2),
	(114, NULL, 'Vêtements', 'vetements', 3),
	(115, 114, 'Manteau', 'manteau', 3),
	(116, 114, 'T-shirts', 't-shirts', 3),
	(117, NULL, 'Carte-cadeau', 'carte-cadeau', 4),
	(118, 117, 'Carte 50€', 'carte-50-€', 4),
	(119, 117, 'Carte 100€', 'carte-100-€', 4);

-- Listage de la structure de table e-commerce. coupons
CREATE TABLE IF NOT EXISTS `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `coupons_types_id` int NOT NULL,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount` int NOT NULL,
  `max_usage` int NOT NULL,
  `validity` datetime NOT NULL,
  `is_valid` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F564111877153098` (`code`),
  KEY `IDX_F56411183DDD47B7` (`coupons_types_id`),
  CONSTRAINT `FK_F56411183DDD47B7` FOREIGN KEY (`coupons_types_id`) REFERENCES `coupons_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.coupons : ~2 rows (environ)
INSERT INTO `coupons` (`id`, `coupons_types_id`, `code`, `description`, `discount`, `max_usage`, `validity`, `is_valid`, `created_at`) VALUES
	(1, 2, 'solde50', '50% de reduction', 50, 10, '2023-10-19 08:47:53', 1, '2023-10-19 08:48:02'),
	(2, 1, 'anniv20', '20% de reduction', 20, 10, '2023-10-19 09:03:05', 1, '2023-10-19 09:03:08');

-- Listage de la structure de table e-commerce. coupons_types
CREATE TABLE IF NOT EXISTS `coupons_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.coupons_types : ~2 rows (environ)
INSERT INTO `coupons_types` (`id`, `name`) VALUES
	(1, 'anniversaire'),
	(2, 'solde');

-- Listage de la structure de table e-commerce. doctrine_migration_versions
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Listage des données de la table e-commerce.doctrine_migration_versions : ~5 rows (environ)
INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
	('DoctrineMigrations\\Version20230905083810', '2023-09-05 08:39:55', 158),
	('DoctrineMigrations\\Version20230917113947', '2023-09-17 11:41:49', 20),
	('DoctrineMigrations\\Version20230917121453', '2023-09-17 12:15:00', 24),
	('DoctrineMigrations\\Version20230918135148', '2023-09-18 13:52:17', 22),
	('DoctrineMigrations\\Version20231006064538', '2023-10-06 06:46:10', 25);

-- Listage de la structure de table e-commerce. images
CREATE TABLE IF NOT EXISTS `images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `products_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E01FBE6A6C8A81A9` (`products_id`),
  CONSTRAINT `FK_E01FBE6A6C8A81A9` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.images : ~0 rows (environ)
INSERT INTO `images` (`id`, `products_id`, `name`) VALUES
	(1, 14, '');

-- Listage de la structure de table e-commerce. messenger_messages
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.messenger_messages : ~0 rows (environ)

-- Listage de la structure de table e-commerce. orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `coupons_id` int DEFAULT NULL,
  `users_id` int NOT NULL,
  `reference` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_E52FFDEEAEA34913` (`reference`),
  KEY `IDX_E52FFDEE6D72B15C` (`coupons_id`),
  KEY `IDX_E52FFDEE67B3B43D` (`users_id`),
  CONSTRAINT `FK_E52FFDEE67B3B43D` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_E52FFDEE6D72B15C` FOREIGN KEY (`coupons_id`) REFERENCES `coupons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.orders : ~0 rows (environ)

-- Listage de la structure de table e-commerce. orders_details
CREATE TABLE IF NOT EXISTS `orders_details` (
  `orders_id` int NOT NULL,
  `products_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`orders_id`,`products_id`),
  KEY `IDX_835379F1CFFE9AD6` (`orders_id`),
  KEY `IDX_835379F16C8A81A9` (`products_id`),
  CONSTRAINT `FK_835379F16C8A81A9` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FK_835379F1CFFE9AD6` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.orders_details : ~0 rows (environ)

-- Listage de la structure de table e-commerce. products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categories_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `stock` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B3BA5A5AA21214B7` (`categories_id`),
  CONSTRAINT `FK_B3BA5A5AA21214B7` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.products : ~8 rows (environ)
INSERT INTO `products` (`id`, `categories_id`, `name`, `description`, `price`, `stock`, `created_at`, `slug`, `img_name`) VALUES
	(11, 106, 'Echarpe physiologique', 'Offrez vous, ou offrez a une jeune ou future maman, notre echarpe physiologique faite main, respectant la peau de votre bébé et celle de la maman', 9999, 10, '2023-09-17 15:12:04', 'quas', 'portageMain.jpg'),
	(12, 106, 'Porte bébé', 'Notre game de portage comporte également des portes bébé, fait main également, souple mais robuste. Pour un confort parfait pour bébé et pour vous.', 19999, 12, '2023-09-17 15:12:04', 'hic-officia', 'echarpePortage2.jpeg'),
	(13, 106, 'Porte bébé 2', 'Notre game de portage comporte également des portes bébé, fait main également, souple mais robuste. Pour un confort parfait pour bébé et pour vous.', 24999, 5, '2023-09-17 15:12:04', 'nam-ut', 'coup-moyen-pere-tenant-bebe-faisant-corvees.jpg'),
	(14, 110, 'Tétine', 'Aut laborum vel et quibusdam. Aut explicabo eveniet occaecati quam nemo veniam. Dolor quibusdam a harum similique expedita fugit error.', 1999, 10, '2023-09-17 15:12:04', 'officiis-unde', 'tetine2.png'),
	(15, 110, 'Tire-laits', 'Dolor molestiae eos porro nulla dolorum placeat quia quam. Ab illo fugiat architecto aut.', 7999, 16, '2023-09-17 15:12:04', 'aut-recusandae', 'accessoires.webp'),
	(16, 110, 'Biberons', 'Cupiditate dolore nulla numquam eum est dolor ut. Maiores aut vero vitae porro et nemo eum eius.', 4999, 9, '2023-09-17 15:12:04', 'commodi', 'biberon.jpg'),
	(20, 117, 'Carte cadeau 50 €', 'Vous souhaitez offrir un cours ou un produit fabriqué par nous à l\'un de \r\nvos proches ? Il vous suffit de cliquer, pour offrir 50€ à la maman de votre choix ! ', 5000, 95, '2023-09-17 15:12:04', 'nobis', 'carte-cadeau.webp'),
	(21, 117, 'Carte cadeau 100 €', 'Vous souhaitez offrir un cours ou un produit fabriqué par nous à l\'un de \r\nvos proches ? Il vous suffit de cliquer, pour offrir 100€ à la maman de votre choix ! ', 10000, 94, '2023-09-18 16:44:51', 'sint-sed-2', 'carte-cadeau.webp');

-- Listage de la structure de table e-commerce. users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipcode` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1483A5E9E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.users : ~6 rows (environ)
INSERT INTO `users` (`id`, `email`, `roles`, `password`, `lastname`, `firstname`, `address`, `zipcode`, `city`, `created_at`) VALUES
	(27, 'ocourtois@dupuis.fr', '[]', '$2y$13$kb1JnS9ySNq9qp28/iERdOQ5yI2dtW5pdUbFx2Dhh4rgczpzWVLu2', 'Maillot', 'Julien', '34, chemin Lemoine', '18731', 'Bonnet-sur-Lebreton', '2023-09-17 15:12:04'),
	(28, 'thierry.herve@tele2.fr', '[]', '$2y$13$3Mkf1WXAcEMCn9wYCars8OwUfmETElbbfWEeFcgZ48vce34Ya3IEK', 'Rossi', 'Laetitia', '53, avenue Riviere', '33212', 'Allain', '2023-09-17 15:12:05'),
	(29, 'morel.hugues@normand.com', '[]', '$2y$13$yZkybiAruqQpuAiRSlv4d.XjNTa0AEoOevSiXN.TMsi.HdiMFMes2', 'Rey', 'Inès', '81, avenue Tristan Morvan', '66320', 'GiraudVille', '2023-09-17 15:12:05'),
	(30, 'victor.mahe@orange.fr', '[]', '$2y$13$iQ8RMkHJaOaT4O/Z1YdvKerhqAckTVEm12b.kvp6CukdDuxxBE2lG', 'Bouvier', 'Capucine', '25, avenue Schmitt', '98181', 'Poirier', '2023-09-17 15:12:05'),
	(31, 'hamon.elodie@yahoo.fr', '[]', '$2y$13$2PqBlvhNNYKcfSEvf2Q15eM1xtMHh1d0LpDCy75pZePBdkYRDRKuu', 'Gimenez', 'Valentine', '64, rue de Renaud', '18327', 'Lecomte', '2023-09-17 15:12:06'),
	(33, 'Admin@admin.com', '["ROLE_ADMIN"]', '$2y$13$KiMVwfYfxGzBzNwSPvRiOe9rWb1NhkO0ztMdhsS/qEivN9mlvChja', 'KEZIC', 'Guillaume', '2 rue de la ville', '67540', 'Ostwald', '2023-09-29 19:45:02');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
