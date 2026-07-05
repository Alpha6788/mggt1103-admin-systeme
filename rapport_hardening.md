# Rapport de TP - Séance 2 : Diagnostic Performance & Durcissement Linux
**Nom :** Alfani Pascal Mwimba  
**Cours :** Sécurité & Administration Système (SecOps)

---

## 1. Audit de Sécurité Initial (Lynis)

Lors du premier scan automatique avec l'outil Lynis, le système a obtenu un score initial de **60%**. Ce score s'explique par l'absence de règles de pare-feu actives, la présence de paquets obsolètes et une configuration SSH ouverte par défaut.

### Capture d'écran du Hardening Index Initial
![Hardening Index Initial](score_initial.png)
### 1. Correction de 3 suggestions Lynis
* **Suggestion 1 : Password hashing rounds**
  * *Action :* Augmentation du nombre de rounds pour SHA-512 dans `/etc/login.defs`.
  * *Commande :* `sudo sed -i 's/SHA_CRYPT_MIN_ROUNDS.*/SHA_CRYPT_MIN_ROUNDS 5000/' /etc/login.defs`
* **Suggestion 2 : SSH Root Login**
  * *Action :* Désactivation de la connexion root directe en SSH.
  * *Commande :* `sudo sed -i 's/PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config`
* **Suggestion 3 : Banner/Motd**
  * *Action :* Ajout d'un message d'avertissement juridique à la connexion.
  * *Commande :* `echo "Accès réservé aux personnes autorisées." | sudo tee /etc/issue`

### 2. Différence entre SIGTERM (15) et SIGKILL (9)
* **SIGTERM (15) :** C'est une demande d'arrêt douce. Le système demande au processus de se fermer. Le processus peut intercepter ce signal pour sauvegarder ses données et fermer ses fichiers proprement avant de s'arrêter.
* **SIGKILL (9) :** C'est un arrêt brutal et immédiat. Le processus n'a pas le choix, il est tué instantanément par le noyau (kernel) sans pouvoir sauvegarder son travail ni nettoyer ses fichiers temporaires.

### 3. Limitation dans limits.conf
Le fichier `/etc/security/limits.conf` permet de restreindre l'utilisation des ressources système pour éviter qu'un utilisateur ou un bug ne fasse planter le serveur. En limitant par exemple le nombre maximal de processus simultanés (`nproc`) ou la taille des fichiers, on protège le système contre les attaques par déni de service (DoS) internes ou les fuites de mémoire.

---

## 2. Diagnostic Réseau : Ports en écoute

Pour l'étape de diagnostic de performance et de vérification des services réseau, la commande exacte pour lister tous les ports en écoute (listening) sur le serveur, avec les numéros de ports au format numérique et les programmes associés, est :

```bash
sudo ss -tulnp
