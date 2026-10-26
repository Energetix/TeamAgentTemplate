# Passation de la conversation

Dernière mise à jour : 2026-10-26. Ce document restitue les décisions et vérifications de la conversation, sans nouvelle consultation ADO lors de sa rédaction. Il ne contient ni secret ni copie du contenu métier des tickets. Les états et révisions ci-dessous sont des observations historiques à revérifier avant toute écriture.

## Objectif et périmètre

Construire un template d'équipe d'agents GitHub Copilot pour VS Code, intégrable par copier-coller dans un dépôt Git de projet du Forem. Maxime, le sous-agent UMLCreator et Antoine sont configurés. Après constat que les tickets ADO n'affichent pas le rendu Mermaid, Maxime ne peut plus déléguer à UMLCreator et ne publie pas de source Mermaid dans les PBI. Le 26/10, une délégation ciblée à Antoine est autorisée pour les exigences de sécurité du besoin.

| Agent | Rôle envisagé | État |
| --- | --- | --- |
| Maxime | Business Analyste : clarification du besoin, rédaction et affinage des PBI ADO | Implémenté et ajusté après test |
| UMLCreator | Sous-agent : diagrammes UML en Mermaid | Implémenté ; lecture seule, résultats retournés à l'agent principal |
| Simone | Expertise UI/UX | Non implémentée |
| Joao | Architecture | Non implémenté |
| Sébastien | Développement FullStack | Non implémenté |
| Antoine | Revue statique de sécurité du code, des dépendances, de l'IaC et de la configuration | Configuré ; rapport `SECURITY_REVIEW.MD` et corrections locales après validation humaine explicite |
| Anne-Cécile | Tests | Non implémentée |
| Vincent | Finalisation et documentation | Non implémenté |

UMLCreator peut être sollicité directement ou par un futur agent autorisé lorsque le diagramme est utile, sans génération systématique. Il produit les types de diagrammes utiles au besoin et retourne son résultat à l'agent principal, qui le relit et l'insère dans un livrable Markdown adapté. Maxime ne l'utilise pas pour la rédaction de PBI ADO. Son modèle n'est pas fixé en attendant la vérification du libellé dans VS Code.

Le paragraphe suivant décrit le mode revue par défaut d'Antoine ; le mode correction après validation est défini dans la section « Évolution : corrections validées du 26/10 ».

Antoine est configuré dans `.github/agents/antoine.agent.md` pour examiner le code, les dépendances, l'IaC et la configuration sans les modifier, puis proposer des corrections sans les appliquer. Il écrit uniquement son rapport `SECURITY_REVIEW.MD` à la racine du dépôt analysé, emplacement confirmé par l'utilisateur le 26/10 ; il préserve les contributions existantes et ne produit pas de rapport local pour une consultation métier de Maxime. À la demande du 26/10, OWASP Top 10:2025 sert de cadre de sensibilisation pour les risques Web ; l'agent peut consulter uniquement la documentation publique officielle OWASP, sans envoyer de contenu du dépôt à un service externe. Il associe les constats aux catégories pertinentes et cite référentiel, version et source, sans prétention d'exhaustivité ou de conformité. Les périmètres API/LLM doivent signaler les limites du Top 10 Web et vérifier le référentiel OWASP spécialisé correspondant. Source officielle : https://top10.owasp.org/2025/. La vérification de la reconnaissance et du comportement de l'agent dans VS Code reste à faire.

### Évolution : corrections validées du 26/10

L'utilisateur demande qu'Antoine puisse appliquer ses recommandations après validation. Le mode par défaut reste la revue avec écriture du seul rapport racine. Toute correction locale nécessite un plan validé explicitement par un humain : constats, fichiers, changements, impacts et vérifications. Un appelant doit transmettre cette validation ; son propre accord ne suffit pas. Maxime reste limité à la consultation du besoin, sans correction ni rapport local. Antoine ne reçoit aucun outil supplémentaire : il reste sans terminal, tests, scanner, déploiement ou accès ADO. Les permissions et protections effectives restent à traiter par un responsable humain. Le rapport distingue les correctifs appliqués des résultats d'exécution encore attendus ; cette évolution des instructions ne résout pas à elle seule les risques de cloisonnement cités dans la revue précédente.

## Décisions communes

Complément du 26/10 pour Antoine : il peut être installé seul dans un dépôt pour une code review sécurité, sans MCP ADO. Il doit tenir compte des configurations, intégrations CI et rapports locaux SonarQube/SonarCloud ou autres outils de validation, en distinguant configuration, exécution prévue et résultats disponibles. Le rapport précise provenance, actualité connue, exclusions et limites de couverture ; les alertes sont recoupées, qualifiées et dédupliquées. Aucun scanner n'est lancé et aucun tableau de bord distant n'est consulté ; demander si nécessaire un export expurgé, jamais un jeton.

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
- Outils : `read`, `edit`, `agent`, `ado/*`. Aucun terminal ni Web ; seul sous-agent autorisé : `agents: [Antoine]`.
- Lecture locale limitée par consigne aux instructions et à `docs/maxime/` ; écriture locale limitée à `docs/maxime/references.md`. Ces limites ne constituent pas une sandbox technique.
- Maxime ne développe pas et ne choisit pas d'architecture. Il consulte ponctuellement Antoine pour les exigences de sécurité du besoin, sans inspection du code par délégation ni élargissement de son périmètre. Pour les PBI ADO, il ne publie pas de source Mermaid ; si nécessaire, il décrit les flux en texte clair.

## Délégation sécurité décidée le 26/10

- Antoine reste accessible directement et devient appelable comme sous-agent : `disable-model-invocation: false`. Il ne délègue pas lui-même et reste sans terminal ou accès ADO. L'outil `edit` est autorisé pour son rapport racine `SECURITY_REVIEW.MD` et les corrections locales explicitement validées selon la procédure ci-dessus, par consigne et non par sandbox technique.
- Maxime peut le consulter ponctuellement pour affiner les exigences et critères de sécurité à partir du contexte du besoin fourni, sans décider d'une solution technique.
- Joao doit pouvoir le consulter pour la sécurité des solutions d'architecture ; Sébastien doit le solliciter prioritairement pour les implémentations et les corrections pertinentes. Leurs fichiers d'agents n'existent pas encore : ajouter l'outil `agent` et autoriser `Antoine` dans leur liste `agents` lors de leur création.
- Antoine retourne son avis à l'appelant pour relecture et intégration. Les exigences proposées et risques de conception ne sont pas présentés comme des vulnérabilités d'implémentation confirmées ; la validation reste humaine.
- Configuration locale mise à jour ; le fonctionnement effectif de cette délégation dans une nouvelle conversation VS Code reste à vérifier.

## Configuration de UMLCreator

- Agent : [.github/agents/umlcreator.agent.md](.github/agents/umlcreator.agent.md).
- Outil autorisé : `read` uniquement. UMLCreator ne modifie pas directement ADO ni les fichiers du dépôt.
- Maxime ne l'autorise pas dans sa liste `agents`. Un futur agent principal tel que Joao pourra le solliciter uniquement après l'avoir explicitement autorisé dans sa configuration.
- UMLCreator produit uniquement des diagrammes utiles, fondés sur les faits fournis ou les fichiers pertinents. Il signale les inconnues sans inventer de contenu.
- Maxime ne place pas de source Mermaid dans la Description ADO. Lorsque Joao sera implémenté et autorisé à le déléguer, il pourra insérer les diagrammes d'architecture relus dans `ARCHITECTURE.md`.
- Modèle non fixé avant vérification dans le sélecteur VS Code.

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
- Ne pas ajouter de rubrique Diagrammes ni de source Mermaid aux PBI ADO. Si un flux doit être expliqué, Maxime le décrit en texte clair. Les diagrammes d'architecture restent du ressort du futur agent Joao, qui pourra déléguer à UMLCreator si autorisé.
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
- Lors de la correction initiale du 20/10 uniquement, Acceptance Criteria comparés avant/après : **strictement identiques**. Titre, zone et état conservés lors de cette correction. Les critères ont ensuite été révisés le 23/10 avec accord utilisateur, comme indiqué ci-dessous.
- État vérifié le 20/10 : `New`, zone Prague ; cette observation est historique et remplacée par la relecture du 23/10 ci-dessous.
- Commentaire initial corrigé selon la formulation aérée fournie par l'utilisateur ; commentaire `10383704`, dernière version vérifiée `3`.
- Les fichiers locaux modifiés ne présentaient pas d'erreur signalée par VS Code lors de la dernière vérification.

Limites : la création directe d'un nouveau `Support Request` n'a pas encore été testée ; seule la conversion l'a été. Aucun conflit de concurrence n'a été volontairement provoqué. Les défauts observés lors de la création initiale en `User story` ne doivent pas être transposés au nouveau type.

## Dernières opérations du 23/10 et reprise du cas concret

### Diagrammes puis retrait du relais de Maxime

- À la demande de l'utilisateur, deux séquences AS-IS et TO-BE ont été ajoutées au PBI 272941 après une production par UMLCreator et relecture. Le TO-BE était explicitement illustratif, pas une architecture validée. Écriture avec test de révision `10`, résultat à la révision `11`.
- L'utilisateur a constaté que les tickets ADO affichent la source Mermaid, sans rendu de diagramme. Il a demandé de retirer à Maxime la possibilité d'appeler UMLCreator pour les PBI.
- Retrait effectué le 23/10 dans la configuration : outil `agent` supprimé, `agents: []`, consignes de Maxime et documentation alignées. Cette interdiction reste applicable à UMLCreator ; la consultation ciblée d'Antoine autorisée le 26/10 constitue une évolution distincte.
- L'utilisateur a nettoyé lui-même le ticket. La relecture ultérieure à la révision `12` a confirmé l'absence de la section ajoutée. Ne pas restaurer les blocs Mermaid.

### Ressources supplémentaires et révision du PBI

L'utilisateur a précisé que le contexte initial était incomplet et a fourni ces sources à consulter pour répondre aux questions d'affinage :

- [Ticket 268404](https://dev.azure.com/leforem/Dossier%20Unique%20Chercheur%20Emploi%20(CRM)/_workitems/edit/268404), dans le projet `Dossier Unique Chercheur Emploi (CRM)`.
- [Analyse wiki 26.11, page 46930](https://dev.azure.com/leforem/Dossier%20Unique%20Chercheur%20Emploi%20(CRM)/_wiki/wikis/Dossier-Unique-Chercheur-Emploi-(CRM).wiki/46930/26.11-D%C3%A9terminer-le-type-de-disponibilit%C3%A9-applicable).

Ces sources ont été lues via MCP ADO, ainsi que les quatre commentaires alors présents sur 268404 (révision du ticket observée : `17`). Pour reprendre l'analyse, relire ces contenus en direct, notamment les échanges des 21, 22 et 23/10 ; leurs détails métier ne sont pas copiés ici. Les commentaires fournissent un contexte complémentaire indispensable au seul champ Description.

- Après synthèse et question explicite, l'utilisateur a choisi de réviser **Description et Acceptance Criteria**, plutôt que de publier uniquement un commentaire.
- Mise à jour effectuée sur 272941 avec `Test /rev = 12`, résultat à la révision `13`.
- Un commentaire de synthèse sourcé a ensuite été ajouté : `10419109`, version `1`. Le commentaire initial `10383704`, version `3`, a été conservé ; ses questions ne doivent donc pas être considérées toutes encore ouvertes sans lire le complément.
- Dernière relecture réussie : PBI 272941, révision **14**, état **`In Progress`**, zone **`Tools Backlogs\Squads\Prague`**. Titre conservé. Description et trois critères d'acceptation révisés présents, liens aux deux nouvelles sources présents, aucun bloc Mermaid dans Description, deux commentaires présents.
- Les décisions d'intégration restent ouvertes et les critères restent proposés à validation. Cette opération n'a pas validé d'architecture et n'a pas déclaré le ticket prêt.
- Les tickets sources et le wiki n'ont pas été modifiés. Aucune nouvelle règle générique n'a été ajoutée aux instructions de Maxime pour imposer ces sources à tous les projets : elles concernent ce cas concret.

### État local à préserver

Dernier `git status --short` lors de cette passation : modifications non commitées de [.github/agents/maxime.agent.md](.github/agents/maxime.agent.md), [docs/guide-equipe.md](docs/guide-equipe.md), [docs/maxime/modele-us.md](docs/maxime/modele-us.md), [docs/maxime/references.md](docs/maxime/references.md) et de ce fichier ; [.github/agents/umlcreator.agent.md](.github/agents/umlcreator.agent.md) non suivi. Ne pas écraser ni annuler ces changements. Aucun commit n'a été créé pendant ces opérations.

Le dernier `git diff --check` des changements de configuration était réussi. L'activation effective de la configuration mise à jour de Maxime dans une nouvelle conversation VS Code reste à vérifier ; un ancien contexte de conversation ne prouve pas que les nouveaux droits ont été chargés.

## Prochaines étapes

L'utilisateur confirme le 2026-10-26 que les trois premiers points de la passation précédente sont validés : le fonctionnement de Maxime/ADO, la reprise de l'affinage et le fonctionnement de la création et de la modification. Il confirme que Maxime alimente bien les commentaires avec les derniers inputs. Il s'agit d'une validation utilisateur, sans nouvelle vérification ADO dans cette session.

1. Vérifier dans une nouvelle conversation VS Code qu'Antoine est reconnu, appelable sans écriture par Maxime pour une question de sécurité du besoin, et que ses revues du dépôt écrivent uniquement le rapport racine `SECURITY_REVIEW.MD` tant qu'aucun plan de correction n'est validé. Vérifier séparément le respect du périmètre approuvé en mode correction.
2. Définir les autres agents progressivement, selon la priorité donnée par l'utilisateur. Pour Joao, décider s'il doit autoriser UMLCreator et intégrer ses diagrammes relus dans `ARCHITECTURE.md`.
3. Vérifier dans VS Code le modèle de UMLCreator et son invocation directe ; Maxime n'a pas accès à ce sous-agent.

Restent à clarifier : règle complète de numérotation, Definition of Ready officielle, validateurs de chaque besoin, disponibilité exacte du modèle de UMLCreator et confidentialité autorisée pour les résumés versionnés. Aucune réponse ne doit être supposée.

## Précautions techniques utiles

Les opérations ADO passent par les outils MCP ; l'analyse locale d'une réponse déjà reçue n'autorise pas un accès distant par script. Sous Windows PowerShell 5.1, `ConvertFrom-Json` peut refuser les clés vides des métadonnées de type ADO. Un repli a fonctionné avec `System.Web.Script.Serialization.JavaScriptSerializer.DeserializeObject` ; ne pas sérialiser ensuite les dictionnaires imbriqués mêlés aux objets PowerShell sans précaution. Pour les contrôles de description du test, le HTML a été analysé avec un parseur XML et les champs Acceptance Criteria comparés directement.

Le serveur `ado` a demandé une authentification au début du 23/10 ; l'utilisateur s'est authentifié via `/mcp auth ado`, puis les lectures et écritures ont fonctionné. Des erreurs génériques temporaires d'invocation MCP ont ensuite disparu après une nouvelle tentative de lecture ; ne pas les interpréter comme une absence de contenu ni contourner MCP. Pour analyser une réponse JSON sauvegardée localement, préciser l'encodage UTF-8 sous PowerShell 5.1 afin d'éviter les caractères accentués mal décodés.
