# README

@TODO :
- Timer :
  - Permettre la desactivation du son
  - Alléger le code JS timer pour supprimer les ms (performance)
  - Bugs sous Firefox (popup & fullscreen)

- Crédits, remerciements, droits
  - CGU : QUID des questionnaires ? et crédit ?
  - Ajouter des descriptions des questionnaires ?
  - "Précautions à prendre"
  - (Carine Lallemand) A-t-on le droit de mettre ces questionnaires en ligne ?

- Aide :
  - Contrôler la validité des réponses et exclures ?
  - Choisir (ou aider ?) le type d'étude : A vs B ; Avant / Après ; Groupe 1 vs Groupe 2
  - Donner des recommandations sur la taille de l'échantillon ? (avant ou pendant l'évaluation)
  - IC /ecart type
  - Transparence technologique sur les formules utilisées (ex. comment sont calculés les IC ?)

- UI :
  - Version tablette + tél pour les répondants
  - Ajouter des filtres pour les dates / statuts des projets
  - Pouvoir créer des dossiers de projet (nous réalisons souvent des tests sur les memes projets, en cycle itératif / sprint de dév). retrouver tous les tests associés à un meme projet dans le meme dossier serait pratique.

- Stats :
  - Ajouter des barres d'erreur pour les IC
  - Revoir calcul des stats pour "attrakdiff_word_pair_average_score"

- Ajouter :
  - SUS "positif"
  - WAMMI

- Routes ou pages pour erreurs 404 et 500

- Suppression logique : https://rubygems.org/gems/paranoia
- Ajouter des questions sur le participant :
  - Âge, sexe, profession/occupation,
  - Groupe d'utilisateurs, version du produit testée,
  - Education, utilise le produit depuis [moins d'un an]

- Montrer un petit message "Nouveautés" et le descriptif

@RELEASES
v1.2.1 :
- Spécification de la Timezone (Paris)

v1.2 :
- Bugs :
  - Modal sur fond blanc
- Exports XLS :
  - Ajout des stats synthétiques pour AttrakDiff et DEEP
  - Ajout des références aux publications
- Questionnaires UX :
  - La date de fin devient optionnelle
  - Ajout d'un statut au proget (Ouvert / Fermé)
  - Ajout d'un champ "Ordonner par..."
  - Ajout des intervalles de confiance et écart-types pour DEEP
- Invisible :
  - Ajout d'un (daily) job automatique pour basculer les statuts des projets (voir doc : https://devcenter.heroku.com/articles/scheduler)

v1.1.14 :
- Ajout de données dans l'export SUS
- Correction dans le Timer (continue après modification du temps + focus on click)

v1.1.13 :
- Suppression Yandex
- Correction fil d'Ariane pour le compte à rebourds

v1.1.12 :
- Bug IC
- Rajout jquery_ujs

v1.1.11 :
- Ajout Yandex.Metrica
- Activation AttrakDiff abrégé
- Suppression jquery_ujs

v1.1.10 :
- Ajout Smartlook (current_user && !admin)

v1.1.9 :
- Ajout du timer
- Ajout du code et table pour AttrakDiff abrégé mais desactivé (test de non régression à faire)

v1.1.8 :
- Bug dans l'enregistrement de date
- Ajout références et remerciements
- Ajout des écart-types et des IC sur SUS

v1.1.7 :
- Ajout des écart-types et des IC sur AttrakDiff
- Ajout de liens dans la partie admin

v1.1.6 :
- Mise à jour de l'admin
- Correction affichage tableau dans DEEP

v1.1.5 :
- div > a dans la nav
- Mise à jour des références

v1.1.4 :
- Modif lien UserReport
- Ajout d'un champ "admin" sur "users" et d'une page /admin

v1.1.3 :
- Correction de coquilles dans DEEP

v1.1.2 :
- MAJ des conditions d'utilisation avec ajout des lien vers les références

v1.1.1 :
- Ajouter des conditions d'utilisation
- MAJ des checkboxes et radio

v1.1 :
- Permettre de modifier le texte de la consigne
- Export XLS revu
- Intégration de UserReport pour la gestion de bugs et d'idées
- Ajout du questionnaire DEEP
