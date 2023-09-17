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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3AF34668727ACA70` (`parent_id`),
  CONSTRAINT `FK_3AF34668727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.categories : ~8 rows (environ)
INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`) VALUES
	(106, NULL, 'Portage', 'portage'),
	(107, 106, 'Echarpes', 'echarpes'),
	(108, 106, 'Porte-bébé', 'porte-bebe'),
	(109, 106, 'Test', 'test'),
	(110, NULL, 'Accessoires', 'accessoires'),
	(111, 110, 'Biberons', 'biberons'),
	(112, 110, 'Tétines', 'tetines'),
	(113, 110, 'Test', 'test');

-- Listage de la structure de table e-commerce. coupons
CREATE TABLE IF NOT EXISTS `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `coupons_types_id` int NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount` int NOT NULL,
  `max_usage` int NOT NULL,
  `validity` datetime NOT NULL,
  `is_valid` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F564111877153098` (`code`),
  KEY `IDX_F56411183DDD47B7` (`coupons_types_id`),
  CONSTRAINT `FK_F56411183DDD47B7` FOREIGN KEY (`coupons_types_id`) REFERENCES `coupons_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.coupons : ~0 rows (environ)

-- Listage de la structure de table e-commerce. coupons_types
CREATE TABLE IF NOT EXISTS `coupons_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.coupons_types : ~0 rows (environ)

-- Listage de la structure de table e-commerce. doctrine_migration_versions
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Listage des données de la table e-commerce.doctrine_migration_versions : ~3 rows (environ)
INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
	('DoctrineMigrations\\Version20230905083810', '2023-09-05 08:39:55', 158),
	('DoctrineMigrations\\Version20230917113947', '2023-09-17 11:41:49', 20),
	('DoctrineMigrations\\Version20230917121453', '2023-09-17 12:15:00', 24);

-- Listage de la structure de table e-commerce. images
CREATE TABLE IF NOT EXISTS `images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `products_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E01FBE6A6C8A81A9` (`products_id`),
  CONSTRAINT `FK_E01FBE6A6C8A81A9` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.images : ~100 rows (environ)
INSERT INTO `images` (`id`, `products_id`, `name`) VALUES
	(1, 13, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\287609d96a370a3a46e7ab618c791465.png'),
	(2, 11, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\c836a953ae718290bac05941562d7a5d.png'),
	(3, 13, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\6f184b7336b7a9c12c8dfd1a4001b06f.png'),
	(4, 16, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\f4e86861ab597445ed0e0cad52b60ccb.png'),
	(5, 14, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\b4b9049a56d51297b46d6ff866f55705.png'),
	(6, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\a41ae9bb4f3322a74cdb880b7f653aaf.png'),
	(7, 11, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\04ff6eadda87345a12093fdd45e66e49.png'),
	(8, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\e8dd2ea7b830b0c80186f1c07039398a.png'),
	(9, 13, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\338038e50377833bb3c262f364410cd8.png'),
	(10, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\e9dce2b63035603ccb938ffe3ffd15c6.png'),
	(11, 11, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\321ca3d504c9135ba1c77a83b1fe3c33.png'),
	(12, 14, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\1dabeb0dde46a2419a1fea2746af6e2b.png'),
	(13, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\7b958c95cf89be42c7d4ab75c1b404c5.png'),
	(14, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\d97e13d649749eda610ae1d76285ac53.png'),
	(15, 15, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\2ed09fcfbed4b711250f814f0fe9d290.png'),
	(16, 11, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\3f5a9fd39abdc2aecd7885db7983b8b9.png'),
	(17, 14, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\865abe8a8fd49cb0168ab1a23bb42266.png'),
	(18, 17, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\5a09e05f72f0cca6ad23a4f4431d5ee3.png'),
	(19, 17, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\3e88c543d5240294d1f908821cf8209b.png'),
	(20, 20, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\61eaf89391292b8419d29c51fd1a070e.png'),
	(21, 13, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\9a598a08eabd4517dd642543e7af187c.png'),
	(22, 14, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\c4c719946dc3cd862033aa65d05567bc.png'),
	(23, 17, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\c6820d38f8eb06ee2562db4a9e696f37.png'),
	(24, 16, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\3489a6736123d869dc73e8934036caee.png'),
	(25, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\d7ce8d79f64e43681c2287b92231fd70.png'),
	(26, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\59b9da67a72ea919b200d4c5d87dab71.png'),
	(27, 19, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\274a6bbea2d854f9b71c968e0603c4cb.png'),
	(28, 20, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\820ea93586ddaa379aea1359d4a70a1d.png'),
	(29, 13, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\45c7891b0e139fe1a1942d9ae907f1c3.png'),
	(30, 14, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\bb48bf6271df507d9f763c47e6a1b1eb.png'),
	(31, 20, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\f3611f8a8362cd07d42795b5c8d41dac.png'),
	(32, 17, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\2147713ce891309fdf507c1efca171e2.png'),
	(33, 19, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\d3d36eb067d7fc5964fc6f173a2a66b7.png'),
	(34, 17, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\42b08b6877608e295d51aba7f1eb544f.png'),
	(35, 17, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\23cf90b37338d92befebe47c452c80be.png'),
	(36, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\f606879a97badf84d3e20edd9857de1d.png'),
	(37, 15, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\51f5f8864739e468219ba5049e4ac1c8.png'),
	(38, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\2d8ea22a6ad6a724c08814d704aaa609.png'),
	(39, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\1fb3181ba0f8197f82971340d17cb0d6.png'),
	(40, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\afa76716e88c6d6425d1edf8ad4f61db.png'),
	(41, 14, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\5e68a093209f5cb053f4ccc3ef8ec0e0.png'),
	(42, 15, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\4af569e678903028b4c9fd037d01ea6c.png'),
	(43, 11, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\20edc9e26e3f9198b56eb8f177763975.png'),
	(44, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\97f00726e3c5f574798e22dcd1485855.png'),
	(45, 20, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\6dde5904364128b2eff65be39ae57a37.png'),
	(46, 19, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\a6d378e87cd4009d3d1c71b7d9e5cc1b.png'),
	(47, 16, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\4548a91461c5993a5d8b499e14788427.png'),
	(48, 15, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\9de031cb691e55213842df7fbfb9ad5b.png'),
	(49, 11, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\2087203d615560b58e8bdee7adb62bef.png'),
	(50, 13, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\50edded92abeb83330702271f776a9a7.png'),
	(51, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\4eb96f2890dbca4d6a40e4d023848e45.png'),
	(52, 11, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\e75ccc6a656f68039656c097450b47e2.png'),
	(53, 20, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\c51f314203ba2db2737495e1ad99d9c2.png'),
	(54, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\5b9ebad974efad1c910388a37c9a74d7.png'),
	(55, 15, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\90c47095f426b0098d196e76a6d21aad.png'),
	(56, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\9f92b7da05d2c4b3c74f9d3a6de1aace.png'),
	(57, 16, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\1f3d2e86dc804a1333f9e8303bd1c14b.png'),
	(58, 17, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\d8e1f3860aaffd87d6e7b96d38bf8e65.png'),
	(59, 19, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\fbcf06ebf44ce3425e56659f151e0862.png'),
	(60, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\95ea94bd6f0f633ab2d89058bb4fffe9.png'),
	(61, 19, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\31be2139def3c88131999c199efd4fdb.png'),
	(62, 13, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\89c32dbfc42f2e616758d5e34446e971.png'),
	(63, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\ea9cbb7fe3d1ff29aa184b914e452385.png'),
	(64, 15, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\6a57a18a99ab4b187d963489e021fc06.png'),
	(65, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\4fc66eb1125df9f9011e39356385fb8c.png'),
	(66, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\4616db84082713ea4f61ab2900cbaf43.png'),
	(67, 11, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\8b45efe366296baad03d24c59e942cfd.png'),
	(68, 19, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\2b5aef1f4e77b3a1abad268aced3220c.png'),
	(69, 19, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\c41526daee88940119bf455d6ae58b6c.png'),
	(70, 11, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\c5c688f29cb36a0fb20f37eeaf9d4909.png'),
	(71, 13, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\caba3d3a55e3cbb09a6fef1bb9656cfc.png'),
	(72, 16, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\4ee8bb6bd46ffe16bb31e06ccef49a23.png'),
	(73, 14, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\a2f07c616293ae9d062b0ec332eb4e7d.png'),
	(74, 20, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\7864a4bde6a51efeb0ce1835dd6efd77.png'),
	(75, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\ed8c8f99a142756e8cb38b2320edc699.png'),
	(76, 11, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\84c8cd9bcf3daa482fca9c3312e63063.png'),
	(77, 15, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\618fc42faea67d1da3054dea46eba278.png'),
	(78, 15, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\639800a641d74f73cc3a91526a9c28ee.png'),
	(79, 20, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\2e96cc5c1781c30517b54262ffda8e3f.png'),
	(80, 16, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\6fc27c420ab974842d4a652e590cd696.png'),
	(81, 20, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\639f68a86771eeb430114a8acec51011.png'),
	(82, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\f5d3fa1af99f4bae1017301c4af56f91.png'),
	(83, 15, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\54fa1dcb387ddba1b0990839cb2671bf.png'),
	(84, 17, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\a9025299ea70723d7c85d74abb886064.png'),
	(85, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\d6743f0d0c8dc6ac754596a853d73e77.png'),
	(86, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\79d070fdcb8f272304757810b59d7f0d.png'),
	(87, 14, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\c19d712f62a54780d4edbadc1cb69f02.png'),
	(88, 13, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\60c9446de31e675060775b82220c9c56.png'),
	(89, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\37613e523040a56a49772a8902ed2873.png'),
	(90, 14, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\30c293ee752500b20b662cfef52dbaf4.png'),
	(91, 13, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\ce53368ab362b0c396989baf6164fd6e.png'),
	(92, 16, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\d43b33c101bf6f0e8280fbd22abd91f5.png'),
	(93, 19, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\c095e6145e7cbfe7ce510c2c29f21f2b.png'),
	(94, 14, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\03b8c2794131910d6081d3cecd73f0c4.png'),
	(95, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\1b096cfa187ddd94aff38937383efd18.png'),
	(96, 20, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\2cf1ba59d927ddf6b542aafc5b0d1d9b.png'),
	(97, 18, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\4eed7c19415f3fec3a91d83cfb1853f4.png'),
	(98, 16, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\d58a68f1dc4432cd5188b02ddcba48c4.png'),
	(99, 16, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\43004d9f03cb46de2d19bd708e24c8be.png'),
	(100, 12, 'C:\\Users\\artbo\\AppData\\Local\\Temp\\330f93dd43e328de880726470285c811.png');

-- Listage de la structure de table e-commerce. messenger_messages
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `reference` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `stock` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B3BA5A5AA21214B7` (`categories_id`),
  CONSTRAINT `FK_B3BA5A5AA21214B7` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.products : ~10 rows (environ)
INSERT INTO `products` (`id`, `categories_id`, `name`, `description`, `price`, `stock`, `created_at`, `slug`) VALUES
	(11, 113, 'Quas.', 'Optio dolores molestias et id necessitatibus. Aut illo in minus voluptatem ut unde ad. Non sequi ut in voluptatem esse provident.', 105896, 7, '2023-09-17 15:12:04', 'quas'),
	(12, 113, 'Hic officia.', 'Mollitia aut et vero nisi. Molestiae excepturi ab dolor aliquam eos qui ipsam. Nihil fuga id cumque et iure rerum.', 33889, 1, '2023-09-17 15:12:04', 'hic-officia'),
	(13, 112, 'Nam ut.', 'Vitae corporis hic omnis enim voluptatem soluta nemo. Consequatur aperiam repellendus vel soluta.', 38036, 3, '2023-09-17 15:12:04', 'nam-ut'),
	(14, 112, 'Officiis unde.', 'Aut laborum vel et quibusdam. Aut explicabo eveniet occaecati quam nemo veniam. Dolor quibusdam a harum similique expedita fugit error.', 86369, 10, '2023-09-17 15:12:04', 'officiis-unde'),
	(15, 106, 'Aut recusandae.', 'Dolor molestiae eos porro nulla dolorum placeat quia quam. Ab illo fugiat architecto aut.', 107691, 8, '2023-09-17 15:12:04', 'aut-recusandae'),
	(16, 110, 'Commodi.', 'Cupiditate dolore nulla numquam eum est dolor ut. Maiores aut vero vitae porro et nemo eum eius.', 93284, 1, '2023-09-17 15:12:04', 'commodi'),
	(17, 107, 'Sint sed.', 'Mollitia in et hic quia optio aut aliquam. Eos magni rem et commodi sit sed sed.', 51269, 8, '2023-09-17 15:12:04', 'sint-sed'),
	(18, 106, 'Quis ratione.', 'Et quae voluptates expedita accusamus. Eligendi qui vel dolores eius. Omnis est facilis in rerum quod.', 63376, 10, '2023-09-17 15:12:04', 'quis-ratione'),
	(19, 109, 'Perspiciatis.', 'Rem dolores earum nihil ut autem et. Aliquam non aut provident. Quia nihil sunt assumenda ipsa molestiae facilis. Omnis est ab ut id aliquam ut. Reprehenderit voluptas possimus est.', 51042, 9, '2023-09-17 15:12:04', 'perspiciatis'),
	(20, 112, 'Nobis.', 'Dolor delectus a illum tempora. Ut debitis atque nemo aut recusandae omnis sed. Repudiandae repellat maxime excepturi est ex.', 133242, 2, '2023-09-17 15:12:04', 'nobis');

-- Listage de la structure de table e-commerce. users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipcode` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1483A5E9E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table e-commerce.users : ~6 rows (environ)
INSERT INTO `users` (`id`, `email`, `roles`, `password`, `lastname`, `firstname`, `address`, `zipcode`, `city`, `created_at`) VALUES
	(26, 'admin@demo.fr', '["ROLE_ADMIN"]', '$2y$13$IeH4H4WZmBT1W4NNxWGOEu2./fPbZh694gbyqq7V3OlSdWSZ96wGW', 'John', 'Doe', '2 rue du port', '67400', 'Strasbourg', '2023-09-17 15:12:04'),
	(27, 'ocourtois@dupuis.fr', '[]', '$2y$13$kb1JnS9ySNq9qp28/iERdOQ5yI2dtW5pdUbFx2Dhh4rgczpzWVLu2', 'Maillot', 'Julien', '34, chemin Lemoine', '18731', 'Bonnet-sur-Lebreton', '2023-09-17 15:12:04'),
	(28, 'thierry.herve@tele2.fr', '[]', '$2y$13$3Mkf1WXAcEMCn9wYCars8OwUfmETElbbfWEeFcgZ48vce34Ya3IEK', 'Rossi', 'Laetitia', '53, avenue Riviere', '33212', 'Allain', '2023-09-17 15:12:05'),
	(29, 'morel.hugues@normand.com', '[]', '$2y$13$yZkybiAruqQpuAiRSlv4d.XjNTa0AEoOevSiXN.TMsi.HdiMFMes2', 'Rey', 'Inès', '81, avenue Tristan Morvan', '66320', 'GiraudVille', '2023-09-17 15:12:05'),
	(30, 'victor.mahe@orange.fr', '[]', '$2y$13$iQ8RMkHJaOaT4O/Z1YdvKerhqAckTVEm12b.kvp6CukdDuxxBE2lG', 'Bouvier', 'Capucine', '25, avenue Schmitt', '98181', 'Poirier', '2023-09-17 15:12:05'),
	(31, 'hamon.elodie@yahoo.fr', '[]', '$2y$13$2PqBlvhNNYKcfSEvf2Q15eM1xtMHh1d0LpDCy75pZePBdkYRDRKuu', 'Gimenez', 'Valentine', '64, rue de Renaud', '18327', 'Lecomte', '2023-09-17 15:12:06');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
