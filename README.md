# README

@TODO :
- Timer :
  - Permettre la desactivation du son
  - Alléger le code JS timer pour supprimer les ms (performance)
  - Bugs sous Firefox (popup & fullscreen)

- Crédits, remerciements, droits
  - Réf : à intégrer dans l'export XLS aussi
  - "Traduction libre extraite du livre « Méthodes de Design UX », de Carine Lallemand et Guillaume Gronier (Editions Eyrolles, 2016)."
  - CGU : QUID des questionnaires ? et crédit ?
  - Ajouter des descriptions des questionnaires et liens vers les publications ?
  - "Précautions à prendre" + "Bibliographie / Références"
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
  - Trier par ...??
  - Afficher le statut du proget : (Ouvert) - (Fermé)

- Stats :
  - Optimiser le code pour le calcul des stats
  - Ajouter des bares d'erreur pour les IC
  - Ecart type et intervalle de confiance
  - Revoir calcul pour "attrakdiff_word_pair_average_score"

- Ajouter :
  - SUS "positif"
  - WAMMI

- Routes ou pages pour erreurs 404 et 500

- Suppression logique : https://rubygems.org/gems/paranoia
- Ajouter des questions sur le participant :
  - Âge, sexe, éducation, profession, utilise le produit depuis [moins d'un an]

@RELEASES
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
