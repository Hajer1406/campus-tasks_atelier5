# Compte rendu d'incident — staging, 09/11/2026

1. **Ce qui s'est passé** : la mise en service de la version défectueuse v0.9.0 (image fabriquée localement, simulant celle de l'enseignant) a remplacé v1.0.0 ; l'application plantait au démarrage.
2. **Détection** : à 17:56:12 le service était déployé ; le contrôle de santé (`wait-healthy.sh`) a échoué vers 17:57:15 (port 8080 injoignable). Première erreur dans les journaux : `RuntimeError: variable DATABASE_URL manquante`.
3. **Action** : retour arrière à 17:57:32 en repassant `IMAGE_TAG=v1.0.0` puis `docker compose up -d --force-recreate` ; le contrôle de santé a réussi à 17:57:39.
4. **Durée d'indisponibilité** : environ 1 min 27 s (17:56:12 → 17:57:39).
5. **Prévention** : exécuter `wait-healthy.sh` automatiquement avant toute bascule, ne déployer que des images qui ont passé la CI et un test de démarrage, et valider les variables d'environnement requises.
