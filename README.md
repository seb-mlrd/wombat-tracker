# Wombat Tracker
Application de runing en Flutter pour voir les scores et les stat de ses amis 
## Sommaire
1. [Présentation](#-présentation)
2. [Fonctionnalités](#-fonctionnalités)
3. [Architecture technique](#-architecture-technique)
4. [Modélisation de la base de données](#-modélisation-de-la-base-de-données)
5. [Diagramme de classes](#-diagramme-de-classes)
6. [Diagramme de séquence](#-diagramme-de-séquence)
7. [Captures d’écran](#-captures-décran)
8. [Installation](#-installation)
9. [Technologies utilisées](#-technologies-utilisées)
10. [Contributeurs](#-contributeurs)

## 🧾 Présentation
Wombat Tracker est une application permettant aux utilisateurs de voir et partager ses statistiques de running, rechercher, ajouter, des amis dans un environemen mobile intuitif.

## ✨ Fonctionnalités

- 🔍 Recherche d'utilisateurs
- ➕ Ajouter des amis
- 👥 Affichage de la liste d’amis
- 🖋️ Modifier son profile
- 📍 Partager et voir des sessions de running que les utilisateurs ont partager
- ⛅ Voir la météo qu'il fait avant les sessions running
- 🗒️ Voir les plannings

## 🏗️ Architecture technique

- utils (Call API, Validateurs)
- test (Test des widget et des fonctions utils)
- widget (Composant réutilisable)
- screen (Page de l'application)


## 🗃️ Modélisation de la base de données

Voici la structure de la base de donné supabase :

![Modélisation de la BDD](lib/docs/bdd.md)
![Modélisation de la BDD supabase](lib/docs/bdd.png)



## 📦 Diagramme de classes

Ce diagramme UML montre les relations entre les principales classes de l’application :

![Diagramme de classes](lib/docs/class-diagram.md)

## 🔁 cas utilisation

Exemple : ajout d’un ami par un utilisateur.

1. Cas de partage des sessions run

![Diagramme cas utilisation](lib/docs/use-case-share-run.png)

2. Ajout des récompenses par l'admin

![Diagramme cas utilisation](lib/docs/use-case-admin-stick.png)

3. Partager et voir les publications

![Diagramme cas utilisation](lib/docs/use-case-add-friends-and-show-run.png)


## 🖼️ Captures d’écran

| Écran de recherche | Résultat | Demande envoyée |
|--------------------|----------|------------------|
| ![](docs/screen1.png) | ![](docs/screen2.png) | ![](docs/screen3.png) |


## ⚙️ Installation

1. Cloner le projet :
   ```bash
   git clone https://github.com/seb-mlrd/diagram-wombat-tracker
   cd wombat-tracker
   flutter pub get
   flutter run


---

## 🛠️ Technologies utilisées

- Flutter 3.x
- Dart
- Supabase



## 👨‍💻 Contributeurs

- [@seb-mlrd](https://github.com/seb-mlrd)
- [@Yezir971](https://github.com/Yezir971)



