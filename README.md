# Komidi

Projet Komidi

Projet étuiant réalisé dans un but pédagogique.

Dans le cadre de son activité ailTECH vous demande de développer une application Client Serveur
de notation des spectacles du festival KOMIDI.
Le principe fondateur du festival Komidi repose sur l'accès à la culture pour tous. Il se donne pour
visée de proposer une grande diversité de spectacles et de genres théâtraux pour que chacun
puisse satisfaire sa curiosité1. Devenu un rendez-vous incontournable, Komidi attire des
spectateurs qui viennent de toute l'île pour assister à des représentations théâtrales dont les
billets coûtent de 1 à 3 euros l'unité2. Des représentations scolaires sont au programme tous les
ans, elles sont gratuites et ont brassé plus de 10 000 élèves3 de la maternelle au lycée lors de
l'édition 2014 et 13 000 en 2016.
L'application devra répondre à l'ensemble des besoins soulevés par le dirigeant de komidi, qui sont:

  - La création et la mise en place d'une base de donnée qui permettra d'accueillir les infomations du site
  - Disposer d'un espace de création d'utilisateurs regroupant les informations principales de ceux-ci
  - Disposer d'un espace de visualisation des spectacles présent dans la base de donnée
  - Un espace de notation des spectacles, associés aux différents utilisateurs
  - Ainsi qu'un espace de visualisation du compte de l'utilisateur
  
  Les choses à faire lors de la récupération:
  
    - Changer les informations de connexion à la base de donnée dans le fichier dev.ini du répertoire Config
    - Importer le fichier sql dans votre base de donnée intitulé komidi.sql qui regroupe le script de création 
    ainsi que quelques membres et spectacles pré-crées
    
  Des documents fournits au début du projet sont disponible dans le dépôt.
  Le projet est réalisé à la base en équipe mais spécialement pour l'épreuve E4 j'ai réalisé celui-ci en individuel , il regroupe
  ma part des tâches car j'ai effectué une refonte complète du projet initiale. 
  Voici les avantages de la refonte :
  
    - Un Framework MVC crée manuellement
    - Une architecture MVC orientée objet
    - Mise en place d'URL génériques
    - Automatisation du routage des requêtes
    - Accès générique aux données
    - Sécurisation des données reçues et affichées pour éviter les injections SQL 

    
