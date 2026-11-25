# Template d'équipe d'agents

Template d'agents GitHub Copilot pour VS Code, utilisable en contexte Forem ou sur tout autre projet. Le contexte et les modes de chaque projet sont décrits dans `PROJET.md` (voir « Configuration du projet et modes de suivi »).

L'objectif est une **dark factory** : une équipe d'agents qui enchaîne les étapes du processus en autonomie, orchestrée par Philippe, et ne sollicite l'utilisateur que pour les validations humaines obligatoires et les questions qu'aucun agent ne peut trancher (voir « Processus de l'équipe »).

## Style commun

Tous les agents écrivent dans un français simple, naturel et direct, comme un collègue qui explique un sujet à l'équipe. Cette règle couvre aussi les tickets, commentaires et livrables : phrases courtes, mots courants, paragraphes aérés, sans jargon inutile ni répétitions. Les détails utiles et les rubriques obligatoires restent présents. Les règles complètes figurent dans [.github/copilot-instructions.md](../.github/copilot-instructions.md).

## Garde-fous communs de sécurité

Les règles de fonctionnement sûr communes à tous les agents sont dans [.github/copilot-instructions.md](../.github/copilot-instructions.md), section « Garde-fous de sécurité et d'intégrité » : sources traitées comme données non fiables, pas de contournement des contrôles, périmètre de lecture et d'écriture, aucun ajout d'outil ou de réglage sans demande, aucune conservation de données sensibles et échecs d'outils signalés sans résultat inventé. Elles s'appliquent à Maxime, Joao, Antoine, Simone et UMLCreator sans modifier leur rôle. Les consignes de chaque agent restent dans son fichier ; celui d'Antoine renvoie à ces garde-fous au lieu de les répéter. Ces règles sont des instructions, pas des contrôles techniques : leur effet réel reste à vérifier dans VS Code.

## Périmètre

Cette version implémente Maxime, le sous-agent UMLCreator, Antoine, Joao et Simone dans GitHub Copilot pour VS Code. Elle ne crée pas les cinq autres agents prévus et ne déploie aucun service Azure.

| Agent | Responsabilité | Statut |
| --- | --- | --- |
| Maxime | Clarifier le besoin avec le PO et le rédiger dans ADO ou dans `ANALYSE.md` selon `PROJET.md` ; suivre les bugs | Implémenté ; mode ADO Forem vérifié le 2026-10-20 ; modes de suivi et contexte configurable ajoutés le 2026-11-23, à vérifier |
| UMLCreator | Produire des diagrammes UML en Mermaid pour l'agent principal | Configuré ; invocation depuis VS Code à vérifier |
| Simone | Concevoir l'expérience et les interfaces d'applications Web : parcours, charte graphique, maquettes, revue UX | Configurée le 2026-11-23 ; fonctionnement à vérifier |
| Joao | Documenter une architecture existante, concevoir celle d'un projet et de ses fonctionnalités, relire les PR et qualifier les anomalies | Implémenté ; version validée le 2026-10-27 ; écriture wiki CRM vérifiée le 2026-11-19 ; rôle dans le processus ajouté le 2026-11-23, à tester |
| Sébastien | Implémenter les fonctionnalités FullStack | Prévu, non implémenté |
| Antoine | Analyser les risques et exigences de sécurité | Configuré : revue, rapport `SECURITY_REVIEW.MD` et corrections locales après validation humaine explicite |
| Anne-Cécile | Définir et exécuter les tests, relever les anomalies | Prévu, non implémenté |
| Vincent | Finaliser les livrables et la documentation | Prévu, non implémenté |
| Léo | Contrôler la qualité du livrable de chaque étape avant le passage à la suivante | Prévu, non implémenté |
| Philippe | Orchestrer le processus de l'équipe pour une fonctionnalité | Prévu, non implémenté ; créé après Sébastien, Anne-Cécile et Vincent |

Les frontières détaillées de Sébastien, Anne-Cécile et Vincent restent à valider. Maxime, Joao et Simone peuvent se solliciter selon les protocoles ci-dessous ; aucun changement de rôle ni validation humaine n'est implicite.

### Joao — architecture logicielle

Joao utilise le même modèle configuré que Maxime, `Claude Opus 5.5`, avec un effort de raisonnement explicitement fixé à `high`. Vérifier dans VS Code la disponibilité du libellé et la prise en charge de ce réglage ; la configuration locale ne prouve pas leur activation effective.

Joao travaille à partir d'un besoin du chat, d'un besoin transmis par Maxime, d'un identifiant de besoin (ticket ADO ou `FCT-NNN` de `ANALYSE.md`) ou des fichiers pertinents d'un dépôt. Il lit `PROJET.md` pour connaître le contexte et les modes du projet. En mode ADO, il ne lit que le ticket identifié et, si nécessaire, ses commentaires via `ado/wit_work_item` ; en mode local, la section du besoin dans `ANALYSE.md`. En contexte Forem, il lit et publie dans les wikis du portefeuille (projet ADO) que l'utilisateur indique pour la demande, par exemple le projet [Dossier Unique Chercheur Emploi (CRM)](https://dev.azure.com/leforem/Dossier%20Unique%20Chercheur%20Emploi%20(CRM)), sans utiliser `PROJET.md` pour choisir ce wiki, et il lit les pages Architecture DDI indiquées dans ses instructions. Dans un autre contexte, il lit et publie selon le mode de wiki de `PROJET.md`. Il publie sans suppression et, depuis le 2026-11-23, sans confirmation par écriture. Joao peut documenter une architecture existante ou proposer une architecture cible sans développer ni déployer la solution. Dans le processus de l'équipe, il conçoit l'architecture d'une fonctionnalité, relit les PR de Sébastien et qualifie les anomalies remontées par Anne-Cécile (voir « Processus de l'équipe »).

Dans un dépôt, son livrable architectural est `ARCHITECTURE.md` à la racine. Il décrit le contexte, le périmètre, les composants principaux et leurs dépendances, ainsi que les flux utiles à la compréhension du système par l'équipe. Juste avant « Composants », une section « Vue d’ensemble des dépendances » présente un schéma Mermaid haut niveau : l'application analysée en un seul bloc, les applications appelantes et les systèmes avec lesquels elle communique autour, avec des liens nommant le rôle des échanges. Cette vue couvre les dépendances internes et externes au SI vérifiables dans les sources, sans détailler les couches internes ni les paquets logiciels. Le détail interne reste dans « Composants ». Joao peut déléguer un diagramme utile à UMLCreator.

La vue « Composants » reste en Mermaid `flowchart`, sans prétendre à une notation UML formelle. Elle montre la structure : regroupements `subgraph` selon les frontières observées, composants à un niveau de détail homogène, systèmes externes séparés et flèches du composant dépendant vers le composant utilisé. Elle évite les détails de classes ou d'injection non structurants et les croisements excessifs ; un zoom ciblé peut compléter une vue trop dense. Les étapes de traitement et décisions restent dans les diagrammes de flux.

Chaque flux ou fonctionnalité principal retenu est présenté dans une même sous-section avec une description des étapes et un diagramme Mermaid adapté. Les deux sont obligatoires et doivent concorder. Joao choisit le type pertinent : séquence pour les interactions entre participants, activité ou logigramme pour les traitements et décisions (en Mermaid `flowchart`). La vue haut niveau et le schéma de composants ne remplacent pas ces diagrammes. En documentation, les comportements représentés restent limités aux faits vérifiés dans les sources.

Joao travaille selon trois modes :

- **Documentation de l'existant** : il décrit seulement ce qu'il constate dans le dépôt. Pas de déduction, d'hypothèse, de point à confirmer, de risque, de recommandation ni de mention d'ADR. Il sollicite systématiquement Antoine pour une revue de sécurité du dépôt (`SECURITY_REVIEW.MD`) et y renvoie depuis `ARCHITECTURE.md`, sans évaluer lui-même la sécurité. C'est le mode par défaut en cas de doute, hors du processus de l'équipe.
- **Conception** : il distingue faits, propositions, décisions validées et points ouverts, et peut consulter Antoine pour un avis ciblé. C'est le mode appliqué dans le processus de l'équipe et quand un agent lui pose une question technique.
- **Challenge** : uniquement sur demande explicite (par exemple challenger un besoin de Maxime). Il peut alors déduire et émettre des hypothèses, présentées comme telles.

Les ADR ne concernent que les changements et décisions d'architecture. Au démarrage d'un projet, Joao regroupe les choix structurants initiaux dans un seul ADR « socle technique », sauf choix au cycle de vie propre ou à fort impact ; ensuite, un ADR n'est créé que pour un changement d'architecture ou une dérogation. Toute modification de l'architecture existante est accompagnée d'un ADR distinct, créé au statut `Proposé` ; un humain doit l'accepter avant le développement. `ARCHITECTURE.md` est mis à jour avec les changements marqués « Proposé (ADR X) », finalisés à l'acceptation ou retirés au refus. Joao utilise le dossier des ADR du cadre technique de `PROJET.md` ou les conventions du dépôt, et demande le dossier s'il n'est pas établi. En contexte Forem, il suit la gouvernance et le modèle Forem : statut, contexte, décision motivée, conséquences positives et négatives, vérification de conformité, auteur, date et ADR liés ; ailleurs, la même structure sauf convention contraire du dépôt. Le titre utilise le code application de `PROJET.md` (en contexte Forem, à défaut, le mapping OMA de Maxime) et le prochain numéro disponible sur trois chiffres (`LDC-001`, `LDC-002`, etc.). Si le code ou la séquence n'est pas vérifiable, il demande au lieu de l'inventer. Les règles détaillées sont dans [docs/joao/modele-adr.md](joao/modele-adr.md) ; celles d'`ARCHITECTURE.md` et des diagrammes dans [docs/joao/modele-architecture.md](joao/modele-architecture.md).

Joao prend en compte Clean Architecture, KISS, DRY et SOLID. En contexte Forem, il applique aussi les [principes d'architecture logicielle du Forem](https://dev.azure.com/leforem/Tools%20Backlogs/_wiki/wikis/Architecture%20DDI/41159/%F0%9F%93%91-Principes-d'architecture-logicielle) et soumet les dérogations au Support aux développements de la DDI ; ailleurs, il utilise la source de principes éventuelle de `PROJET.md` et soumet les dérogations à l'utilisateur. Les principes guident ses propositions sans constituer des dogmes ; les dérogations sont motivées et tracées dans un ADR. La liste des principes peut évoluer selon les instructions ultérieures de l'utilisateur.

Son accès d'écriture dans le dépôt est limité par consigne à `ARCHITECTURE.md`, aux ADR concernés, dans le processus de l'équipe à `docs/fonctionnalites/<ID>/contexte-technique.md` et, en mode de wiki local, à ses documents publiés dans le dossier de `PROJET.md`. Il préserve les contributions existantes, ne modifie ni les tickets ADO, ni `ANALYSE.md`, ni `PROJET.md`, et n'exécute pas de commandes ou de tests. L'outil `wiki_upsert_page` remplace la page entière : Joao relit la page, ne modifie que la partie demandée et transmet l'`etag` lu pour éviter d'écraser une modification concurrente. Ces limites ne sont pas une sandbox technique : l'outil n'est restreint à aucun projet, cette limite repose sur la consigne et les droits ADO. Voir [.github/agents/joao.agent.md](../.github/agents/joao.agent.md) pour les instructions détaillées.

### Relais Maxime ↔ Joao pour les besoins

Pour un besoin transmis par Maxime ou une intervention sur un besoin, Joao s'appuie d'abord sur la cible documentée dans `ARCHITECTURE.md` si elle est disponible et exploitable. Sinon, il signale la limite et utilise les principes applicables : principes génériques (Clean Architecture, KISS, DRY, SOLID), complétés en contexte Forem par le wiki Architecture DDI et, ailleurs, par la source éventuelle indiquée dans `PROJET.md`. Il distingue l'existant, les propositions et la cible validée ; une contradiction ou un accès impossible reste signalé, jamais résolu par une hypothèse silencieuse.

Joao transmet à Maxime les compléments sourcés, les écarts, les impacts, les questions et les modifications proposées de la description, des critères d'acceptation ou des questions du besoin. **Maxime reste seul responsable de l'écriture du besoin**, dans ADO ou dans `ANALYSE.md`. Il intègre les compléments sans validation humaine lorsqu'ils précisent le besoin sans changer une règle métier, un critère validé ou le périmètre ; sinon, il fait trancher le PO. Les décisions d'architecture ne sont pas validées par ce relais.

Maxime peut consulter Joao (`agents: [Antoine, Joao, Simone]`) ; Joao peut appeler Maxime (`agents: [Antoine, UMLCreator, Maxime, Simone]`). Dans le harness Copilot, ces listes ne sont pas appliquées : les délégations reposent sur les consignes. Si Maxime a initié l'analyse, Joao retourne ses compléments directement sans le rappeler. Si Joao a été sollicité directement sur un besoin, Maxime traite le dossier sans rappeler Joao pour la même demande. Un appel impossible est signalé, sans annoncer de mise à jour fictive.

La lecture locale de Maxime inclut les sections utiles de `ARCHITECTURE.md` pour ce relais, sans accès général au code ni droit d'écriture sur l'architecture ou les ADR. Maxime ne délègue pas à UMLCreator pour rédiger un besoin.

### Simone — UI/UX

Simone conçoit l'expérience et les interfaces d'applications Web. Elle utilise `Claude Sonnet 5.5` avec `reasoning-effort: medium`, un modèle moins coûteux que celui de Maxime et Joao. Vérifier le libellé exact dans le sélecteur de modèles de VS Code.

- **Sollicitations** : dans le processus, après le besoin validé par le PO et avant Joao ; aussi pour les questions d'UI ou d'UX de Maxime, Joao et, quand il existera, Sébastien ; ou par l'utilisateur directement. Elle n'a pas accès aux tickets ADO : elle reçoit une synthèse ; en mode local, elle lit la section du besoin dans `ANALYSE.md`. Elle pose ses questions métier à Maxime.
- **Livrables** dans `docs/ux/` : parcours utilisateurs, charte graphique, maquettes basse fidélité en Markdown, règles d'ergonomie et critères UX proposés. Revue UX et accessibilité d'écrans existants uniquement sur demande, sans modification du code.
- **Charte graphique** : en début de projet, Simone propose dans `docs/ux/charte.md` deux ou trois design systems reconnus, l'utilisateur en choisit un, puis elle fixe les design tokens (couleurs, typographie, espacements, formes, points de rupture). WCAG 2.2 niveau AA est proposé comme référence d'accessibilité, à confirmer par l'utilisateur. Une maquette n'utilise aucune valeur hors charte validée.
- **Liste de contrôle** avant livraison : accessibilité, hiérarchie, cohérence, états complets, lisibilité et heuristiques de Nielsen.
- **Nettoyage** : `docs/ux/` sert de dossier de travail pendant le développement. À chaque nouveau projet, Simone liste les documents de l'ancien projet, signale ceux qui n'ont pas été publiés et attend une confirmation explicite. Sans outil de suppression de fichier, l'utilisateur supprime lui-même.
- **Publication** : sur demande explicite, selon le mode de wiki de `PROJET.md` : wiki ADO indiqué ou désigné, dossier local, ou aucune publication. Dans un wiki ADO, mêmes garde-fous que Joao : relecture préalable, `etag`, aucune suppression, sans confirmation par écriture.
- **Relais vers les besoins** : à la fin de sa conception, Simone transmet à Maxime les critères `UX-xx` en texte clair, avec le chemin de la maquette. Maxime les intègre au besoin, chacun citant le `CA-xx` qu'il complète ; les règles d'interface `RI-xx` et les textes d'interface restent dans la maquette et sont seulement référencés. Ni copie de la maquette, ni source Mermaid. Ses questions métier vont à Maxime, qui répond ou les fait remonter au PO et consigne la réponse dans le ticket ou dans `ANALYSE.md`. Simone ne rappelle pas l'agent qui l'a sollicitée : si c'est Maxime, elle lui retourne directement ses critères et questions.
- **Délégations** : `agents: [UMLCreator, Antoine, Maxime, Joao]`. UMLCreator pour les diagrammes de parcours ; Antoine pour un avis ciblé quand un écran touche aux données personnelles, à l'authentification, aux permissions ou à des informations sensibles ; Maxime pour les questions métier et les critères UX ; Joao pour une contrainte technique.
- **Fichiers** : charte du projet dans `docs/ux/charte.md`, livrables d'une fonctionnalité dans `docs/ux/<ID>/`, où `<ID>` est l'identifiant du besoin (numéro de ticket ou `FCT-NNN`).
- **Limites** : ni terminal, ni Web, ni accès aux tickets ADO ; aucune modification de code, de configuration, de besoin ni de `PROJET.md`. Le hook de routage vers Antoine ne couvre pas les fichiers de `docs/ux/`. Voir [.github/agents/simone.agent.md](../.github/agents/simone.agent.md).

### Antoine — sécurité

`Antoine` effectue une revue statique en lecture seule du code, des dépendances, de l'IaC et de la configuration pertinente. Il consulte uniquement les pages publiques officielles OWASP utiles à la revue et n'envoie aucun contenu du dépôt vers un service externe. Il utilise OWASP Top 10:2025 comme cadre de sensibilisation pour les risques Web, en considérant seulement les catégories applicables et sans en faire une checklist exhaustive ou une certification. Il restitue des constats étayés, leur sévérité et leur niveau de confiance, puis recommande des corrections sans modifier le code par défaut (voir « Corrections après validation humaine ») ni tenter d'exploiter une vulnérabilité. Dans le processus de l'équipe, il relit les pull requests de Sébastien avec Joao et rend un verdict « validé » ou « écarts à corriger ». Pour les périmètres API ou LLM, il signale que ce Top 10 ne couvre pas à lui seul les risques spécialisés. Il ne prétend pas certifier l'absence de risque.

En revue du dépôt, Antoine reste observateur et constatateur : aucune extrapolation, hypothèse, question ouverte ou liste de points à confirmer. Chaque défaut et ses conséquences doivent être étayés par les sources accessibles ; une preuve manquante exclut le constat, même avec une confiance faible. Les recommandations portent uniquement sur les défauts étayés. Les sources inaccessibles sont signalées comme limites de couverture, sans supposer l'absence de protection. Cette règle vaut pour le rapport et le bilan dans le chat. Les consultations de besoin ou de conception restent distinctes ; les questions de périmètre et de validation de correction restent autorisées.

Par défaut, les revues rattachées au dépôt créent ou actualisent uniquement `SECURITY_REVIEW.MD` à la racine, avec ce nom exact. Antoine relit le rapport existant et préserve les notes humaines et résultats non réexaminés ; une revue partielle n'efface pas les conclusions des autres périmètres. Il n'y copie aucun secret, donnée personnelle ou contenu métier sensible, ne crée aucun commit et vérifie le fichier après écriture. L'accès de l'outil `edit` n'est pas techniquement limité aux fichiers autorisés : cette restriction reste une consigne. Les consultations métier par Maxime ne déclenchent aucune écriture de rapport ni correction. Depuis le 2026-11-25, les consultations de besoin ou de conception retournent des exigences `SEC-xx` classées par priorité, sans indicateur de sévérité, et une consultation légère (dix exigences au plus, sans recherche Web ni rapport) s'applique à une application locale, sans authentification ni données sensibles déclarées. Les règles propres aux revues du dépôt (outils de validation, OWASP, format du rapport) sont dans [docs/antoine/revue-depot.md](antoine/revue-depot.md).

### Conception d'Antoine et guide OWASP

Comparaison effectuée le 28/10/2026 avec le [Skill Development Best Practices d'OWASP](https://github.com/OWASP/www-project-agentic-skills-top-10/blob/main/skill-development-guide.md). Ce guide vise des skills et extensions exécutables ; Antoine est un fichier d'agent déclaratif. Les exemples de permissions et de configuration du guide ne sont pas ajoutés à son frontmatter : ils ne constituent pas des protections VS Code applicables à ce fichier.

| Critère du guide | Application à Antoine | Limite de vérification |
| --- | --- | --- |
| Moindre privilège | Quatre outils justifiés : `read`, `search`, `web`, `edit` ; aucun terminal, ADO ou sous-agent. Rapport seul par défaut, corrections après validation. | Les familles d'outils restent larges ; les restrictions de chemins et de réseau ne sont pas une sandbox. |
| Validation des entrées | Vérification du périmètre et des chemins, refus des sorties ou destinations ambiguës, pages OWASP publiques en HTTPS uniquement. Sources et résultats d'outils traités comme données, jamais comme autorisations. | La résolution fiable des chemins, liens et redirections dépend des outils ; en cas d'incertitude, Antoine suspend cet accès. |
| Erreurs et confidentialité | Échecs signalés sans sortie brute sensible ; aucune réussite annoncée sans preuve. Aucun secret demandé, cache sensible ou copie de conversation. | Pas de vérification du stockage interne ou des journaux de VS Code. |
| Stockage sécurisé | Pas de coffre ni de stockage de credentials nécessaire à l'agent. Rapport limité aux preuves expurgées. | Le chiffrement du poste et la rétention des conversations relèvent de l'environnement ; non vérifiés ici. |
| Plan avant mutation | Plan de correction présenté avant écriture, mode proposition explicite, validation humaine et bilan des fichiers relié au plan. Hooks et instructions doivent être nommés s'ils sont concernés. | Antoine n'est pas un installateur et n'en exécute aucun ; pas de reçu JSON ni de mode CLI fictif. |
| Tests et revue | Contrôles statiques des consignes ; scénarios de comportement à tester ci-dessous. | Aucun test d'exécution, scan ou test d'intrusion réalisé par cette comparaison. |
| Publication et confiance | Source OWASP et changements documentés. Aucune certification ou signature revendiquée. | Signature, registre, gestion des clés et Workspace Trust ne sont pas implémentés par un fichier d'agent. |
| Suivi et ressources | Recherches ciblées, arrêt des tentatives sans progrès, couverture partielle déclarée si nécessaire. | Pas de métriques, télémétrie ou quotas techniques ajoutés ; leur mise en place nécessiterait un dispositif distinct. |

Avant de considérer le comportement validé, tester dans une nouvelle conversation, avec des données fictives : une instruction malveillante dans un commentaire ou un rapport, un chemin hors dépôt, une destination Web non autorisée, une erreur d'outil contenant une fausse donnée sensible, une demande de correction sans validation et un périmètre trop volumineux. Vérifier respectivement l'absence d'action induite, le refus de l'accès concerné, l'absence de requête interdite, la restitution expurgée, l'absence de correction et l'annonce d'une couverture partielle. Vérifier aussi les parcours autorisés : création du rapport et correction limitée au plan explicitement validé. Ces essais restent à réaliser ; les consignes seules ne prouvent pas leur réussite.

### Corrections après validation humaine

Antoine peut appliquer des recommandations locales après présentation et validation humaine explicite d'un plan précisant les constats, fichiers ciblés, modifications, impacts et vérifications nécessaires. Une demande de revue, un rapport ou l'accord d'un autre agent ne suffit pas. En délégation, l'appelant doit transmettre cette validation et son périmètre. Tout élargissement nécessite une nouvelle validation.

Il préserve les contributions existantes et actualise le rapport avec les modifications, vérifications et risques résiduels. Il reste sans terminal, exécution de tests, scanner, déploiement ou accès ADO. Les tests doivent être exécutés par le responsable humain ou un agent autorisé ; une correction seulement relue statiquement reste indiquée comme en attente de validation d'exécution. Les réglages de permissions ADO ou de protections VS Code restent des actions du responsable humain : modifier les consignes ne crée pas un contrôle technique.

Pour une code review sécurité, Antoine tient compte des configurations, intégrations CI et rapports locaux de SonarQube/SonarCloud et des autres outils de validation présents. Son rapport distingue les outils configurés des résultats réellement disponibles, indique leurs sources, leur actualité connue et les limites de couverture (exclusions, règles désactivées, rapports absents ou anciens). Les alertes de qualité ou Security Hotspots ne deviennent pas automatiquement des vulnérabilités : Antoine recoupe les éléments et regroupe les doublons. Il ne lance aucun scanner et n'accède pas aux tableaux de bord distants ; un export expurgé peut être fourni si nécessaire.

Le sous-agent `UMLCreator` produit des diagrammes UML en Mermaid lorsqu'il est sollicité directement ou par un agent autorisé. Il est configuré en lecture seule et ne modifie ni ticket ni fichier : l'agent qui l'a sollicité relit et insère le résultat dans un livrable Markdown adapté. Maxime ne délègue pas à UMLCreator pour rédiger ou affiner un besoin ; les tickets ADO ne rendant pas Mermaid, il décrit les flux en texte clair et n'y publie pas de blocs de source Mermaid. Joao est autorisé à utiliser UMLCreator pour des diagrammes d'architecture pertinents destinés à `ARCHITECTURE.md`, et Simone pour des diagrammes de parcours utilisateur destinés à `docs/ux/`. Un agent principal doit autoriser explicitement UMLCreator dans sa liste `agents` ; cette liste n'est appliquée que dans le harness Local (voir « Harnesses Local et Copilot »). Le modèle de UMLCreator n'est pas fixé tant que son libellé exact n'a pas été vérifié dans VS Code. Les maquettes d'écran ne sont mentionnées dans les besoins de Maxime que lorsqu'elles sont fournies dans le besoin initial ou produites par Simone pour ce besoin, par leur chemin ou leur lien.

### Consultation d'Antoine par les autres agents

Antoine est utilisable directement et comme sous-agent. L'intensité ci-dessous décrit la place de sa consultation, pas le niveau de sévérité des risques.

| Appelant | Intervention d'Antoine | Configuration |
| --- | --- | --- |
| Maxime — ponctuelle | Questions et exigences de sécurité du besoin, critères proposés ; pas de revue du code ni de décision d'architecture | Autorisé : outil `agent`, `agents: [Antoine, Joao, Simone]` |
| Joao — documentation de l'existant (systématique) ou conception | Revue de sécurité du dépôt (`SECURITY_REVIEW.MD`) ; en conception : risques, frontières de confiance, flux et permissions | Configuré : outil `agent`, `agents: [Antoine, UMLCreator, Maxime, Simone]` |
| Simone — ponctuelle | Exigences et points d'attention de sécurité des écrans ou parcours touchant aux données personnelles, à l'authentification, aux permissions ou aux informations sensibles | Configuré : outil `agent`, `agents: [UMLCreator, Antoine, Maxime, Joao]` |
| Sébastien — prioritaire | Revue de sécurité des implémentations, relecture des pull requests avec Joao et des corrections pertinentes | À câbler lors de la création de Sébastien : outil `agent`, `Antoine` dans `agents` et dans ses consignes (la liste `agents` n'est pas appliquée dans le harness Copilot) |

L'appelant transmet un contexte confirmé et un objectif délimité, puis relit l'avis avant de l'intégrer à son livrable. En revue, Antoine ne modifie que son rapport local ; toute correction suit la procédure de validation humaine ci-dessus, sans accès ADO ni délégation. Sa consultation ne vaut pas validation humaine et ne permet pas de contourner les limites de l'appelant.

## Processus de l'équipe

Processus cible de la dark factory, décidé par l'utilisateur le 2026-11-23. Maxime, Simone, Joao et Antoine y sont adaptés ; Sébastien, Anne-Cécile, Vincent, Léo et Philippe n'existent pas encore. L'utilisateur est le PO. Un besoin est un ticket ADO ou une section `FCT-NNN` de `ANALYSE.md`, selon le mode de suivi de `PROJET.md`.

| Étape | Agent | Entrées | Résultat | Suite |
| --- | --- | --- | --- | --- |
| 1 | Maxime, avec le PO | Besoin d'une fonctionnalité clairement délimitée | Un besoin par responsabilité : Maxime découpe une fonctionnalité qui en porte plusieurs ; validation du PO | Simone |
| 2 | Simone | Besoin validé | Parcours, maquettes, règles et critères UX dans `docs/ux/<ID>/`, critères UX transmis à Maxime | Joao |
| 3 | Joao, avec Antoine au besoin | Besoin et documents de Simone | Contexte technique dans `docs/fonctionnalites/<ID>/contexte-technique.md` ; ADR `Proposé` et `ARCHITECTURE.md` mis à jour si l'architecture change, ADR accepté par un humain avant le développement | Sébastien |
| 4 | Sébastien | Besoin, documents de Simone, contexte technique et ADR éventuel | Branche tirée de la branche principale (`main` ou `master`), PR relue et validée par Joao et Antoine puis par un humain, fusionnée par Sébastien | Anne-Cécile |
| 5 | Anne-Cécile | Besoin, documents de Simone, fonctionnalité fusionnée | Rapport de tests transmis à Joao | Joao, en cas d'anomalie ; sinon Vincent |
| 5 bis | Joao, Maxime, Sébastien | Rapport d'Anne-Cécile | Joao qualifie l'anomalie et transmet les éléments à Maxime, qui crée le bug ; Sébastien corrige ; Anne-Cécile reteste | Jusqu'à la résolution complète, au plus 3 cycles |
| 6 | Vincent | Ensemble des livrables de la fonctionnalité | Documentation Wiki du projet et des processus métier | Fin |

Pendant chaque étape, un agent peut consulter Maxime, Simone ou Joao selon leur responsabilité.

### Règles

- **Autonomie** : les agents enchaînent les étapes sans validation humaine systématique. Un agent bloqué s'adresse d'abord à l'agent responsable de la réponse. Si aucun agent n'en a la responsabilité ou ne sait répondre, il remonte la question ou la demande de validation à l'utilisateur. Aucun agent n'invente une réponse.
- **Questions métier de Simone** : elle les pose d'abord à Maxime. S'il manque de contexte, la question remonte à l'utilisateur. Maxime documente la réponse dans la discussion du ticket ou dans `ANALYSE.md`.
- **Une responsabilité par agent** : seul Maxime crée et modifie les besoins et les bugs. Il crée les bugs à partir des éléments de Joao, eux-mêmes fondés sur le rapport d'Anne-Cécile.
- **Architecture** : `ARCHITECTURE.md` documente le projet entier, jamais une seule fonctionnalité. En conception de projet, il évolue avec le projet ; en documentation de l'existant, il reste le constat du dépôt à un instant donné. Une fonctionnalité qui modifie l'architecture donne lieu à un ADR.
- **Code** : une branche par fonctionnalité depuis la branche principale, une PR préparée par Sébastien, validée par Joao, Antoine puis un humain, et fusionnée par Sébastien. Le comportement détaillé de Sébastien reste à définir.
- **Documentation** : Joao rédige la documentation d'architecture technico-fonctionnelle. Vincent rédige celle du projet et des processus métier ; son rôle sera affiné plus tard.

### Validations humaines et passage d'étape

Décisions de l'utilisateur du 2026-11-23, complétant les règles ci-dessus :

- **Validations humaines conservées** :
  - validation explicite avant de considérer un besoin prêt (Maxime) ;
  - plan validé par un humain avant toute correction d'Antoine ;
  - validation de la charte graphique de Simone ;
  - validation d'un ADR (statut `Accepté`) avant le début du développement ;
  - validation humaine d'une PR, en plus de celles de Joao et Antoine, avant que Sébastien la fusionne dans la branche principale.
- **Écritures wiki autonomes** : Joao, Maxime et Simone n'attendent plus de confirmation avant chaque écriture. Ils gardent la relecture préalable, l'`etag`, le périmètre de wiki autorisé, l'interdiction de supprimer et la relecture après écriture.
- **Passage d'étape** : un agent chef d'orchestre appelle chaque agent comme sous-agent, dans l'ordre du processus. Les agents n'appellent pas directement l'étape suivante.
- **Bugs** : en mode ADO, type de work item, zone et convention de titre définis dans `PROJET.md` ; en mode local, section « Suivi des bugs » de `ANALYSE.md`.

### Agent chef d'orchestre : Philippe

Décisions de l'utilisateur du 2026-11-23. Philippe n'est pas encore créé.

- **Démarrage** : l'utilisateur travaille d'abord directement avec Maxime. Philippe prend le relais une fois le besoin validé, à partir de son identifiant. Un sous-agent ne dialoguant pas avec l'utilisateur, seul Philippe, sélectionné dans le chat, remonte les questions et les validations humaines.
- **Rôle** : coordination uniquement. Philippe appelle les agents dans l'ordre du processus, suit l'état et remonte les blocages. Il ne produit aucun livrable et n'écrit ni dans les besoins ni dans les bugs, en ADO comme dans `ANALYSE.md`.
- **Contrôle qualité** : à la fin de chaque étape, avant de passer à l'agent suivant, Philippe appelle un nouvel agent, **Léo**, chargé du contrôle qualité du livrable. Léo reste à décrire.
- **Suivi** : Philippe tient son propre fichier d'état par fonctionnalité. À la reprise après une interruption, il le corrèle avec le livrable de l'étape en cours : besoin, documents UX, architecture ou développement.
- **Périmètre** : une seule fonctionnalité à la fois.
- **Boucle de correction** : au plus 3 cycles test → bug → correction. Au-delà, Philippe s'arrête et remonte la situation à l'utilisateur.
- **Modèle** : `Claude Sonnet 5.5`.
- **Fichier d'état** : `docs/fonctionnalites/<ID>/etat.md`, où `<ID>` est l'identifiant du besoin. Il suit l'étape en cours, les livrables produits, les blocages et le nombre de cycles de correction.
- **Orchestration économe** (décision du 2026-11-25, après le test local) :
  - Philippe ne lit pas les livrables : il transmet aux agents des identifiants et des chemins, et tient `etat.md` à jour à partir de leurs réponses courtes. Son contexte reste ainsi léger : lors du test, l'orchestrateur, qui avait tout lu, représentait près de 60 % des tokens consommés.
  - Il appelle les agents en arrière-plan pour pouvoir leur transmettre les réponses du PO dans la même conversation. Un sous-agent appelé en mode synchrone ne peut pas recevoir de suite : il faudrait le rappeler avec tout le contexte.
  - Il regroupe les questions et validations en attente de tous les agents en un seul lot avant de solliciter l'utilisateur, puis répartit les réponses.
  - Il crée les dossiers attendus par l'étape (`docs/ux/<ID>/`, `docs/fonctionnalites/<ID>/`, dossier des ADR) avant d'appeler l'agent, car l'outil de création de fichier des sous-agents peut ne pas créer les dossiers parents (constaté lors du test, non vérifié dans VS Code).
  - Il rappelle à chaque agent la fonctionnalité en cours : une seule à la fois.
- **Création** : Philippe ne sera créé qu'une fois Sébastien, Anne-Cécile et Vincent disponibles.

### Agent de contrôle qualité : Léo

Décisions de l'utilisateur du 2026-11-23. Léo n'est pas encore créé.

- **Rôle** : appelé par Philippe à la fin de chaque étape, Léo contrôle le livrable et rend un verdict argumenté. Il ne refait pas le travail de l'agent auteur.
- **Contrôles** :
  - conformité au besoin : le livrable couvre le besoin et ses critères d'acceptation ;
  - complétude : sections, éléments et validations requis par le rôle de l'agent auteur ;
  - cohérence avec les livrables des étapes précédentes : besoin, UX, architecture ;
  - respect des règles de l'agent auteur et des règles communes : pas d'invention, faits et propositions distingués, style ;
  - points ouverts non résolus qui bloquent l'étape suivante.
- **Refus d'un livrable** : Philippe le renvoie à l'agent auteur avec les écarts, puis rappelle Léo. Après 2 essais sans succès, il remonte la situation à l'utilisateur.
- **Contrôle léger** (décision du 2026-11-25) : Léo travaille à partir d'une liste de contrôle courte et des seuls fichiers modifiés par l'étape (diff fourni par Philippe ou liste des chemins), sans relire tout le projet. Il vérifie en priorité la règle de source unique : chaque information citée par son identifiant existe dans sa source, n'est pas recopiée ailleurs et ne contredit pas la source. Lors du test, une précision reportée dans le besoin mais pas dans la maquette est restée incohérente.
- **Accès** : lecture des besoins et bugs (tickets ADO ou `ANALYSE.md`) et des wikis, sans aucune écriture.
- **Modèle** : `Claude Sonnet 5.5`.

### Points ouverts

- **Philippe et Léo** : outils exacts et vérification de la lecture ADO par les sous-agents, dont un essai a échoué le 2026-11-23.
- **À trancher avec Philippe** : en mode ADO, qui transmet à Simone la synthèse du ticket ; passage à Joao possible ou non avec des maquettes provisoires tant que la charte n'est pas validée ; Joao appelle-t-il Sébastien directement pour une correction ou passe-t-il par Philippe ; qui demande une publication wiki dans le processus autonome.
- **Adaptations des agents existants** : faites le 2026-11-23 (voir ci-dessous). Restent à faire avec les prochains agents : appel de Sébastien et d'Anne-Cécile par Joao, et liste `agents` de Sébastien.
- **ADR et développement** : décision du 2026-11-23. Un ADR doit être validé par un humain (statut `Accepté`) avant que Sébastien commence le développement. Un ADR `Proposé` ne suffit pas.
- **Configuration de Maxime** : rendue indépendante du Forem le 2026-11-23 (voir « Configuration du projet et modes de suivi »). Le type, la zone et la convention de titre des bugs ADO restent à renseigner dans `PROJET.md` pour le contexte Forem.
- **Autres agents et modes** : depuis le 2026-11-23, tous les agents lisent `PROJET.md` (règle commune « Configuration du projet » de `.github/copilot-instructions.md`). Joao et Simone lisent le besoin dans ADO ou dans `ANALYSE.md` et publient selon le mode de wiki. Joao n'applique le wiki Architecture DDI et la gouvernance ADR Forem qu'en contexte Forem ; il y lit et publie dans les wikis du portefeuille indiqué par l'utilisateur. Il lit le code application des ADR dans `PROJET.md`. Les futurs agents héritent de la règle commune.

### Configuration du projet et modes de suivi

Décisions de l'utilisateur du 2026-11-23, appliquées à toute l'équipe.

- **`PROJET.md`**, à la racine du dépôt cible, décrit le projet : contexte (`Forem` ou `Autre`), code application, mode de suivi (`ADO` ou `Local`), mode de wiki (`ADO`, `Local` ou `Aucun`), cadre technique et valeurs de connexion ADO si nécessaire. Les deux modes sont indépendants. Maxime le crée avec l'utilisateur à partir de [modele-projet.md](maxime/modele-projet.md), qui contient aussi l'exemple Forem. Tous les agents doivent le lire ; seul Maxime le modifie.
- **Cadre technique** (depuis le 2026-11-25) : pile, hébergement et exécution, exposition réseau et authentification, données sensibles, dossier des ADR, navigateurs et contraintes imposées. Maxime le demande à la création de `PROJET.md` ; l'utilisateur peut répondre « À proposer par Joao ». Joao propose alors des options et les fait valider avant de concevoir, puis Maxime reporte les valeurs validées. Lors du test, ces questions arrivaient en fin d'architecture et Joao avait d'abord supposé la pile et l'hébergement.
- **Source unique et identifiants** (depuis le 2026-11-25) : chaque information a une seule source et les autres livrables la citent par son identifiant (`RM`, `CA`, `UX`, `Q` dans le besoin ; `RI` et textes d'interface dans la maquette ; `P` dans le contexte technique ; `SEC` pour la sécurité ; ADR). Un comportement, un critère : un `UX-xx` complète un `CA-xx` sans le répéter. Le tableau des sources est dans `.github/copilot-instructions.md`.
- **Mode local** : `ANALYSE.md`, à la racine, remplace le backlog. Un seul fichier : index des besoins, une section `FCT-NNN` par besoin (rubriques du modèle de besoin, questions et réponses à la place de la discussion du ticket, historique) et une section « Suivi des bugs » (`BUG-NNN`). Modèle : [modele-analyse.md](maxime/modele-analyse.md). Seul Maxime y écrit.
- **Contexte Forem** : les règles Forem (Prague, `Support Request`, titre OMA, wiki Ressources, cache `docs/maxime/references.md`, wiki Architecture DDI et gouvernance ADR) ne s'appliquent que si `PROJET.md` l'indique. Elles sont dans [docs/maxime/forem.md](maxime/forem.md) et [docs/joao/forem.md](joao/forem.md), lus seulement dans ce contexte.
- **Indisponibilité d'ADO** : si le mode ADO est configuré mais qu'ADO est indisponible, aucun agent ne bascule en local ; le blocage est remonté. Un changement de mode ne se fait que sur demande de l'utilisateur, par Maxime.

### Adaptations du 2026-11-23

- **Règle commune** : section « Autonomie et remontée des questions » dans `.github/copilot-instructions.md`. Un agent bloqué s'adresse à l'agent responsable ; sinon, la question remonte à l'utilisateur. Un sous-agent retourne la question à son appelant sous le libellé « À remonter à l'utilisateur ».
- **Maxime** : un besoin par responsabilité, découpage après accord du PO ; réponses aux questions métier des agents, consignées dans le ticket ou `ANALYSE.md` ; création des bugs à partir des anomalies qualifiées par Joao ; intégration autonome des compléments de Joao et Simone s'ils ne changent ni règle métier, ni critère validé, ni périmètre ; écritures wiki sans confirmation.
- **Simone** : appelle Maxime pour les questions métier et la transmission des critères UX, et Joao pour une contrainte technique ; livrables par fonctionnalité dans `docs/ux/<ID>/` ; validation de la charte remontée à l'utilisateur ; écritures wiki sans confirmation.
- **Joao** : conception d'une fonctionnalité (ADR `Proposé` et mise à jour marquée de `ARCHITECTURE.md` si l'architecture change ; contexte technique dans `docs/fonctionnalites/<ID>/contexte-technique.md` dans tous les cas) ; mode conception dans le processus ; relecture des PR ; qualification des anomalies ; écritures wiki sans confirmation.
- **Antoine** : verdict sur les pull requests avec Joao ; lecture de `ANALYSE.md` en mode local ; collaboration avec Simone.

### Adaptations du 2026-11-25

Après le test local du 2026-11-25 (une fonctionnalité simple, environ 27 millions de tokens en entrée, 7 sollicitations du PO après la validation du besoin), l'utilisateur a retenu ces ajustements pour réduire les allers-retours et la consommation :

- **Consignes allégées** : les règles utiles à une seule tâche sont sorties des agents dans des fichiers lus à la demande. [docs/commun/publication-wiki-ado.md](commun/publication-wiki-ado.md) (procédure wiki ADO, auparavant répétée dans trois agents), [docs/maxime/forem.md](maxime/forem.md), [docs/joao/forem.md](joao/forem.md), [docs/joao/modele-architecture.md](joao/modele-architecture.md), [docs/joao/modele-adr.md](joao/modele-adr.md) et [docs/antoine/revue-depot.md](antoine/revue-depot.md). Aucune règle n'est supprimée. Tailles : Joao de 33 à environ 15 Ko, Maxime de 25 à environ 18 Ko, Antoine de 21 à environ 15 Ko ; les règles communes, chargées par tous, passent de 8 à environ 11 Ko avec le tableau des sources.
- **Maxime** : liste de cas limites (saisies, dates et heures, listes, états, doublons, droits, conservation) passée en revue dès le premier lot, avec une valeur par défaut proposée pour chaque cas, que le PO valide ou corrige d'une seule réponse ; rubrique « Cadre technique » demandée à la création de `PROJET.md`.
- **Cadre technique** et **source unique** : voir « Configuration du projet et modes de suivi ».
- **Joao** : vérifie le cadre technique et pose les questions bloquantes en un seul lot avant de concevoir ; un seul ADR « socle technique » au démarrage d'un projet, puis un ADR seulement pour un changement d'architecture ; contexte technique d'une à deux pages qui cite les règles au lieu de les recopier.
- **Antoine** : en consultation de besoin ou de conception, exigences `SEC-xx` classées par priorité, sans indicateur de sévérité ; **consultation légère** (dix exigences au plus, sans recherche Web ni rapport) pour une application locale, sans authentification ni données sensibles déclarées. L'avis est alors consigné par l'agent qui l'a demandé (Maxime dans le besoin, Joao dans le contexte technique, avec une ligne de renvoi « Avis de sécurité d'Antoine : » dans `ARCHITECTURE.md` et les ADR concernés), ce qui reste une preuve valable pour le hook.
- **Philippe et Léo** : orchestration économe et contrôle léger (voir leurs sections).
- **Non retenus** : droit pour un agent de trancher seul les détails réversibles, trois validations groupées par fonctionnalité, questions groupées par étape au niveau des agents, statut « En révision », un fichier par besoin en mode local, changement de modèles.

## Installation dans un dépôt

### Routage automatique de Joao vers Antoine

Quand `ARCHITECTURE.md`, un fichier `ADR*.md` ou un `contexte-technique.md` contient « Base de données », « API externe », « Authentification » ou « Données personnelles », Joao doit appeler Antoine sans intervention humaine, quel que soit son mode.

- Le contrôle est un hook `postToolUse` au format du harness Copilot : [route-securite.json](../.github/hooks/route-securite.json) lance [route-securite.ps1](../.github/hooks/scripts/route-securite.ps1) après chaque outil réussi. Le script accepte aussi le format VS Code / Local (`tool_input`).
- Le script ignore la casse et les accents. Il cherche l'expression exacte, pas ses variantes (« authentifier », « API tierce »).
- Si un mot-clé est présent et qu'aucune preuve de revue n'existe, il ajoute au résultat de l'outil une consigne (`additionalContext`) qui renvoie l'agent vers Antoine. Dans le harness Copilot, un hook `postToolUse` ne peut ni annuler l'écriture ni bloquer l'agent : c'est un rappel. Le champ `decision: block`, conservé pour le harness Local, y est ignoré. La preuve est un `SECURITY_REVIEW.MD` à la racine ou près du livrable, ou la ligne « Avis de sécurité d'Antoine : » dans le livrable. Depuis le 2026-11-25, sans rapport, l'avis est consigné dans le contexte technique et les autres fichiers contrôlés (`ARCHITECTURE.md`, ADR) portent la même ligne suivie d'un simple renvoi (chemin et identifiants `SEC-xx`).
- Limites : le hook ne vérifie pas qu'Antoine a vraiment été appelé, il vérifie la preuve écrite. Un `SECURITY_REVIEW.MD` ancien suffit. Il s'applique à tout agent qui écrit ces fichiers, pas seulement à Joao ; son déclenchement pour les écritures faites par un sous-agent n'est pas vérifié. Il ne couvre que les fichiers nommés `ARCHITECTURE.md`, `ADR*.md` et `contexte-technique.md`, pas le chat.
- Le fichier de configuration a été migré au format Copilot (`postToolUse`, `bash`/`powershell`, `timeoutSec`). Le script a été adapté le 2026-11-23 et testé avec des entrées simulées dans les deux formats ; son déclenchement réel dans VS Code reste à vérifier. Le 2026-11-25, un défaut a été corrigé : dans un fichier aux fins de ligne CRLF, la ligne « Avis de sécurité d'Antoine : » n'était jamais reconnue et le rappel était émis à tort (6 cas simulés vérifiés après correction). Il suppose Windows PowerShell (`pwsh` ailleurs). Le hook exécute un script : le relire avant d'accorder la confiance à l'espace de travail.

1. Intégrer `.github/copilot-instructions.md`, `.github/agents/maxime.agent.md`, `.github/agents/umlcreator.agent.md`, `.github/agents/antoine.agent.md`, `.github/agents/joao.agent.md`, `.github/agents/simone.agent.md`, `.github/hooks/`, `.vscode/mcp.json` et `docs/` au dépôt cible. Fusionner les configurations existantes au lieu de les écraser. Ne pas copier de `PROJET.md` ni de `ANALYSE.md` : Maxime les crée pour chaque projet. `docs/` contient les fichiers lus à la demande par les agents (`docs/commun/`, `docs/maxime/`, `docs/joao/`, `docs/antoine/`) : les copier tous. Hors contexte Forem, `docs/maxime/references.md`, `docs/maxime/forem.md` et `docs/joao/forem.md` ne sont pas utilisés.
2. Ouvrir le dépôt dans une version à jour de VS Code avec GitHub Copilot Chat et les agents personnalisés activés. N'accorder la confiance à l'espace de travail qu'après vérification de son contenu.
3. Si le projet utilise ADO (suivi ou wiki) : ouvrir `.vscode/mcp.json`, adapter l'URL de l'organisation si ce n'est pas `leforem`, puis démarrer le serveur `ado` avec son action de démarrage ou la commande `MCP: List Servers`. En mode entièrement local, cette étape et la suivante sont inutiles.
4. Autoriser la connexion et s'authentifier dans le parcours Microsoft Entra proposé par VS Code, avec un compte ayant accès à l'organisation. Ne communiquer aucun secret à l'agent.
5. Choisir Maxime dans le sélecteur d'agents. Vérifier que le modèle `Claude Opus 5.5` est reconnu et accessible avec l'abonnement. Le libellé provient de l'utilisateur et n'a pas été vérifié par une API de catalogue. S'il n'est pas reconnu, sélectionner le libellé exact dans VS Code et adapter le champ `model` ; ne pas supposer un remplacement équivalent. Faire la même vérification pour `Claude Sonnet 5.5`, le modèle de Simone.
6. Vérifier que les outils `ado` sont visibles. Si nécessaire, actualiser la découverte des outils ou ouvrir une nouvelle conversation après démarrage du serveur.

Le serveur distant officiel utilise `https://mcp.dev.azure.com/leforem`. Il ne nécessite ni installation Node.js, ni PAT dans le dépôt. L'organisation et le compte doivent être rattachés à Microsoft Entra ; l'accès peut dépendre des politiques et consentements du tenant Forem. Aucun compte ni consentement administrateur n'est créé par ce template.

### Installer uniquement Antoine pour une code review sécurité

Copier `.github/agents/antoine.agent.md` et `docs/antoine/revue-depot.md` dans le dépôt cible, au même emplacement, et fusionner les règles communes de `.github/copilot-instructions.md` avec les instructions existantes, sans les écraser. Aucun serveur MCP ADO ni agent Maxime n'est nécessaire à son utilisation directe. Ouvrir le dépôt dans VS Code, sélectionner Antoine dans une nouvelle conversation et préciser le périmètre de revue. Les configurations et rapports de validation accessibles localement sont pris en compte sans ajouter de secret ni de connexion à une plateforme d'analyse.

## Vérification initiale sans écriture ADO (contexte Forem)

Cette section ne concerne que les projets en contexte Forem et en mode ADO. Demander à Maxime :

> Vérifie uniquement en lecture l'accès au projet Tools Backlogs et identifie l'équipe et le chemin de zone correspondant à Tools Backlogs\Squads\Prague. Consulte Ressources et toutes ses pages enfants, ainsi que les correspondances OMA. Mets à jour ton cache avec les faits non sensibles vérifiés et leurs sources. Ne crée et ne modifie aucun ticket. Signale les informations impossibles à établir.

Cette vérification a été effectuée le 2026-10-20 : équipe `Squad Prague`, chemin `Tools Backlogs\Squads\Prague`, type `User story`, champs rédactionnels, racine Ressources et neuf descendants. Les sources et révisions sont consignées dans `docs/maxime/references.md`. Répéter cette procédure après installation dans un autre environnement ou pour actualiser les références ; l'authentification de chaque utilisateur reste nécessaire.

Arbitrages utilisateur actuels : tous les PBI créés par Maxime restent dans Prague et utilisent uniquement **Support Request**. Le libellé initialement demandé, `Service Request`, a été refusé par ADO ; `Support Request` a ensuite été confirmé par l'utilisateur et vérifié. Le type `User story` mentionné dans le premier contrôle est désormais historique, pas un choix de repli. Les titres suivent `[Code OMA][NNN].[NN] - [Fonctionnalité]`, par exemple `LDC001.01`. LDC est uniquement un exemple. La règle d'incrémentation n'étant pas définie, Maxime demande le numéro si nécessaire et vérifie les doublons avant création.

La description commence par **Expression du besoin**. INVEST reste un contrôle interne, jamais une section publiée. Les critères sont placés uniquement dans Acceptance Criteria ; aucune section du même nom ni section État de l'affinage n'est ajoutée dans Description. Les questions de discussion privilégient un ton naturel, des sujets séparés, des paragraphes courts et des puces, sans rappels de procédure répétitifs.

Pour vérifier les écritures, désigner explicitement un ticket de test et autoriser un commentaire de test. Contrôler le résultat dans ADO. Ne pas tester sur un ticket métier sans accord. L'installation et la validation locale des fichiers ne prouvent pas le fonctionnement de l'authentification ou des écritures ADO.

Un test concret explicitement demandé a réussi le 2026-10-20 : création initiale d'une `User story` dans Prague, puis conversion en `Support Request` et correction de Description à la suite du retour utilisateur. La mise à jour a utilisé un test de révision ; la relecture et la comparaison ont confirmé la conservation exacte des Acceptance Criteria, du titre, de la zone et de l'état. Le commentaire a été réécrit selon la présentation utilisateur et son rendu vérifié. Les valeurs `New`, priorité `3` et `Change Request = false` avaient été appliquées au type initial ; elles ne définissent pas les défauts d'une création directe en `Support Request`, encore non testée. Aucun conflit de concurrence n'a été provoqué. Aucun contenu métier du ticket n'est copié dans ce guide ou le cache.

## Utilisation

Commencer chaque projet en demandant à Maxime de créer `PROJET.md` avec vous. Exemples de demandes ensuite :

### Démarrer un projet

> Nouveau projet [nom]. Crée PROJET.md avec moi : contexte, mode de suivi et mode de wiki.

### Créer un besoin

> Je souhaite créer un besoin pour [application] : [besoin réel]. Vérifie les conventions du projet, crée le besoin dès que les informations obligatoires sont connues et pose les questions restantes.

### Affiner un besoin existant

> Affine le besoin [identifiant]. Lis d'abord son contenu et ses questions, puis pose les questions encore ouvertes sans modifier les décisions établies.

### Lire les nouvelles réponses

> Reprends l'affinage du besoin [identifiant] à partir des nouvelles réponses.

### Actualiser le cache (contexte Forem)

> Actualise complètement ton cache depuis Ressources et ses descendants. Ne modifie aucun ticket.

Maxime ne surveille pas les commentaires en arrière-plan : le relancer pour lire les réponses. Les réponses fournies dans VS Code sont synthétisées dans le ticket ou dans `ANALYSE.md`. La validation du contenu reste humaine et ne déclenche pas automatiquement un changement d'état ADO.

## Outils et confidentialité

La configuration `X-MCP-Tools` expose uniquement les outils de lecture nécessaires, les outils d'écriture de tickets/commentaires et l'écriture wiki `wiki_upsert_page`. Elle n'expose ni les dépôts, ni les pipelines. L'écriture wiki est accordée à Joao, Maxime et Simone selon le mode de wiki de `PROJET.md` (wikis du portefeuille indiqué par l'utilisateur pour Joao en contexte Forem), sans suppression et, depuis le 2026-11-23, sans confirmation par écriture. Maxime reçoit une liste explicite d'outils ADO au lieu de `ado/*`. Simone n'a que `ado/wiki` et `ado/wiki_upsert_page`. Les droits réels restent ceux du compte connecté et des autorisations OAuth ; l'outil d'écriture n'est restreint à aucun projet, cette limite repose sur les consignes et les droits ADO.

Certains outils regroupent plusieurs actions : par exemple `wit_backlog` inclut aussi le réordonnancement. Leur disponibilité ne vaut pas autorisation d'utiliser toutes leurs actions. Maxime ne les emploie qu'en lecture, sauf les écritures d'US, de bugs et de commentaires décrites dans son rôle. Pour une garantie forte, appliquer également les permissions ADO appropriées et les confirmations d'outils de VS Code ; ne pas activer une approbation globale sans examen.

Les outils locaux `read` et `edit` ne sont pas limités techniquement à un dossier. Le périmètre documentaire de Maxime est donc une consigne, pas une sandbox. Il ne dispose pas du terminal ; sa délégation est limitée à Antoine pour les exigences de sécurité du besoin, à Joao pour l'alignement architectural et à Simone pour les questions d'interface. La restriction de consultation Web d'Antoine aux sources OWASP est également une consigne, pas un filtrage technique des domaines.

Le cache `docs/maxime/references.md` est destiné à être versionné uniquement dans un dépôt dont l'accès est compatible avec la confidentialité des informations Forem. Ne pas publier ce cache, les correspondances internes ou les paramètres d'organisation dans un dépôt public sans autorisation. Vérifier son contenu avant chaque commit ; l'agent ne réalise pas les commits.

## Harnesses Local et Copilot

VS Code exécute les agents dans un « harness », c'est-à-dire un environnement d'exécution, choisi dans le chat. Le harness détermine les champs pris en compte et la validation affichée dans les fichiers `.agent.md`. Le harness **Local** est déprécié et sera supprimé en février 2027. Le harness **Copilot** est la cible du template. Sources : [Custom agent file reference](https://code.visualstudio.com/docs/agents/reference/custom-agent-file-reference) et [Subagents](https://code.visualstudio.com/docs/agents/run/subagents), consultées le 2026-11-23.

| Champ | Local | Copilot | Effet pour le template |
| --- | --- | --- | --- |
| `agents` | Liste des sous-agents autorisés | Non pris en charge | Dans Copilot, un agent peut déléguer à tout agent qui n'a pas `disable-model-invocation: true`. Les restrictions de délégation (par exemple Maxime n'appelle pas UMLCreator pour un ticket) reposent uniquement sur les consignes. |
| `handoffs` | Boutons de passage vers l'agent suivant | Non pris en charge | Non utilisé : le passage d'étape passera par un agent chef d'orchestre. |
| `argument-hint` | Texte d'aide dans le chat | Non pris en charge | Sans effet fonctionnel. |
| `model`, `reasoning-effort`, `tools`, `user-invocable`, `disable-model-invocation` | Pris en charge | Pris en charge | Appliqués dans les deux harnesses. |

Les fichiers ne précisent pas de `target` : l'utilisateur ne les réserve pas à un harness. Les indications (`Hint`) grisées sur `agents` et `argument-hint` signalent donc des champs ignorés par Copilot. Les conserver : ils restent utiles dans Local et documentent l'intention. Les indications sur les outils `ado/...` peuvent apparaître tant que la découverte des outils MCP n'est pas terminée ; Joao a utilisé ces outils avec succès les 19 et 23/11.

Dans Copilot, la délégation passe par l'outil natif `task`. Tests du 2026-11-23, dans une conversation utilisant le harness Copilot :

- délégation sur deux niveaux réussie : agent principal → Joao → UMLCreator, via `task` ;
- lecture ADO par Joao appelé comme sous-agent : un premier essai a échoué sur une erreur d'authentification du serveur `ado`, un second a réussi. La cause de l'échec n'est pas connue.

Le serveur MCP `ado` est déclaré dans `.vscode/mcp.json`, lu par VS Code. Hors de VS Code, par exemple avec l'agent GitHub Copilot sur github.com, il faut le déclarer autrement pour que les agents accèdent à ADO. Le hook de routage Joao → Antoine n'a été testé qu'avec des entrées simulées sous Windows PowerShell ; son déclenchement réel n'est pas vérifié.

## Dépannage

- Serveur absent : vérifier que `.vscode/mcp.json` est bien au niveau du dépôt ouvert et que les serveurs MCP sont autorisés par les politiques VS Code.
- Authentification refusée : vérifier le compte, le rattachement Entra, les accès Forem et les politiques du tenant. Les secrets restent dans le parcours d'authentification, jamais dans la conversation.
- Outils absents : redémarrer le serveur après modification de la configuration et renouveler leur découverte dans Copilot. Vérifier les noms officiels avant de modifier la liste autorisée.
- Wiki ou tickets inaccessibles : faire vérifier les droits par le responsable ADO. L'agent concerné signale la limite et ne déduit pas le contenu manquant ; il ne bascule pas en mode local.
- Modèle indisponible : vérifier l'abonnement et le nom exact dans le sélecteur de modèles.

Références officielles consultées pour la configuration : [serveur MCP distant ADO](https://learn.microsoft.com/en-us/azure/devops/mcp-server/remote-mcp-server), [agents personnalisés VS Code](https://code.visualstudio.com/docs/agent-customization/custom-agents), [hooks VS Code](https://code.visualstudio.com/docs/agent-customization/hooks) et [référence des hooks Copilot](https://docs.github.com/en/copilot/reference/hooks-reference).

## Suites possibles

Vérifier dans une nouvelle conversation VS Code qu'Antoine est reconnu, appelable par Maxime sans écriture pour une question de sécurité du besoin, et que ses revues du dépôt n'écrivent que `SECURITY_REVIEW.MD` à la racine sans validation de correction. Vérifier séparément qu'un plan validé n'autorise que les corrections approuvées et leur suivi dans le rapport. Vérifier Joao dans une nouvelle conversation sur ses trois modes, son accès en lecture au besoin explicitement identifié, ses consultations d'Antoine et UMLCreator et le respect de son périmètre d'écriture. Vérifier Simone : reconnaissance du modèle, proposition puis validation d'une charte, maquette et parcours dans `docs/ux/<ID>/`, questions métier posées à Maxime et transmission des critères UX sans rappel en boucle, consultation d'UMLCreator et d'Antoine, et confirmation avant tout nettoyage. Vérifier aussi la consultation de Simone par Maxime et Joao, une première publication wiki par Maxime, la création d'un bug par Maxime, le contexte technique produit par Joao pour une fonctionnalité, le fonctionnement complet en mode local (`PROJET.md`, `ANALYSE.md`) et le déclenchement réel du hook. Ne pas élargir les droits de Maxime au-delà de son rôle.
