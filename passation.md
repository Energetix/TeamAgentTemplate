# Passation de la conversation

Dernière mise à jour : 2026-10-20. Ce document restitue les décisions et vérifications de la conversation, sans nouvelle consultation ADO lors de sa rédaction. Il ne contient ni secret ni copie du contenu métier des tickets.

## Objectif et périmètre

Construire un template d'équipe d'agents GitHub Copilot pour VS Code, intégrable par copier-coller dans un dépôt Git de projet du Forem. Seul Maxime est implémenté pour le moment. Le plan initial a été approuvé, puis ajusté après un test réel d'écriture ADO.

| Agent | Rôle envisagé | État |
| --- | --- | --- |
| Maxime | Business Analyste : clarification du besoin, rédaction et affinage des PBI ADO | Implémenté et ajusté après test |
| Simone | Expertise UI/UX | Non implémentée |
| Joao | Architecture | Non implémenté |
| Sébastien | Développement FullStack | Non implémenté |
| Antoine | Sécurité | Non implémenté |
| Anne-Cécile | Tests | Non implémentée |
| Vincent | Finalisation et documentation | Non implémenté |

Un sous-agent dédié à la production de diagrammes UML en Mermaid est prévu. Son nom, ses outils, son modèle et ses conditions d'invocation restent à définir. Il n'est pas créé et aucun relais automatique n'est activé.

## Décisions communes

- Instructions, questions, réponses, commentaires ADO et documentation en français ; conserver les identifiants techniques.
- Échanges concis, factuels et naturels. Ne rien inventer ; distinguer faits, propositions et questions ouvertes.
- Chaque agent garde son rôle. Les décisions métier et d'architecture nécessitent leurs validateurs humains.
- Opérations ADO exclusivement via les outils ADO disponibles : aucun contournement par terminal, script ou appel HTTP direct.
- Ne pas écraser de contributions existantes. Relire le ticket et ses commentaires avant modification ; utiliser le test de révision pour les champs.
- Ne pas versionner de secrets, données personnelles ou contenu métier sensible. Le cache contient uniquement les conventions réutilisables et leurs sources.

## Configuration de Maxime

- Agent : [.github/agents/maxime.agent.md](.github/agents/maxime.agent.md).
- Règles communes : [.github/copilot-instructions.md](.github/copilot-instructions.md).
- Modèle demandé : `Claude Opus 5.5`, selon la liste fournie par l'utilisateur. Son libellé exact et sa disponibilité dans le sélecteur VS Code restent à confirmer ; aucune comparaison objective des modèles n'a été effectuée.
- Outils : `read`, `edit`, `ado/*`. Aucun terminal, Web ni sous-agent ; `agents: []`.
- Lecture locale limitée par consigne aux instructions et à `docs/maxime/` ; écriture locale limitée à `docs/maxime/references.md`. Ces limites ne constituent pas une sandbox technique.
- Maxime ne développe pas, ne choisit pas d'architecture et ne produit pas lui-même les diagrammes UML.

## Décisions ADO actuelles

- Organisation : `leforem` ; projet : `Tools Backlogs`.
- Équipe : `Squad Prague`, identifiant `a855ca36-c1f3-4eff-899c-92a3799b1358`.
- Zone imposée pour toutes les créations : `Tools Backlogs\Squads\Prague`. L'utilisateur a explicitement confirmé cette exception aux règles génériques du wiki qui orientent normalement vers la zone métier de l'outil.
- Type de PBI : **Support Request uniquement**. L'utilisateur avait demandé « Service Request », mais ADO a renvoyé `VS402323` ; il a ensuite explicitement confirmé `Support Request`. Ne pas revenir à `User story`, `Service Request` ou `Issue` comme solution de repli.
- Titre : `[Code OMA][NNN].[NN] - [Fonctionnalité]`. L'exemple initial `LDC001.01` illustre la structure, sans imposer l'application LDC.
- La signification et l'incrémentation des deux nombres n'ont pas été définies. Demander le numéro si nécessaire ; ne pas calculer arbitrairement « maximum + 1 ». Vérifier les doublons en direct.
- Le code OMA est retrouvé à partir du Tool dans `Release Management`. Ce projet est une source de lecture, pas une cible de création pour Maxime.

## Rédaction des tickets

- Le champ Description commence par **Expression du besoin**, pas « La description ».
- INVEST reste un contrôle interne à Maxime : aucune grille ou vérification INVEST publiée dans la description.
- Les critères restent uniquement dans le champ Acceptance Criteria. Ne pas ajouter dans Description une section Critères d'acceptation, même pour renvoyer au champ dédié.
- Ne pas ajouter de section État de l'affinage dans Description.
- Ne pas mentionner de maquette d'écran si le besoin initial n'en fournit pas.
- Ne pas ajouter de rubrique UML vide ni promettre l'intervention d'un sous-agent non configuré. Les futurs diagrammes seront en Mermaid, produits par le sous-agent dédié.
- Les règles métier et les accès aux données restent documentés ; les inconnues nécessaires sont signalées sans réponse inventée.
- Les propositions et critères non validés restent identifiés comme tels. Aucun choix d'intégration n'est présenté comme acquis sans validation.

## Questions et affinage

Créer le ticket dès que les informations obligatoires sont connues, puis poser les questions métier dans sa discussion. Les réponses dans VS Code sont également acceptées et synthétisées dans ADO.

L'utilisateur a demandé un style plus humain : sujets bien séparés, phrases courtes, question principale puis puces, plutôt que de longs paragraphes composites. Le premier commentaire peut suivre cette structure :

1. **Affinage initial : 3 questions avant de continuer** (adapter le nombre).
2. **Contexte confirmé** : une synthèse courte.
3. **À confirmer** : les propositions encore ouvertes.
4. Jusqu'à trois sujets numérotés, avec questions directes et précisions en puces.
5. Une invitation courte à répondre dans ADO ou VS Code.

Éviter les répétitions administratives. En Markdown ADO, écrire `**Libellé** :` plutôt que `**Libellé :**` : le second format a provoqué une mauvaise interprétation du rendu lors du test.

Maxime ne surveille pas les commentaires en arrière-plan : l'utilisateur doit le relancer. Il ne considère pas un besoin prêt par silence et ne change pas l'état ADO sans demande explicite.

## Fichiers de référence

- [.vscode/mcp.json](.vscode/mcp.json) : serveur MCP officiel distant, nommé `ado`, URL `https://mcp.dev.azure.com/leforem`, liste explicite d'outils ; aucun secret enregistré.
- [docs/guide-equipe.md](docs/guide-equipe.md) : installation, responsabilités, fonctionnement, limites des outils et résultats de vérification.
- [docs/maxime/modele-us.md](docs/maxime/modele-us.md) : modèle de PBI Support Request, séparation Description / Acceptance Criteria et présentation des commentaires.
- [docs/maxime/references.md](docs/maxime/references.md) : conventions sourcées, identifiants, inventaire des pages wiki et ETags, observations historiques et points ouverts.

## Sources wiki et cache

La page [Ressources](https://dev.azure.com/leforem/Tools%20Backlogs/_wiki/wikis/Tools%20backlogs.wiki/47345/Ressources) et ses neuf descendants ont été consultés. L'inventaire et les révisions sont dans le cache ; ne pas refaire tout le parcours sans nécessité.

La page [Correspondances OMA](https://dev.azure.com/leforem/Tools%20Backlogs/_wiki/wikis/Tools%20backlogs.wiki/47513/Correspondances-Tools-OmaCode-NodeName) contient une table dynamique, pas les correspondances dans son Markdown. Elle référence la requête `fc8c65ae-8f49-4eaf-9b6a-cae451579c4b`, chemin `Shared Queries/Ref4Ai/OMA-Tool-NodeName`, qui retourne des Tools de `Release Management` et notamment `Custom.OMAcode`. Les résultats peuvent évoluer sans changement d'ETag wiki : vérifier le Tool en direct avant une création.

Pour obtenir tous les descendants, la lecture `wiki/get_page` avec projet, wiki, chemin canonique et `recursionLevel: Full` a fonctionné. La lecture par URL seule n'avait pas développé l'arborescence. Les identifiants et le chemin canonique sont dans le cache.

## Test réel et état vérifié

Ticket de test concret : [PBI 272941](https://dev.azure.com/leforem/Tools%20Backlogs/_workitems/edit/272941). Lire son contenu et ses commentaires dans ADO pour reprendre le cas ; ne pas copier son contenu métier dans les fichiers versionnés.

- Authentification et lectures ADO réussies après démarrage et connexion par l'utilisateur.
- Création initiale en `User story`, puis conversion en **Support Request** après retour utilisateur.
- Conversion et correction de Description avec `Test /rev`, puis relecture réussie.
- Acceptance Criteria comparés avant/après : **strictement identiques**. Titre, zone et état conservés lors de la correction.
- Dernier état vérifié du ticket : `New`, zone Prague. Le ticket reste à affiner ; aucune décision métier ou technique n'a été validée par cette opération.
- Commentaire initial corrigé selon la formulation aérée fournie par l'utilisateur ; commentaire `10383704`, dernière version vérifiée `3`.
- Les fichiers locaux modifiés ne présentaient pas d'erreur signalée par VS Code lors de la dernière vérification.

Limites : la création directe d'un nouveau `Support Request` n'a pas encore été testée ; seule la conversion l'a été. Aucun conflit de concurrence n'a été volontairement provoqué. Les défauts observés lors de la création initiale en `User story` ne doivent pas être transposés au nouveau type.

## Prochaines étapes

1. Reprendre à partir de ce fichier, de l'agent et du cache. Confirmer que le serveur ADO est connecté et que le modèle choisi est accessible ; une nouvelle session peut nécessiter une authentification.
2. Si l'utilisateur souhaite poursuivre le cas concret, relire le PBI 272941 et ses commentaires, puis intégrer les réponses nouvelles en préservant les contributions et la validation humaine.
3. Si un nouvel essai est demandé, tester une création directe en `Support Request`, avec autorisation explicite et numéro fourni ou confirmé.
4. Définir avec l'utilisateur le sous-agent UML Mermaid et son contrat de délégation avant de l'implémenter. Ne pas élargir automatiquement les outils de Maxime.
5. Définir ensuite les autres agents progressivement, selon la priorité donnée par l'utilisateur ; aucune implémentation supplémentaire n'est déjà approuvée.

Restent à clarifier : règle complète de numérotation, Definition of Ready officielle, validateurs de chaque besoin, disponibilité exacte du modèle et confidentialité autorisée pour les résumés versionnés. Aucune réponse ne doit être supposée.

## Précautions techniques utiles

Les opérations ADO passent par les outils MCP ; l'analyse locale d'une réponse déjà reçue n'autorise pas un accès distant par script. Sous Windows PowerShell 5.1, `ConvertFrom-Json` peut refuser les clés vides des métadonnées de type ADO. Un repli a fonctionné avec `System.Web.Script.Serialization.JavaScriptSerializer.DeserializeObject` ; ne pas sérialiser ensuite les dictionnaires imbriqués mêlés aux objets PowerShell sans précaution. Pour les contrôles de description du test, le HTML a été analysé avec un parseur XML et les champs Acceptance Criteria comparés directement.
