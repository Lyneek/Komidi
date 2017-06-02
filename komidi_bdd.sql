-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Ven 02 Juin 2017 à 14:32
-- Version du serveur :  5.7.14
-- Version de PHP :  5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `komidi_bdd`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_spectacles_selon_duree` (`p_spectacle_duree` INT)  BEGIN
    SELECT *
    FROM t_spectacle
    WHERE Spe_duree = p_spectacle_duree;                               
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_genre`
--

CREATE TABLE `t_genre` (
  `Gre_id` int(11) NOT NULL,
  `Gre_nom` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `t_genre`
--

INSERT INTO `t_genre` (`Gre_id`, `Gre_nom`) VALUES
(1, 'Théâtre musical et humoristique'),
(2, 'Comédie satirique'),
(3, 'Théâtre jeune public'),
(4, 'Burlesque et théâtre d\'objet en français et en créole'),
(5, 'Théâtre'),
(6, 'Théâtre musical et humoristique'),
(7, 'Comédie satirique'),
(8, 'Spectacle de dessin sur sable '),
(9, 'Théâtre gestuel'),
(10, 'Marionnette – objet'),
(11, 'Théâtre d\'humour musical'),
(12, 'Lecture théâtralisée'),
(13, 'Spectacle musical - Opéra'),
(14, 'Théâtre danse et humour'),
(15, 'Duo de spectacle musical'),
(16, 'Marionnettes sur table, musical et sans paroles');

-- --------------------------------------------------------

--
-- Structure de la table `t_membre`
--

CREATE TABLE `t_membre` (
  `Mem_id` int(11) NOT NULL,
  `Mem_nom` varchar(100) NOT NULL,
  `Mem_prenom` varchar(100) NOT NULL,
  `Mem_courriel` varchar(100) NOT NULL,
  `Mem_mdp` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `t_membre`
--

INSERT INTO `t_membre` (`Mem_id`, `Mem_nom`, `Mem_prenom`, `Mem_courriel`, `Mem_mdp`) VALUES
(24, 'Dupont', 'Benoit', 'Dupont@gmail.com', 'DBenoit'),
(25, 'admin', 'admin', 'admin@gmail.com', 'komidi'),
(26, 'Toto', 'Titi', 'tototiti@gmail.com', 'TTiti');

--
-- Déclencheurs `t_membre`
--
DELIMITER $$
CREATE TRIGGER `after_update_membre` AFTER UPDATE ON `t_membre` FOR EACH ROW BEGIN
  INSERT
INTO
  t_membre_histo(
    nom,
    prenom,
    courriel,
    mdp,
    date_histo,
    utilisateur_histo,
    evenement_histo
  )
VALUES(
  OLD.Mem_nom,
  OLD.Mem_prenom,
  OLD.Mem_courriel,
  OLD.Mem_mdp, NOW(), CURRENT_USER(), 'UPDATE') ;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_membre_histo`
--

CREATE TABLE `t_membre_histo` (
  `id` smallint(6) UNSIGNED NOT NULL,
  `nom` varchar(30) DEFAULT NULL,
  `prenom` varchar(20) DEFAULT NULL,
  `courriel` varchar(30) DEFAULT NULL,
  `mdp` varchar(16) NOT NULL,
  `date_histo` datetime NOT NULL,
  `utilisateur_histo` varchar(20) NOT NULL,
  `evenement_histo` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `t_membre_histo`
--

INSERT INTO `t_membre_histo` (`id`, `nom`, `prenom`, `courriel`, `mdp`, `date_histo`, `utilisateur_histo`, `evenement_histo`) VALUES
(1, 'Dupont', 'Benoit', 'Dupont@gmail.com', 'DBenoit', '2017-06-02 17:34:08', 'root@localhost', 'UPDATE'),
(2, 'Dupont', 'Jack', 'Dupont@gmail.com', 'DBenoit', '2017-06-02 17:35:49', 'root@localhost', 'UPDATE'),
(3, 'Dupont', 'Benoit', 'Dupont@gmail.com', 'DBenoit', '2017-06-02 17:43:47', 'root@localhost', 'UPDATE');

-- --------------------------------------------------------

--
-- Structure de la table `t_notation`
--

CREATE TABLE `t_notation` (
  `Mem_idNote` int(11) NOT NULL,
  `Spe_idNote` int(11) NOT NULL,
  `Nota_note` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `t_spectacle`
--

CREATE TABLE `t_spectacle` (
  `Spe_id` int(11) NOT NULL,
  `Spe_titre` varchar(100) DEFAULT NULL,
  `Spe_duree` int(11) NOT NULL DEFAULT '0',
  `Spe_affiche` varchar(50) DEFAULT NULL,
  `Spe_resumeCourt` varchar(500) DEFAULT NULL,
  `GreSpec_id` int(11) DEFAULT NULL,
  `Spe_resumeLong` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `t_spectacle`
--

INSERT INTO `t_spectacle` (`Spe_id`, `Spe_titre`, `Spe_duree`, `Spe_affiche`, `Spe_resumeCourt`, `GreSpec_id`, `Spe_resumeLong`) VALUES
(1, '150Kg à deux...On vous en met un peu plus ?', 60, '2017-150kg.jpg', 'Deux drôles d’oiseaux se livrent sans retenue à une festive joute verbale, un combat à mots nus, phrases délicates et refrains sans cholestérol.', 12, 'Deux drôles d’oiseaux se livrent sans retenue à une festive joute verbale, un combat à mots nus, phrases délicates et refrains sans cholestérol.\nLeur cahier des charges ? La légèreté ! Sur la balance, pas un gramme de gras, deux écritures aériennes, car, voyez-vous, ces deux-là ont de la plume !\nUn émincé de traits d’esprit en apesanteur, avec pour seules armes une guitare aérienne et deux pupitres venus à pied. Deux poids... démesure !'),
(2, 'Au nom du pèze', 45, '2017-peze.jpg', 'Richard est devenu, à contrario de ses utopies juvéniles, l’homme d’affaire le plus riche de la planète. Il est accro à l’argent. Comme pour toute drogue dure, cette addiction le mène jusqu’à l’overdose.', 2, 'Richard est devenu, à contrario de ses utopies juvéniles, l’homme d’affaire le plus riche de la planète. Il est accro à l’argent. Comme pour toute drogue dure, cette addiction le mène jusqu’à l’overdose. Si cette fois il en réchappe, il n’en demeure pas moins contraint de suivre une cure de désintoxication monétaire. Sur le conseil des A.A.A (les Accros à l’Argent Anonyme) et afin d’éviter la rechute fatale, il doit tout mettre en œuvre pour perdre de l’argent, se « désenrichir » …. Désenrichir ? Le mot n’existe pas. Comment Richard va-t-il réussir cette course au «désenrichissement » ? Comment réaliser cette folle utopie de posséder moins quand on a tout et que ce tout rapporte dividendes sur dividendes contre sa propre volonté ? Comment échapper au système dont on est le maître-artisan ? Comment fuir un film catastrophe quand on en est l’acteur principal ?'),
(3, 'Au pied de mon arbre', 60, '2017-pieddemonarbre.jpg', 'L’arbre rouge est un fabuleux trésor dans le jardin de l’enfance de deux petites sœurs qui s’inventent milles et une façon de rencontrer la grande Vie et ses mystères. ', 5, 'L’arbre rouge est un fabuleux trésor dans le jardin de l’enfance de deux petites sœurs qui s’inventent milles et une façon de rencontrer la grande Vie et ses mystères. \nFleur a six ans. Elle aime les fleurs, les arbres, l’odeur de la terre, les petites bêtes et les coccinelles, le parfum de la citronnelle et les histoires de graines.\nRosa, la soeur de Fleur a huit ans. Elle aime les livres, les parfums d’orient, la musique, les vieux objets et le parfum de mémé Adélaïde. Elle aime les jupons qui dépassent de sa robe.\nFleur veut la valise Rouge de Rosa, elle sait qu’elle contient les secrets de sa soeur. Rosa veut les lunettes de Fleur, elle sait qu’elles possèdent un pouvoir magique.\nAu pied de mon arbre est l’histoire d’enfants qui cherchent des réponses à leurs questions et qui trouvent des réponses qui font naitre d’autres questions …'),
(4, 'Aujourd’hui plus qu’hier', 60, '2017-aujourdhuiplus.jpg', 'Dans leur petite salle-à-manger trop moderne pour eux, Minouche et Minouche, couple de centenaires à la mémoire défaillante, tentent de se rappeler leurs vrais prénoms.', 13, 'Dans leur petite salle-à-manger trop moderne pour eux, Minouche et Minouche, couple de centenaires à la mémoire défaillante, tentent de se rappeler leurs vrais prénoms.\nAujourd\'hui, Minouche et Minouche sont très très vieux.  Quel âge a-t-il ? Quel âge a-t-elle ? Ils ne savent plus très bien. Hier, c\'était une autre histoire : hier, ils n\'avaient pas le même prénom. Il s\'appelait....    Elle s\'appelait... Comment s\'appelaient-ils donc? Ils ont la mémoire qui bugge.\nPourtant Minouche , elle, pourrait tout vous raconter de leur rencontre,  ils étaient des enfants, il y a... combien de temps ? Il y a si longtemps. Et Minouche, lui, pourrait vous dire la suite, quand tout a commencé vraiment, dans ce "bal la poussière".\nMinouche et Minouche connaissent si bien cette histoire là qu\'ils en oublient le reste :   ont-ils déjà mangé ce midi? Oui, non, peut-être. Et comment marchent ces choses là, maintenant? Télévision, télécommande, décodeur, ventilateur, télécommande, téléphone, radio, chaîne Hifi, télécommande... Tant d\'étranges machines sans fil ni bouton, aujourd\'hui. '),
(5, 'Bashir Lazhar', 30, '2017-bashir.jpg', 'L’histoire extraordinaire d’un homme ordinaire. Embauché au pied levé comme professeur remplaçant dans une école primaire, Bashir Lazhar, enseignant pas comme les autres, apprend peu à peu à connaître et à s’attacher à ses élèves. Et pendant ce temps, personne à l’école ne soupçonne le passé de Bashir…', 13, 'L’histoire extraordinaire d’un homme ordinaire. Embauché au pied levé comme professeur remplaçant dans une école primaire, Bashir Lazhar, enseignant pas comme les autres, apprend peu à peu à connaître et à s’attacher à ses élèves. Et pendant ce temps, personne à l’école ne soupçonne le passé de Bashir…\nUne pièce en forme de puzzle, qui parle à la fois d’éducation, d’amour, de migration, d’enfance, de violence, de dictée, de justice, de cour de récréation, de transmission, de guerre et de taille-crayon.'),
(6, 'Boby Lapointe', 60, '2017-boby.jpg', 'Accompagné de sa guitare et de son accordéon diatonique, Jacques Dau entre de plain-pied dans l’univers absurde de Boby Lapointe et on l’accompagne avec plaisir.', 16, 'Accompagné de sa guitare et de son accordéon diatonique, Jacques Dau entre de plain-pied dans l’univers absurde de Boby Lapointe et on l’accompagne avec plaisir.\nIl nous raconte l’histoire du jeu de mots. Le premier qu’on a compris, c’était lequel ? Et c’était quand ? D’un coup, à ce moment-là, très précis, on a eu cette sensation délicieuse d’être plus intelligent, comme si, dans notre cerveau, une fenêtre supplémentaire s’ouvrait et nous faisant entrevoir un autre monde, parallèle au nôtre, avec son propre langage.'),
(7, 'Caché dans son buisson de lavande, Cyrano sentait ', 60, '2017-cachecyrano.jpg', 'Quand on a un gros nez, on peut aussi avoir une vie normale. Manger (sans trop de poivre), boire (avec une paille), dormir (sauf sur le ventre) et être amoureux (sans commentaires). Cyrano était amoureux. De sa cousine Roxanne.', 14, 'Quand on a un gros nez, on peut aussi avoir une vie normale. Manger (sans trop de poivre), boire (avec une paille), dormir (sauf sur le ventre) et être amoureux (sans commentaires). Cyrano était amoureux. De sa cousine Roxanne.'),
(8, 'Camille et Simon fêtent leur divorce', 60, '2017-camilleetsimon.jpg', 'Le One-Couple-Show qui titille la libido. Camille et Simon ont la joie de vous faire part de leur divorce ! Ce soir ils donnent une réception avec traiteur et orchestre. Parents et amis sont là pour immortaliser l’évènement.', 3, 'Le One-Couple-Show qui titille la libido. Camille et Simon ont la joie de vous faire part de leur divorce ! Ce soir ils donnent une réception avec traiteur et orchestre. Parents et amis sont là pour immortaliser l’évènement.'),
(9, 'Des rêves dans le sable', 60, '2017-revesdanssable.jpg', 'Lorène Bihorel est une jeune artiste qui excelle dans une discipline d’un genre nouveau. Elle présente un spectacle étonnant de dessin sur sable, qui émerveille les enfants et fascine les adultes.', 5, 'PRIX DU FESTIVAL D’AVIGNON 2014\nLorène Bihorel est une jeune artiste qui excelle dans une discipline d’un genre nouveau. Elle présente un spectacle étonnant de dessin sur sable, qui émerveille les enfants et fascine les adultes. Sur sa table lumineuse, rediffusée simultanément sur grand écran, les dessins naissent en quelques secondes et se transforment sous les yeux des spectateurs, au rythme des histoires auxquelles ils donnent vie. Un moment unique et magique.'),
(10, 'Des roses dans la salade', 60, '2017-rosesdanssalade.jpg', '“Les légumes c’est du sérieux!” dit le Chef. “Les légumes c’est pas marrant !” dit Romilda, son assistante.', 8, '“Les légumes c’est du sérieux!” dit le Chef. “Les légumes c’est pas marrant !” dit Romilda, son assistante.\nIl faudrait y mettre un peu de couleur dans cette cuisine, non ? Qu’en pensez-vous ? À partir du travail de recherche de Bruno Munari, un spectacle avec épluchures de légumes, peinture, ombres chinoises et animations vidéo créé pour les enfants à partir de 2 ans.\nAprès son succès au Festival International de Théâtre pour l’Enfance de Bologne, au Musée des Enfants de Milan et après plusieurs ateliers menés et spectacles joués en écoles maternelles, crèches et théâtres en Italie, le spectacle arrive en France pour la première fois.'),
(11, 'I’m gonna sit right down and write myself a letter', 60, '432422.jpg', '', 13, ''),
(12, 'Intra-muros', 30, '2017-intramuros.jpg', 'Tandis que l\'orage menace, Richard, un metteur en scène sur le retour, vient dispenser son premier cours de théâtre en prison centrale.', 10, 'Tandis que l\'orage menace, Richard, un metteur en scène sur le retour, vient dispenser son premier cours de théâtre en prison centrale. Il espère une forte affluence, qui entraînerait d\'autres cours - et d\'autres cachets - mais seuls deux détenus se présentent : Kevin, un jeune chien fou, et Ange, la cinquantaine mutique, qui n\'est là que pour accompagner son ami. Richard, secondé par une de ses anciennes actrices - accessoirement son ex-femme - et par une assistante sociale inexpérimentée, choisit de donner quand même son cours…'),
(13, 'J’ai hâte d’aimer', 30, '2017-jaihatedaimer.jpg', 'J\'ai hâte d\'aimer est le fruit de la rencontre extraordinaire entre la compagnie Interface et Francis Lalanne. Un spectacle aux multiples langages, hymne à la naissance, hymne à ces instants ou l\'univers se présente à soi dans toute sa splendeur et sa force.', 7, 'Prix du public au festival OFF Avignon 2014 avec le spectacle Teruel\nJ\'ai hâte d\'aimer est le fruit de la rencontre extraordinaire entre la compagnie Interface et Francis Lalanne. Un spectacle aux multiples langages, hymne à la naissance, hymne à ces instants ou l\'univers se présente à soi dans toute sa splendeur et sa force. Après avoir vécu j\'ai hâte d\'aimer, on se souvient que tout part du rêve et quand le rêve disparait, la vie s\'éteint. '),
(14, 'Je buterais bien ma mère un dimanche', 60, '2017-jebuteraisbien.jpg', 'Que celui qui n’a jamais eu envie de tuer sa mère lui jette la première pierre.', 6, 'Que celui qui n’a jamais eu envie de tuer sa mère lui jette la première pierre. Trois générations de femmes esquintées par la vie, de la grand-mère collabo à la fille percluses de névroses, l’histoire n’est pas banale. Julie Villers, comédienne burlesque, propose une thérapie folle-dingue, entre cartoon et Almodovar, pour que toutes ces femmes se (ré)concilient.'),
(15, 'Joséphina', 60, '2017-josephina.jpg', 'Au travers de jeux de mots et de gestes, d’ellipses et d’indices, une absente omniprésente, Joséphina, occupe l’espace…', 14, 'Récompensé par trois coups de cœur lors du Festival de Montréal, élu « Meilleur spectacle » au Festival International de Théâtre à Monterrey au Mexique. Prix du Public au festival Internationale de Théâtre et de Danse de Huesca en Espagne.\nAu travers de jeux de mots et de gestes, d’ellipses et d’indices, une absente omniprésente, Joséphina, occupe l’espace… Que s’est-il passé trois mois plus tôt ? Au fil des partitions physiques, à demi-mot et à demi-geste, des fragments de vie et d’intimité sont dévoilés. Quelle piste suivre ou croire ? Empreintes gestuelles et traces sonores s’entremêlent, cherchant à révéler le fin mot de l’histoire…'),
(16, 'Juliette et Roméo', 60, '2017-julietteetromeo.jpg', 'C’est l’histoire de Roméo et Juliette bien sûr... mais racontée par la Nourrice. C’est elle qui a élevé Juliette, c’est elle qui a été le témoin de ses premiers émois amoureux, et tout ça pour finir si tragiquement ! Alors elle a besoin de la raconter cette histoire, encore et encore, avec toutes ses marionnettes. Les marionnettes peuvent mourir tant de fois. Donc revivre aussi. ', 15, 'C’est l’histoire de Roméo et Juliette bien sûr... mais racontée par la Nourrice. C’est elle qui a élevé Juliette, c’est elle qui a été le témoin de ses premiers émois amoureux, et tout ça pour finir si tragiquement ! Alors elle a besoin de la raconter cette histoire, encore et encore, avec toutes ses marionnettes. Les marionnettes peuvent mourir tant de fois. Donc revivre aussi. '),
(17, 'L’homme de rien', 60, '2017-lhommederien.jpg', 'Un conte mouvementé qui commence la nuit de Noël, et qui dérape ! Quand il était enfant, l’homme de rien a reçu une pelle en cadeau. Depuis il creuse des trous, et un jour il tombe dedans ! Entre danse, théâtre et clown, tous les âges sont invités à découvrir le mime.', 4, 'Un conte mouvementé qui commence la nuit de Noël, et qui dérape ! Quand il était enfant, l’homme de rien a reçu une pelle en cadeau. Depuis il creuse des trous, et un jour il tombe dedans ! Entre danse, théâtre et clown, tous les âges sont invités à découvrir le mime.'),
(18, 'La beauté, recherche et développements', 60, '2017-labeaute.jpg', 'Pour relativiser toutes nos angoisses, deux femmes, Brigitte et Nicole, ont trouvé la solution : Le "Parcours Beauté".\nElles vous accueillent et vous guident à travers les méandres de la beauté, entre le délire burlesque et l\'absurde.', 2, 'Pour relativiser toutes nos angoisses, deux femmes, Brigitte et Nicole, ont trouvé la solution : Le "Parcours Beauté".\nElles vous accueillent et vous guident à travers les méandres de la beauté, entre le délire burlesque et l\'absurde.\nNicole et Brigitte sont deux femmes d\'âge moyen, comme on dit. Et c\'est d\'ailleurs parce qu\'elles sont "moyennes" qu\'elles sont aussi capables de tout. Le pire et le meilleur.'),
(19, 'La fossette bleue', 60, '2017-fossettebleue.jpg', 'Quels goûts nous ont laissé nos Madeleines ? Que nous reste-t-il de nos souvenirs, nos émotions, nos sensations ? A quoi nous servent-ils ? Difficile pour Clémence d’être “une grande fille efficace au présent”, quand on songe perpétuellement à “la petite fille décalée qu’on a été”.', 1, 'Quels goûts nous ont laissé nos Madeleines ? Que nous reste-t-il de nos souvenirs, nos émotions, nos sensations ? A quoi nous servent-ils ? Difficile pour Clémence d’être “une grande fille efficace au présent”, quand on songe perpétuellement à “la petite fille décalée qu’on a été”. Aidée par Éric, son cousin à l’existence machinale, elle finit par décrocher un job.\nElle rencontre Julien, petit chef obtus qui se fout éperdument des états d’âme de Clémence qui, de son côté, méprise ce petit monsieur chez qui elle ne décèle pas la moindre trace d’affect.\nAprès “Du vent dans mes mollets” et “Et pendant ce temps-là, les araignées tricotent des pulls autour de nos bilboquets”, Raphaële Moussafir revient avec sa toute dernière création.'),
(20, 'La main de Leïla', 60, '2017-lamainleila.jpg', '1987, Sidi Fares, un petit village proche d’Alger. Dans un garage secrètement transformé en salle de spectacle, Samir rejoue les plus grands baisers du cinéma que l’Etat censure. “Un dinar la place et bienvenue au Haram Cinéma, le cinéma le plus illégal de toute l’Algérie !” Ici, il y a deux règles à respecter: l’identité de Samir doit rester secrète et les femmes sont interdites. Sauf qu’un jour, Leïla, la fille du puissant colonel Bensaada, se glisse dans le public et découvre la mythique hist', 15, '1987, Sidi Fares, un petit village proche d’Alger. Dans un garage secrètement transformé en salle de spectacle, Samir rejoue les plus grands baisers du cinéma que l’Etat censure. “Un dinar la place et bienvenue au Haram Cinéma, le cinéma le plus illégal de toute l’Algérie !” Ici, il y a deux règles à respecter: l’identité de Samir doit rester secrète et les femmes sont interdites. Sauf qu’un jour, Leïla, la fille du puissant colonel Bensaada, se glisse dans le public et découvre la mythique histoire de Casablanca. Un an plus tard, Samir et Leïla s’aiment d’un amour inconditionnel mais interdit... Ils rêvent à un avenir commun tandis que derrière eux, se trame l’ombre d’octobre 88…'),
(21, 'La tragédie comique', 60, '2017-tragediecomique.jpg', 'A la croisée du théâtre élisabéthain et de la création contemporaine, La Tragédie Comique joue avec la représentation, son cortège d\'impostures et de dévoilements, ses limites et son infinité.', 16, 'Prix du « Meilleur spectacle étranger » à Québec (Carrefour International de Théâtre de Québec)\nA la croisée du théâtre élisabéthain et de la création contemporaine, La Tragédie Comique joue avec la représentation, son cortège d\'impostures et de dévoilements, ses limites et son infinité. Seul en scène, Yves Hunstad, avec une maîtrise du verbe hors du commun, invente un fabuleux personnage cosmique, humain, grave et fragile, qui nous embarque, séance tenante, pour un voyage jusqu’au coeur d’un grand mystère : celui du THÉÂTRE. Yves Hunstad brasse le plaisir du jeu, l’intelligence alliée à l’émotion et nous livre un inoubliable moment de grâce. '),
(22, 'Le cercle des illusionnistes', 30, '2017-lecercle.jpg', 'Résumé du spectacle : En 1984, alors que se déroule le championnat d’Europe des Nations, Décembre vole un sac dans le métro. Dans le sac, il trouve la photo d’Avril jolie.', 1, '3 MOLIÈRES 2014 MEILLEUR AUTEUR MEILLEURE MISE EN SCÈNE et REVELATION FÉMININE\n\nRésumé du spectacle : En 1984, alors que se déroule le championnat d’Europe des Nations, Décembre vole un sac dans le métro. Dans le sac, il trouve la photo d’Avril jolie. Il la rappelle, ils se rencontrent dans un café. Il va lui raconter l’histoire de Jean-Eugène Robert-Houdin, horloger, inventeur, magicien du XIXe siècle. Cette histoire les mènera tous deux sous le coffre de la BNP du boulevard des Italiens, dans le théâtre disparu de Robert-Houdin, devant la roulotte d’un escamoteur, derrière les circuits du Turc mécanique, aux prémices du kinétographe, et à travers le cercle des illusionnistes.'),
(23, 'Le chat botté', 60, '2017-chatbotte.jpg', 'La Cie Les Nomadesques, qui triomphe depuis 5 ans à Paris avec LE LOUP EST REVENU est de retour à KOMIDI avec LE CHAT BOTTE, complet au festival en 2014! Et 2015 ! à Avignon.', 3, 'La Cie Les Nomadesques, qui triomphe depuis 5 ans à Paris avec LE LOUP EST REVENU est de retour à KOMIDI avec LE CHAT BOTTE, complet au festival en 2014! Et 2015 ! à Avignon.'),
(24, 'Le comte de Monte Cristo', 45, '2017-comtemontecristo.jpg', 'Tout commence avec la visité guidée au château d\'If, forteresse maritime-prison désaffectée, d\'un étrange visiteur plus particulièrement intéressé par deux cellules, celles qui furent occupées par un jeune marin et un abbé érudit, savant et philosophe. Commence également un voyage dans le temps et l\'espace qui va reconstituer une vie.', 8, 'Tout commence avec la visité guidée au château d\'If, forteresse maritime-prison désaffectée, d\'un étrange visiteur plus particulièrement intéressé par deux cellules, celles qui furent occupées par un jeune marin et un abbé érudit, savant et philosophe. Commence également un voyage dans le temps et l\'espace qui va reconstituer une vie.'),
(25, 'Le conte des contes', 45, '2017-contedescontes.jpg', 'Ô lecteur, si tu n’as pas les oreilles bouchées par de la bouillie de roseau, si tu n’es pas aveuglé par de la fiente d’hirondelle, je suis sûr que tu sauras goûter toute la truculence et la vivacité de ce Conte des Contes ! ', 6, 'Ô lecteur, si tu n’as pas les oreilles bouchées par de la bouillie de roseau, si tu n’es pas aveuglé par de la fiente d’hirondelle, je suis sûr que tu sauras goûter toute la truculence et la vivacité de ce Conte des Contes ! N’allez pas croire que cet accès de familiarité soit gratuit : c’est, à quelques mots près, la langue de Giambattista Basile, dans « La vieille écorchée », un des cinquante contes enchâssés dans le Conte des Contes. Et précisément un des deux que Sylvie Espérance, traduit en créole. L’autre, « L’Ourse », sera dit en français.'),
(26, 'Le petit poilu illustré', 60, '2017-petitpoilu.jpg', 'Paul et Ferdinand, deux poilus, anciennement artistes de cabaret, reviennent de l’au-delà pour raconter la guerre... Entre humour, burlesque et poésie, ils rejoueront pour nous les grands chapitres de l’Histoire.', 13, 'Labellisé et soutenu par le CENTENAIRE de la Grande Guerre (Ministère).\nPaul et Ferdinand, deux poilus, anciennement artistes de cabaret, reviennent de l’au-delà pour raconter la guerre... Entre humour, burlesque et poésie, ils rejoueront pour nous les grands chapitres de l’Histoire. Ce duo clownesque raconte en un condensé facétieux l’histoire et les absurdités de la Grande Guerre.'),
(27, 'Le piston de Manoche', 60, '2017-manoche.jpg', 'Manoche, enfant croisé de Bourvil et de Raymond Devos, nous entraîne dans une désopilante et poétique virée musicale.', 7, 'Prix Coup de Coeur du FESTIVAL D’AVIGNON 2011\nManoche, enfant croisé de Bourvil et de Raymond Devos, nous entraîne dans une désopilante et poétique virée musicale. Tendre clown accroché à son instrument, Manoche jongle subtilement avec les mots qui se jouent de lui et l’entraînent dans des situations rocambolesques, tout en tentant de nous faire découvrir les mystères du cornet à pistons. Un prétexte pour nous dresser un tableau de notre société avec des histoires à dormir debout. Personnage lunaire qui semble s’être trompé d’endroit, il semble avoir oublié qu’il fait là. Empêtré dans ses mots et dans son corps, il bouscule nos certitudes et nos préjugés avec verve, humour, musique et poésie. Plus qu\'un simple divertissement, faire rire sans avilir... '),
(28, 'Le tort qu’on a, c’est d’adresser la parole aux ge', 60, '2017-letord.jpg', 'L\'œuvre de Samuel Beckett, c\'est un éventail de styles littéraires et de sujets qui résonnent encore  parmi les plus actuels. Beckett est porteur d\'une modernité engagée, post-moderne pour certains mais surtout ancrée dans l\'écriture comme lieu d\'une résistance à toute habitude de complaisance subjective.', 3, 'L\'œuvre de Samuel Beckett, c\'est un éventail de styles littéraires et de sujets qui résonnent encore  parmi les plus actuels. Beckett est porteur d\'une modernité engagée, post-moderne pour certains mais surtout ancrée dans l\'écriture comme lieu d\'une résistance à toute habitude de complaisance subjective. La lecture de son œuvre montre comment Beckett nous entraine encore, toujours, dans l\'étrangeté de l\'être et dans la dimension poétique des traversées de langues. Ses jeux de l\'autobiographie fictive, depuis le foisonnement et le labyrinthe des premiers romans jusqu\'au minimalisme de ses dernières années, marquent l\'histoire unique d\'un prix Nobel qui remonte à 1969.'),
(29, 'Le tour du monde en 80 jours', 60, '2017-letourdumonde.jpg', 'Fidèlement adapté du chef d’œuvre de Jules Verne, ce spectacle virevoltant, drôle et pétillant nous fait voyager dans l’Égypte, l’Inde, la Chine et les États-Unis du 19e siècle. Trains, bateaux, éléphant et montgolfière transportent nos héros tout autour du globe.', 11, 'Fidèlement adapté du chef d’œuvre de Jules Verne, ce spectacle virevoltant, drôle et pétillant nous fait voyager dans l’Égypte, l’Inde, la Chine et les États-Unis du 19e siècle. Trains, bateaux, éléphant et montgolfière transportent nos héros tout autour du globe.'),
(30, 'Les contes d’Hoffmann', 60, '2017-lesconteshoffmann.jpg', 'Dans une taverne brumeuse, Hoffmann rencontre un riche industriel, Lindorf, qui le fait boire et raconter l’histoire des trois femmes de sa vie, tandis que leur maîtresse commune, Stella, se fait attendre.', 2, 'Prix du public du FESTIVAL D’AVIGNON 2013 avec Cosi Fan Tutte\nPrix du public du FESTIVAL D’AVIGNON 2014 pour Les contes d’’Hoffmann\nDans une taverne brumeuse, Hoffmann rencontre un riche industriel, Lindorf, qui le fait boire et raconter l’histoire des trois femmes de sa vie, tandis que leur maîtresse commune, Stella, se fait attendre.'),
(31, 'Ma class’ Hip Hop', 60, '2017-maclasshiphop.jpg', 'Avec Ma Class’ Hip Hop, Céline Lefèvre nous propose un voyage à travers les époques, et les techniques pour découvrir 40 ans d’histoire d’une danse de rue très codée venue des Etats Unis : Le Hip Hop.', 2, 'Avec Ma Class’ Hip Hop, Céline Lefèvre nous propose un voyage à travers les époques, et les techniques pour découvrir 40 ans d’histoire d’une danse de rue très codée venue des Etats Unis : Le Hip Hop.'),
(32, 'Ma folle otarie', 60, '2017-mafolleotarie.jpg', 'L’employé d’une agence de voyages, insignifiant et timide à l’excès, se trouve confronté soudain à un problème des plus atypiques, à priori risible mais plein de conséquences fâcheuses.', 8, 'L’employé d’une agence de voyages, insignifiant et timide à l’excès, se trouve confronté soudain à un problème des plus atypiques, à priori risible mais plein de conséquences fâcheuses. Tous ses slips et ses pantalons commencent irrésistiblement à rétrécir depuis que ses fesses ont commencé petit à petit, inexorablement, à grossir démesurément. Devenu une sorte de monstre, il trouvera refuge auprès d’une otarie.'),
(33, 'Ma vie sans bal', 60, '2017-maviesansbal.jpg', 'Dans cette conférence dansée de vingt à trente minutes, Eric Languet et Wilson Payet abordent de façon légère et décomplexée le handicap dans toutes ses dimensions : sociale, symbolique, philosophique et poétique.', 13, 'Dans cette conférence dansée de vingt à trente minutes, Eric Languet et Wilson Payet abordent de façon légère et décomplexée le handicap dans toutes ses dimensions : sociale, symbolique, philosophique et poétique.\nForts d’une expérience de 15 ans en danse intégrée(*), ils nous livrent en mouvements et en mots leur vision à la fois réaliste, provocante et émouvante de ces mondes que l’on réunit sous le terme générique de « Handicap ».\n(*) Danse intégrée : Ateliers de danse intégrant des personnes handicapées et des personnes porteuses de normalité.'),
(34, 'Mémoires d’un fou', 60, '2017-memoiredunfou.jpg', 'Mémoires d\'un fou est le 1er texte en partie autobiographique de Gustave Flaubert, la matrice géniale de toute son œuvre. Il y raconte l\'enfance, la jeunesse, les questionnements existentiels aux accents intemporels mais surtout la découverte de l\'amour, le plus pur, le plus passionné.', 15, 'Mémoires d\'un fou est le 1er texte en partie autobiographique de Gustave Flaubert, la matrice géniale de toute son œuvre. Il y raconte l\'enfance, la jeunesse, les questionnements existentiels aux accents intemporels mais surtout la découverte de l\'amour, le plus pur, le plus passionné.'),
(35, 'Mon jardin', 60, '2017-monjardin.jpg', 'Une plongée sensible au cœur de la relation parent-enfant. Au fil des chansons nous partageons l\'agitation d\'une maman qui veut bien faire, les projets d\'avenir d\'un papa rêveur, et l\'univers d\'un joyeux petit garçon qui ne comprend pas que ses plus belles idées soient nommées "bêtises".', 12, 'Une plongée sensible au cœur de la relation parent-enfant. Au fil des chansons nous partageons l\'agitation d\'une maman qui veut bien faire, les projets d\'avenir d\'un papa rêveur, et l\'univers d\'un joyeux petit garçon qui ne comprend pas que ses plus belles idées soient nommées "bêtises". Un spectacle plein d\'émotion qui convie enfants et parents à rire ensemble librement.'),
(36, 'Nul n’est à l’abri', 60, '2017-nulnestalabri.jpg', '', 8, ''),
(37, 'Peter Pan', 60, '2017-planete.jpg', 'Trois êtres atypiques sans voix ni lois, habitent trois manipulateurs, témoins et acteurs de leurs confrontations émotionnelles. Tour à tour colériques, versatiles, facétieux, violents ou candides, ils se déchirent ou se rassemblent. Les manipulateurs devront trouver un équilibre entre l’ordre et le chaos.', 1, 'Trois êtres atypiques sans voix ni lois, habitent trois manipulateurs, témoins et acteurs de leurs confrontations émotionnelles. Tour à tour colériques, versatiles, facétieux, violents ou candides, ils se déchirent ou se rassemblent. Les manipulateurs devront trouver un équilibre entre l’ordre et le chaos.');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `t_genre`
--
ALTER TABLE `t_genre`
  ADD PRIMARY KEY (`Gre_id`);

--
-- Index pour la table `t_membre`
--
ALTER TABLE `t_membre`
  ADD PRIMARY KEY (`Mem_id`),
  ADD UNIQUE KEY `Mem_courriel` (`Mem_courriel`);

--
-- Index pour la table `t_membre_histo`
--
ALTER TABLE `t_membre_histo`
  ADD PRIMARY KEY (`id`,`date_histo`);

--
-- Index pour la table `t_notation`
--
ALTER TABLE `t_notation`
  ADD PRIMARY KEY (`Mem_idNote`,`Spe_idNote`),
  ADD KEY `Spe_idNote` (`Spe_idNote`);

--
-- Index pour la table `t_spectacle`
--
ALTER TABLE `t_spectacle`
  ADD PRIMARY KEY (`Spe_id`),
  ADD KEY `fk_spe_gen` (`GreSpec_id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `t_genre`
--
ALTER TABLE `t_genre`
  MODIFY `Gre_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT pour la table `t_membre`
--
ALTER TABLE `t_membre`
  MODIFY `Mem_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT pour la table `t_membre_histo`
--
ALTER TABLE `t_membre_histo`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `t_spectacle`
--
ALTER TABLE `t_spectacle`
  MODIFY `Spe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `t_notation`
--
ALTER TABLE `t_notation`
  ADD CONSTRAINT `Mem_idNote` FOREIGN KEY (`Mem_idNote`) REFERENCES `t_membre` (`Mem_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Spe_idNote` FOREIGN KEY (`Spe_idNote`) REFERENCES `t_spectacle` (`Spe_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `t_spectacle`
--
ALTER TABLE `t_spectacle`
  ADD CONSTRAINT `fk_spe_gen` FOREIGN KEY (`GreSpec_id`) REFERENCES `t_genre` (`Gre_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
