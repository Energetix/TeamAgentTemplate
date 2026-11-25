# Joao — modèle de ARCHITECTURE.md et diagrammes

Joao lit ce fichier avant de créer ou de mettre à jour `ARCHITECTURE.md` ou de demander un diagramme à UMLCreator.

## Finalité et proportion

- En documentation, `ARCHITECTURE.md` présente simplement l'architecture technique de l'existant, à partir du dépôt Git local ouvert, qu'il soit hébergé dans ADO ou GitHub. Une personne extérieure au projet doit en comprendre le métier, la structure et les principaux échanges.
- En conception, il décrit l'architecture du projet entier, jamais une seule fonctionnalité, et évolue avec le projet.
- Reste précis sur les éléments structurants, sans catalogue de classes, méthodes, paramètres ou dépendances logicielles. Adapte la longueur à la taille du projet.
- N'y recopie aucune règle métier, critère ou texte d'interface : cite leurs identifiants (`RM-xx`, `CA-xx`, `UX-xx`, `RI-xx`) et renvoie vers leur source (règles communes, « Source unique et identifiants »).

## Sections

1. **Contexte** : finalité métier, utilisateurs ou systèmes bénéficiaires, services rendus et périmètre, uniquement lorsque les sources les établissent.
2. **Vue d'ensemble des dépendances** : schéma haut niveau placé juste avant « Composants ».
3. **Composants** : composants internes principaux, responsabilités, dépendances et technologies structurantes, avec une vue structurelle Mermaid.
4. **Flux métiers principaux** : pour chaque flux retenu, une description concise des étapes et un diagramme Mermaid adapté, dans la même sous-section.
5. **Sécurité** : en documentation, les mécanismes visibles dans le dépôt (authentification, autorisations, gestion des secrets, échanges avec l'extérieur), décrits sans évaluation ni reproduction de valeurs sensibles, avec un renvoi vers `SECURITY_REVIEW.MD` produit par Antoine ; en conception, les mécanismes prévus, avec un renvoi vers le rapport d'Antoine s'il existe, sinon la ligne « Avis de sécurité d'Antoine : » suivie des exigences `SEC-xx` retenues et du chemin du contexte technique qui les consigne.
6. **Architecture cible uniquement** : décisions proposées ou validées (avec leur ADR), alternatives et points ouverts, clairement distingués.

En documentation, n'ajoute aucune section de constats, risques, limites, points à confirmer ou ADR, et aucune légende du type « Observé / Déduit / À confirmer » : tout ce qui est écrit est constaté. Si une source n'a pas pu être lue, signale-le dans ta réponse, pas dans `ARCHITECTURE.md`.

## Vue d'ensemble des dépendances

- L'application analysée est un seul bloc central, sans ses projets, classes ou couches internes. Autour : les applications appelantes et tous les systèmes avec lesquels elle communique dans le périmètre documenté (applications et services internes ou externes au SI, bases de données, messagerie, autres services techniques). Pas de bibliothèques ni de paquets logiciels.
- Nomme les systèmes avec les noms établis par les sources et précise leur rôle dans les libellés des liens ou un court texte. Les flèches indiquent le sens des appels ou des publications, pas un sens de circulation des données si ce n'est pas ce qu'elles représentent.
- N'invente aucun système, échange, consommateur de message ou protocole. En documentation, chaque élément et chaque lien est vérifié dans les sources ; en conception, distingue les dépendances proposées des existantes.

## Vue « Composants »

Mermaid `flowchart`, sans la présenter comme un diagramme de composants UML formel. Vue structurelle, pas un logigramme :

- `subgraph` selon les frontières réellement présentes dans les sources (applications ou hôtes, modules, couches, responsabilités). Ne plaque pas une Clean Architecture absente et ne duplique pas un composant partagé dans chaque hôte.
- Niveau de détail homogène : composants principaux nommés avec leur rôle, sans classes, méthodes, interfaces ni enregistrements d'injection, sauf une interface utile à une dépendance structurante.
- Technologies structurantes constatées et leur rôle (framework d'exécution, messagerie, stockage, moteur de base de données…), sans inventaire des paquets ou versions. Distingue modules internes et services techniques consommés.
- Disposition `LR` ou `TB` lisible, croisements limités, systèmes externes séparés ; seulement les systèmes externes utiles à cette vue.
- Flèches du composant dépendant vers le composant utilisé, nommées si le sens n'est pas évident ; distingue dépendance et implémentation d'interface si les deux apparaissent. Ni étapes numérotées ni losanges de décision.
- Si la vue est trop dense : une vue principale synthétique et un zoom ciblé.

## Flux métiers principaux

- Retiens les flux ou fonctionnalités principaux utiles, sans représenter tous les parcours. Pour chacun, la description et le diagramme sont obligatoires ; ni le texte seul, ni la vue haut niveau, ni la vue composants ne remplacent ce diagramme.
- Décris chaque flux de bout en bout dans le périmètre vérifiable : déclencheur, participants, étapes importantes, décisions structurantes, résultat. Détaille seulement ce qui aide à comprendre le parcours, notamment les échanges asynchrones et les persistances utiles, sans énumérer les appels de méthodes.
- Type de diagramme selon le sujet : `sequenceDiagram` pour les interactions entre participants, activité ou logigramme (`flowchart`) pour les traitements, décisions et branches. Texte et diagramme décrivent les mêmes étapes, acteurs et conditions, dans le même ordre. En documentation, seulement les comportements vérifiés, sans réponse, branche d'erreur ou comportement interne inventé.

## Délégation des diagrammes à UMLCreator

- Confie obligatoirement à `UMLCreator` la rédaction et la correction de tous les diagrammes des livrables. Tu prépares le contexte, relis et intègres ; tu ne rédiges ni ne corriges toi-même le code Mermaid et ne lui fournis pas un diagramme déjà rédigé à restituer.
- Dossier à transmettre pour chaque diagramme : objectif, type de vue, périmètre, niveau de détail, acteurs ou composants et leurs rôles, technologies pertinentes, frontières et regroupements confirmés, relations orientées et leur signification ; pour un flux, déclencheur, ordre des étapes, conditions, échanges synchrones ou asynchrones et résultat. Ajoute les références aux fichiers utiles, les noms à conserver et la description textuelle du flux. Distingue faits et propositions ; explicite les informations manquantes.
- Transmets les règles de structure ci-dessus et demande une disposition hiérarchique adaptée, un sens de lecture constant, les éléments très connectés au centre de leur groupe ou à un niveau charnière, et une réduction des croisements, détours et zigzags. Les vues trop denses sont décomposées sans perdre de relation structurante ni modifier les faits.
- Relis le résultat : conformité aux sources, périmètre, niveau de détail, cohérence avec le texte, lisibilité. En cas d'écart, retourne les corrections attendues et leurs justifications à UMLCreator. Intègre le bloc Mermaid retourné sans le réécrire ; pour un wiki ADO, remplace seulement les délimiteurs (voir `docs/commun/publication-wiki-ado.md`). Ne prétends pas avoir vérifié un rendu non observé.
- Si UMLCreator ne peut pas être appelé ou ne fournit pas de résultat exploitable, signale le blocage et suspends seulement les diagrammes concernés, sans diagramme de remplacement ni livrable annoncé complet.

## Vérification finale

Relis pour vérifier la cohérence entre contexte, schémas, flux et ADR. En documentation : les cinq sections, un contexte métier clair, les responsabilités et technologies des composants, et le renvoi au rapport d'Antoine réellement produit ; retire toute déduction, hypothèse, évaluation ou mention d'ADR. Pour chaque flux : un texte concis et un diagramme concordants dans la même sous-section. Retire répétitions et détails d'implémentation inutiles.
