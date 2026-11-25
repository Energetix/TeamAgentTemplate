# Joao — décisions d'architecture et ADR

Joao lit ce fichier avant de créer ou de modifier un ADR. En contexte Forem, il lit aussi `docs/joao/forem.md`.

## Quand créer un ADR

- Les ADR concernent uniquement les changements et décisions d'architecture. Une documentation de l'existant n'en produit pas et n'en mentionne pas.
- **Démarrage d'un projet** : regroupe les choix structurants initiaux (pile technique, persistance, hébergement et exposition, organisation de l'application) dans un seul ADR « socle technique ». Ne crée un ADR séparé que pour un choix au cycle de vie propre ou à fort impact, et justifie-le dans ta réponse.
- **Ensuite** : un ADR seulement quand une fonctionnalité change l'architecture ou impose une dérogation aux principes. Une précision qui ne change pas une décision existante va dans le contexte technique de la fonctionnalité, pas dans un nouvel ADR.
- Une dérogation explicite le bénéfice attendu, les alternatives, les risques résiduels et les conditions de sortie.

## Emplacement et nommage

- Utilise le dossier des ADR indiqué dans la rubrique « Cadre technique » de `PROJET.md`, sinon les conventions existantes du dépôt. S'il n'est établi nulle part, demande-le avant de créer l'ADR.
- Un fichier Markdown par ADR. Préserve les ADR existants : ne les réécris pas et ne change pas leur statut sans demande et validation humaine explicites.
- Titre : `[CodeApplication]-[séquence sur 3 chiffres] - [Décision affirmative]`, avec le code application de `PROJET.md` et le numéro suivant parmi les ADR existants de l'application (`LDC-001`, puis `LDC-002`). Si le code ou le numéro ne peut pas être établi, demande au lieu d'inventer.

## Contenu

- Statut parmi `Brouillon`, `Proposé`, `Accepté`, `Constaté` ou `Supplanté` (valeurs de la gouvernance Forem, utilisées aussi ailleurs sauf convention contraire du dépôt). `Accepté` exige une validation humaine. `Constaté` qualifie seulement un état existant dont la décision initiale est inconnue.
- Contexte et alternatives utiles, décision et justification, conséquences positives et négatives, vérification de conformité, auteur, date de création, ADR liés. Si une métadonnée est inconnue, demande-la ou indique qu'elle reste à renseigner.
- Cite les besoins et exigences par leur identifiant (`FCT-NNN`, `RM-xx`, `SEC-xx`) sans les recopier. Si l'ADR contient un mot-clé surveillé par le hook de sécurité (« Base de données », « API externe », « Authentification », « Données personnelles ») et qu'aucun rapport d'Antoine n'existe, ajoute la ligne « Avis de sécurité d'Antoine : » suivie du renvoi vers le contexte technique qui consigne l'avis et des identifiants `SEC-xx`.
- Hors Forem, utilise les conventions ADR du dépôt si elles existent, sinon cette structure.

## Cycle de vie

- Un ADR est créé au statut `Proposé`. `ARCHITECTURE.md` est mis à jour avec chaque changement marqué « Proposé (ADR [identifiant]) ».
- L'acceptation est une validation humaine obligatoire : remonte-la sous « À remonter à l'utilisateur ». Le développement ne démarre qu'après.
- À l'acceptation, passe l'ADR à `Accepté` avec la date et la formulation de la validation, puis retire le marquage de `ARCHITECTURE.md`. Au refus, retire les changements marqués.
